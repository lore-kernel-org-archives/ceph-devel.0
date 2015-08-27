From: "zhao.mingyue-vVzyEvZLFYE@public.gmane.org" <zhao.mingyue-vVzyEvZLFYE@public.gmane.org>
Subject: shutdown primary monitor,
 status of the osds on it will not change,
 and command like 'rbd create xxx' would block
Date: Thu, 27 Aug 2015 06:01:30 +0000
Message-ID: <1CB94550540AE44E9CAAE8CD5AF40BF846CE88CF@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0089079373=="
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
To: "sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0089079373==
Content-Language: zh-CN
Content-Type: multipart/related;
	boundary="_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_";
	type="multipart/alternative"

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: multipart/alternative;
	boundary="_000_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_"

--_000_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi sage,
I'm testing ceph feature,and now have a probem make me confused.
Network construction is as shown in the figure below:
  serverB is primary monitor , it has 5 osds
  serverC is secondary monitor, it has 5 osds
  serverD is tertiary monitor,it has 5 osds
  client A use a rbd block via 'rbd map' command.
[1 monitor(tertiary)  5 osds][1 monitor(secondary)  5 osds][1 monitor(prima=
ry)  5 osds][cid:image009.jpg-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org]
When shutdown serverB(primary monitor), input 'ceph osd tree' on serverC or=
 serverD will show all the osd is up and in, At this time ,if input 'rbd cr=
eate aaa -size 100', it will block, after neally 18 minutes, osds on server=
B change status to down, and command 'rbd create xxx' return;

My question:

1.       Why rbd create will block about 18minutes? Is this because the sta=
tus of osds on serverB(the shutdown one) is not modified to down? What is t=
he time mechanism about this?

2.       When write objects, if primary osd think other osd is up, it will =
always wait until other osd reply, it doesn't have timeout mechanism, isn't=
 it?

3.       The same environment , if I shutdown serverC(secondary monitor) , =
'ceph osd tree' show four osds down and another one osd is up;

if I shutdown serverD,the result is five osds are all down or all up, when =
all osd is up,the result is the same as shutdown server B;

shutdown primary monitor / secondary monitor / tertiary monitor, ceph statu=
s is not the same,I'm very confused about this.Can you help me?

---------------------------------------------------------------------------=
----------------------------------------------------------
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
???
This e-mail and its attachments contain confidential information from H3C, =
which is
intended only for the person or entity whose address is listed above. Any u=
se of the
information contained herein in any way (including, but not limited to, tot=
al or partial
disclosure, reproduction, or dissemination) by persons other than the inten=
ded
recipient(s) is prohibited. If you receive this e-mail in error, please not=
ify the sender
by phone or email immediately and delete it!

--_000_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:SimSun}
@font-face
	{font-family:SimSun}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-indent:21.0pt;
	line-height:150%;
	text-autospace:none;
	font-size:10.5pt;
	font-family:"Times New Roman","serif"}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{margin:0cm;
	margin-bottom:.0001pt;
	text-indent:21.0pt;
	text-autospace:none;
	font-size:9.0pt;
	font-family:"Times New Roman","serif"}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{margin:0cm;
	margin-bottom:.0001pt;
	text-indent:21.0pt;
	line-height:150%;
	text-autospace:none;
	font-size:10.5pt;
	font-family:"Times New Roman","serif"}
span.EmailStyle17
	{font-family:"Calibri","sans-serif";
	color:windowtext}
span.Char
	{font-family:"Times New Roman","serif"}
.MsoChpDefault
	{font-family:"Calibri","sans-serif"}
@page WordSection1
	{margin:72.0pt 90.0pt 72.0pt 90.0pt}
div.WordSection1
	{}
ol
	{margin-bottom:0cm}
ul
	{margin-bottom:0cm}
-->
</style>
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><a name=3D"_GoBack"><span =
lang=3D"EN-US" style=3D"line-height:150%; color:#333333; background:white">=
Hi sage,</span></a></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%; color:#333333; background:white">I'm testing ceph fea=
ture,and now have a probem make me confused.</span></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%; color:#333333; background:white"></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%; color:#333333; background:white">Network construction=
 is as</span><span lang=3D"EN-US" style=3D"line-height:150%"> shown in the =
