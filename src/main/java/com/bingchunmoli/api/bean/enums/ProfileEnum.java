package com.bingchunmoli.api.bean.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author MoLi
 */

@Getter
@AllArgsConstructor
public enum ProfileEnum {

    /**
     * 环境美剧
     */
    DEV("dev"), PROD("prod"), TEST("test");

    private final String profile;
}
