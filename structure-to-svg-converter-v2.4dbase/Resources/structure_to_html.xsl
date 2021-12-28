<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output  

        method="html" 

        encoding="UTF-8"

        version="1.0"

        doctype-public="-//W3C//DTD HTML 4.01//EN"

        doctype-system="http://www.w3.org/TR/html4/strict.dtd"

        indent="yes"

        standalone="yes"

    />



    <!-- Parameters -->

    <!--            -->

    <xsl:variable name="vTriggersInfo">1</xsl:variable><!-- 0=section not visible; 1=section visible -->

    

    <xsl:variable name="vNumberedField">1</xsl:variable><!-- 0=non-numbered field; 1=numbered field -->

    

    <xsl:variable name="vColTypeInfo">3</xsl:variable><!-- 0=column not visible; 1=Icon visible only; 2=text visible only; 3=both icon and text visible -->

    <xsl:variable name="vColIndexed">1</xsl:variable><!-- 0=Indexed column not visible; 1=Indexed column visible -->

    <xsl:variable name="vColUnique">1</xsl:variable><!-- 0=Unique column not visible; 1=Unique column visible -->

    <xsl:variable name="vColNotNull">1</xsl:variable><!-- 0=Not Null column not visible; 1=Not Null column visible -->

    <xsl:variable name="vColNeverNull">1</xsl:variable><!-- 0=Never Null column not visible; 1=Never Null column visible -->

    <xsl:variable name="vColInvisible">1</xsl:variable><!-- 0=Visible column not visible; 1=Visible column visible -->

    <xsl:variable name="vColEnterable">1</xsl:variable><!-- 0=Enterable column not visible; 1=Enterable column visible -->

    <xsl:variable name="vColModifiable">1</xsl:variable><!-- 0=Modifiable column not visible; 1=Modifiable column visible -->

    <xsl:variable name="vColMandatory">1</xsl:variable><!-- 0=Mandatory column not visible; 1=Mandatory column visible -->

    <xsl:variable name="vColMultiLine">1</xsl:variable><!-- 0=MultiLine column not visible; 1=MultiLine column visible -->

    <xsl:variable name="vColCompressed">1</xsl:variable><!-- 0=Compressed column not visible; 1=Compressed column visible -->

    <xsl:variable name="vColStore_as_utf8">1</xsl:variable><!-- 0=UTF column not visible; 1=UTF column visible -->
    
    <xsl:variable name="vColStore_as_UUID">1</xsl:variable><!-- 0=UUID column not visible; 1=UUID column visible -->

    <xsl:variable name="vTableCommentsInfo">1</xsl:variable><!-- 0=Table comments not visible; 1=Table comments visible -->



    <xsl:variable name="vCompositeIndexesInfo">1</xsl:variable><!-- 0=Composite Indexes not visible; 1=Composite Indexes visible -->

    

    <xsl:variable name="vRelationsInfo">1</xsl:variable><!-- 0=Relations not visible; 1=Relations visible -->





    <!-- Default values for triggers (see the corresponding "base_core.dtd") -->

    

    <xsl:variable name="vTriggerLoadDefaultValue">false</xsl:variable>

    <xsl:variable name="vTriggerInsertDefaultValue">false</xsl:variable>

    <xsl:variable name="vTriggerUpdateDefaultValue">false</xsl:variable>

    <xsl:variable name="vTriggerDeleteDefaultValue">false</xsl:variable>

    

    <!-- Default values for field type (see the corresponding "base_core.dtd") -->

    

    <xsl:variable name="vFieldUniqueDefaultValue">false</xsl:variable> 

    <xsl:variable name="vFieldNotNullDefaultValue">false</xsl:variable>

    <xsl:variable name="vFieldNeverNullDefaultValue">false</xsl:variable>

    <xsl:variable name="vFieldInvisibleDefaultValue">false</xsl:variable><!-- visible=true by default in the DTD -->

    <xsl:variable name="vFieldEnterableDefaultValue">true</xsl:variable>

    <xsl:variable name="vFieldModifiableDefaultValue">true</xsl:variable>

    <xsl:variable name="vFieldMandatoryDefaultValue">false</xsl:variable>

    <xsl:variable name="vFieldMultiLineDefaultValue">false</xsl:variable>

    <xsl:variable name="vFieldCompressedDefaultValue">false</xsl:variable>

    <xsl:variable name="vFieldUTFDefaultValue">false</xsl:variable>
    
    <xsl:variable name="vFieldUUIDDefaultValue">false</xsl:variable>

    

    <!-- Localization variables -->

    <!--                        -->

    

    <!-- General -->

    <xsl:variable name="vPageTitle">4D Structure Definition</xsl:variable>

    <xsl:variable name="vTitlePrefix">Structure Definition of </xsl:variable>

    <xsl:variable name="vTitleSuffix"> Database</xsl:variable>

    

    <!-- Triggers -->

    <xsl:variable name="vTriggerTitle">Triggers</xsl:variable>

    <xsl:variable name="vTriggerLoadTitle">On Load</xsl:variable>

    <xsl:variable name="vTriggerInsertTitle">On Save New Record</xsl:variable>

    <xsl:variable name="vTriggerUpdateTitle">On Save</xsl:variable>

    <xsl:variable name="vTriggerDeleteTitle">On Delete</xsl:variable>

    

    <!-- Table -->

    <xsl:variable name="vPlusOrMinus">plusOrMinus</xsl:variable>

    <xsl:variable name="vTableIDPrefix">table</xsl:variable>

    <xsl:variable name="vTableTitle">Table</xsl:variable>

    <xsl:variable name="vFieldNameTitle">Field name</xsl:variable> 

    <xsl:variable name="vFieldTypeTitle">Type</xsl:variable>

    <xsl:variable name="vFieldIndexedTitle">Indexed</xsl:variable>

    <xsl:variable name="vFieldUniqueTitle">Unique</xsl:variable> 

    <xsl:variable name="vFieldNotNullTitle">Not Null</xsl:variable>

    <xsl:variable name="vFieldNeverNullTitle">Never Null</xsl:variable>

    <xsl:variable name="vFieldInvisibleTitle">Invisible</xsl:variable>

    <xsl:variable name="vFieldEnterableTitle">Enterable</xsl:variable>

    <xsl:variable name="vFieldModifiableTitle">Modifiable</xsl:variable>

    <xsl:variable name="vFieldMandatoryTitle">Mandatory</xsl:variable>

    <xsl:variable name="vFieldMultiLineTitle">Multiline</xsl:variable>

    <xsl:variable name="vFieldCompressedTitle">Compressed</xsl:variable>

    <xsl:variable name="vFieldUTFTitle">UTF-8 Encoding</xsl:variable>
    
    <xsl:variable name="vFieldUUIDTitle">UUID</xsl:variable>

      

    <!-- Types of indexes -->

    <xsl:variable name="vIndexBtree">B-tree</xsl:variable><!-- 1 --> 

    <xsl:variable name="vIndexClusterBtree">Cluster B-tree</xsl:variable><!-- 3 --> 

    <xsl:variable name="vIndexAuto">Auto</xsl:variable><!-- 7-->

    <xsl:variable name="vIndexKeywords">Keywords</xsl:variable>

    

    <!-- Comments -->

    <xsl:variable name="vCommentTitle">Comments</xsl:variable>

    

    <!-- Composite Indexes -->

    <xsl:variable name="vCompositeIndexesTitle">Composite indexes</xsl:variable>

    <xsl:variable name="vCompositeIndexesNameTitle">Name</xsl:variable>

    <xsl:variable name="vCompositeIndexesTypeTitle">Type</xsl:variable>

    <xsl:variable name="vCompositeIndexesFieldsTitle">Fields</xsl:variable>

    

    <!-- Relations -->

    <xsl:variable name="vRelationTitle">Relations</xsl:variable>

    <xsl:variable name="vRelationFrom">From</xsl:variable>

    <xsl:variable name="vRelationTo">To</xsl:variable>    

    

    <!-- Images -->

    <xsl:variable name="vTickImageAlt">tick</xsl:variable>



    <xsl:template match="base">

  

        <html>

            <head>

                <title><xsl:value-of select="$vPageTitle"/></title>

                <style type="text/css">

                    body  

                    { 

                        background: #fff; 

                        color: #333;

                        text-align: left;

                        font-size: 11pt;

                        font-family: Verdana, Helvetica, sans-serif; 

                        margin: 0px; 

                        padding: 0px; 

                    }

                    h1 

                    {

                        color: #036;

                        margin: 5px auto;

                    }

                    h2 

                    {

                        font-size: small;

                        font-weight: bold;

                        color: #036;

                        padding: 2px 10px;

                        border: 1px solid #036;

                        background-color: #eee;

                    }

                    h2 a

                    {

                        text-decoration: none;

                    }

                    h2 a b

                    {

                        font-weight: normal;

                    }

                    h3

                    {

                        color: #036;

                        display: list-item;

                        list-style-type: square;

                        list-style-position: inside;

                        margin: 2px 0;

                        padding-bottom: 3px;

                        font-size: small;

                        font-weight: normal;

                    }

                    a, a:visited

                    {

                        color: #036;

                    }

                    #header

                    {

                        margin: 0 10px;

                        padding: 0;

                        text-align: center;

                    }

                    #contents

                    {

                        margin: 0 10px;

                        padding: 0;

                    }

                    .tableInformation

                    {

                        margin: 0;

                        padding: 0;

                        margin-bottom: 40px;

                    }

                    .information

                    {

                        margin: 0;

                        padding: 0;

                        margin-bottom: 10px;

                        margin-left: 10px;

                    }

                    ul

                    {

                        margin: 0;

                        padding: 0;

                        font-size: x-small;

                        list-style-type: none;

                    }

                    li

                    {  

                        margin: 0;

                        padding: 0;

                        display: inline;

                        margin-right: 10px;

                    }

                    table 

                    {

                        background: #036;

                        font-size: x-small;

                        border-spacing: 1px;

                        border: 0;

                        margin: 0;

                        padding: 0;

                        text-align: left;

                    }

                    table tr th, table tr td

                    {

                        height: 20px;

                        padding: 2px 10px;

                        border: 0;

                        margin: 0;

                    }

                    table tr th

                    {

                        background: #036;

                        color: #fff;

                        text-align: center;

                        font-weight: bold;

                    }

                    table tr td

                    {

                        background: #fff;

                        white-space: nowrap;

                    }

                    table tr td.tickOrNot

                    {

                        text-align: center;

                        vertical-align: middle;

                    }

                    table.triggers

                    {

                        width: 50%;

                    }

                    table.triggers tr th, table.triggers tr td

                    {

                        width: 25%;

                    }

                    table.table

                    {

                        width: 100%;

                    }

                    table.table tr th.fieldName

                    {

                        width: 20%;

                    }

                    table.table tr th.fieldType, table.table tr th.fieldIndexed

                    {

                        width: 13%;

                    }

                    table.relations

                    {

                        width: 50%;

                    }

                    table.relations tr th, table.relations tr td

                    {

                        width: 25%;

                    }

                    table.compositeIndexes

                    {

                        width: 50%;

                    }

                    table.compositeIndexes tr th, table.compositeIndexes tr td

                    {

                        width: 25%;

                    }

                    .comments

                    {

                        background: #efefef;

                        font-size: x-small;

                        margin-top: 10px;

                        padding: 2px 10px;

                    }

                </style>

                

                <script type="text/javascript">

                    <xsl:comment>

                        <![CDATA[ 

                            function expandAll()

                            {

                                var x = document.getElementsByTagName('div');

                                for (i = 0 ; i < x.length ; i++)

                                    if(x[i].className == "tableInformation")

                                        x[i].style.display = "block";

                                x = document.getElementsByTagName('b');

                                for (i = 0 ; i < x.length ; i++)

                                    if(x[i].className == "plusOrMinus")

                                        x[i].innerHTML = "-"; 

                            }

                            

                            function collapseAll()

                            {

                                var x = document.getElementsByTagName('div');

                                for (i = 0 ; i < x.length ; i++)

                                    if(x[i].className == "tableInformation")

                                        x[i].style.display = "none";

                                x = document.getElementsByTagName('b');

                                for (i = 0 ; i < x.length ; i++)

                                    if(x[i].className == "plusOrMinus")

                                        x[i].innerHTML = "+"; 

                            }

                            

                            function openCloseTable(linkID, tableID)

                            {

                                if(document.getElementById(tableID).style.display == "none")

                                {

                                    document.getElementById(tableID).style.display = "block"; 

                                    document.getElementById(linkID).innerHTML = "-";

                                }

                                else

                                {

                                    document.getElementById(tableID).style.display = "none"; 

                                    document.getElementById(linkID).innerHTML = "+";   

                                }

                            }

                        ]]> 

                    </xsl:comment>

                </script>

                <xsl:text disable-output-escaping="yes">

                    <![CDATA[

                        <!--[if lt IE 7]>

                            <script defer type="text/javascript">

                                var arVersion = navigator.appVersion.split("MSIE")

                                var version = parseFloat(arVersion[1])

                                

                                if ((version >= 5.5) && (document.body.filters)) 

                                {

                                   for(var i=0; i<document.images.length; i++)

                                   {

                                      var img = document.images[i]

                                      var imgName = img.src.toUpperCase()

                                      if (imgName.substring(imgName.length-3, imgName.length) == "PNG")

                                      {

                                         var imgID = (img.id) ? "id='" + img.id + "' " : ""

                                         var imgClass = (img.className) ? "class='" + img.className + "' " : ""

                                         var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "

                                         var imgStyle = "display:inline-block;" + img.style.cssText 

                                         if (img.align == "left") imgStyle = "float:left;" + imgStyle

                                         if (img.align == "right") imgStyle = "float:right;" + imgStyle

                                         if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle

                                         var strNewHTML = "<span " + imgID + imgClass + imgTitle

                                         + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"

                                         + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"

                                         + "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>" 

                                         img.outerHTML = strNewHTML

                                         i = i-1

                                      }

                                   }

                                }

                            </script>

                        <![endif]-->

                    ]]>

                </xsl:text>

            </head>

    

            <body>

                <div id="header">

                    <h1><xsl:value-of select="$vTitlePrefix"/><xsl:value-of select="@name"/><xsl:value-of select="$vTitleSuffix"/></h1>

                    <ul id="menu">

                        <li>

                            <a href="#" onclick="expandAll();"><xsl:text>Expand all</xsl:text></a><xsl:text> / </xsl:text><a href="#" onclick="collapseAll();"><xsl:text>Collapse all</xsl:text></a>

                        </li>

                    </ul>

                </div>

                

                <div id="contents">

                    

                    <xsl:for-each select="table[not(table_extra/@trashed='true')]">

                        <xsl:sort select="@name" order="ascending"/>

                        <xsl:variable name="vTableName"><xsl:value-of select="@name" /></xsl:variable>

                        <xsl:variable name="tableID" select="generate-id()"/>

                        

                        <h2>

                            <xsl:text>[</xsl:text>

                            <a href="#{concat($vPlusOrMinus, position())}" onclick="openCloseTable('{concat($vPlusOrMinus, position())}', '{concat($vTableIDPrefix, $tableID)}')">

                                <b class="plusOrMinus" id="{concat($vPlusOrMinus, position())}"><xsl:text>-</xsl:text></b>

                            </a>

                            <xsl:text>] </xsl:text>

                            <xsl:value-of select="@name"/>

                        </h2>

                        

                        <div id="{concat($vTableIDPrefix, $tableID)}" class="tableInformation">

                        

                            <!-- Triggers -->

                            <xsl:if test="$vTriggersInfo=1">

                                <div class="information">

                                    <h3>

                                        <xsl:value-of select="$vTriggerTitle"/>

                                    </h3>

                                    <table class="triggers" cellspacing="1">

                                        <tr>

                                            <th>

                                                <xsl:value-of select="$vTriggerLoadTitle"/>

                                            </th>

                                            <th>

                                                <xsl:value-of select="$vTriggerInsertTitle"/>

                                            </th>

                                            <th>

                                                <xsl:value-of select="$vTriggerDeleteTitle"/>

                                            </th>

                                            <th>

                                                <xsl:value-of select="$vTriggerUpdateTitle"/>

                                            </th>

                                        </tr>

                                        <tr>

                                            <xsl:call-template name="tickedCellOrNot">

                                                <xsl:with-param name="vDefaultValue" select="$vTriggerLoadDefaultValue"/>

                                                <xsl:with-param name="vValue" select="table_extra/@trigger_load"/>

                                            </xsl:call-template>

                                            

                                            <xsl:call-template name="tickedCellOrNot">

                                                <xsl:with-param name="vDefaultValue" select="$vTriggerInsertDefaultValue"/>

                                                <xsl:with-param name="vValue" select="table_extra/@trigger_insert"/>

                                            </xsl:call-template>

                                            

                                            <xsl:call-template name="tickedCellOrNot">

                                                <xsl:with-param name="vDefaultValue" select="$vTriggerDeleteDefaultValue"/>

                                                <xsl:with-param name="vValue" select="table_extra/@trigger_delete"/>

                                            </xsl:call-template>

                                            

                                            <xsl:call-template name="tickedCellOrNot">

                                                <xsl:with-param name="vDefaultValue" select="$vTriggerUpdateDefaultValue"/>

                                                <xsl:with-param name="vValue" select="table_extra/@trigger_update"/>

                                            </xsl:call-template>  

                                        </tr>

                                    </table>

                                </div>

                            </xsl:if>

                            

                            <!-- Table -->

                            <div class="information">

                                <h3>

                                    <xsl:value-of select="$vTableTitle"/> (<xsl:value-of select="count(field)"/> fields)

                                </h3>

                                <table class="table" cellspacing="1">

                                    <tr>

                                        <th class="fieldName">

                                            <xsl:value-of select="$vFieldNameTitle"/>

                                        </th>

                                    

                                        <xsl:if test="$vColTypeInfo &gt; 0">

                                            <th class="fieldType">

                                                <xsl:value-of select="$vFieldTypeTitle"/>

                                            </th>

                                        </xsl:if>

                                    

                                        <xsl:if test="$vColIndexed=1">

                                            <th class="fieldIndexed">

                                                <xsl:value-of select="$vFieldIndexedTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColUnique=1">

                                            <th>

                                                <xsl:value-of select="$vFieldUniqueTitle"/>

                                            </th>

                                        </xsl:if>

                            

                                        <xsl:if test="$vColNotNull=1">

                                            <th>

                                                <xsl:value-of select="$vFieldNotNullTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColNeverNull=1">

                                            <th>

                                                <xsl:value-of select="$vFieldNeverNullTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColInvisible=1">				

                                            <th>

                                                <xsl:value-of select="$vFieldInvisibleTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColEnterable=1">				

                                            <th>

                                                <xsl:value-of select="$vFieldEnterableTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColModifiable=1">				

                                            <th>

                                                <xsl:value-of select="$vFieldModifiableTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColMandatory=1">				

                                            <th>

                                                <xsl:value-of select="$vFieldMandatoryTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColMultiLine=1">				

                                            <th>

                                                <xsl:value-of select="$vFieldMultiLineTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColCompressed=1">				

                                            <th>

                                                <xsl:value-of select="$vFieldCompressedTitle"/>

                                            </th>

                                        </xsl:if>

                                        

                                        <xsl:if test="$vColStore_as_utf8=1">				

                                            <th>

                                                <xsl:value-of select="$vFieldUTFTitle"/>

                                            </th>

                                        </xsl:if>
                                        

										<xsl:if test="$vColStore_as_UUID=1">
										
											<th>

												<xsl:value-of select="$vFieldUUIDTitle"/>

											</th>

										</xsl:if>


                                    </tr>

            

                                    <xsl:for-each select="field">

                                        <tr>

                          

                                            <xsl:for-each select="../index">

                                                <xsl:if test="fields/field_ref/table_ref/@name=$vTableName">

                                                    <xsl:text>vTableName</xsl:text>

                                                </xsl:if>

                                            </xsl:for-each>

            

                                            <td>

                                                <xsl:if test="$vNumberedField=1">

                                                    <xsl:value-of select="position()"/><xsl:text>. </xsl:text>

                                                </xsl:if>

                                                <xsl:value-of select="@name" />

                                                <xsl:call-template name="comments"/>

                                            </td>

                                

                                            <xsl:if test="$vColTypeInfo &gt; 0">

                                                <td>

                                                    <xsl:variable name="type" select="@type"/>

                                                    <xsl:choose>

                                                        <xsl:when test='$type=1'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_5.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Boolean'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=2'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="''"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Byte'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=3'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_6.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Integer'"/></xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=4'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_7.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Longint'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=5'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_8.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Long 64'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=6'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_9.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Real'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=7'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_10.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Float'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=8'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_3.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Date'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=9'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_4.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Time'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=10 or $type=14 or $type=17'>

                                                            <xsl:choose>

                                                                <xsl:when test="@limiting_length!='0'">

                                                                    <xsl:call-template name="type_management">

                                                                        <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                        <xsl:with-param name="vParamImgPath" select="'images/Field_1.png'"/>

                                                                        <xsl:with-param name="vParamTypeName" select="'Alpha'"/>

                                                                        <xsl:with-param name="vParamLength" select="@limiting_length"/>

                                                                    </xsl:call-template>

                                                                </xsl:when>

                                                                <xsl:otherwise>

                                                                    <xsl:call-template name="type_management">

                                                                        <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                        <xsl:with-param name="vParamImgPath" select="'images/Field_2.png'"/>

                                                                        <xsl:with-param name="vParamTypeName" select="'Text'"/>

                                                                    </xsl:call-template>									

                                                                </xsl:otherwise>								

                                                            </xsl:choose>							

                                                        </xsl:when>

                                                        <xsl:when test='$type=11 or $type=18'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_11.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Blob'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=12'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_12.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Image'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                        <xsl:when test='$type=21'>

                                                            <xsl:call-template name="type_management">

                                                                <xsl:with-param name="vParamColTypeInfo" select="$vColTypeInfo"/>

                                                                <xsl:with-param name="vParamImgPath" select="'images/Field_14.png'"/>

                                                                <xsl:with-param name="vParamTypeName" select="'Object'"/>

                                                            </xsl:call-template>

                                                        </xsl:when>

                                                    </xsl:choose>                                    

                                                </td>

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColIndexed=1">

                                                <xsl:call-template name="indexType">

                                                    <xsl:with-param name="vIndexType" select="../../index[@uuid=current()/index_ref/@uuid]/@type"/>

                                                    <xsl:with-param name="vIndexKind" select="../../index[@uuid=current()/index_ref/@uuid]/@kind"/>

                                                </xsl:call-template>

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColUnique=1">

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldUniqueDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="@unique"/>

                                                </xsl:call-template>                                             

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColNotNull=1">

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldNotNullDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="@not_null"/>

                                                </xsl:call-template>   

                                            </xsl:if>



                                            <xsl:if test="$vColNeverNull=1">

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldNeverNullDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="@never_null"/>

                                                </xsl:call-template>                                             

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColInvisible=1">

                                                <xsl:choose>

                                                    <xsl:when test="field_extra/@visible='false'">

                                                        <xsl:call-template name="tickedCellOrNot">

                                                            <xsl:with-param name="vDefaultValue" select="$vFieldInvisibleDefaultValue"/>

                                                            <xsl:with-param name="vValue" select="'true'"/>

                                                        </xsl:call-template>

                                                    </xsl:when>

                                                    <xsl:otherwise>

                                                        <xsl:call-template name="tickedCellOrNot">

                                                            <xsl:with-param name="vDefaultValue" select="$vFieldInvisibleDefaultValue"/>

                                                            <xsl:with-param name="vValue" select="'false'"/>

                                                        </xsl:call-template>

                                                    </xsl:otherwise>

                                                </xsl:choose>   

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColEnterable=1">				

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldEnterableDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="field_extra/@enterable"/>

                                                </xsl:call-template>   

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColModifiable=1">				

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldModifiableDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="field_extra/@modifiable"/>

                                                </xsl:call-template>   

                                            </xsl:if>

                            

                                            <xsl:if test="$vColMandatory=1">								

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldMandatoryDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="field_extra/@mandatory"/>

                                                </xsl:call-template>   

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColMultiLine=1">								

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldMultiLineDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="field_extra/@multi_line"/>

                                                </xsl:call-template>   

                                            </xsl:if>

                                            

                                            <xsl:if test="$vColCompressed=1">								

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldCompressedDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="field_extra/@compressed"/>

                                                </xsl:call-template>   

                                            </xsl:if>                            

                                        

                                            <xsl:if test="$vColStore_as_utf8=1">

                                                <xsl:call-template name="tickedCellOrNot">

                                                    <xsl:with-param name="vDefaultValue" select="$vFieldUTFDefaultValue"/>

                                                    <xsl:with-param name="vValue" select="@store_as_utf8"/>

                                                </xsl:call-template>   

                                            </xsl:if>


											<xsl:if test="$vColStore_as_UUID=1">
											
												<xsl:call-template name="tickedCellOrNot">
													
													<xsl:with-param name="vDefaultValue" select="$vFieldUUIDDefaultValue"/>
													
													<xsl:with-param name="vValue" select="@store_as_UUID"/>
													
												</xsl:call-template>   
											
											</xsl:if>



                                        </tr>

                                

                                    </xsl:for-each>                

                                </table>      

                                

                                <!-- Comments -->

                                <xsl:if test="$vTableCommentsInfo=1">								

                                    <xsl:for-each select="table_extra/comment">

                                        <xsl:if test="@format='text'">

                                            <div class="comments">

                                                <b><xsl:value-of select="$vCommentTitle" /></b><xsl:text>: </xsl:text><xsl:value-of select="."/>

                                            </div>

                                        </xsl:if>

                                    </xsl:for-each>

                                </xsl:if>

                                    

                            </div>

                        

                            <!-- Composite Indexes -->

                            <xsl:if test="$vCompositeIndexesInfo=1 and count(field[index_ref]/index_ref[not(@uuid=preceding::index_ref/@uuid)])!=count(field[index_ref]/index_ref)">

                                <div class="information">			

                                    <h3>

                                        <xsl:value-of select="$vCompositeIndexesTitle"/>

                                    </h3>

                                    <table class="compositeIndexes" cellspacing="1">

                                        <tr>

                                            <th>

                                                <xsl:value-of select="$vCompositeIndexesNameTitle"/>

                                            </th>

                                            <th>

                                                <xsl:value-of select="$vCompositeIndexesTypeTitle"/>

                                            </th>

                                            <th>

                                                <xsl:value-of select="$vCompositeIndexesFieldsTitle"/>

                                            </th>

                                        </tr>

                                        <xsl:for-each select="field[index_ref]/index_ref[not(@uuid=preceding::index_ref/@uuid)]">

                                            <xsl:variable name="indexRef">

                                                <xsl:value-of select="@uuid"/>

                                            </xsl:variable>

                                            <xsl:if test="count(//index[@uuid=$indexRef]/field_ref) &gt; 1">

                                                <tr>

                                                    <td>

                                                        <xsl:value-of select="//index[@uuid=$indexRef]/@name"/>

                                                    </td>

                                                    <xsl:call-template name="indexType">

                                                        <xsl:with-param name="vIndexType" select="//index[@uuid=$indexRef]/@type"/>

                                                        <xsl:with-param name="vIndexKind" select="//index[@uuid=$indexRef]/@kind"/>

                                                    </xsl:call-template>

                                                    <xsl:call-template name="compositeIndexesFieldsNames">

                                                        <xsl:with-param name="vIndexRef" select="$indexRef"/>

                                                    </xsl:call-template>

                                                </tr>

                                            </xsl:if>

                                        </xsl:for-each>

                                    </table>

                                </div>

                            </xsl:if>

                                                        

                            <!-- Relations -->

                            <xsl:if test="$vRelationsInfo=1 and count(parent::node()/relation) &gt; 0">

                                <div class="information">			

                                    <h3>

                                        <xsl:value-of select="$vRelationTitle"/>

                                    </h3>

                                    <table class="relations" cellspacing="1">

                                        <tr>

                                            <th><xsl:value-of select="$vRelationFrom"/></th>

                                            <th><xsl:value-of select="$vRelationTo"/></th>

                                        </tr>

                                        <xsl:for-each select="../relation">		

                                            <xsl:if test="related_field/field_ref/table_ref/@name=$vTableName">

                                                <tr>

                                                    <td>

                                                        <xsl:text>[</xsl:text><xsl:value-of select="related_field[1]/field_ref/table_ref/@name"/><xsl:text>]</xsl:text>

                                                        <xsl:value-of select="related_field[1]/field_ref/@name"/>

                                                    </td>

                                                    <td>

                                                        <xsl:text>[</xsl:text><xsl:value-of select="related_field[2]/field_ref/table_ref/@name"/><xsl:text>]</xsl:text>

                                                        <xsl:value-of select="related_field[2]/field_ref/@name"/>

                                                    </td>

                                                </tr>

                                            </xsl:if>

                                        </xsl:for-each>

                                    </table>

                                </div>

                            </xsl:if>

                            

                        </div>

                    </xsl:for-each>

                </div>

            </body>

        </html>

    </xsl:template>

	

	<!-- Returns the field index type if there is any -->

	<xsl:template name="indexType">

        <xsl:param name="vIndexType"/>

		<xsl:param name="vIndexKind"/>

		

		<td>

            <xsl:choose>

                <xsl:when test="$vIndexType=1">

                    <xsl:value-of select="$vIndexBtree"/>

                </xsl:when>

                <xsl:when test="$vIndexType=3">

                    <xsl:value-of select="$vIndexClusterBtree"/>

                </xsl:when>

                <xsl:when test="$vIndexType=7">

                    <xsl:value-of select="$vIndexAuto"/>

                </xsl:when>

            </xsl:choose>

            <xsl:if test="$vIndexType &gt; 0 and translate($vIndexKind, 'k', 'K')=$vIndexKeywords">

                <xsl:text>, </xsl:text>    

            </xsl:if>

            <xsl:if test="translate($vIndexKind, 'k', 'K')=$vIndexKeywords">

                <xsl:value-of select="$vIndexKeywords"/>

            </xsl:if>

        </td>

    </xsl:template>

    

    <!-- Returns the fields names of a composite index -->

    <xsl:template name="compositeIndexesFieldsNames">

        <xsl:param name="vIndexRef"/>

        

        <td>

            <xsl:for-each select="//index[@uuid=$vIndexRef]/field_ref">

                <xsl:value-of select="@name"/>

                <xsl:if test="position()!=last()">

                    <xsl:text>, </xsl:text>

                </xsl:if>

            </xsl:for-each>

        </td>

        

    </xsl:template>

    

    <!-- Ticks cell when true -->

    <xsl:template name="tickedCellOrNot">

		<xsl:param name="vDefaultValue"/>

		<xsl:param name="vValue"/>

		

		<xsl:choose>

            <xsl:when test="($vDefaultValue='true' and not($vValue='false')) or ($vDefaultValue='false' and $vValue='true')">

                <td class="tickOrNot">

                    <img src="images/tick.png" alt="{$vTickImageAlt}"/>

                </td>

            </xsl:when>

            <xsl:otherwise>

                <td class="tickOrNot"/>

            </xsl:otherwise>

        </xsl:choose>

        

	</xsl:template>

    

    <!-- Formats field type -->

    <xsl:template name="type_management">

        <xsl:param name="vParamColTypeInfo"/>

        <xsl:param name="vParamImgPath"/>

        <xsl:param name="vParamTypeName"/>

        <xsl:param name="vParamLength"/>

    

        <xsl:choose>

            <xsl:when test="$vParamColTypeInfo=1">

                <xsl:element name="img">

                    <xsl:attribute name="src"><xsl:value-of select="$vParamImgPath"/></xsl:attribute>

                    <xsl:attribute name="alt"><xsl:value-of select="$vParamTypeName"/></xsl:attribute>

                </xsl:element>

                <xsl:text> </xsl:text><xsl:value-of select="$vParamLength"/>

            </xsl:when>

    

            <xsl:when test="$vParamColTypeInfo=2">

                <xsl:value-of select="$vParamTypeName"/> <xsl:text> </xsl:text><xsl:value-of select="$vParamLength"/>

            </xsl:when>

    

            <xsl:when test="$vParamColTypeInfo=3">

                <xsl:element name="img">

                    <xsl:attribute name="src"><xsl:value-of select="$vParamImgPath"/></xsl:attribute>

                    <xsl:attribute name="alt"><xsl:value-of select="$vParamTypeName"/></xsl:attribute>

                </xsl:element>

                <xsl:text> </xsl:text><xsl:value-of select="$vParamTypeName"/><xsl:text> </xsl:text><xsl:value-of select="$vParamLength"/>

            </xsl:when>

        </xsl:choose>

        

    </xsl:template>

    

    <!-- Comments -->

    <xsl:template name="comments">

        <xsl:for-each select="field_extra/comment">

            <xsl:if test="@format='text'">

                <xsl:value-of select="." />

            </xsl:if>

        </xsl:for-each>

    </xsl:template>

    

</xsl:stylesheet>