figure below:</span></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%">&nbsp; serverB is primary monitor , it has 5 osds</sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%">&nbsp; serverC is secondary monitor, it has 5 osds</s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%">&nbsp; serverD is tertiary monitor,it has 5 osds</spa=
n></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%">&nbsp; client A use a rbd block via 'rbd map' command=
.&nbsp;
<span style=3D"color:#333333; background:white"></span></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:26.25pt"><span style=3D"positio=
n:absolute; z-index:251656704; left:0px; margin-left:265px; margin-top:134p=
x; width:113px; height:37px"><img width=3D"113" height=3D"37" src=3D"cid:im=
age004.png-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org" alt=3D"1 monitor(tertiary)
5 osds
"></span><span style=3D"position:absolute; z-index:251657728; left:0px; mar=
gin-left:117px; margin-top:135px; width:128px; height:37px"><img width=3D"1=
28" height=3D"37" src=3D"cid:image006.png-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org" alt=3D"1 monit=
or(secondary)
5 osds
"></span><span style=3D"position:absolute; z-index:251658752; left:0px; mar=
gin-left:-7px; margin-top:134px; width:116px; height:37px"><img width=3D"11=
6" height=3D"37" src=3D"cid:image008.png-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org" alt=3D"1 monito=
r(primary)
5 osds
"></span><span lang=3D"EN-US"><img width=3D"300" height=3D"264" id=3D"_x000=
0_i1025" src=3D"cid:image009.jpg-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org"></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US" style=
=3D"line-height:150%">When shutdown serverB(primary monitor), input &#8216;=
ceph osd tree&#8217; on serverC or serverD will show all the osd is up and =
in, At this time ,if input &#8216;rbd create aaa &#8211;size 100&#8217;,
 it will block, after neally 18 minutes, osds on serverB change status to d=
own, and command &#8216;rbd create xxx&#8217; return;&nbsp;
</span></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US">&nbsp=
;</span></p>
<p class=3D"MsoNormal" style=3D"text-indent:0cm"><span lang=3D"EN-US">My qu=
estion:</span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt; text-indent:-18.=
0pt"><span lang=3D"EN-US"><span style=3D"">1.<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span lang=3D"EN-US">Why rbd create will block about 1=
8minutes? Is this because the status of osds on serverB(the shutdown one) i=
s not modified to down? What is the time mechanism about this?</span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt; text-indent:-18.=
0pt"><span lang=3D"EN-US"><span style=3D"">2.<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span lang=3D"EN-US">When write objects, if primary os=
d think other osd is up, it will always wait until other osd reply, it does=
n&#8217;t have timeout mechanism, isn&#8217;t it?</span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt; text-indent:-18.=
0pt"><span lang=3D"EN-US"><span style=3D"">3.<span style=3D"font:7.0pt &quo=
t;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span lang=3D"EN-US">The same environment , if I shutd=
own serverC(secondary monitor) , &#8216;ceph osd tree&#8217; show four osds=
 down and another one osd is up;</span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt; text-indent:0cm"=
><span lang=3D"EN-US">if I shutdown serverD,the result is five osds are all=
 down or all up, when all osd is up,the result is the same as shutdown serv=
