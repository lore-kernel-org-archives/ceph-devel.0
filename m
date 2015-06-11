From: Shambhu Rajak <Shambhu.Rajak-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Ceph giant installation fails on rhel 7.0
Date: Thu, 11 Jun 2015 12:26:42 +0000
Message-ID: <39F9E8A5546B9448A82E55FBEBE3EC4526584F21@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1846731584=="
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1846731584==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_39F9E8A5546B9448A82E55FBEBE3EC4526584F21SACMBXIP03sdcor_"

--_000_39F9E8A5546B9448A82E55FBEBE3EC4526584F21SACMBXIP03sdcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am trying to install ceph gaint on rhel 7.0, while installing ceph-common=
-0.87.2-0.el7.x86_64.rpm I am getting following dependency

packages]$ sudo yum install ceph-common-0.87.2-0.el7.x86_64.rpm
Loaded plugins: amazon-id, priorities, rhui-lb
Examining ceph-common-0.87.2-0.el7.x86_64.rpm: 1:ceph-common-0.87.2-0.el7.x=
86_64
Marking ceph-common-0.87.2-0.el7.x86_64.rpm to be installed
Resolving Dependencies
--> Running transaction check
---> Package ceph-common.x86_64 1:0.87.2-0.el7 will be installed
--> Processing Dependency: libtcmalloc.so.4()(64bit) for package: 1:ceph-co=
mmon-0.87.2-0.el7.x86_64
--> Finished Dependency Resolution
Error: Package: 1:ceph-common-0.87.2-0.el7.x86_64 (/ceph-common-0.87.2-0.el=
7.x86_64)
           Requires: libtcmalloc.so.4()(64bit)
You could try using --skip-broken to work around the problem
You could try running: rpm -Va --nofiles -nodigest


So I am trying install gperftools-libs to resolve the dependencies, but I a=
m unable to get the package using yum install

Can any one help me getting the complete list of dependencies to install ce=
ph giant on rhel 7.0.

Thanks,
Shambhu


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


--_000_39F9E8A5546B9448A82E55FBEBE3EC4526584F21SACMBXIP03sdcor_
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
<p class=3D"MsoNormal">I am trying to install ceph gaint on rhel 7.0, while=
 installing ceph-common-0.87.2-0.el7.x86_64.rpm I am getting following depe=
ndency<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">packages]$ sudo yum install ceph-common-0.87.2-0.el7=
.x86_64.rpm<o:p></o:p></p>
<p class=3D"MsoNormal">Loaded plugins: amazon-id, priorities, rhui-lb<o:p><=
/o:p></p>
<p class=3D"MsoNormal">Examining ceph-common-0.87.2-0.el7.x86_64.rpm: 1:cep=
h-common-0.87.2-0.el7.x86_64<o:p></o:p></p>
<p class=3D"MsoNormal">Marking ceph-common-0.87.2-0.el7.x86_64.rpm to be in=
stalled<o:p></o:p></p>
<p class=3D"MsoNormal">Resolving Dependencies<o:p></o:p></p>
<p class=3D"MsoNormal">--&gt; Running transaction check<o:p></o:p></p>
<p class=3D"MsoNormal">---&gt; Package ceph-common.x86_64 1:0.87.2-0.el7 wi=
ll be installed<o:p></o:p></p>
<p class=3D"MsoNormal">--&gt; Processing Dependency: libtcmalloc.so.4()(64b=
it) for package: 1:ceph-common-0.87.2-0.el7.x86_64<o:p></o:p></p>
<p class=3D"MsoNormal">--&gt; Finished Dependency Resolution<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Package: 1:ceph-common-0.87.2-0.el7.x86_64 (/=
ceph-common-0.87.2-0.el7.x86_64)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Requires: libtcmalloc.so.4()(64bit)<o:p></o:p></p>
<p class=3D"MsoNormal">You could try using --skip-broken to work around the=
 problem<o:p></o:p></p>
<p class=3D"MsoNormal">You could try running: rpm -Va --nofiles &#8211;nodi=
gest<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So I am trying install gperftools-libs to resolve th=
e dependencies, but I am unable to get the package using yum install<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can any one help me getting the complete list of dep=
endencies to install ceph giant on rhel 7.0.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Shambhu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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

--_000_39F9E8A5546B9448A82E55FBEBE3EC4526584F21SACMBXIP03sdcor_--

--===============1846731584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1846731584==--
