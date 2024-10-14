package com.bingchunmoli.api.weather.bean;

import jakarta.validation.constraints.Email;
import lombok.Data;

@Data
public class WeatherSubscribeParam {
    @Email
    private String email;

    private String location;
}
