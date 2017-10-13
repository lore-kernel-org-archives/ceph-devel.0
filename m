From: zhaomingyue <zhao.mingyue-vVzyEvZLFYE@public.gmane.org>
Subject: assert(objiter->second->version >
 last_divergent_update) when testing pull out disk and insert
Date: Fri, 13 Oct 2017 07:48:36 +0000
Message-ID: <1CB94550540AE44E9CAAE8CD5AF40BF894B8428B@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1891621663945123485=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: zh-CN
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "'sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org'" <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1891621663945123485==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_1CB94550540AE44E9CAAE8CD5AF40BF894B8428BH3CMLB12EXsrvhu_"

--_000_1CB94550540AE44E9CAAE8CD5AF40BF894B8428BH3CMLB12EXsrvhu_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGmjug0KICAgIEkgaGFkIG1ldCBhbiBhc3NlcnQgcHJvYmxlbSBsaWtlIGJ1ZzE2Mjc5KGh0dHA6
Ly90cmFja2VyLmNlcGguY29tL2lzc3Vlcy8xNjI3OSkgd2hlbiB0ZXN0aW5nIHB1bGwgb3V0IGRp
c2sgYW5kIGluc2VydCwgY2VwaCB2ZXJzaW9uIDEwLjIuNaOsYXNzZXJ0KG9iaml0ZXItPnNlY29u
ZC0+dmVyc2lvbiA+IGxhc3RfZGl2ZXJnZW50X3VwZGF0ZSkNCmFjY29yZGluZyB0byBvc2QgbG9n
o6xJIHRoaW5rIHRoaXMgbWF5YmUgZHVlIHRvIChsb2cuaGVhZCAhPSAqbG9nLmxvZy5yYmVnaW4u
dmVyc2lvbi52ZXJzaW9uKSB3aGVuIHNvbWUgYWJub3JtYWwgY29uZGl0aW9uIGhhcHBlbmVkLHN1
Y2ggYXMgcG93ZXIgb2ZmICxwdWxsIG91dCBkaXNrIGFuZCBpbnNlcnQuDQpJbiBiZWxvdyBzaXR1
YXRpb24sIG1lcmdlX2xvZyB3b3VsZCBwdXNoIDIzNKGvMTAzNCBpbnRvIGRpdmVyZ2VudCBsaXN0
O2FuZCBkaXZlcmdlbnQgaGFzIG9ubHkgb25lIG5vZGU7dGhlbiBsZWFkIHRvIGFzc2VydChvYmpp
dGVyLT5zZWNvbmQtPnZlcnNpb24gPiBsYXN0X2RpdmVyZ2VudF91cGRhdGUpLg0Kb2xvZyAgLS0t
LS0tLS0tLS0tLS0tLSAgICgwoa8wLCAyMzShrzEwMzQpICBvbG9nLmhlYWQgPSAyMzShrzEwMzQN
CmxvZyAgIC0tLS0tLS0tLS0tLS0tLS0gICAoMKGvMCwgMjM0oa8xMDM0KSAgbG9nLmhlYWQgPSAy
MzShrzEwMzMNCg0KSSBzZWUgb3NkIGxvYWRfcGdzIGNvZGUsaW4gZnVuY3Rpb24gUEdMb2c6OnJl
YWRfbG9nKCkgLCBjb2RlIGxpa2UgdGhpczoNCiAuLi4uLg0KIGZvciAocC0+c2Vla190b19maXJz
dCgpOyBwLT52YWxpZCgpIDsgcC0+bmV4dCgpKSB7DQouLi4uLg0KICAgIGxvZy5sb2cucHVzaF9i
YWNrKGUpOw0KICAgIGxvZy5oZWFkID0gZS52ZXJzaW9uOyAgLy8gZXZlcnkgcGcgbG9nIG5vZGUN
CiAgfQ0KLi4uLi4NCiBsb2cuaGVhZCA9IGluZm8ubGFzdF91cGRhdGU7DQoNCnR3byBkb3VidDoN
CmZpcnN0IDogd2h5IHNldCAobG9nLmhlYWQgPSBpbmZvLmxhc3RfdXBkYXRlKSBhZnRlciBhbGwg
cGcgbG9nIG5vZGUgcHJvY2Vzc2VkKGV2ZXJ5IG5vZGUgaGFzIHVwZGF0ZWQgbG9nLmhlYWQgPSBl
LnZlcnNpb24pPw0Kc2Vjb25kOiBXaGV0aGVyIGl0IGNhbiBvY2N1ciB0aGF0IGluZm8ubGFzdF91
cGRhdGUgaXMgbGVzcyB0aGFuICpsb2cubG9nLnJiZWdpbi52ZXJzaW9uIG9yIG5vdCBhbmQgd2hh
dCBzY2VuZSBoYXBwZW5zPw0KDQpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseSF0aGtzDQoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCrG+08q8/rywxuS4vbz+uqzT0NDCu6rI/by8yvXT0M/euavL
vrXEsaPD3NDFz6KjrL32z97T2reiy824+MnPw+a12Na31tDB0LP2DQq1xLj2yMu78si61+mho737
1rnIzrrOxuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1q7K7z97T2sirsr+78rK/t9a12NC5wrah
ori01sahog0Ku/LJoreio6mxvtPKvP7W0LXE0MXPoqGjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68T6
waK8tLXnu7C78tPKvP7NqNaqt6K8/sjLsqLJvrP9sb4NCtPKvP6joQ0KVGhpcyBlLW1haWwgYW5k
IGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIE5l
dyBIM0MsIHdoaWNoIGlzDQppbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3
aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUNCmluZm9ybWF0aW9u
IGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQg
dG8sIHRvdGFsIG9yIHBhcnRpYWwNCmRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlzc2Vt
aW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZA0KcmVjaXBpZW50KHMp
IGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVh
c2Ugbm90aWZ5IHRoZSBzZW5kZXINCmJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBk
ZWxldGUgaXQhDQo=

