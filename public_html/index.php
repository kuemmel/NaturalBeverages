<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
	<HEAD>
		<TITLE>Praxi | JAVA COMPILER</TITLE>
		<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
		<META http-equiv=imagetoolbar content=no><LINK href="http://praxi.mt.haw-hamburg.de:8081/~witt/assets/hc_css.css" type=text/css rel=stylesheet>
	</HEAD>
	
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0">
	
	
	
	<!-- // start main table (gradientBG) -->
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TR>
		<TD bgColor=#636a72 colSpan=5><IMG height=33 hspace=0 src="http://praxi.mt.haw-hamburg.de:8081/~daniel/assets/spacer.gif" width=1 border=0></TD>
	</TR>
	<TR>
		<TD vAlign=top>
			<IMG height=331 hspace=0 src="http://praxi.mt.haw-hamburg.de:8081/~witt/assets/gradient3.gif" width="100%" border=0>
		</TD>
		<TD vAlign=top width=1>
			<IMG height=331 hspace=0 src="http://praxi.mt.haw-hamburg.de:8081/~witt/assets/gradient_shadow_left.gif" width=17 border=0>
		</TD>
    <TD vAlign=top align=middle width=600>

    	<!-- // start sheet table (whiteBG) -->
			<TABLE cellSpacing=0 cellPadding=0 width=600 border=0>
				<TR>
					<TD valign=middle background="http://praxi.mt.haw-hamburg.de:8081/~witt/assets/headerBG.gif" class="tableheader">
						Praxi JAVA COMPILER
					</TD>
				</TR>
				<TR>
					<TD class="content">

						<!-- form START -->
						<?php
						
						$path = dirname($_SERVER["SCRIPT_FILENAME"]).'/WEB-INF/classes/';
						preg_match("/\/([a-z]{1}[0-9]{2})\//",$path,$m);
						$userdir = $m[1];
						// compile
						if($_POST["submitok"])
						{
							$jd = trim($_POST["javafile"]);
							if(preg_match("/\.java$/",$jd) && is_file($path.$jd))
							{
								$r = shell_exec('/home/compilejava.sh '.$path.$jd. ' '.$userdir.' 2>&1 ');
								
								if(empty($r)){
									print("<br/>".$jd." wurde um ".date("H:i:s")." erfolgreich kompiliert: ");
									print("<a href='http://praxi.mt.haw-hamburg.de".dirname($_SERVER["PHP_SELF"])."/servlet/".str_replace(".java","",$jd)."'  target='_new' >&gt;&gt; zum Servlet</a>");
								}else{
									echo "<br/><span style='background-color:red;color:#fff;padding:3px;margin-top:10px'>Beim Kompilieren ist ein Fehler aufgetreten!</span>";
									echo "<pre style='line-height:150%;color:#fff;background-color:#000;border:1px dotted #888;padding:4px;margin-top:8px;'>".$r."</pre>";
								}
								
								?><br/><br/>
								<input type="button" class="button" onClick="location.reload();" value="Kompilierung wiederholen">
								<?
							}
						} else {
						
						
						?>
						
						Dies ist der Java-Servlet-Compiler auf Praxi. W&auml;hle unten Deine Hauptklasse und klicke dann <i>Datei kompilieren</i>.<br><br>
						Sollte die gesuchte Datei nicht in der Liste auftauchen, stelle sicher, dass die folgenden Voraussetzungen erf&uuml;llt sind:<br>
						Die Klassendateien m&uuml;ssen die Endung <i>.class</i> haben und auf Praxi in Deinem Benutzer-Verzeichnis unter <i>public_html/WEB-INF/classes/</i> liegen.<br><br>
						
						<form method="post" action="<?=$_SERVER["PHP_SELF"];?>">
						<select name="javafile" class="filechooser">
						
						<?
						$handle = opendir($path);
						while ($file = readdir ($handle)) {
						    if($file != "." && $file != "..") {
						        if(is_file($path."/".$file) && stristr($file,".java")) {
						            ?>
									<option value="<?=$file?>"><?=$file?></option>
									<?
						        }
						    }
						}
						closedir($handle);
						
						?>
						</select>
						
						<input type="submit" class="button" name="submitok" value="Datei kompilieren">
							</form>
					<? } ?>
						<!-- form END-->

					</TD>
				</TR>
			</TABLE>
			<!-- // end sheet table (whiteBG) --></TD>

			<TD vAlign=top width=1>
				<IMG height=331 hspace=0 src="http://praxi.mt.haw-hamburg.de:8081/~witt/assets/gradient_shadow_right.gif" width=17 border=0>
			</TD>
			<TD vAlign=top>
				<IMG height=331 hspace=0 src="http://praxi.mt.haw-hamburg.de:8081/~witt/assets/gradient3.gif" width="100%" border=0>
			</TD>
		</TR>
  <TR>

	<TD bgColor=#adb2b6 colSpan=5>
		<IMG height=34 hspace=0 src="http://praxi.mt.haw-hamburg.de:8081/~witt/assets/spacer.gif" width=1 border=0>
	</TD>
</TR>
</TABLE>
<!-- // end main table (gradientBG) -->

	</BODY>
</HTML>

