package com.eleme.pl5;

import lombok.Data;

@Data
public class BaseApiResponse<T> {
    private Integer code;

    private String msg;

    private T data;
}
