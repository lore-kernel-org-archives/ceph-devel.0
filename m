From: "Talyansky, Roman" <roman.talyansky@sap.com>
Subject: Write operation is stuck
Date: Wed, 10 Feb 2010 22:26:32 +0100
Message-ID: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0888458386243550241=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
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
List-Id: ceph-devel.vger.kernel.org

--===============0888458386243550241==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7DDEWDFECCR01wd_"

--_000_C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7DDEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

Recently I ran three application  instances simultaneously over a mounted C=
EPH file system and one of them got stuck calling a write operation.
I had the following CEPH configuration:
-       The nodes have Debian installation - lenny  , unstable
-       Three nodes with osd servers
-       Three client nodes
-       One client node among the three mentioned above was located at a no=
de where an osd server ran.

Can the origin of the problem be the client collocated with an osd server?
Can you help me to resolve this issue?

Thanks and regards,

Roman

--

Roman Talyansky
SAP Research, Israel

T +972 777 5538
M +972 3388 032
mailto:roman.talyansky@sap.com





--_000_C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7DDEWDFECCR01wd_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri, sans-serif" size=3D"2">
<div>Hello,</div>
<div>&nbsp;</div>
<div>Recently I ran three application&nbsp; instances simultaneously over a=
 mounted CEPH file system and one of them got stuck calling a write operati=
on.</div>
<div>I had the following CEPH configuration:</div>
<ul style=3D"margin-top: 0pt; margin-bottom: 0pt; margin-left: 36pt; ">
<li>The nodes have Debian installation &#8211; lenny &nbsp;, unstable</li><=
li>Three nodes with osd servers</li><li>Three client nodes</li><li>One clie=
nt node among the three mentioned above was located at a node where an osd =
server ran.</li></ul>
<div>&nbsp;</div>
<div>Can the origin of the problem be the client collocated with an osd ser=
ver?</div>
<div>Can you help me to resolve this issue?</div>
<div>&nbsp;</div>
<div>Thanks and regards,</div>
<div>&nbsp;</div>
<div>Roman</div>
<div>&nbsp;</div>
<div>--</div>
<div>&nbsp;</div>
<div><font face=3D"Arial, sans-serif" size=3D"1"><b>Roman Talyansky<br>

</b>SAP Research, Israel </font></div>
<div style=3D"margin-top: 5pt; margin-bottom: 5pt; "><font face=3D"Arial, s=
ans-serif" size=3D"1">T &#43;972 777 5538<br>

M &#43;972 3388 032<br>

<a href=3D"mailto:roman.talyansky@sap.com">mailto:roman.talyansky@sap.com</=
a><br>

</font></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7DDEWDFECCR01wd_--


--===============0888458386243550241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============0888458386243550241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============0888458386243550241==--
