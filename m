From: "Magarshak, Roman" <roman.magarshak@sap.com>
Subject: Re: Problem on ceph configuration
Date: Thu, 14 Jan 2010 17:01:33 +0100
Message-ID: <8C507B5E0BA5114E933C3C6E2E9729E005ECB4211B@DEWDFECCR01.wdf.sap.corp>
References: <8C507B5E0BA5114E933C3C6E2E9729E005ECB42098@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7740020738304660422=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8C507B5E0BA5114E933C3C6E2E9729E005ECB42098@DEWDFECCR01.wdf.sap.corp>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
Cc: "Talyansky, Roman" <roman.talyansky@sap.com>
List-Id: ceph-devel.vger.kernel.org

--===============7740020738304660422==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8C507B5E0BA5114E933C3C6E2E9729E005ECB4211BDEWDFECCR01wd_"

--_000_8C507B5E0BA5114E933C3C6E2E9729E005ECB4211BDEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all ,
  I've forgot to mention that the problems is , that the kernel client gets=
 stuck and any other mount tries fail.


\Roman.


Roman Magarshak
Intern
SAP Research Israel
T   +972   9 777 9853
M  +972 54 464 0910
E   mailto:roman.magarshak@sap.com

From: Magarshak, Roman [mailto:roman.magarshak@sap.com]
Sent: Thursday, January 14, 2010 5:25 PM
To: ceph-devel@lists.sourceforge.net
Cc: Talyansky, Roman
Subject: [LIKELY JUNK][ceph-devel] Problem on ceph configuration

Hi all ,
  We have tried to run ceph on 2 nodes without btrfs and encountered the fo=
llowing problem?

The system:
2 Virtual (on vmware) 32 bit machines , running Debian Lenny  unstable
Both have access to NFS (where the configuration file is kept)

Kernel version:  2.6.32-trunk-vserver-686
Ceph is installed from tar.gz including kernel and fuse clients (version 0.=
18)
Ceph1=3D10.26.236.93
Ceph2=3D10.26.236.94
On both servers /ceph /ceph/out /ceph/log exists.

The scenario:

On ceph1 the following commands are executed:
$ mkcephfs --allhosts -c /mnt/nfs/ceph/ceph.conf
$ /etc/init.d/ceph -a -c /mnt/nfs/ceph/ceph.conf start

After that the cmds , cmon, cosd are running

Now the following commands on ceph2 are executed:
$ mount -t ceph ceph1:6789:/ /mnt/ceph
The mount succeeds
After 'ls' and 'touch' commands, the console gets stuck.
Dmesg log  is attached.

On ceph1 cmds no longer appears on ps.

Ceph2 console gets stuck, and umount is no longer possible.
Mds logs, configuration files and dmesg logs are attached.


Has anyone encountered a similar problem?


Thank you in advance for your help.
\Roman
Roman Magarshak
Intern
SAP Research Israel
T   +972   9 777 9853
M  +972 54 464 0910
E   mailto:roman.magarshak@sap.com


--_000_8C507B5E0BA5114E933C3C6E2E9729E005ECB4211BDEWDFECCR01wd_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Hi all , <o:p></o:p></sp=
an></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp; I&#8217;ve forgot=
 to mention
that the problems is , that the kernel client gets stuck and any other moun=
t
tries fail.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>\Roman.<o:p></o:p></span=
></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<div>

