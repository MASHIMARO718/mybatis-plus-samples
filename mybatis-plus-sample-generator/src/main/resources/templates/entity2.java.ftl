package ${package.Entity};

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import com.baomidou.mybatisplus.annotation.TableName;
/**
* ${entity} 实体类
* Created by ${author} on ${date}.
*/
@Data
@TableName("${table.name}")
@ApiModel(value="${table.name}对象", description="${table.comment}")
public class ${entity} implements Serializable{

    private static final long serialVersionUID = 1L;
<#list table.commonFields as column>
    /**
    * ${column.comment}
    */
    @ApiModelProperty(value = "${column.comment}")
    @TableId(type = IdType.${idType},value="${column.name}")
    private ${column.columnType.type} ${column.propertyName};
</#list>
<#list table.fields as column>
    /**
    * ${column.comment}
    */
    @ApiModelProperty(value = "${column.comment}")
    @TableField(value = "${column.name}")
    private ${column.columnType.type} ${column.propertyName};
</#list>
}