er B;</span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt; text-indent:0cm"=
><span lang=3D"EN-US">shutdown primary monitor / secondary monitor / tertia=
ry monitor, ceph status is not the same,I&#8217;m very confused about this.=
Can you help me?</span><span lang=3D"EN-US"></span></p>
</div>
<span style=3D"font-size:7.5pt; font-family:&#21326;&#25991;&#32454;&#40657=
;; color:gray"><span lang=3D"EN-US">---------------------------------------=
---------------------------------------------------------------------------=
-------------------<br>
</span>&#26412;&#37038;&#20214;&#21450;&#20854;&#38468;&#20214;&#21547;&#26=
377;&#26477;&#24030;&#21326;&#19977;&#36890;&#20449;&#25216;&#26415;&#26377=
;&#38480;&#20844;&#21496;&#30340;&#20445;&#23494;&#20449;&#24687;&#65292;&#=
20165;&#38480;&#20110;&#21457;&#36865;&#32473;&#19978;&#38754;&#22320;&#223=
36;&#20013;&#21015;&#20986;<span lang=3D"EN-US"><br>
</span>&#30340;&#20010;&#20154;&#25110;&#32676;&#32452;&#12290;&#31105;&#27=
490;&#20219;&#20309;&#20854;&#20182;&#20154;&#20197;&#20219;&#20309;&#24418=
;&#24335;&#20351;&#29992;&#65288;&#21253;&#25324;&#20294;&#19981;&#38480;&#=
20110;&#20840;&#37096;&#25110;&#37096;&#20998;&#22320;&#27844;&#38706;&#122=
89;&#22797;&#21046;&#12289;<span lang=3D"EN-US"><br>
</span>&#25110;&#25955;&#21457;&#65289;&#26412;&#37038;&#20214;&#20013;&#30=
340;&#20449;&#24687;&#12290;&#22914;&#26524;&#24744;&#38169;&#25910;&#20102=
;&#26412;&#37038;&#20214;&#65292;&#35831;&#24744;&#31435;&#21363;&#30005;&#=
35805;&#25110;&#37038;&#20214;&#36890;&#30693;&#21457;&#20214;&#20154;&#241=
82;&#21024;&#38500;&#26412;<span lang=3D"EN-US"><br>
</span>&#37038;&#20214;&#65281;<span lang=3D"EN-US"><br>
</span></span><span lang=3D"EN-US" style=3D"font-size:7.5pt; font-family:&q=
uot;Arial&quot;,&quot;sans-serif&quot;; color:gray">This e-mail and its att=
achments contain confidential information from H3C, which is
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

--_000_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_--

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: application/octet-stream; name="image002.emz"
Content-Description: image002.emz
Content-Disposition: inline; filename="image002.emz"; size=2656;
	creation-date="Thu, 27 Aug 2015 06:01:30 GMT";
	modification-date="Thu, 27 Aug 2015 06:01:30 GMT"
Content-ID: <image002.emz-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

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

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: image/png; name="image004.png"
Content-Description: image004.png
Content-Disposition: inline; filename="image004.png"; size=898;
	creation-date="Thu, 27 Aug 2015 06:01:30 GMT";
	modification-date="Thu, 27 Aug 2015 06:01:30 GMT"
Content-ID: <image004.png-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAHEAAAAlCAYAAAB1YQYxAAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAAMCSURBVHja
7ZlNrhshDIDZJ4veIlI26S4Sm/QoWXGFrHMDDtBeg+XLEd4BOEQXVaXuKDAQDHgm859OZUsjJRns
MXzYeBy22+1+M8YMXdu7LpfLj/v9ztj5fP5pSDYnj8fDHA6HT4JIEEkIIglBJIgEkSAqwQyXekWX
lRGMm8mP1NJwof4tn/x6DrczCaKW3L+jrAsRPl+MWzgHkEujJ9gZ/ewFNsTkSHQg3wVxzK61HhvJ
hVET7Yx79gCQYJO9F2LY8SpELHOOKZE+FxGdR7XbkXaxq/Fhp0rx1IlZscuO9Pes3nerB9Ooqu24
I6J+JrBRPRtGj/scOylxs0B92GkJ9906ZeMbH/pm+wUhuh0PFzRMznvm7oVJw9QWJiNU0m3Gp0Vq
FpjbMSrZMK/tRB9Lf7Uu7Fio8X5z3qvaRqETfXLfk/04x9qH5F97eh6S4RZOpyGanlDjxJuJuUmU
+qlQ6tKNi5MWsp8dzN/aThYtz00EU3Cug38vIzVP4f45MNKLsNscRJjekr3hEF/b6QexTmMDIPr0
nCKwDWK+BnWRtCmITWopAZnBEPvZCYucUdJVOk33Y4T0h5jOslcQwXmMFDGrnYl4IZE7ElMSLBay
QqewUxUX9gcNxkNdKdoLm/YiBatOW3TCwtc2ch2NFW52Q3He2BCIfjeslavTTYqPWiQy1nfEbsQS
VhnlBLEbpHgzRhu1pQurd2xIxrKDle90IYj/gUyEiHUn5pDh5wJBHAtRyUUWGnZASBaFWHYl5hSK
xNUg6tj77ACJv0uCDSDtOyR80X6m57wxUI0lmQNiRir7fw79HcLOmsygEZ519VMbqxpLsgBEpAsS
oxBtSse/Xoq/o/JIhXDxbgfJ3BBFvcjtTWlwn2H/ZtRnIhxLsgREkPIKinhTGla1Udefh7DhHV5b
sLEkM0GERUhHeGBNaQeR8/r9MjWewfiWsSRzRyIJQSQhiASRIBJEEoJIMjvE/X7/x4Gka1vX8Xj8
dTqdPjxEIcTX6/X6ja7tXbfb7YuD+BfIGglKXEZVNQAAAABJRU5ErkJggg==

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: application/octet-stream; name="image005.emz"
Content-Description: image005.emz
Content-Disposition: inline; filename="image005.emz"; size=2574;
	creation-date="Thu, 27 Aug 2015 06:01:30 GMT";
	modification-date="Thu, 27 Aug 2015 06:01:30 GMT"
