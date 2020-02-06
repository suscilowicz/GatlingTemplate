#!/bin/bash

function getFolders(){
    for var in "$@"
    do
         echo "$var"
    done
}

function folders(){
    for var in $getFolders $(ls -d */ | sed -e "s/\///g")
    do
         echo "<option value="./$var/index.html">$var</option>"
    done
}

function firstReport(){
    set -- $getFolders $(ls -d */ | sed -e "s/\///g")
    echo "./$1/index.html"
}

cat << _EOF_
<!DOCTYPE html>
<html>

  <head>
    <title>Change src value of iframe dynamically</title>
    <script type="text/javascript">
     function newSrc() {
      var e = document.getElementById("MySelectMenu");
      var newSrc = e.options[e.selectedIndex].value;
      document.getElementById("MyFrame").src=newSrc;
     }
    </script>
  </head>

  <body>
  <div>
  List of reports:
  <select id="MySelectMenu" onChange="newSrc();">
     $(folders)
    </select>
  <div>
    <div style="margin:0px;padding:0px;overflow:hidden;height:900px">
    <iframe src=$(firstReport) width="100%" height="100%" frameborder="0" id="MyFrame"></iframe>
    </div>
    
  </body>

</html>
_EOF_


