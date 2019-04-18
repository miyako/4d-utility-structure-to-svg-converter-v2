# 4d-utility-structure-to-svg-converter-v2
Create visual image of 4D structure (SVG or PDF)

### Platform

| carbon | cocoa | win32 | win64 |
|:------:|:-----:|:---------:|:---------:|
|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|

**Warning**: Not tested on 32-bit

### Version

<img src="https://user-images.githubusercontent.com/1725068/41266195-ddf767b2-6e30-11e8-9d6b-2adf6a9f57a5.png" width="32" height="32" />

### Usage

```
$structurePath:=Get 4D folder(Current resources folder)+"InvoicesDemo.xml"

$createSVG:=False  //else PDF

If ($createSVG)
	
	  //convert xml to svg
	C_OBJECT($result)
	$result:=convert_structure_to_svg ($structurePath)
	$svgParth:=Temporary folder+Path to object($structurePath).name+".svg"
	WRITE PICTURE FILE($svgParth;$result.svg;".svg")
	OPEN URL($svgParth;"Safari")
	
Else 
	
	$pdfPath:=System folder(Desktop)+"InvoicesDemo.pdf"
	
	  //store current print settings
	C_OBJECT($currentPrintSettings)
	
	C_REAL($left;$top;$right;$bottom)
	GET PRINTABLE MARGIN($left;$top;$right;$bottom)
	
	C_LONGINT($destination)
	GET PRINT OPTION(Destination option;$destination)
	
	$currentPrintSettings:=New object(\
	"name";Get current printer;\
	"destination";$destination;\
	"margin";New object(\
	"left";$left;\
	"top";$top;\
	"right";$right;\
	"bottom";$bottom)\
	)
	
	  //target pdf
	If (Is Windows)
		SET CURRENT PRINTER(Generic PDF driver)
		SET PRINT OPTION(Destination option;2;$pdfPath)
	Else 
		
		SET PRINT OPTION(Destination option;3;$pdfPath)
	End if 
	
	  //convert xml to pdf
	C_OBJECT($result)
	$result:=print_structure ($structurePath)
	
	OPEN URL($pdfPath)
	
	  //restore original print settings
	SET CURRENT PRINTER($currentPrintSettings.name)
	SET PRINT OPTION(Destination option;$currentPrintSettings.destination)
	SET PRINTABLE MARGIN(\
	$currentPrintSettings.margin.left;\
	$currentPrintSettings.margin.top;\
	$currentPrintSettings.margin.right;\
	$currentPrintSettings.margin.bottom)
	
End if 
```
