From: Michael Kuriger <mk7193-CivJcMWXhi0@public.gmane.org>
Subject: Re: Does anyone understand Calamari??
Date: Wed, 13 May 2015 20:59:31 +0000
Message-ID: <D17908E7.31B8A%mk7193@yp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1796057603=="
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
To: Bruce McFarland <Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org>, "ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel
	(ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1796057603==
Content-Language: en-US
Content-Type: multipart/related; boundary="_004_D17908E731B8Amk7193ypcom_";
	type="multipart/alternative"

--_004_D17908E731B8Amk7193ypcom_
Content-Type: multipart/alternative;
	boundary="_000_D17908E731B8Amk7193ypcom_"

--_000_D17908E731B8Amk7193ypcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

OK, I finally got mine working.  For whatever reason, the latest version of=
 salt was the issue for me.  Leaving the latest version of salt on the cala=
mari server is working, but had to downgrade the minions.


  Removed:

    salt.noarch 0:2014.7.5-1.el6        salt-minion.noarch 0:2014.7.5-1.el6



  Installed:

    salt.noarch 0:2014.7.1-1.el6        salt-minion.noarch 0:2014.7.1-1.el6


This is on CentOS 6.6


-=3DMike Kuriger


[yp]



Michael Kuriger
Sr. Unix Systems Engineer
=95 mk7193-CivJcMWXhi0@public.gmane.org<mailto:mk7193-CivJcMWXhi0@public.gmane.org> |=95 818-649-7235


From: Bruce McFarland <Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org<mailto:Bruce.McFarl=
and-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org>>
Date: Tuesday, May 12, 2015 at 4:34 PM
To: "ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>" <ce=
ph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<mailto:ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>>, ceph-user=
s <ceph-users-Qp0mS5GaXlQ@public.gmane.org<mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org>>, "ceph-devel (ceph-deve=
l@vger.kernel.org<mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>)" <ceph-devel-u79uwXL29TY@public.gmane.org=
nel.org<mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>>
Subject: [ceph-users] Does anyone understand Calamari??

Increasing the audience since ceph-calamari is not responsive. What salt ev=
ent/info does the Calamari Master expect to see from the ceph-mon to determ=
ine there is an working cluster? I had to change servers hosting the calama=
ri master and can=92t get the new machine to recognize the cluster. The =91=
salt \* ceph.get_heartbeats=92 returns monmap, fsid, ver, epoch, etc for th=
e monitor and all of the osd=92s. Can anyone point me to docs or code that =
might enlighten me to what I=92m overlooking? Thanks.

--_000_D17908E731B8Amk7193ypcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <83F22C0D5232E14B9C5CB6F94D3A54B6-CivJcMWXhi0@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-fami=
ly: Calibri, sans-serif;">
<div>
<div>OK, I finally got mine working. &nbsp;For whatever reason, the latest =
version of salt was the issue for me. &nbsp;Leaving the latest version of s=
alt on the calamari server is working, but had to downgrade the minions.</d=
iv>
<div><br>
</div>
<div>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp;&nbsp;=
Removed:</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; &nbsp=
; salt.noarch 0:2014.7.5-1.el6&nbsp; &nbsp; &nbsp; &nbsp; salt-minion.noarc=
h 0:2014.7.5-1.el6&nbsp; &nbsp; &nbsp; &nbsp;</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: 1=
3px;">&nbsp;&nbsp;</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; Insta=
lled:</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; &nbsp=
; salt.noarch 0:2014.7.1-1.el6&nbsp; &nbsp; &nbsp; &nbsp; salt-minion.noarc=
h 0:2014.7.1-1.el6&nbsp; &nbsp; &nbsp; &nbsp;</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;"><br>
</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">This is on C=
entOS 6.6</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;"><br>
</p>
<p style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">-=3DMike Kur=
iger</p>
</div>
<div>
<div><br>
</div>
<div>
<p class=3D"MsoNormal" style=3D"font-size: 12pt; font-family: 'Times New Ro=
man', serif;">
<span style=3D"font-size: 10.5pt; font-family: Calibri, sans-serif;">&nbsp;=
</span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" style=3D"font-family: Calibri;">
<tbody>
<tr>
<td width=3D"84" style=3D"width: 63.3pt; border-style: none solid none none=
; border-right-color: rgb(122, 122, 124); border-right-width: 1pt; padding:=
 0in;">
