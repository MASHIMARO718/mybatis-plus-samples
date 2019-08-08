<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${entity}Mapper">

    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
            <result column="id" property="id" />
        <#list table.fields as column>
                <result column="${column.name}" property="${column.propertyName}" jdbcType="${column.type}"/>
        </#list>
    </resultMap>

    <!-- 通用查询结果列 -->
    <sql id="Base_Column_List">
        <#list table.fields as column >
            ,t.${column.name} as
        </#list>
    </sql>
    <!-- whereSql-->
    <sql id="whereSql">
        <#list table.commonFields as column >
            <if test="${column.propertyName} != null and ${column.propertyName} != '' ">
                AND t.${column.name} = <#noparse>#{</#noparse>${column.propertyName}<#noparse>}</#noparse>
            </if>
        </#list>
        <#list table.fields as column >
            <if test="${column.propertyName} != null and ${column.propertyName} != '' ">
                AND t.${column.name} = <#noparse>#{</#noparse>${column.propertyName}<#noparse>}</#noparse>
            </if>
        </#list>
    </sql>

    <!-- 通用查询-->
    <select id="selectList" parameterType="${package.Entity}.${entity}" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List"/>
         FROM ${table.name} t
        <where>
            1 = 1
            <include refid="whereSql"/>
        </where>
    </select>

    <!-- 通用查询-->
    <select id="count" parameterType="${package.Entity}.${entity}" resultType="Integer">
        SELECT count(1)
        FROM ${table.name} t
        <where>
            1 = 1
            <include refid="whereSql"/>
        </where>
    </select>

    <!-- 新增或更新-->
    <insert id="addOrUpdate" parameterType="${package.Entity}.${entity}">
        insert into  ${table.name}
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list table.commonFields as column >
                <if test="${column.propertyName} != null">
                    ${column.name},
                </if>
            </#list>
            <#list table.fields as column >
                <if test="${column.propertyName} != null">
                    ${column.name},
                </if>
            </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <#list table.commonFields as column >
                <if test="${column.propertyName} != null">
                    <#noparse>#{</#noparse>${column.propertyName}<#noparse>}</#noparse>,
                </if>
            </#list>
            <#list table.fields as column >
                <if test="${column.propertyName} != null">
                    <#noparse>#{</#noparse>${column.propertyName}<#noparse>}</#noparse>,
                </if>
            </#list>
        </trim>
        ON DUPLICATE KEY UPDATE
        <trim suffixOverrides=",">
            <#list table.fields as column >
                <if test="${column.propertyName} != null">
                    ${column.name} = <#noparse>#{</#noparse>${column.propertyName}<#noparse>}</#noparse>,
                </if>
            </#list>
        </trim>
    </insert>

    <!-- 批量新增或更新-->
    <insert id="batchAddOrUpdate" parameterType="java.util.List">
        insert into  ${table.name}
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list table.commonFields as column >
                    ${column.name},
            </#list>
            <#list table.fields as column >
                    ${column.name},
            </#list>
        </trim>
        VALUES
        <foreach collection="list" item="item" index="index" separator=",">
            (
            <#list table.commonFields as column >
                    <#noparse>#{</#noparse>item.${column.propertyName}<#noparse>}</#noparse>,
            </#list>
            <#list table.fields as column >
                    <#noparse>#{</#noparse>item.${column.propertyName}<#noparse>}</#noparse><#if column_has_next>,</#if>
            </#list>
            )
        </foreach>
        ON DUPLICATE KEY UPDATE
        <#list table.fields as column >
            ${column.name} = VALUES(${column.name})<#if column_has_next>,</#if>
        </#list>
    </insert>
    <!-- 根据主键id更新-->
    <update id="updateByPrimaryKey" parameterType="${package.Entity}.${entity}">
        update ${table.name}
        <set>
            <#list table.fields as column >
                <if test="${column.propertyName} != null">
                    ${column.name} = <#noparse>#{</#noparse>${column.propertyName}<#noparse>}</#noparse><#if column_has_next>,</#if>
                </if>
            </#list>
        </set>
        where id =  <#noparse>#{</#noparse>id,jdbcType=BIGINT<#noparse>}</#noparse>
    </update>
</mapper>
