## NAME:
	bashgpt - Integration between chatgpt and bash terminal

## CREATORS:
	Kshitij Saxena, Rajat Govil, Yashasvi Khare, Sparsh Kaudinya, Hashim 

## SYNOPSIS:
	bashgpt [DOMAIN] "QUESTION"
	bashgpt CTSSUM [OPTIONS] [FILE...]
	bashgpt [INFO]

## DESCRIPTION: 
	This Project attempts to integrate the functionality of chatgpt to the bash terminal along with the added usability of CTS log file.
	bashgpt asks the QUESTION under the DOMAIN specified from chatgpt and outputs it onto the terminal.

## INFO:
	--help 
		Output a usage message and exit.
	
	-V, --version
		Outputs the version number of bashgpt and exit.
	
	-m, --maxtokens NUM
		GPT responses will be of maximum NUM words.
		
	-k, -K, -Key, -key [Valid_API_Key]
		Outputs your current API key being used if no arguement given, otherwise, overwrites the old with the new key provided.
		
## CTSSUM:
	Cts Log File Summerizer
	OPTIONS:
		-1 [Log File (.logv)]
			Outputs Cell Count & Capacitance
		-2 [Log File (.logv)]
			Ouputs OPDesign Summary PreCTS
		-3 [Log File (.logv)]
			Ouputs OPDesign Summary PostCTS
		-4 [Log File (.logv)]
			Outputs detail about DRV Violators
		-5 [Skew Group File (.rpt)]
			Ouputs Explicit Path Details
		-6 [Skew Group File (.rpt)]
			Ouputs Clock Sinks per Skew Groups
		-7 [Skew Group File (.rpt)]
			Min And Max Path For A Given Clock At A Delay Corner
		When using no option, the user will be prompted by a menu to guide them.