Content-ID: <image005.emz-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

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
L+7JXhoINQAA

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: image/png; name="image006.png"
Content-Description: image006.png
Content-Disposition: inline; filename="image006.png"; size=868;
	creation-date="Thu, 27 Aug 2015 06:01:30 GMT";
	modification-date="Thu, 27 Aug 2015 06:01:30 GMT"
Content-ID: <image006.png-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAIAAAAAlCAYAAACK7+GWAAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAALkSURBVHja
7ZoxkuowDIZ9AWa2oaHac6SiouYUrt8MBSXLDXIDbpHL+ARbb7WVXxzHjmwrLAGHJJNfMx4yYCuK
9Ul2LIQQQqOtq2232+/z+fxxvV6FuN1uGrIu2e12P6fT6RMAAAAAAAAAAACAAAAIAPhbVFk0rxFF
qd5obqWlKHSWW1byzbbTWwstqzy6jB9e0fVaBphwEu3Dl/qpZ6/tFrk88My9RT4AXgVqwQAoXRby
CQBMFpF6Ivdnidp8czEmAKrURVFHaLtUmIhzy4aov1eEXn8y5WalHVvK6HvqvDaSBFkSWF1mjNNl
7htHv7lX07/WW0V6WDu7iR5mu3FS178zT5KTOaeb2lxY+/xy6/SEDn8WqpEA6B7W/m4cRx+gdVrg
DDtGVt1Y+1PndDvh9lqpKqT+IV12oqjNfuLq8cEn6UvHGBua64G2N/C3/fmU7eYltdlCSp+1TPZB
8XPNYAmwFKskRXUA+MlMHuLeWO76UV3cRLkJtzb5LEUim3PYUNupjiRaXRby2Sy0OQS8/o0J9UUC
YNNf6EQfOQMBeEyXTjaAfiPZfs+lUhq9etD9OhupDgsZAa7tX8k7APgMyL8FvX0JCCKFubNbH10K
9f3cmkfSoQjWuP6xgZ4ocv/Sxe4jjBYDcbQup3rC9TvR/YDtbhmM+ycZp7ZNyr555aN/uk3gUsVA
yETY3EWVko3+6V4DFw7BlGcYw0wVvYdu0x4EQRYvAAAAAAAAAAAAwHAAyKtRxh11zkoZZEwAmOPI
DN7PXimDjAIAc16dSfJXyiCjAKDckeWdP4X0Vsui6ltvpYztC5kBAIGb2XNrvlrGVN90f6WM6wuZ
HQBmO8AXLvhqGX+Gz1fK0r6QuQHQd6TaUy2Lq29xBggrZWlfyBwAoP9iueMYrlrGVd96K2VsX8i8
MgAEAEAAAAQAQAAAZNkAHI9Hfblc0FbUNpvNrwdgv99/oa2rHQ6Hf8b5DQDuAm2d7T+iGoxTnOUh
ngAAAABJRU5ErkJggg==

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: application/octet-stream; name="image007.emz"
Content-Description: image007.emz
Content-Disposition: inline; filename="image007.emz"; size=2367;
	creation-date="Thu, 27 Aug 2015 06:01:30 GMT";
	modification-date="Thu, 27 Aug 2015 06:01:30 GMT"
Content-ID: <image007.emz-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

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

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: image/png; name="image008.png"
Content-Description: image008.png
Content-Disposition: inline; filename="image008.png"; size=809;
	creation-date="Thu, 27 Aug 2015 06:01:30 GMT";
	modification-date="Thu, 27 Aug 2015 06:01:30 GMT"
