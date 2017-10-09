DEPRECATED -- read the files in out/

package langs;

%langs=(
	"ar"=>["Arabic","0"],
	"bn"=>["Bengali","1"],
	"br"=>["Breton","2"],
	"ca"=>["Catalan","3"],
	"cy"=>["Welsh","4"],
	"de"=>["German","5"],
	"el"=>["Greek","6"],
	"en"=>["English","7"],
	"eo"=>["Esperanto","8"],
	"es"=>["Spanish","9"],
	"eu"=>["Basque","a"],
	"fr"=>["French","b"],
	"gl"=>["Galician","c"],
	"ht"=>["Haitian","d"],
	"it"=>["Italian","e"],
	"ja"=>["Japanese","f"],
	"lv"=>["Latvian","g"],
	"nds"=>["Low Saxon","h"],
	"nl"=>["Dutch","i"],
	"oc"=>["Occitan","j"],
	"pl"=>["Polish","k"],
	"pt"=>["Portuguese","l"],
	"ru"=>["Russian","m"],
	"sk"=>["Slovak","n"],
	"sr"=>["Serbian","o"],
	"sv"=>["Swedish","p"],
	"vi"=>["Vietnamese","q"],
	"zh"=>["Chinese","r"]
);

%hardset=(
	"ar"=>"0",
	"bn"=>"1",
	"br"=>"2",
	"ca"=>"3",
	"cy"=>"4",
        "de"=>"5",
        "el"=>"6",
        "en"=>"7",
        "eo"=>"8",
        "es"=>"9",
        "eu"=>"Basque",
        "fr"=>"French",
        "gl"=>"Galician",
        "ht"=>"Haitian",
        "it"=>"Italian",
        "ja"=>"Japanese",
        "lv"=>"Latvian",
        "nds"=>"Low Saxon",
        "nl"=>"Dutch",
        "oc"=>"Occitan",
        "pl"=>"Polish",
        "pt"=>"Portuguese",
        "ru"=>"Russian",
        "sk"=>"Slovak",
        "sr"=>"Serbian",
        "sv"=>"Swedish",
        "vi"=>"Vietnamese",
        "zh"=>"Chinese"

);

sub get_names() 
{
    my %names=(
	"ar"=>"Arabic",
	"bn"=>"Bengali",
	"br"=>"Breton",
	"ca"=>"Catalan",
	"cy"=>"Welsh",
        "de"=>"German",
        "el"=>"Greek",
        "en"=>"English",
        "eo"=>"Esperanto",
        "es"=>"Spanish",
        "eu"=>"Basque",
        "fr"=>"French",
        "gl"=>"Galician",
        "ht"=>"Haitian",
        "it"=>"Italian",
        "ja"=>"Japanese",
        "lv"=>"Latvian",
        "nds"=>"Low Saxon",
        "nl"=>"Dutch",
        "oc"=>"Occitan",
        "pl"=>"Polish",
        "pt"=>"Portuguese",
        "ru"=>"Russian",
        "sk"=>"Slovak",
        "sr"=>"Serbian",
        "sv"=>"Swedish",
        "vi"=>"Vietnamese",
        "zh"=>"Chinese"
	);

    return %names;
}

1;