<p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt=
:auto'><b><span
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:blue'>Roma=
n
Magarshak</span></b><span style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif";
color:#1F497D'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:#7F7F7F'>Intern</span><span style=3D'font-size:12.0pt;font-family:"Ti=
mes New Roman","serif";
color:#1F497D'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:#7F7F7F'>SAP Research Israel</span><span style=3D'font-size:12.0pt;
font-family:"Times New Roman","serif";color:#1F497D'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:gray'>T&nbsp;&nbsp; +972&nbsp;&nbsp; 9 777 9853</span><span
style=3D'font-size:12.0pt;font-family:"Times New Roman","serif";color:#1F49=
7D'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:gray'>M&nbsp; +972 54 464 0910</span><span style=3D'font-size:12.0pt;
font-family:"Times New Roman","serif";color:#1F497D'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:gray'>E&nbsp;&nbsp; <a href=3D"mailto:roman.magarshak@sap.com">mailto=
:roman.magarshak@sap.com</a></span><span
style=3D'font-size:12.0pt;font-family:"Times New Roman","serif";color:#1F49=
7D'><o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in'>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Tahoma=
","sans-serif"'>From:</span></b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Magarshak, Ro=
man
[mailto:roman.magarshak@sap.com] <br>
<b>Sent:</b> Thursday, January 14, 2010 5:25 PM<br>
<b>To:</b> ceph-devel@lists.sourceforge.net<br>
<b>Cc:</b> Talyansky, Roman<br>
<b>Subject:</b> [LIKELY JUNK][ceph-devel] Problem on ceph configuration<o:p=
></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Hi all , <o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; We have tried to run ceph on 2 nodes without bt=
rfs
and encountered the following problem?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><b>The system:<o:p></o:p></b></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>2 Virtual (on vmware) 32=
 bit
machines , running Debian Lenny&nbsp; unstable<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Both have access to NFS =
(where
the configuration file is kept)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Kernel version:&nbsp;
2.6.32-trunk-vserver-686<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Ceph is installed from t=
ar.gz
including kernel and fuse clients (version 0.18)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Ceph1=3D10.26.236.93<o:p=
></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Ceph2=3D10.26.236.94<o:p=
></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>On both servers /ceph /c=
eph/out
/ceph/log exists.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><b><span style=3D'color:#1F497D'>The scenario: <o:p></=
o:p></span></b></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>On ceph1 the following c=
ommands
are executed:<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>$ mkcephfs --allhosts -c
/mnt/nfs/ceph/ceph.conf<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>$ /etc/init.d/ceph -a -c
/mnt/nfs/ceph/ceph.conf start<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>After that the cmds , cm=
on, cosd
are running<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Now the following comman=
ds on
ceph2 are executed:<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>$ mount -t ceph ceph1:67=
89:/
/mnt/ceph<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>The mount succeeds<o:p><=
/o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>After &#8216;ls&#8217; a=
nd
&#8216;touch&#8217; commands, the console gets stuck.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Dmesg log&nbsp; is attac=
hed.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>On ceph1 cmds no longer =
appears
on ps.<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Ceph2 console gets stuck, and umount is no longer poss=
ible.<o:p></o:p></p>

<p class=3DMsoNormal>Mds logs, configuration files and dmesg logs are attac=
hed.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Has anyone encountered a similar problem?<o:p></o:p></=
p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thank you in advance for your help.<o:p></o:p></p>

<p class=3DMsoNormal>\Roman<o:p></o:p></p>

<p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt=
:auto'><b><span
style=3D'font-size:10.0pt;font-family:"Arial","sans-serif";color:blue'>Roma=
n
Magarshak</span></b><span style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'>
<br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:#7F7F7F'>Intern</span><span style=3D'font-size:12.0pt;font-family:"Ti=
mes New Roman","serif"'>
<br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:#7F7F7F'>SAP Research Israel</span><span style=3D'font-size:12.0pt;
font-family:"Times New Roman","serif"'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:gray'>T&nbsp;&nbsp; +972&nbsp;&nbsp; 9 777 9853</span><span
style=3D'font-size:12.0pt;font-family:"Times New Roman","serif"'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:gray'>M&nbsp; +972 54 464 0910</span><span style=3D'font-size:12.0pt;
font-family:"Times New Roman","serif"'> <br>
</span><span style=3D'font-size:7.5pt;font-family:"Arial","sans-serif";
color:gray'>E&nbsp;&nbsp; <a href=3D"mailto:roman.magarshak@sap.com">mailto=
:roman.magarshak@sap.com</a></span><span
style=3D'font-size:12.0pt;font-family:"Times New Roman","serif"'><o:p></o:p=
></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</div>

</body>

</html>

--_000_8C507B5E0BA5114E933C3C6E2E9729E005ECB4211BDEWDFECCR01wd_--


--===============7740020738304660422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============7740020738304660422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============7740020738304660422==--
