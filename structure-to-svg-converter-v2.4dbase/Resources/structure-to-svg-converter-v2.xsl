<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    
    <xsl:output method="xml" indent="yes" />
    <!-- params -->
    <xsl:param name="table_color_floor" select="36" />
<!--    <xsl:param name="table_start_brightness" select="0.9" />-->
    <xsl:param name="table_start_brightness" select="0.95" />
    
<!--    <xsl:param name="table_default_start_red" select="255" />-->
<!--    <xsl:param name="table_default_start_green" select="255" />-->
<!--    <xsl:param name="table_default_start_blue" select="255" />-->

    <xsl:param name="table_default_start_red" select="192" />
    <xsl:param name="table_default_start_green" select="192" />
    <xsl:param name="table_default_start_blue" select="192" />
    
<!--    <xsl:param name="table_default_stop_red" select="127" />-->
<!--    <xsl:param name="table_default_stop_green" select="127" />-->
<!--    <xsl:param name="table_default_stop_blue" select="127" />-->

    <xsl:param name="table_default_stop_red" select="211" />
    <xsl:param name="table_default_stop_green" select="211" />
    <xsl:param name="table_default_stop_blue" select="211" />
    
    <xsl:param name="translate_x" select="5" />
    <xsl:param name="translate_y" select="5" />
    
    <xsl:param name="structure_font_family" select="'Arial'" />
    <xsl:param name="structure_font_size" select="12" />
    <xsl:param name="structure_font_weight" select="'normal'" />
    <xsl:param name="structure_margin_x" select="100" />
    <xsl:param name="structure_margin_y" select="100" />
    <xsl:param name="linear_gradient_start_opacity" select="'100%'" />
    <xsl:param name="linear_gradient_stop_opacity" select="'100%'" />
    <xsl:param name="table_rx" select="10" />
    <xsl:param name="table_ry" select="10" />
    <xsl:param name="table_spread_method" select="'reflect'" />
    <xsl:param name="table_x1" select="0" />
    <xsl:param name="table_y1" select="1" />
    <xsl:param name="table_x2" select="1" />
    <xsl:param name="table_y2" select="0" />
    <xsl:param name="table_gradient_1" select="'1%'" />
    <xsl:param name="table_gradient_2" select="'99%'" />
    <xsl:param name="table_row_height" select="18" />
    <xsl:param name="table_margin_y" select="18" />
    
    <xsl:param name="table_stroke_width" select="2" />
    <xsl:param name="table_stroke_width_separator" select="1" />

    <xsl:param name="table_stroke" select="'#888888'" />
    <xsl:param name="table_stroke_separator" select="'#AAAAAA'" />
    
    <xsl:param name="relation_control_offset" select="150" />
    <xsl:param name="table_header_height" select="15" />
    <xsl:param name="relation_marker_height" select="6" />
    <xsl:param name="relation_marker_width" select="6" />
    <xsl:param name="relation_marker_refx" select="3" />
    <xsl:param name="relation_marker_refy" select="3" />
    <xsl:param name="relation_marker_cx" select="3" />
    <xsl:param name="relation_marker_cy" select="3" />
    <xsl:param name="relation_stroke_r" select="1.8" />
    <xsl:param name="relation_stroke_width" select="0.5" />
    <xsl:param name="relation_marker_polygon" select="'1,1 1,5 5,3'" />
    <!-- keys -->
    <xsl:key name="table_by_uuid" match="/base/table" use="./@uuid" />
    
    <xsl:template match="/">
        <xsl:element name="svg:svg">
            <xsl:attribute name="font-family">
                <xsl:value-of select="$structure_font_family" />
            </xsl:attribute>
            <xsl:attribute name="font-size">
                <xsl:value-of select="$structure_font_size" />
            </xsl:attribute>
            <xsl:attribute name="font-weight">
                <xsl:value-of select="$structure_font_weight" />
            </xsl:attribute>
            <xsl:attribute name="height">
                <xsl:for-each select="/base/table/table_extra/editor_table_info/coordinates">
                    <xsl:sort select="@top + @height" data-type="number" />
                    <xsl:if test="position() = last()" >
                        <xsl:value-of select="number(@top) + number(@height) + $table_header_height + $structure_margin_y" />
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>
            <xsl:attribute name="width">
                <xsl:for-each select="/base/table/table_extra/editor_table_info/coordinates">
                    <xsl:sort select="@left" data-type="number" />
                    <xsl:if test="position() = last()" >
                        <xsl:value-of select="number(@left) + number(@width) + $structure_margin_x" />
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>

            <svg:defs>
                <svg:linearGradient id="default" x1="{$table_x1}" y1="{$table_y1}" x2="{$table_x2}" y2="{$table_y2}">
                    <svg:stop offset="{$table_gradient_1}" stop-color="rgb({$table_default_start_red}, {$table_default_start_green}, {$table_default_start_blue})" />
                    <svg:stop offset="{$table_gradient_2}" stop-color="rgb({$table_default_stop_red}, {$table_default_stop_green}, {$table_default_stop_blue})" />
                </svg:linearGradient>
                
                <svg:image
                height="16"
                id="field_type_21"
                width="16"
                x="0"
                y="0" xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAB3RJTUUH3gkYDwkJ3x+OLgAAAbhJREFUOMutk7+LE0EUxz9vdnYSd/eiyd2tMScn5jQHySkWFseBiGBxtrZio9iJthaCIHLV/Rc2gq2FhQoi6BUioqiInOAhF8GfiIWSZJ/F5jbRZMHC17x5X2a+877fNwP/K07OjwErc9QrY/D5E+NJ9C5e5LhgXHiV6eauLbwZs9dZs4IfnkdVcrvYN8kqoLjwE3Hz4BDBEd/jO9ChMnctl6A2wUPE+8jF9+W/Jeg9IoEOEzN3Rg4uN/oEJR6D/ZB3QWDoEtbuA9BYTsHWzsGGkqNNYcdGHkEc8A0/epUBUwtpXtrD7tDxQESU6qGzI+ZqmheqnDOgFMq3qS1OARiARHGqbFPxEjy3CcANHemgIGx6BkBDul37h4RbZyiFls8UJ9/kSahGtLHBupy+GaVIf9KLs5mJTxE/18SSN2RiX5sBWNvI6p+QCKo2G2N5QPCjh2KkkxkjkhJsRdHyAu3FFLevEbfqfFnn7VdoTXMg8HmWgMXY1wBI+iDtMMGx/VxqP0F+ac8pmmSdCr1uIi+xxUfMLl3h+btRfUfrg/X1U4EgM1ndMOAfvzzotnb4H79opT7+Nw7Fb9zvbKc5NNsoAAAAAElFTkSuQmCC" />
                
                <svg:image
                height="16"
                id="field_type_1"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAACTUlEQVR42nyTQU8TQRiGn1kGClvaLmxbhVZtSNFQxRITk8ao0YteTLx4I5GD8cgv8ayJVxIuJ
                iZKPKAnE49G8QLaA7ZAGlsKhSmbltLtjpdFKohzned982We+YTWGgAhBAC5XO5+MBicy2QyccuyUEpRqVTI5/ObSqnHhULhPcBhzqDrpNPp2UAgsBiLxeJCCJrVKq1aD
                SEEkUgkLqVcDIfDs90Z0TWBHB8f3zBN024p1fukVOJMuw1AVUqe2zYtKV3HcbaUUue01u7xgrCU8pbruu+mDcE9y6Svvxf2XQ5Ugw8dj3nAMIwHnud90lrXAWTXNNJ1X
                QCyoX5ymQQD8TBsOzTzv6iVFfOA53l/5brfoAGsA3xHMJaKkryWInneZixi8vOIW/dZjk/QAmoAc6rBlc8FnmqBUd3jZVnx4oir+eyJAg1oy7KYnJykODXFM8tC2YrK0
                AQTy8usrq7SbDa1z57UmEqlZrLZLIlEAiEE1WqVmq/Rtm2SySShUGjmVI3pdLpkmma8Xq+zFy0xcLWNMMD5JunbsJFS4jjOplIqcZrGO67rvg1eFJx9FMbs7aPJAbq9R
                +WNh7MChmE89Dzv42kaOwBDN4PcuDxGMjBMmV2+ttZob2/hrIDneZ3/aVwDdgYjATKjo9y9neFSbIToaBDDBGDHZxr/KmgBm8BC8dUuxf0tln4UKIka6qBJ+TUACz7TO
                nKn9Z/NAgaB68CX/kSPTk1H9Oh0UAdG0MCSfzfYnRPH1lkCw8AFIAr0+MUdYBso+h/JPcz9HgCnVQzBBwDfFwAAAABJRU5ErkJggg=="/>
                
                <svg:image
                height="16"
                id="field_type_10"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA
                CXBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBUR
                nEhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28A
                AgBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxA
                Ii4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNM
                zgwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9
                MOOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62
                B7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiW
                QRlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28gg
                Mor8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPs
                CF6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7k
                CLKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQ
                l9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar
                1akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHO
                Dc57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DM
                kGPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzF
                Sos2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xy
                dHXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85Dn
                L152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWN
                BbsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGP
                qYy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T
                8oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/Pb
                FWyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMr
                glc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3K
                zQM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1S
                No0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Sn
                np1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7du
                Jt0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/9
                4vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBj
                SFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAACwklEQVR42oyTy2tTQRTGv5nMneTePG6S5t30YVta0SqCCy0ogoJC7aIuRFAUF92JaxEFK/4B
                rtwUKrqRghUfIBZxUxFxIVhQ1KLd2LTSmKSNaW9yzb1z3NxKKF144Cxm+L7f4cw5A2wTMTPKu9rzeznn7zlj87l05mxnLmfgP4N15/OHNeFb1DSf45eiYQS0Wnd7Ziyf
                TWtbxb6t5t6ujs7SaumhJniXaUamIpHQHIe7nzPUpZSvVqu1RquBtx5y6YSfbOuqERD9waD/u123J5gU70KGdERA6AcE0wCw2ZEhtukRrbCOZOx4sVo+FZKyyf3Gk58r
                hYXhvuzA3LrjMvCek5nk0LW+bL3gNJuzwweLG5wt/gPs6skHVeP3paCupRwmnu+u1qeeHNk3VF8rn1uVQh4iGhSl4p2PRE0X+FVREH9i4fubAN6dDJ/+WaselJxVD5mx
                N9ej7oVcceUyKXJBxG4qUv1cfhqU2ucV0Jrt2h32RrPEACCo+wN93W2PSKnhHUSVe4rqUUXtDUXLM1FzcrxUGV1TNNgUxsXlH8tvAbhebggArH/njn3rq6WBiFKYVhQX
                ivBWUXHaDI/fnlt4l0incsqu7XGEb78wjOeOZVkACIArAPhWyuWzaNi9LxVBKMIHRaXJiDl+d74wA6Bea7hLqDeVztYHMpGILFhWxQMAAHSzLfT0WchPZEj6GtCs852p
                GwA6AegAAol42zHG2BJjrJxLpo5uHX94xK99Uz5OFmd0K6i/6AsZewAEATBv2dKGJh8DoGQsfiVoGLIVEH0NEAH0gPHCiWTbKIBoSxUGIJSIxc8wxiqc86+ZZKrLuwcA
                xC2AvgA0ljAnAGQBbN15DUAurBt3AZDwiafZVDqxSY8A6PD6LQMoArBaH8nTGQDSnq4KoATAZh5d93q1ATQAqG1+KQcQ8PSOp3X+DgD9QwTkbaFrdQAAAABJRU5ErkJg
                gg==" />
                
                <svg:image
                height="16"
                id="field_type_12"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA
                CXBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBUR
                nEhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28A
                AgBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxA
                Ii4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNM
                zgwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9
                MOOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62
                B7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiW
                QRlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28gg
                Mor8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPs
                CF6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7k
                CLKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQ
                l9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar
                1akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHO
                Dc57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DM
                kGPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzF
                Sos2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xy
                dHXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85Dn
                L152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWN
                BbsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGP
                qYy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T
                8oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/Pb
                FWyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMr
                glc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3K
                zQM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1S
                No0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Sn
                np1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7du
                Jt0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/9
                4vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBj
                SFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAACr0lEQVR42oyST08bVxTFf+/NjGfGdhP/STDIYFyJBIopqagqlayqIMonQMqmopGQum12+QDJ
                sqv0m1SyUKt01SK5aiOaiEBRiIEkLZgx2BNH2PPnvW5M47Dqka7e1b3vHp173jPo45uVO5+lkqmvx4rFzw9ev1rnf0Lc+/buWhSGS0IIpJSk02kc10VrjRCC7Z0dHMdh
                emqKF7u7ND2PUrmMUurZd98/XJZBr7ew8OUi5XKZjv8GFSvGRkeZqVSYm5vjtOOTSCWZnLxOynWYvzkPcQQwLaWcN6WUvS8WF03LMHn+1w5B0EMphed5bG1ucsmyCX2f
                tWoVx7YxTJO3nQ6WmwQYMQF63TOCIEApRSKRwDs+ptVqMTE1ya2lJfbrdZ5ubND0mtjJJLdXVlj/5VeiKLLle4YIgdbwe63G1EyFr1ZXKV+boDhWYnz8Q1Aa23EYHi0i
                pURrLcxBAsMw8I4bXM5msawEDx7cp1qtkrQdPq3M4tgOm0+e8mTjT8IwBMC8qCAIAgAe137jh0c/0Tw9Iem6/HN0yFAmS7vj02g06PXvvbeCUoqEbWOZJoWhq3xSqXAl
                l6OQy5PPZDnrdpGGAUAcx+8U2I6LZVlorcnmchwfHbFXrzM7+RHjI0VUFOP7Pq3WKZnhIXJX8hy9/vs/Be4ftRr7e3v0ggDXcfn4xg26YcjW9hanTY9G45CT1gmZwlWm
                Z2cplUqk02kAIWOtHz9a+5GXBy/J5fMkbBvbthkpFhGmyWGzidduowyD1AeXIIp5/mybvf19X0MospnMctJ1F6RhFKSUJlprpRSAiJUyoygylFImoKQQkTSMSCL0Wa/b
                bLXbPwvgGjAKZPqe6PNH6Z+yHxpQA/0Q2BWAC1wGrIEhBkjEQP2cBCAC3p43zIt/4oKKQeiBPP53AEDEEDmlb4ziAAAAAElFTkSuQmCC" />
                
                <svg:image
                height="16"
                id="field_type_14"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA
                CXBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBUR
                nEhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28A
                AgBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxA
                Ii4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNM
                zgwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9
                MOOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62
                B7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiW
                QRlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28gg
                Mor8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPs
                CF6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7k
                CLKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQ
                l9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar
                1akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHO
                Dc57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DM
                kGPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzF
                Sos2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xy
                dHXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85Dn
                L152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWN
                BbsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGP
                qYy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T
                8oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/Pb
                FWyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMr
                glc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3K
                zQM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1S
                No0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Sn
                np1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7du
                Jt0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/9
                4vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBj
                SFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABvklEQVR42pyTwYoTQRRFT1WqkhBNmBCSgBsTcBFQ1F0gC8Gtez/Bb9BfcC04n+BO8BNcaHZu
                BDskhAmBYbBFiaPjdHV113MxnRClRciFWtSre+97VN1Sk8nkba1We1CtVrHWYoxBKYWIkGUZ3nvSNMU5h3OONE3x3k9ns9kj4MLoK5zFcXycJMlpFEWfxuPx/eFweOy9
                Z7lcPo2i6P1gMBhYa2/U6/UnItIAbgInRmut1+v1s8VicQp8Bc6bzeZ3ay0AInIdSFer1TtA9Xq9j51O5wXQAKrGe/9ysVh8ABzwBbjs9/u3tNYopVBKZcAGOAOyOI7j
                o6OjV8A5EMx0On1duCXAL0DCFRAR9hCADLiYz+fPC40zRWdfEATAe4+I4L0nhMBfEOASSIHcFMI/WEmSYIwhyzLyPKcEebEwZafOuZ34HwY7lBokSUKlUjncwDmH1poQ
                AlmWHT5BCOGwCbz37TzPEZGyV/i/gYjc2wobjcadgqfLuJX9zWg0etjtdt8opR5va9ba2+12+26r1fq22WxO9vMCoEoMW0Af6AHXivoP4DMQAz+3GSgz0EB1+1H2xg5F
                YrcJ3F3M7wEAWx7lE1IEvNoAAAAASUVORK5CYII=" />
                
                <svg:image
                height="16"
                id="field_type_15"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA
                CXBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBUR
                nEhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28A
                AgBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxA
                Ii4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNM
                zgwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9
                MOOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62
                B7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiW
                QRlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28gg
                Mor8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPs
                CF6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7k
                CLKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQ
                l9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar
                1akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHO
                Dc57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DM
                kGPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzF
                Sos2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xy
                dHXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85Dn
                L152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWN
                BbsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGP
                qYy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T
                8oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/Pb
                FWyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMr
                glc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3K
                zQM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1S
                No0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Sn
                np1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7du
                Jt0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/9
                4vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBj
                SFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABuklEQVR42oySP4saQRjGf7ObZUFyl0JT6EUEPXIEsYkJpDuuDxwSENLkA4iNzULAysZvYBtC
                2uQzpAppEpsDQa9b7vYKG9fTZcf9Mymi5rx1w/2qd2beeeZ9HkYopfguhAIEa17c3PwC6qTzO5/Pv1JK8ej+ycn19ZcoiuoAw+EQgPl8TjabBaBWqwHUu93uO+BbQsD3
                /VNd11UURbfVajXxtJQSXdcPJ5PJV0DcF1BKqSvLsgRwCBDHMZqm7TT1er1tfVdAAdjHx8/k+TnNZpNcLofruhSLRQBsx+Fzt8tyudxe2kiLTYjFy8tbgHK5jOd5ZDKZ
                bfOFZXF2dEQURbsTnCm1WYvxeDwH6Pf7yezXmbz2vL0WAFitVpimSafTwXEcCoVCYpIwDBMWtsRxvK2DIGA0GuE4zk5PwsJdwjBESrnfwppWq5Uu4Ps+pmnSbrcJggDD
                MDAMgyAI+PjJ5v3bl2jaVbpAHMePATzPYzqdAjCbzSiVSpw8Dfjxc0jp9AlqHfw+Cwsp5cFgMEi1IN98SJ/Atu2DRqPB/1gsFlQqlf0CUkpc1+WhCPXvE/3dEOL5Qy8r
                pSZ/BgADtbuJ3KG4mgAAAABJRU5ErkJggg==" />
                
                <svg:image
                height="16"
                id="field_type_16"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA
                CXBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBUR
                nEhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28A
                AgBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxA
                Ii4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNM
                zgwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9
                MOOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62
                B7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiW
                QRlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28gg
                Mor8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPs
                CF6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7k
                CLKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQ
                l9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar
                1akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHO
                Dc57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DM
                kGPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzF
                Sos2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xy
                dHXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85Dn
                L152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWN
                BbsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGP
                qYy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T
                8oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/Pb
                FWyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMr
                glc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3K
                zQM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1S
                No0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Sn
                np1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7du
                Jt0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/9
                4vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBj
                SFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABuklEQVR42oySP4saQRjGf7ObZUFyl0JT6EUEPXIEsYkJpDuuDxwSENLkA4iNzULAysZvYBtC
                2uQzpAppEpsDQa9b7vYKG9fTZcf9Mymi5rx1w/2qd2beeeZ9HkYopfguhAIEa17c3PwC6qTzO5/Pv1JK8ej+ycn19ZcoiuoAw+EQgPl8TjabBaBWqwHUu93uO+BbQsD3
                /VNd11UURbfVajXxtJQSXdcPJ5PJV0DcF1BKqSvLsgRwCBDHMZqm7TT1er1tfVdAAdjHx8/k+TnNZpNcLofruhSLRQBsx+Fzt8tyudxe2kiLTYjFy8tbgHK5jOd5ZDKZ
                bfOFZXF2dEQURbsTnCm1WYvxeDwH6Pf7yezXmbz2vL0WAFitVpimSafTwXEcCoVCYpIwDBMWtsRxvK2DIGA0GuE4zk5PwsJdwjBESrnfwppWq5Uu4Ps+pmnSbrcJggDD
                MDAMgyAI+PjJ5v3bl2jaVbpAHMePATzPYzqdAjCbzSiVSpw8Dfjxc0jp9AlqHfw+Cwsp5cFgMEi1IN98SJ/Atu2DRqPB/1gsFlQqlf0CUkpc1+WhCPXvE/3dEOL5Qy8r
                pSZ/BgADtbuJ3KG4mgAAAABJRU5ErkJggg==" />
                
                <svg:image
                height="16"
                id="field_type_18"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA
                CXBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBUR
                nEhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28A
                AgBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxA
                Ii4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNM
                zgwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9
                MOOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62
                B7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiW
                QRlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28gg
                Mor8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPs
                CF6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7k
                CLKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQ
                l9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar
                1akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHO
                Dc57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DM
                kGPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzF
                Sos2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xy
                dHXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85Dn
                L152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWN
                BbsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGP
                qYy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T
                8oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/Pb
                FWyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMr
                glc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3K
                zQM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1S
                No0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Sn
                np1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7du
                Jt0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/9
                4vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBj
                SFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAAC0ElEQVR42myTzWtcVRiHn3M/584MM5mPxkDSmtQigmgXrcEUagUjpS5ciLhwY8FVV5UW/COy
                KGajuHHtyoU7QXQhFKl0EypSN6aTL8bJ5M7M/Tr3nHPvdWETG+m7/vHA877vT1RVxfPmo68v3fGd2qeWsM6Z0jzMdPL5d7e2Hvw/J54HuLF5/otee+626znkuSLLDLpQ
                hdTZlR/v7JyCOAAffPX6auA2NhzLuZSqZFja6Uteo0EtKFBRTJakJJm2cyM3gLdPAdbvnV2te437InBt4WqSKGxKmWF5ik63TV5kFEeSSTrBROKtT765Gj2r5MxkuFGr
                CduuC/zAxgoNh38qAjFFZQWZyonGinQATukJLaJmpsw1Xaj76/fOXnFmh8laq+Xg+gG9XhNtFI9+MPyxF7K7EFE5JbNhjjyCi+tdRC06peSku+yNVL7SsGOKomQaZrSW
                HQY/ScaP1Ynry9c6rL67yHA8PVHSM9Zsv4cd7xfXKTwCr0/Tn8ezGqgyHziue/ONDy+8+to7yy8srPSZTjRpHjM6iJg+0eSHDER9CW/xcuv7y++vXPd97+nZNLrQaGkO
                5+e7fdcVKGXIpEFKyeNfB0x3FMLmrpXu4i9ddS/WmgX1tkbUItJyTJgeEspR33Iy/JaEIEJWIbGe4rdtsn02q4JNp/Ei/XymFkok7c4c0tj/Os6mmAjKZUW3N4cucwwZ
                MzmDjsmSbT5LtsFJnlAOf1ehnU462cSghGK6r0n+giIVjM/F+C1BFGfEs5x0ZNATimc/UY+21LfxYHJrZytCeBXJRKNjsBzYfhQyyxK0Ljjak6QHYFJ+OekC0AJe8c9w
                2w64ISw6Vcm4SPnZabBm11l0WyAE6Agqzd9qyntyyMNjgA10gfPAEhAACbBn+bT8Ph8LmzcBuyr4TYd8aVIeAOYYcKxSBxqAC2ggBiRwBmg/zUXAAfy3g38GAJP0jIBk
                0XeoAAAAAElFTkSuQmCC" />
                
                <svg:image
                height="16"
                id="field_type_3"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABe0lEQVR42ozTMWsUURQF4O8tM4ZNIprYrBtQsAk2YiH5A4JgSpt0giT/wNIfEBsh2FkEwUK0S
                CGk0jLINjYJRLYQg4Ii2iWK62bHsfCODOtukgsX5p0397x73nlXWZaGMyK9bLnZaSuRB5Z32so6lhkdabNl8XTDZqyb0Gnrfxx48KWwjVM4bIwhaGz80H136GF1ckVyI
                XN3YcITJBhHUD4+8O1zYaeG5bDb9+j9wFqn7QD5OAm/8Ws66Q1vfCpsZ4Xi0t/KZpZSSriGO7iIF9jAfiMpa7XFVs/yjaZ12OpZrhRcRjmUz9BcmjK/ds5tnMUE5lZnr
                azOWsFcYNaj6CmW8D3WVzGNmfgxYRKtyEmkDPexg93QPhUtf0UPPwMv47tfSQrMTLQzj26Ar3C+suq4aEQ7b6N4D9dx5p+nI15r/dVmeF4rXoyO8pMS3Kvd/h7e4DUWK
                gnHEXRH2FjiVjUrRxEkXAlb8trN7uNDODGoTej/U3fU5knizwCW0dLNg9pzEwAAAABJRU5ErkJggg==" />
                
                <svg:image
                height="16"
                id="field_type_4"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAAB0klEQVR42oySP2hTURSHv/v+5D3TkvYFfU2o2C4iJvQZobWr6FIzOLi4CMUWHDoEIYND1w4uI
                mSVrAV1sVAUKR27OYRXTCoOaRyqLXRoEjVpa56D50ksTc2Bw+Wee8/vfPeeo4Ig4KQppQBUeuLpjK5H3wL4pVwEOAJML1M4DGOqh4BKpZeyhhlbrR9szlv2SMqy3Lxfy
                g14mcL3dnvvGYBluXmN003b39+oNBqV2YCOZlluvtGozAKDzebnB193Vl63fu58AuhFoAHngKgTn05ccG/N2XbysV/KnQd0L1PYBagfbM4bPQhIpZduGmZs1S/l3KHha
                75tJwmT263d5632t3KtWnyvAAVMAg+BMWAFeDOSuDPoxKcfRSLxJ2G17eqLNS9T+PIPLXAVKJ8AeAUsOM7UxdiwNwVQqxbfAcdj43N3O51DS2nGkaFHfwAUgQBYBu4DT
                dlfB4aAJJAAooANuMAlcVcBl4Es8BHoAOtCMQrsdVH9klUXcqQQjly+AmxJcE0qK/owTfDKklwFbgv+nzJB0NMBDOBlV3JWiMx+BRYlORT4AGwAN8In/E9gq0ug2+8J3
                ZkCCvCkTab8dADUgZp04fi0cf87SGcd9mO/BwAyXOkbHWbB4wAAAABJRU5ErkJggg==" />
                
                <svg:image
                height="16"
                id="field_type_5"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABl0lEQVR42ozTTUuUURjG8d8Zn5mmEfNlQBKNWlQWSRKWuLBVmzBo0SZaViBRUOgq6QPork9Qy
                6AWofQGtWhjrdokpAMGEa0ME7IXIZ2eFp2Rh3BsLrgX5z73/T/XeQtpmvpXIQQIQ2NOJ0VPYXZSAevZ/OykQmJrhcHrRpKixyvvXcol1tkE5EPOtVi3sx6g6deq5kIzH
                fvdjbkWhL4LDjUVnIm5fK6eg+qGBJbm3Pj5xe3hCd9Qatvn7ddPpmqF9QCbWnzi5dqyeRga9wha97gJwxOWAwKO4yL2YgYzXQPauwaMlsrGYHnBlcq0171nnSy26W/pN
                rqy6HLAYf6ukNEDXO3s01M+6AQsPPQca9jRcUBP5xH9lWnP4A5S3MN5fI/jY2hFF3ajhCbksQtllBJMYQ7v8BvN0cUSfsSAagRXY4RYrx3d6EUlFr2IKwcNKBftzcfmD
                zgV7YM0TesGJLifaR6JjvKNAm7F5hrgDV5hsLaF/wEqGUA2zkV32wICjsZrymdOehUf8RkbW/3YzTe/3WQj+jMALMPB51DgWLIAAAAASUVORK5CYII=" />
                
                <svg:image
                height="16"
                id="field_type_6"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAACFElEQVR42sSTsWsUURDGfzNvN0ss7hBSJeFUDuJBSPbYcNgJQqwsAlpZqV0KSxH0D7AztZ3YW
                Zh0CkFQMI2KOVwCiYXJKcjtoSByZy63e3tvLXwHwTaF03y8b74HM9/MSFEUnCSUE4YnIhJFUWSMWQfOAF9Ho9G1ZrPZBMblydLS0lVVfXb882g0uuwBxhizAVSste9U9
                YJ7V4HcaY21tqGqWGv3gC5g0zQ98sIwXAYqWZY9ieP4QRiG9ycmJm6EYbgcx/Gmq8Ko6kWA7e3tFWAIZEBXVfUSwGAweAH8dIjjxx6pqs4DNBqND41G42MURbeBVIuiU
                P72kQG/HeJ4A1Cr1c4BJdf3J0CMMfeiKLrlAQIgIhawDhnzgKRp+qvdbtfyPPf7/f7R9PR0ZWZm5pWIrKi19huA53kVQBwy5gEpl8sLc3NzD6vV6lnge7vd3nW5016v1
                9sKggDf91cXFxcPfN9fBej1elv1ej1U1XKSJOdnZ2evBEFQqdfrd4wxNwHyPH+rrVZrP8/zdRGZD4LguYjMD4fDx61W64vneWvGmJdJkjxNkuS9iCz4vr+pqtettXtJk
                jwyAJ1O53WpVNoHDrIs29jZ2VkD0qmpqYmiKHY7nc6bbre7XiqVPo81cRzfPTw8/CFuVAFwCvDdjPuABSZd/siZOuk0ueMGcsxx47AARuMNdGjHC/WPppD/fo1/BgB2y
                t9df1EW0AAAAABJRU5ErkJggg==" />
                
                <svg:image
                height="16"
                id="field_type_7"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAAB4ElEQVR42tTTy0uUARQF8N/3mEcaM+EjE1MXFRVpZpIQoS2Kli16LK19UNC2VrVp0bZV23b9B
                S3ETequIggdQtBI0WzGpsZPxdGZNl9/gasOHLiXC4d7zuUGzWbTQRA6IA4sEAdB8K/OXDX+KhLdbmrO79p9NmN2Cg0EQ4aOFBUeRqI7ofDUvv2pdT/vRf82uWj4cl39e
                F19Oyc3npGZOKbr67Ll0qhL54oKk3v2Wquqn0PhoazsWCyqB4jHjT1IJD8++LiAnnbt5wcNPA6FubLyzaLixBdf3v5S3UEG3VeNv9yx8y7G4Vj8pKxyC9+wWlFZnzO3P
                2DgeUHh6XvTj7CLTdTR39CobkqWwjPOjAaCrkhYwB+sYm7dz6k1a28i0ckRIzewgjWUs7LVSNS6aHEyzMicgjZt19KrNJGcdjrIydWRLSq8GHXpOgJEgwaubdh4vWVrJ
                crIHO/QcTcnN9ylq3LU0e/9+vtice9Hn6a3ba916rySl7/fp3ekT++JisqneaUZlKOaWtTi0JG8fE8svhCLO5etzJSUFrCZSDZqaot5+SgUFn/7PTOvNIsKkgAdOItu1
                LCUet3CPlrQh560X06ZoBkgxuGU0kGSpt1MfefQmma0nYo3IPj/n+nvABOjooQGZOMzAAAAAElFTkSuQmCC" />
                
                <svg:image
                height="16"
                id="field_type_8"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAACXklEQVR42pyQTYiOURiGr/f3nG8+3zfDZBASCzZTU0SizJRSKHvJygYbsdOUjYWFnwUWI0kpQ
                sOkiNJYGDYGC8lPqNGMJs3Cz7zfe855f86x+Ji/bLjrWT0913PfN0wr6u27Mdy1qUfyd0W9F26+nLl3zuEB0RGPTCzuYP+rd1zt3oAd+YgIQIQeIoAogLCjg+5Hb3m+o
                5Pa93G2fXCxcy4PgUolgrVtlosDg3SKjJWLQoIoxo8FnpAgJF+q7VwcGGTz0tXU1ThABchDIJoXQ+HgG1BGEr+lRiAlvmiOiwVWVn/vBdXIA1wEEALMlx7zSkPnjVPUS
                0NQbyWUFTwh8YXAhTH10rH+8XWqhUaG08WEAG0SJk1C26dnEEISgQwgCjwiH0IfFgBVC9IHz58DmDh5l11b1iFFTEtFEkchRWnRJiNVmiRVqKTBZJIybjSfv/6A3TunA
                VobwjBAxBGv34+y59B53g6eZt3Oo4yMTUx9u3buIPWaQGsz24HSGmsdtx8Mc/zsbQCK0vLi3glSpXk49Iprd56ypKOVRCmU1lMAvwkw5EXB9p4u+vsO45xDm4wsy8mLg
                mNn+jmwdyultVhrUXMdaK3RJuNPHOccqdLkRcGVW0Ns6FrFwvYaDaWb3cxw0AQYg9KG0loaWmOdI0kVRVnyZPg93RvXYLKcPC8o8gJtzOwIxmQ0lKaRKlJlsNaSpIpGq
                njzYYwVy9rRWYbJm5HMb7dTDrKsCcjykNaa5OrZAyQNRWktl07tI8+LGZ2UZNlcQF5wuf8+/yMPqAPLgdZ/uPsBjDrnfv4aAGJgOzQ0Reu/AAAAAElFTkSuQmCC" />
                
                <svg:image
                height="16"
                id="field_type_9"
                width="16"
                x="0"
                y="0"
                xlink:href="data:;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAC
                XBIWXMAAAsTAAALEwEAmpwYAAAKTWlDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURn
                EhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AA
                gBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAI
                i4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMz
                gwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9M
                OOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B
                7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQ
                RlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggM
                or8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsC
                F6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kC
                LKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl
                9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1
                akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHOD
                c57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMk
                GPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFS
                os2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xyd
                HXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL
                152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNB
                bsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPq
                Yy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8
                oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbF
                WyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrg
                lc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3Kz
                QM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SN
                o0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snn
                p1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJ
                t0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94
                vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/sl0p8zAAAABGdBTUEAALGOfPtRkwAAACBjS
                FJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAAC9klEQVR42lyTy28bdRDHP7/dtb3ejZ+xm8RWkyitaSktpY0UkiYSzx6gtBJSDwgJceLWSjwu8
                DcgONMTouKCQOQALkRFEAnahFaAFJW2KlJbDKnzcmrHXu+u9/HjkhWGucwcfvOZ+c18RwBMz5zif3YGuAhkgFXgOWAAuAdsAywvVZFSovQl7Qc+B444jrWQMFPvIsSO1
                OLnlpeqd4AA+BOY6q+k9cXnhBDpY3PPvuOH8jXLspTtjTpoifmnTr/R6TxsfKJ69suKoqj9ABH58+99eKhQHF60HbeQHdAoZhOYyRhrm01WbtXkvVpdWJ3O1frff5wu5
                wvb//nC5MzzqUJx6DstFis8Xskzc7TMxFiJy791OXF8P6+cmhRPTz9KOpM5UdpbubC8VI1FHSiAOjV78k2r6wyX8woHxorsG99LPl9g4doa46NlJsbKPDNV4fihUZnN5
                c8+MXtmLupeARKKor7uew4HRwcpjxTJDBjENRBIEqogN2AwXMzx5OGSSKVS5Af3nAViEUBv7rRLuhqQTevEVUHg2lQv/8z6Vov5Sz8R+g5GTKE0aJLLpPxUOvMIEI8AW
                qfTwe5aKASEno3nWly9tkLYvMOV67fwnA4EPWKKxDAMTMNQog1qAK7dfnD3r3DC7XbwEipSBrz/9ku8+kKNYwdLeI5NGAY02zaJpKkJsVHrH6K3Wrv/5WajydeLK9jdN
                p5jo+IxeWAPIvQIPBena3GzLqSu66zev30J8COA+/uvP1x0rJ2NrxZv8O2PN/Bch8BzCf0eod/Ddmyu3G6xZSHarcY3iwtf/AL0IiEpQNHMjsxWHpv+SI0ni0cqIxytj
                JBNG7TtgFrDlz0ZF37Pvv7Zxx+81dis3wSaUkoZKTEBDKlafGLf4bnzqWzxRT1p6oZhYJomST3xcH317oXvq5/OAzVgC/CllP9KeXcteWAIyOSGxsdSmcGc1dp80Fivr
                e1e4TrQAjyAfkD/cSUBY9cru8OyAQtwgDB6LKXknwEAb1wzL9NzB2EAAAAASUVORK5CYII=" />
            </svg:defs>
            
            <svg:g transform="translate({$translate_x},{$translate_y})">
                <xsl:call-template name="table_colors" />
                <xsl:apply-templates select="//relation" />
                <xsl:apply-templates select="//table" />
            </svg:g>
   
        </xsl:element>
    </xsl:template>
    
    <!-- define fill for each table; used by table rect and markers -->
    <xsl:template name="table_colors">
        <xsl:for-each select="//table">
            
            <xsl:variable name="gradient_target_red">
                <xsl:value-of select="255" />
            </xsl:variable>
            
            <xsl:variable name="gradient_target_green">
                <xsl:value-of select="255" />
            </xsl:variable>
            
            <xsl:variable name="gradient_target_blue">
                <xsl:value-of select="255" />
            </xsl:variable>
            
            <xsl:variable name="gradient_start_red">
                <xsl:choose>
                    <xsl:when test="string(number(./table_extra/editor_table_info/color/@red))='NaN'">127</xsl:when>
                    <xsl:when test="number(./table_extra/editor_table_info/color/@red * $table_start_brightness) &gt; 255">
                        <xsl:value-of select="255" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="floor(./table_extra/editor_table_info/color/@red * $table_start_brightness)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="gradient_start_green">
                <xsl:choose>
                    <xsl:when test="string(number(./table_extra/editor_table_info/color/@green))='NaN'">127</xsl:when>
                    <xsl:when test="number(./table_extra/editor_table_info/color/@green * $table_start_brightness) &gt; 255">
                        <xsl:value-of select="255" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="floor(number(./table_extra/editor_table_info/color/@green) * $table_start_brightness)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="gradient_start_blue">
                <xsl:choose>
                    <xsl:when test="string(number(./table_extra/editor_table_info/color/@blue))='NaN'">127</xsl:when>
                    <xsl:when test="number(./table_extra/editor_table_info/color/@blue * $table_start_brightness) &gt; 255">
                        <xsl:value-of select="255" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="floor(number(./table_extra/editor_table_info/color/@blue) * $table_start_brightness)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:call-template name="linear_gradient">
                <xsl:with-param name="linear_gradient_id" select="concat('lg-', @uuid)" />
                <xsl:with-param name="linear_gradient_start" select="concat('rgb(', $gradient_start_red, ',', $gradient_start_green, ',', $gradient_start_blue, ')')" />
                <xsl:with-param name="linear_gradient_stop" select="concat('rgb(', $gradient_target_red, ',', $gradient_target_green, ',', $gradient_target_blue, ')')" />
                <xsl:with-param name="linear_gradient_x1" select="$table_x1" />
                <xsl:with-param name="linear_gradient_x2" select="$table_x2" />
                <xsl:with-param name="linear_gradient_y1" select="$table_y1" />
                <xsl:with-param name="linear_gradient_y2" select="$table_y2" />
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <!-- create marker defs; should be called before reference -->
    <xsl:template name="marker">
        <xsl:param name="table_id_1" />
        <xsl:param name="table_id_n" />
        <xsl:param name="relation_id" />
        <xsl:element name="svg:defs">
            <xsl:element name="svg:marker">
                <xsl:attribute name="orient">
                    <xsl:value-of select="'auto'" />
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="concat($relation_id, '-n')" />
                </xsl:attribute>
                <xsl:attribute name="markerHeight">
                    <xsl:value-of select="$relation_marker_height" />
                </xsl:attribute>
                <xsl:attribute name="markerWidth">
                    <xsl:value-of select="$relation_marker_width" />
                </xsl:attribute>
                <xsl:attribute name="refX">
                    <xsl:value-of select="$relation_marker_refx" />
                </xsl:attribute>
                <xsl:attribute name="refY">
                    <xsl:value-of select="$relation_marker_refy" />
                </xsl:attribute>
                <xsl:element name="svg:circle">
                    <xsl:attribute name="cx">
                        <xsl:value-of select="$relation_marker_cx" />
                    </xsl:attribute>
                    <xsl:attribute name="cy">
                        <xsl:value-of select="$relation_marker_cy" />
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="number(key( 'table_by_uuid', $table_id_n )/table_extra/editor_table_info/color/@red)
                            + number(key( 'table_by_uuid', $table_id_n )/table_extra/editor_table_info/color/@green)
                            + number(key( 'table_by_uuid', $table_id_n )/table_extra/editor_table_info/color/@blue)">
                            <xsl:attribute name="fill">
                                <xsl:value-of select="concat('url(#lg-', $table_id_n, ')' )" />
                            </xsl:attribute>
                            <xsl:attribute name="stroke">
                                <xsl:value-of select="concat('url(#lg-', $table_id_n, ')' )" />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="fill">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                            <xsl:attribute name="stroke">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="r">
                        <xsl:value-of select="$relation_stroke_r" />
                    </xsl:attribute>
                    <xsl:attribute name="stroke-width">
                        <xsl:value-of select="$relation_stroke_width" />
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
            <xsl:element name="svg:marker">
                <xsl:attribute name="orient">
                    <xsl:value-of select="'auto'" />
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="concat($relation_id, '-1')" />
                </xsl:attribute>
                <xsl:attribute name="markerHeight">
                    <xsl:value-of select="$relation_marker_height" />
                </xsl:attribute>
                <xsl:attribute name="markerWidth">
                    <xsl:value-of select="$relation_marker_width" />
                </xsl:attribute>
                <xsl:attribute name="refX">
                    <xsl:value-of select="$relation_marker_refx" />
                </xsl:attribute>
                <xsl:attribute name="refY">
                    <xsl:value-of select="$relation_marker_refy" />
                </xsl:attribute>
                <xsl:element name="svg:polygon">
                    <xsl:attribute name="points">
                        <xsl:value-of select="$relation_marker_polygon" />
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="number(key( 'table_by_uuid', $table_id_1 )/table_extra/editor_table_info/color/@red = 0 )
                            and number(key( 'table_by_uuid', $table_id_1 )/table_extra/editor_table_info/color/@green = 0 )
                            and number(key( 'table_by_uuid', $table_id_1 )/table_extra/editor_table_info/color/@blue =0 )">
                            <xsl:attribute name="fill">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                            <xsl:attribute name="stroke">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="number(key( 'table_by_uuid', $table_id_1 )/table_extra/editor_table_info/color/@red = 255)
                            and number(key( 'table_by_uuid', $table_id_1 )/table_extra/editor_table_info/color/@green = 255 )
                            and number(key( 'table_by_uuid', $table_id_1 )/table_extra/editor_table_info/color/@blue = 255 )">
                            <xsl:attribute name="fill">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                            <xsl:attribute name="stroke">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="fill">
                                <xsl:value-of select="concat('url(#lg-', $table_id_1, ')' )" />
                            </xsl:attribute>
                            <xsl:attribute name="stroke">
                                <xsl:value-of select="concat('url(#lg-', $table_id_1, ')' )" />
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="stroke-width">
                        <xsl:value-of select="$relation_stroke_width" />
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="linear_gradient">
        <xsl:param name="linear_gradient_id" />
        <xsl:param name="linear_gradient_start" />
        <xsl:param name="linear_gradient_stop" />
        <xsl:param name="linear_gradient_x1" />
        <xsl:param name="linear_gradient_x2" />
        <xsl:param name="linear_gradient_y1" />
        <xsl:param name="linear_gradient_y2" />
        <svg:defs>
            <xsl:element name="svg:linearGradient">
                <xsl:attribute name="id">
                    <xsl:value-of select="$linear_gradient_id" />
                </xsl:attribute>
                <xsl:attribute name="x1">
                    <xsl:value-of select="$linear_gradient_x1" />
                </xsl:attribute>
                <xsl:attribute name="y1">
                    <xsl:value-of select="$linear_gradient_y1" />
                </xsl:attribute>
                <xsl:attribute name="x2">
                    <xsl:value-of select="$linear_gradient_x2" />
                </xsl:attribute>
                <xsl:attribute name="y2">
                    <xsl:value-of select="$linear_gradient_y2" />
                </xsl:attribute>
                <xsl:attribute name="spreadMethod">
                    <xsl:value-of select="$table_spread_method" />
                </xsl:attribute>
                <svg:stop offset="{$table_gradient_1}" stop-color="{$linear_gradient_start}" stop-opacity="{$linear_gradient_start_opacity}" />
                <svg:stop offset="{$table_gradient_2}" stop-color="{$linear_gradient_stop}" stop-opacity="{$linear_gradient_stop_opacity}" />
            </xsl:element>
        </svg:defs>
    </xsl:template>
    
    <!-- draw relation lines -->
    <xsl:template match="//relation">
        <svg:g uuid="{@uuid}">
            <xsl:variable name="source_table_id">
                <xsl:value-of select="./related_field[@kind = 'source']/field_ref/table_ref/@uuid" />
            </xsl:variable>
            <xsl:variable name="source_field_id">
                <xsl:value-of select="./related_field[@kind = 'source']/field_ref/@uuid" />
            </xsl:variable>
            <!-- <xsl:variable name="source_x">
             <xsl:value-of select="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/coordinates/@left)" />
             </xsl:variable> -->
            <!-- perhaps @left can be scientific notation too? -->
            <xsl:variable name="source_coordinates_left">
                <xsl:value-of select="key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/coordinates/@left" />
            </xsl:variable>
            <xsl:variable name="source_coordinates_left_e" select="number(substring-after($source_coordinates_left, 'E'))" />
            <xsl:variable name="source_x">
                <xsl:choose>
                    <xsl:when test="$source_coordinates_left_e &lt; 0">
                        <xsl:value-of select="1"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="number($source_coordinates_left)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <!-- <xsl:variable name="source_top">
             <xsl:value-of select="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/coordinates/@top) + 15" />
             </xsl:variable> -->
            <!-- @top counld be a scientific notation if very close to zero -->
            <xsl:variable name="source_coordinates_top">
                <xsl:value-of select="key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/coordinates/@top" />
            </xsl:variable>
            <xsl:variable name="source_coordinates_top_e" select="number(substring-after($source_coordinates_top, 'E'))" />
            <xsl:variable name="source_top">
                <xsl:choose>
                    <xsl:when test="$source_coordinates_top_e &lt; 0">
                        <xsl:value-of select="1"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="number($source_coordinates_top)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="source_bottom">
                <xsl:value-of select="$source_top + number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/coordinates/@height) " />
            </xsl:variable>
            <xsl:variable name="source_width">
                <xsl:value-of select="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/coordinates/@width)" />
            </xsl:variable>
            <!-- <xsl:comment>source_x:<xsl:value-of select="$source_x"/></xsl:comment>
             <xsl:comment>source_width:<xsl:value-of select="$source_width"/></xsl:comment> -->
            <xsl:variable name="source_y">
                <xsl:for-each select="/base/table[@uuid = $source_table_id]/field">
                    <xsl:if test="@uuid = $source_field_id">
                        <xsl:choose>
                            <xsl:when test="($source_top + (position() * $table_row_height)) &lt; $source_bottom">
                                <xsl:value-of select="string($source_top + (position() * $table_row_height))" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$source_bottom + 2" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="destination_table_id">
                <xsl:value-of select="./related_field[@kind = 'destination']/field_ref/table_ref/@uuid" />
            </xsl:variable>
            <xsl:variable name="destination_field_id">
                <xsl:value-of select="./related_field[@kind = 'destination']/field_ref/@uuid" />
            </xsl:variable>
            <!-- <xsl:variable name="destination_x">
             <xsl:value-of select="number(key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/coordinates/@left)" />
             </xsl:variable> -->
            <!-- perhaps @left can be scientific notation too? -->
            <xsl:variable name="destination_coordinates_left">
                <xsl:value-of select="key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/coordinates/@left" />
            </xsl:variable>
            <xsl:variable name="destination_coordinates_left_e" select="number(substring-after($destination_coordinates_left, 'E'))" />
            <xsl:variable name="destination_x">
                <xsl:choose>
                    <xsl:when test="$destination_coordinates_left_e &lt; 0">
                        <xsl:value-of select="1"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="number($destination_coordinates_left)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <!-- <xsl:variable name="destination_top">
             <xsl:value-of select="number(key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/coordinates/@top) + 15" />
             </xsl:variable> -->
            <!-- @top counld be a scientific notation if very close to zero -->
            <xsl:variable name="destination_coordinates_top">
                <xsl:value-of select="key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/coordinates/@top" />
            </xsl:variable>
            <xsl:variable name="destination_coordinates_top_e" select="number(substring-after($destination_coordinates_top, 'E'))" />
            <xsl:variable name="destination_top">
                <xsl:choose>
                    <xsl:when test="$destination_coordinates_top_e &lt; 0">
                        <xsl:value-of select="16"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="number($destination_coordinates_top) + 15"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            
            
            <xsl:variable name="destination_bottom">
                <xsl:value-of select="$destination_top + number(key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/coordinates/@height) " />
            </xsl:variable>
            <xsl:variable name="destination_width">
                <xsl:value-of select="number(key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/coordinates/@width)" />
            </xsl:variable>
            <xsl:variable name="destination_y">
                <xsl:for-each select="key( 'table_by_uuid', $destination_table_id )/field">
                    <xsl:if test="@uuid = $destination_field_id">
                        <xsl:choose>
                            <xsl:when test="($destination_top + (position() * $table_row_height)) &lt; $destination_bottom">
                                <xsl:value-of select="string($destination_top + (position() * $table_row_height))" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$destination_bottom + 2" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="start_x">
                <xsl:choose>
                    <xsl:when test="$destination_x &gt; $source_x">
                        <xsl:value-of select="$source_x + $source_width" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$source_x" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="stop_x">
                <xsl:choose>
                    <xsl:when test="$destination_x &gt; $source_x">
                        <xsl:value-of select="$destination_x" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$destination_x + $destination_width" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="path_type">
                <xsl:choose>
                    <xsl:when test="$destination_y &gt; $source_y">
                        <xsl:choose>
                            <xsl:when test="($destination_y - $source_y) &lt; 10">
                                <xsl:value-of select="'straight'" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'bezier'" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="($source_y - $destination_y) &lt; 10">
                                <xsl:value-of select="'straight'" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'bezier'" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="control_offset">
                <xsl:choose>
                    <xsl:when test="$destination_x &gt; $source_x">
                        <xsl:value-of select="-150" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="150"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="length_horizontal">
                <xsl:choose>
                    <xsl:when test="$stop_x &gt; $start_x">
                        <xsl:value-of select="$stop_x - $start_x" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$start_x - $stop_x" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="length_vertical">
                <xsl:choose>
                    <xsl:when test="$destination_y &gt; $source_y">
                        <xsl:value-of select="$destination_y - $source_y" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$source_y - $destination_y" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="orientation_horizontal">
                <xsl:value-of select="$length_horizontal &gt; $length_vertical" />
            </xsl:variable>
            <xsl:variable name="direction_up">
                <xsl:value-of select="$destination_y &lt; $source_y" />
            </xsl:variable>
            <xsl:variable name="direction_left">
                <xsl:value-of select="$stop_x &lt; $start_x" />
            </xsl:variable>
            
            <xsl:variable name="source_red">
                <xsl:choose>
                    <xsl:when test="string(number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@red)) = 'NaN' ">
                        <xsl:value-of select="$table_default_start_red" />
                    </xsl:when>
                    <xsl:when test="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@red) = 0">
                        <xsl:value-of select="$table_default_start_red" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@red" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="source_green">
                <xsl:choose>
                    <xsl:when test="string(number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@green)) = 'NaN' ">
                        <xsl:value-of select="$table_default_start_green" />
                    </xsl:when>
                    <xsl:when test="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@green) = 0">
                        <xsl:value-of select="$table_default_start_green" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@green" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="source_blue">
                <xsl:choose>
                    <xsl:when test="string(number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@blue)) = 'NaN' ">
                        <xsl:value-of select="$table_default_start_blue" />
                    </xsl:when>
                    <xsl:when test="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@blue) = 0">
                        <xsl:value-of select="$table_default_start_blue" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@blue" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="destination_red">
                <xsl:choose>
                    <xsl:when test="string(number(key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/color/@red)) = 'NaN' ">
                        <xsl:value-of select="$table_default_stop_red" />
                    </xsl:when>
                    <xsl:when test="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@red) = 0">
                        <xsl:value-of select="$table_default_stop_red" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/color/@red" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="destination_green">
                <xsl:choose>
                    <xsl:when test="string(number(key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/color/@green)) = 'NaN' ">
                        <xsl:value-of select="$table_default_stop_green" />
                    </xsl:when>
                    <xsl:when test="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@green) = 0">
                        <xsl:value-of select="$table_default_stop_green" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/color/@green" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="destination_blue">
                <xsl:choose>
                    <xsl:when test="string(number(key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/color/@blue)) = 'NaN' ">
                        <xsl:value-of select="$table_default_stop_blue" />
                    </xsl:when>
                    <xsl:when test="number(key( 'table_by_uuid', $source_table_id )/table_extra/editor_table_info/color/@blue) = 0">
                        <xsl:value-of select="$table_default_stop_blue" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="key( 'table_by_uuid', $destination_table_id )/table_extra/editor_table_info/color/@blue" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:call-template name="linear_gradient">
                <xsl:with-param name="linear_gradient_id" select="concat('lg-', @uuid)" />
                <xsl:with-param name="linear_gradient_start" select="concat('rgb(', number($source_red), ',', number($source_green), ',', number($source_blue), ')')" />
                <xsl:with-param name="linear_gradient_stop" select="concat('rgb(', number($destination_red), ',', number($destination_green), ',', number($destination_blue), ')')" />
                <xsl:with-param name="linear_gradient_x1" select="number( $direction_left = 'true' and orientation_horizontal = 'true' )" />
                <xsl:with-param name="linear_gradient_x2" select="number( $direction_left = 'false' and orientation_horizontal = 'true' )" />
                <xsl:with-param name="linear_gradient_y1" select="number( $direction_up = 'true' )" />
                <xsl:with-param name="linear_gradient_y2" select="number( $direction_up = 'false' )" />
            </xsl:call-template>
            
            <xsl:call-template name="marker">
                <xsl:with-param name="table_id_1" select="./related_field[@kind = 'destination']/field_ref/table_ref/@uuid" />
                <xsl:with-param name="table_id_n" select="./related_field[@kind = 'source']/field_ref/table_ref/@uuid" />
                <xsl:with-param name="relation_id" select="@uuid" />
            </xsl:call-template>
            
            <xsl:choose>
                <xsl:when test="$path_type = 'straight' ">
                    <xsl:element name="svg:path">
                        <xsl:attribute name="d">
                            <xsl:value-of select="concat('M ', $start_x, ' ', $source_y - 5, ' L ', $stop_x, ' ', $destination_y - 5)" />
                        </xsl:attribute>
                        <xsl:attribute name="stroke-width">
                            <xsl:value-of select="3" />
                        </xsl:attribute>
                        <xsl:attribute name="stroke">
                            <xsl:value-of select="concat('url(#lg-', @uuid, ')' )" />
                        </xsl:attribute>
                        <xsl:attribute name="marker-end">
                            <xsl:value-of select="concat('url(#', @uuid, '-1', ')' )" />
                        </xsl:attribute>
                        <xsl:attribute name="marker-start">
                            <xsl:value-of select="concat('url(#', @uuid, '-n', ')' )" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="svg:path">
                        <xsl:attribute name="d">
                            <xsl:value-of select="concat('M ', string($start_x), ' ', string($source_y - 5), ' ',
                            'C ', string($start_x - $control_offset), ' ', string($source_y - 5), ' ', string($stop_x + $control_offset), ' ', string($destination_y - 5), ' ', string($stop_x), ' ', string($destination_y - 5))" />
                        </xsl:attribute>
                        <xsl:attribute name="fill">
                            <xsl:value-of select="'none'" />
                        </xsl:attribute>
                        <xsl:attribute name="stroke-width">
                            <xsl:value-of select="3" />
                        </xsl:attribute>
                        <xsl:attribute name="stroke">
                            <xsl:value-of select="concat('url(#lg-', @uuid, ')' )" />
                        </xsl:attribute>
                        <xsl:attribute name="marker-end">
                            <xsl:value-of select="concat('url(#', @uuid, '-1', ')' )" />
                        </xsl:attribute>
                        <xsl:attribute name="marker-start">
                            <xsl:value-of select="concat('url(#', @uuid, '-n', ')' )" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
            
        </svg:g>
    </xsl:template>
    
    <!-- draw a table -->
    <xsl:template match="//table">
        <svg:g uuid="{@uuid}">
            <xsl:variable name="coordinates_top">
                <xsl:value-of select="./table_extra/editor_table_info/coordinates/@top" />
            </xsl:variable>
            <xsl:variable name="coordinates_top_e" select="number(substring-after($coordinates_top, 'E'))" />
            <xsl:variable name="text_coordinates_top">
                <xsl:choose>
                    <xsl:when test="$coordinates_top_e &lt; 0">
                        <xsl:value-of select="1"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="number($coordinates_top)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="coordinates_left">
                <xsl:value-of select="./table_extra/editor_table_info/coordinates/@left" />
            </xsl:variable>
            <xsl:variable name="coordinates_left_e" select="number(substring-after($coordinates_left, 'E'))" />
            <xsl:variable name="text_coordinates_left">
                <xsl:choose>
                    <xsl:when test="$coordinates_left_e &lt; 0">
                        <xsl:value-of select="1"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="number($coordinates_left)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="text_y">
                <!-- <xsl:value-of select="string(number(./table_extra/editor_table_info/coordinates/@top) + 15)" /> -->
                <xsl:value-of select="string($text_coordinates_top + 15)" />
            </xsl:variable>
            <xsl:variable name="text_x">
                <!-- <xsl:value-of select="string((number(./table_extra/editor_table_info/coordinates/@width) div 2) + number(./table_extra/editor_table_info/coordinates/@left)  )" /> -->
                <xsl:value-of select="string((number(./table_extra/editor_table_info/coordinates/@width) div 2) + $text_coordinates_left)" />
            </xsl:variable>
            <xsl:variable name="text_x_boudary">
                <!-- <xsl:value-of select="number(./table_extra/editor_table_info/coordinates/@left) + 15" /> -->
                <xsl:value-of select="$text_coordinates_left + 15" />
            </xsl:variable>
            <xsl:variable name="text_y_boudary">
                <!-- <xsl:value-of select="number(./table_extra/editor_table_info/coordinates/@top) + number(./table_extra/editor_table_info/coordinates/@height)" /> -->
                <xsl:value-of select="$text_coordinates_top + number(./table_extra/editor_table_info/coordinates/@height)" />
            </xsl:variable>
            <xsl:variable name="text_x_icon">
                <!-- <xsl:value-of select="number(./table_extra/editor_table_info/coordinates/@width) + number($text_coordinates_left) - 18" /> -->
                <xsl:value-of select="number(./table_extra/editor_table_info/coordinates/@width) + $text_coordinates_left - 18" />
            </xsl:variable>
            
            <!-- text color, default is black, but use white if the box is too dark -->
            <xsl:element name="svg:g">
                <xsl:choose>
                    <xsl:when test="number(./table_extra/editor_table_info/color/@red = 255)
                        and number(./table_extra/editor_table_info/color/@green = 255)
                        and number(./table_extra/editor_table_info/color/@blue = 255) ">
                        <xsl:attribute name="fill">
                            <xsl:value-of select="'black'" />
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="number(./table_extra/editor_table_info/color/@red = 0)
                        and number(./table_extra/editor_table_info/color/@green = 0)
                        and number(./table_extra/editor_table_info/color/@blue = 0) ">
                        <xsl:attribute name="fill">
                            <xsl:value-of select="'black'" />
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:when test="((number(./table_extra/editor_table_info/color/@red )
                        + number(./table_extra/editor_table_info/color/@green )
                        + number(./table_extra/editor_table_info/color/@blue ) ) div 3 ) &lt; $table_color_floor ">
                        <xsl:attribute name="fill">
                            <xsl:value-of select="'white'" />
                        </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="'black'" />
                    </xsl:otherwise>
                </xsl:choose>
                <!-- draw table rect -->
                <xsl:element name="svg:rect">
                    <xsl:attribute name="x">
                        <xsl:value-of select="$text_coordinates_left" />
                    </xsl:attribute>
                    <xsl:attribute name="y">
                        <xsl:value-of select="$text_coordinates_top" />
                    </xsl:attribute>
                    <xsl:attribute name="height">
                        <xsl:value-of select="number(./table_extra/editor_table_info/coordinates/@height)" />
                    </xsl:attribute>
                    <xsl:attribute name="width">
                        <xsl:value-of select="number(./table_extra/editor_table_info/coordinates/@width)" />
                    </xsl:attribute>
                    <xsl:attribute name="stroke-width">
                        <xsl:value-of select="$table_stroke_width" />
                    </xsl:attribute>
                    <xsl:attribute name="stroke">
                        <xsl:value-of select="$table_stroke" />
                    </xsl:attribute>
                    
                    <xsl:if test="./table_extra/editor_table_info/color/@alpha">
                        <xsl:attribute name="fill-opacity">
                            <xsl:value-of select="1" />
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:attribute name="rx">
                        <xsl:value-of select="$table_rx" />
                    </xsl:attribute>
                    <xsl:attribute name="ry">
                        <xsl:value-of select="$table_ry" />
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="number(./table_extra/editor_table_info/color/@red = 255)
                            and number(./table_extra/editor_table_info/color/@green = 255)
                            and number(./table_extra/editor_table_info/color/@blue = 255) ">
                            <xsl:attribute name="fill">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="number(./table_extra/editor_table_info/color/@red = 0)
                            and number(./table_extra/editor_table_info/color/@green = 0)
                            and number(./table_extra/editor_table_info/color/@blue = 0) ">
                            <xsl:attribute name="fill">
                                <xsl:value-of select="'url(#default)'" />
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="fill">
                                <xsl:value-of select="concat('url(', '#', 'lg-', @uuid, ')')" />
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                
                <xsl:element name="svg:line">
                    <xsl:attribute name="x1">
                        <xsl:value-of select="$text_coordinates_left" />
                    </xsl:attribute>
                    <xsl:attribute name="x2">
                        <xsl:value-of select="$text_coordinates_left + number(./table_extra/editor_table_info/coordinates/@width)" />
                    </xsl:attribute>
                    <xsl:attribute name="y1">
                        <xsl:value-of select="$text_coordinates_top + $table_row_height" />
                    </xsl:attribute>
                    <xsl:attribute name="y2">
                        <xsl:value-of select="$text_coordinates_top + $table_row_height" />
                    </xsl:attribute>
                    <xsl:attribute name="stroke-width">
                        <xsl:value-of select="$table_stroke_width_separator" />
                    </xsl:attribute>
                    <xsl:attribute name="stroke">
                        <xsl:value-of select="$table_stroke_separator" />
                    </xsl:attribute>
                </xsl:element>
                
                <xsl:element name="svg:text">
                    <xsl:attribute name="text-anchor">
                        <xsl:value-of select="'middle'" />
                    </xsl:attribute>
                    <xsl:attribute name="x">
                        <xsl:value-of select="$text_x" />
                    </xsl:attribute>
                    <xsl:attribute name="y">
                        <xsl:value-of select="$text_y" />
                    </xsl:attribute>
                    <xsl:value-of select="./@name" />
                </xsl:element>
                <!-- draw field titles -->
                <xsl:for-each select="./field">
                    <xsl:if test="$text_y_boudary &gt; ($text_y + (position() * $table_row_height))">
                        <xsl:element name="svg:text">
                            <xsl:attribute name="text-anchor">
                                <xsl:value-of select="'start'" />
                            </xsl:attribute>
                            <xsl:attribute name="x">
                                <xsl:value-of select="$text_x_boudary" />
                            </xsl:attribute>
                            <xsl:attribute name="y">
                                <xsl:value-of select="$text_y + (position() * $table_row_height)" />
                            </xsl:attribute>
                            <xsl:if test="./index_ref/@uuid">
                                <xsl:attribute name="font-weight">
                                    <xsl:value-of select="'bold'" />
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="./field_extra/@visible = false()">
                                <xsl:attribute name="font-style">
                                    <xsl:value-of select="'italic'" />
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="../primary_key/@field_uuid = @uuid">
                                <xsl:attribute name="text-decoration">
                                    <xsl:value-of select="'underline'" />
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="@name"/>
                        </xsl:element>
                        <!-- draw field type icons -->
                        <svg:g transform="translate({$text_x_icon}, {number($text_y) + (position() * $table_row_height) - 13} )">
                            <xsl:choose>
                                <xsl:when test="@type = 1">
                                    <!-- <svg:use xlink:href="url(#field_type_1)"/> -->
                                    <svg:use xlink:href="#field_type_1"/>
                                </xsl:when>
                                <xsl:when test="@type = 3">
                                    <!-- <svg:use xlink:href="url(#field_type_3)"/> -->
                                    <svg:use xlink:href="#field_type_3"/>
                                </xsl:when>
                                <xsl:when test="@type = 4">
                                    <!-- <svg:use xlink:href="url(#field_type_4)"/> -->
                                    <svg:use xlink:href="#field_type_4"/>
                                </xsl:when>
                                <xsl:when test="@type = 5">
                                    <!-- <svg:use xlink:href="url(#field_type_5)"/> -->
                                    <svg:use xlink:href="#field_type_5"/>
                                </xsl:when>
                                <xsl:when test="@type = 6">
                                    <!-- <svg:use xlink:href="url(#field_type_6)"/> -->
                                    <svg:use xlink:href="#field_type_6"/>
                                </xsl:when>
                                <xsl:when test="@type = 7">
                                    <!-- <svg:use xlink:href="url(#field_type_7)"/> -->
                                    <svg:use xlink:href="#field_type_7"/>
                                </xsl:when>
                                <xsl:when test="@type = 8">
                                    <!-- <svg:use xlink:href="url(#field_type_8)"/> -->
                                    <svg:use xlink:href="#field_type_8"/>
                                </xsl:when>
                                <xsl:when test="@type = 9">
                                    <!-- <svg:use xlink:href="url(#field_type_9)"/> -->
                                    <svg:use xlink:href="#field_type_9"/>
                                </xsl:when>
                                <xsl:when test="@type = 12">
                                    <!-- <svg:use xlink:href="url(#field_type_12)"/> -->
                                    <svg:use xlink:href="#field_type_12"/>
                                </xsl:when>
                                <xsl:when test="@type = 14">
                                    <!-- <svg:use xlink:href="url(#field_type_14)"/> -->
                                    <svg:use xlink:href="#field_type_14"/>
                                </xsl:when>
                                <xsl:when test="@type = 15">
                                    <!-- <svg:use xlink:href="url(#field_type_15)"/> -->
                                    <svg:use xlink:href="#field_type_15"/>
                                </xsl:when>
                                <xsl:when test="@type = 16">
                                    <!-- <svg:use xlink:href="url(#field_type_16)"/> -->
                                    <svg:use xlink:href="#field_type_16"/>
                                </xsl:when>
                                <xsl:when test="@type = 21">
                                    <!-- <svg:use xlink:href="url(#field_type_21)"/> -->
                                    <svg:use xlink:href="#field_type_21"/>
                                </xsl:when>
                                <xsl:when test="@type = 18">
                                    <!-- <svg:use xlink:href="url(#field_type_18)"/> -->
                                    <svg:use xlink:href="#field_type_18"/>
                                </xsl:when>
                                <xsl:when test="@type = 10">
                                    <xsl:choose>
                                        <xsl:when test="@limiting_length">
                                            <!-- <svg:use xlink:href="url(#field_type_10)"/> -->
                                            <svg:use xlink:href="#field_type_10"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <!-- <svg:use xlink:href="url(#field_type_14)"/> -->
                                            <svg:use xlink:href="#field_type_14"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                            </xsl:choose>
                        </svg:g>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
            <!-- print footnote for undrawn fields -->
            <xsl:if test="count(./field[ ($text_y + (position() * $table_row_height)) &gt; $text_y_boudary])">
                <xsl:element name="svg:text">
                    <xsl:attribute name="text-anchor">
                        <xsl:value-of select="'start'" />
                    </xsl:attribute>
                    <xsl:attribute name="x">
                        <xsl:value-of select="$text_x_boudary" />
                    </xsl:attribute>
                    <xsl:attribute name="y">
                        <xsl:value-of select="$text_y_boudary + $table_row_height" />
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="count(./field[ ($text_y + (position() * $table_row_height)) &gt; ($text_y_boudary + $table_margin_y) ]) = 1">
                            <xsl:value-of select="'1 more field'" />
                        </xsl:when>
                        <xsl:when test="count(./field[ ($text_y + (position() * $table_row_height)) &gt; ($text_y_boudary + $table_margin_y) ]) = 0">
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(string(count(./field[ ($text_y + (position() * $table_row_height)) &gt; ($text_y_boudary + $table_margin_y) ])), ' more fields' )" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:if>
        </svg:g>
    </xsl:template>
    
</xsl:stylesheet>

