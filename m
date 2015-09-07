From: Xusangdi <xu.sangdi-vVzyEvZLFYE@public.gmane.org>
Subject: rgw potential security issue
Date: Mon, 7 Sep 2015 06:43:52 +0000
Message-ID: <FF8D83DAE5DF57468726B79904321E060402E7@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2053415336=="
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2053415336==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_FF8D83DAE5DF57468726B79904321E060402E7H3CMLB12EXsrvhuaw_"

--_000_FF8D83DAE5DF57468726B79904321E060402E7H3CMLB12EXsrvhuaw_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Cephers,

Recently when I did some tests of RGW functions I found that the swift key =
of a subuser is kept after removing the subuser. As a result, this subuser-=
swift_key pair can still pass authentication system and get an auth-token (=
without any permission though). Moreover, if we create a subuser with the s=
ame name later, the swift key becomes valid again. I know we can actually d=
elete the key by explicitly specifying '--purge-keys', just curious why it =
is not set as default.

Any thought or comment?

p.s.  You may find more information on ceph tracker: http://tracker.ceph.co=
m/issues/12890


Best Regards,
Sangdi Xu
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

--_000_FF8D83DAE5DF57468726B79904321E060402E7H3CMLB12EXsrvhuaw_
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
	{font-family:Calibri}
@font-face
	{font-family:SimSun}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif"}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
span.EmailStyle17
	{font-family:"Calibri","sans-serif";
	color:windowtext}
.MsoChpDefault
	{font-family:"Calibri","sans-serif"}
@page WordSection1
	{margin:72.0pt 90.0pt 72.0pt 90.0pt}
div.WordSection1
	{}
-->
</style>
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Cephers,</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Recently when I did some tests =
of RGW functions I found that the swift key of a subuser is kept after remo=
ving the subuser. As a result, this subuser-swift_key pair can still pass a=
uthentication system and get an auth-token
 (without any permission though). Moreover, if we create a subuser with the=
 same name later, the swift key becomes valid again. I know we can actually=
 delete the key by explicitly specifying '--purge-keys', just curious why i=
t is not set as default.</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Any thought or comment?</span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">p.s. &nbsp;You may find more in=
formation on ceph tracker:
<a href=3D"http://tracker.ceph.com/issues/12890">http://tracker.ceph.com/is=
sues/12890</a>
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best Regards,</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sangdi Xu</span><span lang=3D"E=
N-US"></span></p>
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

--_000_FF8D83DAE5DF57468726B79904321E060402E7H3CMLB12EXsrvhuaw_--

--===============2053415336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2053415336==--
