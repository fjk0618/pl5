<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <title>彩票数据分析</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        * {
            box-sizing: border-box;
        }
        html, body {
            overflow-x: hidden;
            width: 100%;
            margin: 0;
            padding: 0;
        }
        body {
            padding: 0;
        }
        .main-container {
            margin: 0;
            padding: 0;
            max-width: 100%;
            overflow-x: hidden;
        }
        .page-header {
            background: white;
            padding: 10px 0;
            margin-bottom: 0;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .issue-title {
            font-size: 1.8rem;
            color: #495057;
        }
        .issue-number {
            color: #667eea;
            font-size: 2rem;
        }
        .lottery-balls {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .lottery-ball {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(240, 147, 251, 0.4);
            position: relative;
            overflow: hidden;
        }
        .lottery-ball::before {
            content: '';
            position: absolute;
            top: 10%;
            left: 20%;
            width: 20px;
            height: 20px;
            background: radial-gradient(circle, rgba(255,255,255,0.6) 0%, transparent 70%);
            border-radius: 50%;
        }
        .lottery-ball span {
            font-size: 1.5rem;
            font-weight: 800;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            z-index: 1;
        }
        .lottery-ball:nth-child(1) {
            background: linear-gradient(135deg, #FF6B6B 0%, #EE5A6F 100%);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }
        .lottery-ball:nth-child(2) {
            background: linear-gradient(135deg, #4ECDC4 0%, #44A08D 100%);
            box-shadow: 0 5px 15px rgba(78, 205, 196, 0.4);
        }
        .lottery-ball:nth-child(3) {
            background: linear-gradient(135deg, #FFD93D 0%, #F6C23E 100%);
            box-shadow: 0 5px 15px rgba(255, 217, 61, 0.4);
        }
        .lottery-ball:nth-child(4) {
            background: linear-gradient(135deg, #A8E6CF 0%, #56CCF2 100%);
            box-shadow: 0 5px 15px rgba(168, 230, 207, 0.4);
        }
        .lottery-ball:nth-child(5) {
            background: linear-gradient(135deg, #B8A4FF 0%, #8B7FFF 100%);
            box-shadow: 0 5px 15px rgba(184, 164, 255, 0.4);
        }
        .draw-time {
            color: #6c757d;
            font-size: 1rem;
            font-weight: 500;
        }
        .page-header h1 {
            color: #667eea;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .page-header .subtitle {
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 10px;
        }
        .row {
            margin: 0 !important;
        }
        .col-12 {
            padding: 0 !important;
        }
        .stat-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            margin-top: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
        }
        .stat-card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            font-weight: 600;
            text-align: center;
        }
        .stat-card-header i {
            font-size: 1.5rem;
        }
        .stat-card-body {
            padding: 0;
        }
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        .data-table {
            margin: 0;
            font-size: 0.95rem;
            white-space: nowrap;
            background-color: transparent;
            border-collapse: collapse;
        }
        .data-table thead th {
            color: #495057;
            font-weight: 700;
            border: 1px solid #dee2e6;
            padding: 10px 5px;
            margin: 0;
            position: sticky;
            top: 0;
            z-index: 10;
            text-align: center;
            white-space: nowrap;
            background-color: transparent;
            width: auto;
        }
        .data-table tbody td {
            padding: 10px 5px;
            border: 1px solid #dee2e6;
            transition: all 0.2s ease;
            text-align: center;
            white-space: nowrap;
        }
        .data-table tbody tr:hover {
            background-color: #f0f7ff;
        }
        .position-label {
            color: white;
            font-weight: 600;
            border: 1px solid #dee2e6 !important;
            vertical-align: middle;
            max-width: 100px;
            min-width: 80px;
            width: 80px;
            /*padding: 10px 8px !important;*/
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .number-cell {
            font-weight: normal;
            color: #495057;
        }
        .number-badge {
            display: inline-block;
            padding: 6px 0;
            border-radius: 8px;
            font-weight: normal;
            color: #1a1a1a;
        }
        .max-value .number-badge {
            color: #dc3545 !important;
            font-weight: 700 !important;
        }
        .refresh-countdown {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 15px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            color: #667eea;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .refresh-countdown i {
            font-size: 1rem;
        }
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.5rem;
            }
            .issue-title {
                font-size: 1.3rem;
            }
            .issue-number {
                font-size: 1.5rem;
            }
            .lottery-balls {
                gap: 10px;
            }
            .lottery-ball {
                width: 40px;
                height: 40px;
            }
            .lottery-ball span {
                font-size: 1.2rem;
            }
            .draw-time {
                font-size: 0.9rem;
            }
            .stat-card-header {
                font-size: 1rem;
                min-height: 20px;
            }
            .data-table {
                font-size: 0.85rem;
            }
            .data-table thead th,
            .data-table tbody td {
                padding: 0;
            }
            .number-badge {
                padding: 4px 0;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid main-container">
        <!-- 页面头部 - 开奖信息 -->
        <div class="page-header">
            <div class="text-center">
                <div class="issue-title mb-3">
                    <i class="bi bi-trophy-fill text-warning"></i>
                    第 <span class="issue-number">${latest.issue!'-'}</span> 期
                </div>
                <div class="lottery-balls">
                    <#assign numbers = latest.drawCode?split(",")>
                    <#list numbers as num>
                    <div class="lottery-ball">
                        <span>${num}</span>
                    </div>
                    </#list>
                </div>
                <div class="draw-time mt-3">
                    <i class="bi bi-calendar-check-fill"></i>
                    开奖时间：${latest.drawTime!'-'}
                </div>
            </div>
        </div>

        <div class="row">
            <!-- 位置统计 -->
            <div class="col-12">
                <div class="stat-card">
                    <div class="stat-card-header">
                        位置
                    </div>
                    <div class="stat-card-body">
                        <div class="table-responsive">
                            <table class="table data-table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th><i class="bi bi-tag-fill"></i> 位置</th>
                                    <th>0</th>
                                    <th>1</th>
                                    <th>2</th>
                                    <th>3</th>
                                    <th>4</th>
                                    <th>5</th>
                                    <th>6</th>
                                    <th>7</th>
                                    <th>8</th>
                                    <th>9</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="position-label">✅ ⬜ ⬜ ⬜</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${location0[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">⬜ ✅ ⬜ ⬜</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${location1[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">⬜ ⬜ ✅ ⬜</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${location2[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">⬜ ⬜ ⬜ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${location3[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 合数统计 -->
            <div class="col-12">
                <div class="stat-card">
                    <div class="stat-card-header">
                        合数
                    </div>
                    <div class="stat-card-body">
                        <div class="table-responsive">
                            <table class="table data-table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th><i class="bi bi-diagram-3-fill"></i> 组合</th>
                                    <th>0</th>
                                    <th>1</th>
                                    <th>2</th>
                                    <th>3</th>
                                    <th>4</th>
                                    <th>5</th>
                                    <th>6</th>
                                    <th>7</th>
                                    <th>8</th>
                                    <th>9</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- 两数合 -->
                                <tr>
                                    <td class="position-label">✅ ✅ ⬜ ⬜</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge01[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">✅ ⬜ ✅ ⬜</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge02[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">✅ ⬜ ⬜ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge03[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">⬜ ✅ ✅ ⬜</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge12[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">⬜ ✅ ⬜ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge13[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">⬜ ⬜ ✅ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge23[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">✅ ✅ ✅ ⬜</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge012[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">✅ ✅ ⬜ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge013[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">✅ ⬜ ✅ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge023[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">⬜ ✅ ✅ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge123[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                <tr>
                                    <td class="position-label">✅ ✅ ✅ ✅</td>
                                    <#list 0..9 as i>
                                    <td class="number-cell"><span class="number-badge">${merge1234[i?string]!'-'}</span></td>
                                    </#list>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 对数统计 -->
            <div class="col-12">
                <div class="stat-card">
                    <div class="stat-card-header">
                        对数
                    </div>
                    <div class="stat-card-body">
                        <div class="table-responsive">
                            <table class="table data-table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th><i class="bi bi-graph-up"></i> 对数</th>
                                    <th>05</th>
                                    <th>16</th>
                                    <th>27</th>
                                    <th>38</th>
                                    <th>49</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="position-label">间隔</td>
                                    <td class="number-cell"><span class="number-badge">${oppositionNumber05!'-'}</span></td>
                                    <td class="number-cell"><span class="number-badge">${oppositionNumber16!'-'}</span></td>
                                    <td class="number-cell"><span class="number-badge">${oppositionNumber27!'-'}</span></td>
                                    <td class="number-cell"><span class="number-badge">${oppositionNumber38!'-'}</span></td>
                                    <td class="number-cell"><span class="number-badge">${oppositionNumber49!'-'}</span></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 倒计时 -->
            <div class="col-12" style="padding: 0; margin-top: 15px;">
                <div class="text-center" style="line-height: 1;">
                    <div class="refresh-countdown">
                        <i class="bi bi-arrow-clockwise"></i>
                        <span id="countdown-text">计算中...</span>
                    </div>
                </div>
            </div>
        </div>



    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 自动刷新功能：每5分钟的15秒时刷新页面
        let countdownInterval;

        function scheduleAutoRefresh() {
            const now = new Date();
            const currentMinute = now.getMinutes();
            const currentSecond = now.getSeconds();

            // 计算到下一个刷新点的毫秒数
            // 刷新点：5分15秒，10分15秒，15分15秒，20分15秒...
            let targetMinute = Math.floor(currentMinute / 5) * 5 + 5;
            if (targetMinute >= 60) {
                targetMinute = 0;
            }

            // 如果当前分钟已经是5的倍数且秒数>=15，则等待下一个5分钟周期
            if (currentMinute % 5 === 0 && currentSecond >= 15) {
                targetMinute = currentMinute + 5;
                if (targetMinute >= 60) {
                    targetMinute = 0;
                }
            }

            const targetTime = new Date(now);
            targetTime.setMinutes(targetMinute);
            targetTime.setSeconds(15);
            targetTime.setMilliseconds(0);

            // 如果目标时间已过，加60分钟
            if (targetTime <= now) {
                targetTime.setHours(targetTime.getHours() + 1);
            }

            const timeUntilRefresh = targetTime.getTime() - now.getTime();

            console.log('下次刷新时间：', targetTime.toLocaleTimeString());

            // 更新倒计时显示
            updateCountdown(timeUntilRefresh);

            setTimeout(function() {
                console.log('自动刷新页面...');
                location.reload();
            }, timeUntilRefresh);
        }

        function updateCountdown(totalMs) {
            const countdownElement = document.getElementById('countdown-text');

            // 清除之前的定时器
            if (countdownInterval) {
                clearInterval(countdownInterval);
            }

            let remainingMs = totalMs;

            function formatTime(ms) {
                const totalSeconds = Math.floor(ms / 1000);
                const minutes = Math.floor(totalSeconds / 60);
                const seconds = totalSeconds % 60;
                return '距离自动刷新：' + minutes + '分' + seconds + '秒';
            }

            // 立即更新一次
            countdownElement.textContent = formatTime(remainingMs);

            // 每秒更新
            countdownInterval = setInterval(function() {
                remainingMs -= 1000;
                if (remainingMs <= 0) {
                    countdownElement.textContent = '正在刷新...';
                    clearInterval(countdownInterval);
                } else {
                    countdownElement.textContent = formatTime(remainingMs);
                }
            }, 1000);
        }

        // 页面加载时启动自动刷新
        scheduleAutoRefresh();

        // 高亮每行最大值
        document.addEventListener('DOMContentLoaded', function() {
            const tables = document.querySelectorAll('.data-table tbody');
            tables.forEach(table => {
                const rows = table.querySelectorAll('tr');
                rows.forEach(row => {
                    const cells = Array.from(row.querySelectorAll('td.number-cell'));
                    if (cells.length === 0) return;

                    // 获取所有数值（从 number-badge 中获取）
                    const values = cells.map(cell => {
                        const badge = cell.querySelector('.number-badge');
                        if (!badge) return -1;
                        const text = badge.textContent.trim();
                        return text === '-' ? -1 : parseInt(text);
                    });

                    // 找到最大值
                    const maxValue = Math.max(...values);
                    if (maxValue < 0) return; // 如果全是'-'则跳过

                    // 为最大值单元格添加类
                    cells.forEach((cell, index) => {
                        if (values[index] === maxValue) {
                            cell.classList.add('max-value');
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>