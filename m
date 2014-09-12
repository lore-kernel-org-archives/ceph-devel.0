From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Regarding key/value interface
Date: Fri, 12 Sep 2014 01:11:57 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2139055991=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Haomai Wang
	(haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org)" <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2139055991==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176SACMBXIP02sdcor_"

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176SACMBXIP02sdcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Sage/Haomai,
If I have a key/value backend that support transaction, range queries (and =
I don't need any explicit caching etc.) and I want to replace filestore (an=
d leveldb omap) with that,  which interface you recommend me to derive from=
 , directly ObjectStore or  KeyValueDB ?
I have already integrated this backend by deriving from ObjectStore interfa=
ces earlier (pre keyvalueinteface days) but not tested thoroughly enough to=
 see what functionality is broken (Basic functionalities of RGW/RBD are wor=
king fine).
Basically, I want to know what are the advantages (and disadvantages) of de=
riving it from the new key/value interfaces ?
Also, what state is it in ? Is it feature complete and supporting all the O=
bjectStore interfaces like clone and all ?

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).


--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176SACMBXIP02sdcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Sage/Haomai,<o:p></o:p></p>
<p class=3D"MsoNormal">If I have a key/value backend that support transacti=
on, range queries (and I don&#8217;t need any explicit caching etc.) and I =
want to replace filestore (and leveldb omap) with that, &nbsp;which interfa=
ce you recommend me to derive from , directly
 ObjectStore or &nbsp;<span style=3D"color:black;background:white;mso-highl=
ight:white">KeyValueDB</span><span style=3D"color:black"> ?<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:black">I have already integrate=
d this backend by deriving from ObjectStore interfaces earlier (pre keyvalu=
einteface days) but not tested thoroughly enough to see what functionality =
is broken (Basic functionalities of
 RGW/RBD are working fine).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Basically, I want to kno=
w what are the advantages (and disadvantages) of deriving it from the new k=
ey/value interfaces ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Also, what state is it i=
n ? Is it feature complete and supporting all the ObjectStore interfaces li=
ke clone and all ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks &amp; Regards<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Somnath</span><o:p></o:p=
></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"2"><br>
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this
 message in error and that any review, dissemination, distribution, or copy=
ing of this message is strictly prohibited. If you have received this commu=
nication in error, please notify the sender by telephone or e-mail (as show=
n above) immediately and destroy
 any and all copies of this message in your possession (whether hard copies=
 or electronically stored copies).<br>
<br>
</font>
</body>
</html>

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176SACMBXIP02sdcor_--

--===============2139055991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2139055991==--