Content-ID: <image008.png-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAHQAAAAlCAYAAACTSM11AAAAAXNSR0ICQMB9xQAAAAlwSFlzAAAO
xAAADsQBlSsOGwAAABl0RVh0U29mdHdhcmUATWljcm9zb2Z0IE9mZmljZX/tNXEAAAKpSURBVHja
7ZrNdcMgDMcZpVPkwCmHDJApWCADpLn1yAYZoHeWYRhqjDES4NRxbSf0/fUefanNh+CHJCIihBAO
pf1yOp2+brebENfr1UHalvv97g6HwzeAAigEQCEACgFQAF0C1GrZH5Gltjuqa5wS0q0ypFFP6r7i
2DPXV5m9LfTpRVl70tqZJQ07vYUy7t3FKPE01IaBWqelWgDUW5py749z2Ry3A2q1k7KzoME1e4uI
blp0zy3ZhWOWI27Hoa1W2XMKw1tZ3y65wWpfvk3sy4+bW2c+FtGNt5VOxrHnzG3Uz5cIJe9PkLDl
4dG6y1zvRkCjclFZD4IqPkBgixvaKJPahlcJYgAWPltr+O6d1VdYoKRz0Iu+92PwBQ7v0tgz58bW
wj8rdek3BgVodBGjub4vdblhN9rCdaRJp8XLlX/UtvZ5bl+VBRqszVbnNKXH73NLwKgX4brwjdi9
q5hiU0CDW+JQRqt8Eui8vlx5IMqA8oPIcqC9Cx7qGPUA6Oh56ifo3VzuGDNYvMqVDFZjSawZY8vQ
hsa9uDmm2rJ+RtdXj6F5X9U4zKyonAttS8eeMze2PkMcVWpqverWuf+hqFXxCx8tJXe5LxCrVdU6
9//a0jhUqU12wNlbhemxX5NYgLydACiAQgAU0gLQlPkQK54Sl5zsIGsAraSpVqDJU2OQvYBW8pIr
ydLjOuSPQG1MZT34Djd5k9L/r5wx5QYpk9d5XcgGQBm2an6yfvtBLLB7T29AaCqQPs/rQjYH6sNp
PeFcv/2o52ALiMxy9/vpB4BO3bhM3H6MPxshFkwtNCS1441FWReyBVB6G/9goWu3H/4XAzKPleSi
+fe6kG0tFAKgEACFACiAAuh/A3o8Hp2HitJuOZ/PDOgnSvvlcrl89ED9H5T/U34AcA51taz0GhMA
AAAASUVORK5CYII=

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_
Content-Type: image/jpeg; name="image009.jpg"
Content-Description: image009.jpg
Content-Disposition: inline; filename="image009.jpg"; size=7942;
	creation-date="Thu, 27 Aug 2015 06:01:30 GMT";
	modification-date="Thu, 27 Aug 2015 06:01:30 GMT"
Content-ID: <image009.jpg-YfYv9sZxh/JqIy2hK3x9kTRmByFHzeGd@public.gmane.org>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAEIASwDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+iii
gAooooAKKKKACiiigAooooAKKKKACiiigAyKazqiFnYKoGSScAUkjFY3YfwgmvIdFuv+ExgXUfGF
5ctZzTOtvaRt5dmArlQJNvJPH8RxQB2V749s3uZLLw/aT67eqcMLXiCM/wC3MflH4ZPtVLb48Zvt
/wDaukpN203yGMG30Mv3t3vjHtXS21nBZ20dvawxQ26j5I4VCp+GKk8s0AYFr47t7eZLPxJZTaHd
McK8x3W0h/2Zh8v4HBrr4pEliWSN1dGGVZTkEexrMmto7mB4J4kmhcYaORQykehB4Nc7/wAIfLpU
huPC2py6U55a0cGa0f6oeU+qkUAdxkUA5ri08aXWkER+K9JksEzj7fa5mtW9yw+ZP+BD8a6yzvba
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
ihVUegAoooAkooooAKKKKAP/2Q==

--_010_1CB94550540AE44E9CAAE8CD5AF40BF846CE88CFH3CMLB12EXsrvhu_--

--===============0089079373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0089079373==--