<p class=3D"MsoNormal" style=3D"font-size: 12pt; font-family: 'Times New Ro=
man', serif;">
<span style=3D"font-size: 11.5pt; font-family: Calibri, sans-serif; color: =
rgb(31, 73, 125);"><img width=3D"75" height=3D"57" id=3D"Picture_x0020_1" s=
rc=3D"cid:B4177D5E-1EF8-404D-8A66-2239A715A4FE" alt=3D"yp" type=3D"image/pn=
g"></span><span style=3D"font-size: 13.5pt; font-family: Calibri, sans-seri=
f; color: rgb(31, 73, 125);"><o:p></o:p></span></p>
</td>
<td width=3D"9" style=3D"width: 6.7pt; padding: 0in;">
<p class=3D"MsoNormal" style=3D"font-size: 12pt; font-family: 'Times New Ro=
man', serif;">
<span style=3D"font-size: 11pt; font-family: Calibri, sans-serif; color: rg=
b(31, 73, 125);">&nbsp;</span><span style=3D"font-size: 11pt; font-family: =
Calibri, sans-serif; color: rgb(31, 73, 125);"><o:p></o:p></span></p>
</td>
<td width=3D"507" style=3D"width: 380pt; padding: 0in;">
<p class=3D"MsoNormal" style=3D"font-size: 12pt; font-family: 'Times New Ro=
man', serif;">
<span style=3D"font-family: Calibri, sans-serif; color: rgb(64, 64, 64);">M=
ichael Kuriger</span><span style=3D"font-family: Calibri, sans-serif; color=
: rgb(31, 73, 125);"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"font-size: 12pt; font-family: 'Times New Ro=
man', serif;">
<span style=3D"font-family: Calibri, sans-serif; color: rgb(64, 64, 64);">S=
r. Unix Systems Engineer</span><span style=3D"font-family: Calibri, sans-se=
rif; color: rgb(31, 73, 125);"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"font-size: 12pt; font-family: 'Times New Ro=
man', serif;">
<span style=3D"font-size: 10pt; font-family: Wingdings; color: rgb(148, 138=
, 84);">*</span><span style=3D"font-size: 10pt; font-family: Arial, sans-se=
rif; color: rgb(64, 64, 64);">&nbsp;<a href=3D"mailto:mk7193-CivJcMWXhi0@public.gmane.org">mk7193=
@yp.com</a>&nbsp;|</span><span style=3D"font-size: 10pt; font-family: Wingd=
ings; color: rgb(148, 138, 84);">(</span><span style=3D"font-size: 10.5pt; =
font-family: Calibri, sans-serif;">&nbsp;818-649-7235</span></p>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div><br>
</div>
<span id=3D"OLK_SRC_BODY_SECTION">
<div style=3D"font-family:Calibri; font-size:11pt; text-align:left; color:b=
lack; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM:=
 0in; PADDING-LEFT: 0in; PADDING-RIGHT: 0in; BORDER-TOP: #b5c4df 1pt solid;=
 BORDER-RIGHT: medium none; PADDING-TOP: 3pt">
<span style=3D"font-weight:bold">From: </span>Bruce McFarland &lt;<a href=
=3D"mailto:Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org">Bruce.McFarland-rnQ3HPfPGGWoFjWMlG8qsQ@public.gmane.org=
om</a>&gt;<br>
<span style=3D"font-weight:bold">Date: </span>Tuesday, May 12, 2015 at 4:34=
 PM<br>
<span style=3D"font-weight:bold">To: </span>&quot;<a href=3D"mailto:ceph-ca=
lamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&quot; &lt;<a href=
=3D"mailto:ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&g=
t;, ceph-users &lt;<a href=3D"mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org">ceph-users@ceph.c=
om</a>&gt;,
 &quot;ceph-devel (<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel=
@vger.kernel.org</a>)&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;<br>
<span style=3D"font-weight:bold">Subject: </span>[ceph-users] Does anyone u=
nderstand Calamari??<br>
</div>
<div><br>
</div>
<div xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micro=
soft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" x=
mlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:/=
/www.w3.org/TR/REC-html40">
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
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Increasing the audience since ceph-calamari is not r=
esponsive. What salt event/info does the Calamari Master expect to see from=
 the ceph-mon to determine there is an working cluster? I had to change ser=
vers hosting the calamari master and
 can=92t get the new machine to recognize the cluster. The =91salt \* ceph.=
get_heartbeats=92 returns monmap, fsid, ver, epoch, etc for the monitor and=
 all of the osd=92s. Can anyone point me to docs or code that might enlight=
en me to what I=92m overlooking? Thanks.<o:p></o:p></p>
</div>
</div>
</div>
</span>
</body>
</html>

--_000_D17908E731B8Amk7193ypcom_--

--_004_D17908E731B8Amk7193ypcom_
Content-Type: image/png; name="A78C4A05-FC1E-4FCA-A8F8-D2C4B9EEC9CA[1].png"
Content-Description: A78C4A05-FC1E-4FCA-A8F8-D2C4B9EEC9CA[1].png
Content-Disposition: inline;
	filename="A78C4A05-FC1E-4FCA-A8F8-D2C4B9EEC9CA[1].png"; size=4193;
	creation-date="Wed, 13 May 2015 20:59:31 GMT";
	modification-date="Wed, 13 May 2015 20:59:31 GMT"
Content-ID: <B4177D5E-1EF8-404D-8A66-2239A715A4FE>
Content-Transfer-Encoding: base64

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

--_004_D17908E731B8Amk7193ypcom_--

--===============1796057603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1796057603==--
