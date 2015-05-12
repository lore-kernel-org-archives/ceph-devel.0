From: Bruce McFarland <Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org>
Subject: Does anyone understand Calamari??
Date: Tue, 12 May 2015 23:34:41 +0000
Message-ID: <7E8CF9C16F722345A89076330719CB1F4A82525D@EXMAIL1.taec.toshiba.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0494808566=="
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
To: "ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel
	(ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0494808566==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7E8CF9C16F722345A89076330719CB1F4A82525DEXMAIL1taectosh_"

--_000_7E8CF9C16F722345A89076330719CB1F4A82525DEXMAIL1taectosh_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Increasing the audience since ceph-calamari is not responsive. What salt ev=
ent/info does the Calamari Master expect to see from the ceph-mon to determ=
ine there is an working cluster? I had to change servers hosting the calama=
ri master and can't get the new machine to recognize the cluster. The 'salt=
 \* ceph.get_heartbeats' returns monmap, fsid, ver, epoch, etc for the moni=
tor and all of the osd's. Can anyone point me to docs or code that might en=
lighten me to what I'm overlooking? Thanks.

--_000_7E8CF9C16F722345A89076330719CB1F4A82525DEXMAIL1taectosh_
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
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
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
<p class=3D"MsoNormal">Increasing the audience since ceph-calamari is not r=
esponsive. What salt event/info does the Calamari Master expect to see from=
 the ceph-mon to determine there is an working cluster? I had to change ser=
vers hosting the calamari master and
 can&#8217;t get the new machine to recognize the cluster. The &#8216;salt =
\* ceph.get_heartbeats&#8217; returns monmap, fsid, ver, epoch, etc for the=
 monitor and all of the osd&#8217;s. Can anyone point me to docs or code th=
at might enlighten me to what I&#8217;m overlooking? Thanks.<o:p></o:p></p>
</div>
</body>
</html>

--_000_7E8CF9C16F722345A89076330719CB1F4A82525DEXMAIL1taectosh_--

--===============0494808566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0494808566==--
