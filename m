From: Bruce McFarland <Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org>
Subject: Re: Does anyone understand Calamari??
Date: Wed, 13 May 2015 22:33:28 +0000
Message-ID: <7E8CF9C16F722345A89076330719CB1F4A825CAB@EXMAIL1.taec.toshiba.com>
References: <D17908E7.31B8A%mk7193@yp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0439579774=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <D17908E7.31B8A%mk7193-CivJcMWXhi0@public.gmane.org>
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
To: Michael Kuriger <mk7193-CivJcMWXhi0@public.gmane.org>, "ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel	(ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0439579774==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_";
	type="multipart/alternative"

--_004_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_
Content-Type: multipart/alternative;
	boundary="_000_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_"

--_000_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Possibly my issue as well. The calamari master is salt 0.17.5 but the minio=
ns are running 2015.2.0rc2. I have to build the minions from source (big en=
dian unsupported architecture). All of my salt issues seemed to get resolve=
d when I got similar versions of ZMQ running on both master and minion. The=
 calamari master is running on Ubuntu 14.04.


From: Michael Kuriger [mailto:mk7193-CivJcMWXhi0@public.gmane.org]
Sent: Wednesday, May 13, 2015 2:00 PM
To: Bruce McFarland; ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org; cep=
h-devel (ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)
Subject: Re: [ceph-users] Does anyone understand Calamari??

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
* mk7193-CivJcMWXhi0@public.gmane.org<mailto:mk7193-CivJcMWXhi0@public.gmane.org> |* 818-649-7235


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
ri master and can't get the new machine to recognize the cluster. The 'salt=
 \* ceph.get_heartbeats' returns monmap, fsid, ver, epoch, etc for the moni=
tor and all of the osd's. Can anyone point me to docs or code that might en=
lighten me to what I'm overlooking? Thanks.

--_000_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Menlo;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
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
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Possibly my issue as w=
ell. The calamari master is salt 0.17.5 but the minions are running 2015.2.=
0rc2. I have to build the minions from source (big endian unsupported archi=
tecture). All of my salt issues seemed
 to get resolved when I got similar versions of ZMQ running on both master =
and minion. The calamari master is running on Ubuntu 14.04.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Michael =
Kuriger [mailto:mk7193-CivJcMWXhi0@public.gmane.org]
<br>
<b>Sent:</b> Wednesday, May 13, 2015 2:00 PM<br>
<b>To:</b> Bruce McFarland; ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-users@ceph.c=
om; ceph-devel (ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)<br>
<b>Subject:</b> Re: [ceph-users] Does anyone understand Calamari??<o:p></o:=
p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;color:black">OK, I f=
inally got mine working. &nbsp;For whatever reason, the latest version of s=
alt was the issue for me. &nbsp;Leaving the latest version of salt on the c=
alamari server is working, but had to downgrade
 the minions.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black">&nbsp;&nbsp;=
Removed:<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black">&nbsp; &nbsp=
; salt.noarch 0:2014.7.5-1.el6&nbsp; &nbsp; &nbsp; &nbsp; salt-minion.noarc=
h 0:2014.7.5-1.el6&nbsp; &nbsp; &nbsp; &nbsp;<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt;min-height: 13px"><span style=
=3D"font-size:8.5pt;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:b=
lack">&nbsp;&nbsp;<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black">&nbsp; Insta=
lled:<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black">&nbsp; &nbsp=
; salt.noarch 0:2014.7.1-1.el6&nbsp; &nbsp; &nbsp; &nbsp; salt-minion.noarc=
h 0:2014.7.1-1.el6&nbsp; &nbsp; &nbsp; &nbsp;<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black"><o:p>&nbsp;<=
/o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black">This is on C=
entOS 6.6<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black"><o:p>&nbsp;<=
/o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:8.5p=
t;font-family:&quot;Menlo&quot;,&quot;serif&quot;;color:black">-=3DMike Kur=
iger<o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:10.5pt;color:black">&nbsp;</span><span st=
yle=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif=
&quot;;color:black"><o:p></o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0">
<tbody>
<tr>
<td width=3D"84" style=3D"width:63.3pt;border:none;border-right:solid #7A7A=
7C 1.0pt;padding:0in 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:11.5pt;color:#1F497D"><img width=3D"75" h=
eight=3D"57" id=3D"Picture_x0020_1" src=3D"cid:image001.png-HMQGKcdgDs3ka2+Sj5X+9Q@public.gmane.org=
90" alt=3D"yp"></span><span style=3D"font-size:12.0pt"><o:p></o:p></span></=
p>
</td>
<td width=3D"9" style=3D"width:6.7pt;padding:0in 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"color:#1F497D">&nbsp;</span><span style=3D"font-siz=
e:12.0pt"><o:p></o:p></span></p>
</td>
<td width=3D"507" style=3D"width:380.0pt;padding:0in 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"color:#404040">Michael Kuriger</span><span style=3D=
"font-family:&quot;Times New Roman&quot;,&quot;serif&quot;"><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"color:#404040">Sr. Unix Systems Engineer</span><o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:10.0pt;font-family:Wingdings;color:#948A5=
4">*</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&q=
uot;sans-serif&quot;;color:#404040">&nbsp;<a href=3D"mailto:mk7193-CivJcMWXhi0@public.gmane.org">=
mk7193-CivJcMWXhi0@public.gmane.org</a>&nbsp;|</span><span style=3D"font-size:10.0pt;font-family:=
Wingdings;color:#948A54">(</span><span style=3D"font-size:10.5pt">&nbsp;818=
-649-7235</span><span style=3D"font-size:12.0pt"><o:p></o:p></span></p>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From: </span></b><spa=
n style=3D"color:black">Bruce McFarland &lt;<a href=3D"mailto:Bruce.McFarla=
nd-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org">Bruce.McFarland-rnQ3HPfPGGWsvWnuDiJtQA@public.gmane.org</a>&gt;<br>
<b>Date: </b>Tuesday, May 12, 2015 at 4:34 PM<br>
<b>To: </b>&quot;<a href=3D"mailto:ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-calam=
ari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&quot; &lt;<a href=3D"mailto:ceph-calamari-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com">ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;, ceph-users &lt;<a href=3D"mailt=
o:ceph-users-Qp0mS5GaXlQ@public.gmane.org">ceph-users-Qp0mS5GaXlQ@public.gmane.org</a>&gt;, &quot;ceph-devel
 (<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<=
/a>)&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel@vge=
r.kernel.org</a>&gt;<br>
<b>Subject: </b>[ceph-users] Does anyone understand Calamari??<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Increasing the audience =
since ceph-calamari is not responsive. What salt event/info does the Calama=
ri Master expect to see from the ceph-mon to determine there is an working =
cluster? I had to change servers hosting
 the calamari master and can&#8217;t get the new machine to recognize the c=
luster. The &#8216;salt \* ceph.get_heartbeats&#8217; returns monmap, fsid,=
 ver, epoch, etc for the monitor and all of the osd&#8217;s. Can anyone poi=
nt me to docs or code that might enlighten me to what I&#8217;m
 overlooking? Thanks.<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_--

--_004_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=4193;
	creation-date="Wed, 13 May 2015 22:33:28 GMT";
	modification-date="Wed, 13 May 2015 22:33:28 GMT"
Content-ID: <image001.png-HMQGKcdgDs3ch3A6brQHxDRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

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

--_004_7E8CF9C16F722345A89076330719CB1F4A825CABEXMAIL1taectosh_--

--===============0439579774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0439579774==--
