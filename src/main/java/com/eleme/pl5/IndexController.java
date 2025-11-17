package com.eleme.pl5;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.lang.TypeReference;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpResponse;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONUtil;
import org.noear.solon.annotation.Controller;
import org.noear.solon.annotation.Mapping;
import org.noear.solon.core.handle.ModelAndView;

import java.util.*;

@Controller
public class IndexController {
    @Mapping("/")
    public ModelAndView index() {
        ModelAndView indexMv = new ModelAndView("index.ftl");
        //查出今日数据和昨日数据作为历史数据

        String today = DateUtil.today();
        String yesterday = DateUtil.yesterday().toDateStr();
        List<DrawDetailDTO> todayData = queryByDate(today);
        List<DrawDetailDTO> yesterdayData = queryByDate(yesterday);
        if (CollUtil.isNotEmpty(todayData)) {
            yesterdayData.addAll(todayData);
        }
        yesterdayData.sort((o1, o2) -> o2.getIssue().compareTo(o1.getIssue()));
        //最新一期
        DrawDetailDTO latest = generateLast();
        indexMv.put("latest",latest);
        //位置 千 百 十 个
        Map<String, Integer> location0 = queryLastLocation(yesterdayData, 0);
        Map<String, Integer> location1 = queryLastLocation(yesterdayData, 1);
        Map<String, Integer> location2 = queryLastLocation(yesterdayData, 2);
        Map<String, Integer> location3 = queryLastLocation(yesterdayData, 3);
        //合数 千百 千十 千个 百十 百个 十个
        Map<String, Integer> merge01 = queryLastLocationMerge(yesterdayData, 0, 1);
        Map<String, Integer> merge02 = queryLastLocationMerge(yesterdayData, 0, 2);
        Map<String, Integer> merge03 = queryLastLocationMerge(yesterdayData, 0, 3);
        Map<String, Integer> merge12 = queryLastLocationMerge(yesterdayData, 1, 2);
        Map<String, Integer> merge13 = queryLastLocationMerge(yesterdayData, 1, 3);
        Map<String, Integer> merge23 = queryLastLocationMerge(yesterdayData, 2, 3);
        //三数合 千百十 千百个 千十个 百十个
        Map<String, Integer> merge012 = queryLastLocationMerge(yesterdayData, 0, 1, 2);
        Map<String, Integer> merge013 = queryLastLocationMerge(yesterdayData, 0, 1, 3);
        Map<String, Integer> merge023 = queryLastLocationMerge(yesterdayData, 0, 2, 3);
        Map<String, Integer> merge123 = queryLastLocationMerge(yesterdayData, 1, 2, 3);
        //四数合 千百十个
        Map<String, Integer> merge1234 = queryLastLocationMerge(yesterdayData, 0,1,2,3);
        //对数 05 16 27 38 49
        int oppositionNumber05 = queryOppositionNumber(yesterdayData, 0, 5);
        int oppositionNumber16 = queryOppositionNumber(yesterdayData, 1, 6);
        int oppositionNumber27 = queryOppositionNumber(yesterdayData, 2, 7);
        int oppositionNumber38 = queryOppositionNumber(yesterdayData, 3, 8);
        int oppositionNumber49 = queryOppositionNumber(yesterdayData, 4, 9);
        indexMv.put("location0",location0)
                .put("location1",location1)
                .put("location2",location2)
                .put("location3",location3)
                .put("merge01",merge01)
                .put("merge02",merge02)
                .put("merge03",merge03)
                .put("merge12",merge12)
                .put("merge13",merge13)
                .put("merge23",merge23)
                .put("merge012",merge012)
                .put("merge013",merge013)
                .put("merge023",merge023)
                .put("merge123",merge123)
                .put("merge1234",merge1234)
                .put("oppositionNumber05",oppositionNumber05)
                .put("oppositionNumber16",oppositionNumber16)
                .put("oppositionNumber27",oppositionNumber27)
                .put("oppositionNumber38",oppositionNumber38)
                .put("oppositionNumber49",oppositionNumber49)
                .put("latest",latest);
        return indexMv;
    }

    private int queryOppositionNumber(List<DrawDetailDTO> data, int number1,int number2){
        for (int i = 0; i < data.size(); i++) {
            //1,2,3,4,5
            DrawDetailDTO number = data.get(i);
            String drawCode = number.getDrawCode();
            drawCode = StrUtil.sub(drawCode,0,7);
            if (drawCode.contains(number1 + "")&&drawCode.contains(number2 + "")){
                return i;
            }
        }
        return 0;
    }

    private Map<String, Integer> queryLastLocationMerge(List<DrawDetailDTO> data, int... idx) {

        Map<String, Integer> resp = new LinkedHashMap<>();
        List<String> locationHistory = data.stream().map(d -> {
            String[] drawCode = d.getDrawCode().split(",");
            int s = 0;
            for (int i : idx) {
                s += Integer.parseInt(drawCode[i]);
            }
            return s % 10 + "";
        }).toList();
        for (int number = 0; number < 10; number++) {
            int index = locationHistory.indexOf(String.valueOf(number));
            resp.put(String.valueOf(number), index);
        }
        return resp;
    }

    private Map<String, Integer> queryLastLocation(List<DrawDetailDTO> data, int idx) {
        Map<String, Integer> resp = new LinkedHashMap<>();
        List<String> locationHistory = data.stream().map(d -> {
            String[] drawCode = d.getDrawCode().split(",");
            return drawCode[idx];
        }).toList();
        for (int number = 0; number < 10; number++) {
            int index = locationHistory.indexOf(String.valueOf(number));
            resp.put(String.valueOf(number), index);
        }
        return resp;
    }


    private List<DrawDetailDTO> queryByDate(String date) {
        String api = "https://api.cc138001.com/server/lottery/day/%s/%s";
        api = String.format(api, "ygxy5", date);
        try (HttpResponse httpResponse = HttpUtil.createGet(api)
                .execute()) {
            String responseBody = httpResponse.body();
            BaseApiResponse<List<DrawDetailDTO>> baseApiResponse = JSONUtil.toBean(responseBody, new TypeReference<>() {
            }, false);
            if (Objects.equals(baseApiResponse.getCode(), 0)) {
                return baseApiResponse.getData();
            }
        }
        return new ArrayList<>();
    }

    private DrawDetailDTO generateLast() {
        try (HttpResponse httpResponse = HttpUtil.createGet("https://api.cc138001.com/server/lottery/latest/ygxy5")
                .execute()) {
            String responseBody = httpResponse.body();
            BaseApiResponse<DrawDetailDTO> baseApiResponse = JSONUtil.toBean(responseBody, new TypeReference<>() {
            }, false);
            if (Objects.equals(baseApiResponse.getCode(), 0)) {
                return baseApiResponse.getData();
            }
        }
        throw new RuntimeException("获取数据失败");
    }
}