--_000_1CB94550540AE44E9CAAE8CD5AF40BF894B8428BH3CMLB12EXsrvhu_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"=C5=FA=D7=A2=BF=F2=CE=C4=B1=BE Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:9.0pt;
	font-family:=CB=CE=CC=E5;}
span.Char
	{mso-style-name:"=C5=FA=D7=A2=BF=F2=CE=C4=B1=BE Char";
	mso-style-priority:99;
	mso-style-link:=C5=FA=D7=A2=BF=F2=CE=C4=B1=BE;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">Hi</span>=A3=BA<span lang=3D"EN-US"><br>
&nbsp; &nbsp; I had met an assert problem like bug16279(<a href=3D"http://t=
racker.ceph.com/issues/16279">http://tracker.ceph.com/issues/16279</a>) whe=
n testing pull out disk and insert, ceph version 10.2.5</span>=A3=AC<b><spa=
n lang=3D"EN-US">assert(objiter-&gt;second-&gt;version &gt;
 last_divergent_update)</span></b><span lang=3D"EN-US"><o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;text-indent:21.0pt;layou=
t-grid-mode:char;punctuation-wrap:simple;text-autospace:none">
<span lang=3D"EN-US">according to osd log</span>=A3=AC<span lang=3D"EN-US">=
I think this maybe due to (log.head !=3D *log.log.rbegin.version.version) w=
hen some abnormal condition happened,such as power off ,pull out disk and i=
nsert.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;text-indent:21.0pt;layou=
t-grid-mode:char;punctuation-wrap:simple;text-autospace:none">
<span lang=3D"EN-US">In below situation, merge_log would push 234</span>=A1=
=AF<span lang=3D"EN-US">1034 into divergent list;and divergent has only one=
 node;then lead to assert(objiter-&gt;second-&gt;version &gt; last_divergen=
t_update).<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;text-indent:21.0pt;layou=
t-grid-mode:char;punctuation-wrap:simple;text-autospace:none">
<span lang=3D"EN-US">olog&nbsp; ----------------&nbsp;&nbsp; (0</span>=A1=
=AF<span lang=3D"EN-US">0, 234</span>=A1=AF<span lang=3D"EN-US">1034)&nbsp;
<b>olog.head =3D 234</b></span><b>=A1=AF<span lang=3D"EN-US">1034</span></b=
><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:21.0pt;text-indent:21.0pt;layou=
t-grid-mode:char;punctuation-wrap:simple;text-autospace:none">
<span lang=3D"EN-US">log&nbsp;&nbsp; ----------------&nbsp;&nbsp; (0</span>=
=A1=AF<span lang=3D"EN-US">0, 234</span>=A1=AF<span lang=3D"EN-US">1034)&nb=
sp;
<b>log.head =3D 234</b></span><b>=A1=AF<span lang=3D"EN-US">1033<o:p></o:p>=
</span></b></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">I see osd load_pgs code,in function PGLog::read_log() =
, code like this:
<br>
&nbsp;.....<br>
&nbsp;for (p-&gt;seek_to_first(); p-&gt;valid() ; p-&gt;next()) {<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt;layout-grid-mode:char;pu=
nctuation-wrap:simple;text-autospace:none">
<span lang=3D"EN-US">.....<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; log.log.push_back(e);<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; <b><span style=3D"color:red">log.he=
ad =3D e.version;&nbsp; // every pg log node</span><o:p></o:p></b></span></=
p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:12.0pt;layout-grid-mode:char;pu=
nctuation-wrap:simple;text-autospace:none">
<span lang=3D"EN-US">.....<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US"><b><span style=3D"color:red">&nbsp;log.head =3D info.l=
ast_update;</span><o:p></o:p></b></span></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<b><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">two doubt:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">first : why set (log.head =3D info.last_update) after =
all pg log node processed(every node has updated log.head =3D e.version)?<o=
:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"layout-grid-mode:char;punctuation-wrap:simp=
le;text-autospace:none">
<span lang=3D"EN-US">second: Whether it can occur that info.last_update is =
less than *log.log.rbegin.version or not and what scene happens?<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
 <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Looking forward to your reply!t=
hks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span><span lang=3D"EN-U=
S" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;;color:#1F497D"><o:p></o:p></span></p>
</div>
<span style=3D"font-size:7.5pt;font-family:=BB=AA=CE=C4=CF=B8=BA=DA;color:g=
ray"><span lang=3D"EN-US">-------------------------------------------------=
---------------------------------------------------------------------------=
---------<br>
</span>=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=C2=BB=AA=
=C8=FD=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=
=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=
=B3=F6<span lang=3D"EN-US"><br>
</span>=B5=C4=B8=F6=C8=CB=BB=F2=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=
=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=
=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=
=A1=A2=B8=B4=D6=C6=A1=A2<span lang=3D"EN-US"><br>
</span>=BB=F2=C9=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=
=A1=A3=C8=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=
=FA=C1=A2=BC=B4=B5=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=
=B2=A2=C9=BE=B3=FD=B1=BE<span lang=3D"EN-US"><br>
</span>=D3=CA=BC=FE=A3=A1<span lang=3D"EN-US"><br>
</span></span><span lang=3D"EN-US" style=3D"font-size:7.5pt;font-family:&qu=
ot;Arial&quot;,&quot;sans-serif&quot;;color:gray">This e-mail and its attac=
hments contain confidential information from New H3C, which is
<br>
intended only for the person or entity whose address is listed above. Any u=
se of the
<br>
information contained herein in any way (including, but not limited to, tot=
al or partial
<br>
disclosure, reproduction, or dissemination) by persons other than the inten=
ded <br>
recipient(s) is prohibited. If you receive this e-mail in error, please not=
ify the sender
<br>
by phone or email immediately and delete it!</span>
</body>
</html>

--_000_1CB94550540AE44E9CAAE8CD5AF40BF894B8428BH3CMLB12EXsrvhu_--

--===============1891621663945123485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1891621663945123485==--
