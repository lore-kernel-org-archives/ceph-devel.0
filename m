From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Regarding cache tier understanding
Date: Thu, 7 Aug 2014 08:25:24 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0122076586=="
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
To: "Sage Weil (sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org)" <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Allen Samuels <Allen.Samuels-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0122076586==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2SACMBXIP02sdcor_"

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2SACMBXIP02sdcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Sage,
I went through the tiering agent code base and here is my understanding on =
the agent behavior. Please let me know if that is correct.


1.       Agent will be always in idle state if target_max_bytes or target_m=
ax_objects not set on the pool irrespective of other tiering params set in =
the pool. dirty_micro and full_micro will not be calculated if those two pa=
rams are zero which is by default I guess.

2.       Now, flush will be activated if dirty_micro is > flush_target. My =
understanding is, once it is activated it will iterate through all the dirt=
y objects and flush all the dirty objects which is > cache_min_flush_age. A=
m I right ?

3.       For the eviction, if full_micro > 1000000 , the mode set as TierAg=
entState::EVICT_MODE_FULL and all the clean objects are flushed.

4.       if (full_micro > evict_target), the mode is set as TierAgentState:=
:EVICT_MODE_SOME. In this scenario evict_effort is calculated and based on =
hit_set and temp calculation some clean objects are evicted. My question is=
 , can we quantify this value ? For ex, if the target_full_ratio =3D 50%, o=
nce the eviction is triggered, what %objects will be evicted ?

5.       Also, why we are multiplying with 1000000 always ? Is it because i=
n the histogram it is positioned as 0..1000000 ?

6.       I saw the cache_min_evict_age is not been used anywhere, am I miss=
ing anything ?

7.       The cache_min_flush_age will only be applicable if the flush is tr=
iggered after crossing the dirty_threshold, right ? If dirty_threshold is n=
ot breached, the flush age param is never checked.

I need to understand the behavior so that we can test the Cache tiering pro=
perly.
Is there any behavior I am missing here which you want us to test out ?

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


--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2SACMBXIP02sdcor_
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
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1106077404;
	mso-list-type:hybrid;
	mso-list-template-ids:-963712782 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%">Hi Sage,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%">I went through the tie=
ring agent code base and here is my understanding on the agent behavior. Pl=
ease let me know if that is correct.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo2"><![if !supportLists]><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><span style=3D"m=
so-list:Ignore">1.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:#17375E;mso-style-textf=
ill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">Agent will be =
always in idle state if target_max_bytes or target_max_objects not set on t=
he pool irrespective of other tiering
 params set in the pool. </span><span style=3D"color:#17375E;mso-style-text=
fill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%;background:whi=
te;mso-highlight:white">dirty_micro</span><span style=3D"color:#17375E;mso-=
style-textfill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">
 and <span style=3D"background:white;mso-highlight:white">full_micro</span>=
 will not be calculated if those two params are zero which is by default I =
guess.</span><span style=3D"color:#17375E;mso-style-textfill-fill-color:#17=
375E;mso-style-textfill-fill-alpha:100.0%"><o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo2"><![if !supportLists]><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><span style=3D"m=
so-list:Ignore">2.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:#17375E;mso-style-textf=
ill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">Now, flush wil=
l be activated if dirty_micro is &gt;
<span style=3D"background:white;mso-highlight:white">flush_target</span>. M=
y understanding is, once it is activated it will iterate through all the di=
rty objects and
</span><span style=3D"color:#17375E;mso-style-textfill-fill-color:#17375E;m=
so-style-textfill-fill-alpha:100.0%">flush all the dirty objects which is &=
gt; cache_min_flush_age. Am I right ?</span><span style=3D"color:#17375E;ms=
o-style-textfill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><=
o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo2"><![if !supportLists]><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><span style=3D"m=
so-list:Ignore">3.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:#17375E;mso-style-textf=
ill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">For the evicti=
on, if
</span><span style=3D"color:#17375E;mso-style-textfill-fill-color:#17375E;m=
so-style-textfill-fill-alpha:100.0%;background:white;mso-highlight:white">f=
ull_micro &gt; 1000000</span><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">
 , the mode set as <span style=3D"background:white;mso-highlight:white">Tie=
rAgentState::EVICT_MODE_FULL</span> and all the clean objects are flushed.<=
/span><span style=3D"color:#17375E;mso-style-textfill-fill-color:#17375E;ms=
o-style-textfill-fill-alpha:100.0%"><o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo2"><![if !supportLists]><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><span style=3D"m=
so-list:Ignore">4.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:#17375E;mso-style-textf=
ill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%;background:whit=
e;mso-highlight:white">if (full_micro &gt; evict_target)</span><span style=
=3D"color:#17375E;mso-style-textfill-fill-color:#17375E;mso-style-textfill-=
fill-alpha:100.0%">,
 the mode is set as <span style=3D"background:white;mso-highlight:white">Ti=
erAgentState::EVICT_MODE_SOME</span>. In this scenario evict_effort is calc=
ulated and based on hit_set and temp calculation some clean objects are evi=
cted. My question is , can we quantify
 this value ? For ex, if the target_full_ratio =3D 50%, once the eviction i=
s triggered, what %objects will be evicted ?</span><span style=3D"color:#17=
375E;mso-style-textfill-fill-color:#17375E;mso-style-textfill-fill-alpha:10=
0.0%"><o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo2"><![if !supportLists]><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><span style=3D"m=
so-list:Ignore">5.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:#17375E;mso-style-textf=
ill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">Also, why we a=
re multiplying with 1000000 always ?</span><span style=3D"color:#17375E;mso=
-style-textfill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">
 Is it because in the histogram it is positioned as 0..1000000 ?<o:p></o:p>=
</span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo2"><![if !supportLists]><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><span style=3D"m=
so-list:Ignore">6.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:#17375E;mso-style-textf=
ill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">I saw the cach=
e_min_evict_age is not been used anywhere, am I missing anything ?</span><s=
pan style=3D"color:#17375E;mso-style-textfill-fill-color:#17375E;mso-style-=
textfill-fill-alpha:100.0%"><o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo2"><![if !supportLists]><span style=3D"color:#17375E;mso-style-textfil=
l-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><span style=3D"m=
so-list:Ignore">7.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:#17375E;mso-style-textf=
ill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">The
</span><span style=3D"color:#17375E;mso-style-textfill-fill-color:#17375E;m=
so-style-textfill-fill-alpha:100.0%">cache_min_flush_age will only be appli=
cable if the flush is triggered after crossing the dirty_threshold, right ?=
 If dirty_threshold is not breached,
 the flush age param is never checked.</span><span style=3D"color:#17375E;m=
so-style-textfill-fill-color:#17375E;mso-style-textfill-fill-alpha:100.0%">=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%">I need to understand t=
he behavior so that we can test the Cache tiering properly.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%">Is there any behavior =
I am missing here which you want us to test out ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%">Thanks &amp; Regards<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#17375E;mso-style-textfill-fill=
-color:#17375E;mso-style-textfill-fill-alpha:100.0%">Somnath<o:p></o:p></sp=
an></p>
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

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2SACMBXIP02sdcor_--

--===============0122076586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0122076586==--
