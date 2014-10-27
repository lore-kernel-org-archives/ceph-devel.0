From: "Meng, Chen" <chen.meng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [ceph 0.72.2] PGs are incomplete status after some
 OSDs are out of cluster
Date: Mon, 27 Oct 2014 01:41:42 +0000
Message-ID: <1FC8FDB3BDEB4F4F9A6DBC50FBC0163601B39870@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0853787352=="
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
To: "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0853787352==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1FC8FDB3BDEB4F4F9A6DBC50FBC0163601B39870SHSMSX103ccrcor_"

--_000_1FC8FDB3BDEB4F4F9A6DBC50FBC0163601B39870SHSMSX103ccrcor_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Cepher

I meet the issue with ceph 0.72.2 that some OSDs are down & out and cannot =
rejoin the cluster via restart osd daemon.
Here below is I captured from the osd log which are down & out. All of them=
 have the same error info.


2014-10-22 16:49:18.834850 7fc2d3fd9700  0 filestore(/var/lib/ceph/osd/ceph=
-28)  error (39) Directory not empty not handled on operation 21 (72744853.=
0.2, or op 2, counting from 0)

2014-10-22 16:49:18.834897 7fc2d3fd9700  0 filestore(/var/lib/ceph/osd/ceph=
-28) ENOTEMPTY suggests garbage data in osd data dir

2014-10-22 16:49:18.834899 7fc2d3fd9700  0 filestore(/var/lib/ceph/osd/ceph=
-28)  transaction dump:

{ "ops": [

        { "op_num": 0,

          "op_name": "remove",

          "collection": "meta",

          "oid": "bfa3b7d0\/pglog_3.194a\/0\/\/-1"},

        { "op_num": 1,

          "op_name": "omap_rmkeys",

          "collection": "meta",

          "oid": "16ef7597\/infos\/head\/\/-1"},

        { "op_num": 2,

          "op_name": "rmcoll",

          "collection": "3.194a_head"}]}

2014-10-22 16:49:18.951947 7fc2d3fd9700 -1 os/FileStore.cc: In function 'un=
signed int FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, =
int, ThreadPool::TPHandle*)' thread 7fc2d3fd9700 time 2014-10-22 16:49:18.8=
59039

os/FileStore.cc: 2448: FAILED assert(0 =3D=3D "unexpected error")


Before that 2 days, I take add some new OSDs into cluster and increase the =
PG #.
I manually add OSDs which is lost one by one follow the process of add new =
OSD, it takes a long time to recovey.
And now, ceph health detail shows as following, all OSDs are up and in.

HEALTH_WARN 14 pgs backfilling; 4 pgs degraded; 2 pgs incomplete; 2 pgs stu=
ck inactive; 16 pgs stuck unclean; 200 requests are blocked > 32 sec; 2 osd=
s have slow requests; recovery 13269/10624283 objects degraded (0.125%)
pg 3.1019 is stuck inactive since forever, current state incomplete, last a=
cting [44,39,35]
pg 3.13c4 is stuck inactive since forever, current state incomplete, last a=
cting [49,66,16]
pg 4.df8 is stuck unclean for 719511.538414, current state active+degraded+=
remapped+backfilling, last acting [62,37]
pg 3.1f3e is stuck unclean for 722343.421598, current state active+remapped=
+backfilling, last acting [62,33,35,27]
pg 3.1019 is stuck unclean since forever, current state incomplete, last ac=
ting [44,39,35]
pg 3.1852 is stuck unclean for 725266.838670, current state active+remapped=
+backfilling, last acting [5,59,37,35]
pg 3.13c4 is stuck unclean since forever, current state incomplete, last ac=
ting [49,66,16]
pg 4.1848 is stuck unclean for 828659.231379, current state active+degraded=
+remapped+backfilling, last acting [12,37,62]
pg 3.160b is stuck unclean for 726568.972467, current state active+remapped=
+backfilling, last acting [58,33,5,57]
pg 4.252 is stuck unclean for 757159.325059, current state active+degraded+=
remapped+backfilling, last acting [30,17,60]
pg 3.9e3 is stuck unclean for 722359.550585, current state active+degraded+=
remapped+backfilling, last acting [0,17,30]
pg 4.175d is stuck unclean for 784690.950635, current state active+remapped=
+backfilling, last acting [34,57,16,60]
pg 3.16e is stuck unclean for 319022.053579, current state active+remapped+=
backfilling, last acting [7,11,58,63]
pg 3.1446 is stuck unclean for 723439.399481, current state active+remapped=
+backfilling, last acting [7,11,59,27]
pg 4.1130 is stuck unclean for 829487.905981, current state active+remapped=
+backfilling, last acting [24,30,32,59]
pg 4.1aff is stuck unclean for 329617.786292, current state active+remapped=
+backfilling, last acting [7,17,58,16]
pg 3.1404 is stuck unclean for 726186.450522, current state active+remapped=
+backfilling, last acting [32,33,60,12]
pg 4.1403 is stuck unclean for 780839.164866, current state active+remapped=
+backfilling, last acting [32,33,60,12]
pg 3.1f3e is active+remapped+backfilling, acting [62,33,35,27]
pg 4.1aff is active+remapped+backfilling, acting [7,17,58,16]
pg 3.1852 is active+remapped+backfilling, acting [5,59,37,35]
pg 4.1848 is active+degraded+remapped+backfilling, acting [12,37,62]
pg 4.175d is active+remapped+backfilling, acting [34,57,16,60]
pg 3.160b is active+remapped+backfilling, acting [58,33,5,57]
pg 3.1446 is active+remapped+backfilling, acting [7,11,59,27]
pg 4.1403 is active+remapped+backfilling, acting [32,33,60,12]
pg 3.1404 is active+remapped+backfilling, acting [32,33,60,12]
pg 3.13c4 is incomplete, acting [49,66,16]
pg 4.1130 is active+remapped+backfilling, acting [24,30,32,59]
pg 3.1019 is incomplete, acting [44,39,35]
pg 4.df8 is active+degraded+remapped+backfilling, acting [62,37]
pg 3.9e3 is active+degraded+remapped+backfilling, acting [0,17,30]
pg 4.252 is active+degraded+remapped+backfilling, acting [30,17,60]
pg 3.16e is active+remapped+backfilling, acting [7,11,58,63]
200 ops are blocked > 134218 sec
100 ops are blocked > 134218 sec on osd.44
100 ops are blocked > 134218 sec on osd.49
2 osds have slow requests
recovery 13269/10624283 objects degraded (0.125%)

There are 2 PG is in incomplete status. And not response from ceph ph pg# q=
uery. I have checked them in each related OSD. I find that 3.13c4_head & 3.=
1019_head are empty. So I think these data are lost. :(
I have try to mark the osd.44 & 49 as lost, but it has no effort.

BTW, some PGs are in stale status, I have resolved them via mkdir pg_head m=
anually in related OSD.
And some unfound Objects, I cannot use =1B$B!F=1B(Bceph pg # mark_unfound_l=
ost revert|delete=1B$B!G=1B(B to resolve.
But fortunately, these objects are in the pool that I am not using now. So =
I remove the pool already.

So how to deal with the blocked ops in =1B$B!F=1B(B100 ops are blocked > 13=
4218 sec on osd.44=1B$B!(=1B(B100 ops are blocked > 134218 sec on osd.49=1B=
$B!G=1B(B?
My openstack VMs are using ceph block storage, and they are hang now. I wan=
t to save as lives VMs as possible.



Best Regards!
Meng Chen


--_000_1FC8FDB3BDEB4F4F9A6DBC50FBC0163601B39870SHSMSX103ccrcor_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hi, Cepher<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I meet the issue with =
ceph 0.72.2 that some OSDs are down &amp; out and cannot rejoin the cluster=
 via restart osd daemon.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Here below is I captur=
ed from the osd log which are down &amp; out. All of them have the same err=
or info.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">2014=
-10-22 16:49:18.834850 7fc2d3fd9700&nbsp; 0 filestore(/var/lib/ceph/osd/cep=
h-28)&nbsp; error (39) Directory not empty not handled on operation
 21 (72744853.0.2, or op 2, counting from 0)<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">2014=
-10-22 16:49:18.834897 7fc2d3fd9700&nbsp; 0 filestore(/var/lib/ceph/osd/cep=
h-28) ENOTEMPTY suggests garbage data in osd data dir<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">2014=
-10-22 16:49:18.834899 7fc2d3fd9700&nbsp; 0 filestore(/var/lib/ceph/osd/cep=
h-28)&nbsp; transaction dump:<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">{ &q=
uot;ops&quot;: [<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;op_num&quot;: 0,<o:p></o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;op_name&quot;: &qu=
ot;remove&quot;,<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;collection&quot;: =
&quot;meta&quot;,<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;oid&quot;: &quot;b=
fa3b7d0\/pglog_3.194a\/0\/\/-1&quot;},<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;op_num&quot;: 1,<o:p></o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;op_name&quot;: &qu=
ot;omap_rmkeys&quot;,<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;collection&quot;: =
&quot;meta&quot;,<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;oid&quot;: &quot;1=
6ef7597\/infos\/head\/\/-1&quot;},<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;op_num&quot;: 2,<o:p></o:p><=
/span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;op_name&quot;: &qu=
ot;rmcoll&quot;,<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;collection&quot;: =
&quot;3.194a_head&quot;}]}<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">2014=
-10-22 16:49:18.951947 7fc2d3fd9700 -1 os/FileStore.cc: In function 'unsign=
ed int FileStore::_do_transaction(ObjectStore::Transaction&amp;,
 uint64_t, int, ThreadPool::TPHandle*)' thread 7fc2d3fd9700 time 2014-10-22=
 16:49:18.859039<o:p></o:p></span></p>
<p style=3D"margin:0in;margin-bottom:.0001pt"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">os/F=
ileStore.cc: 2448: FAILED assert(0 =3D=3D &quot;unexpected error&quot;)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Before that 2 days, I =
take add some new OSDs into cluster and increase the PG #.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I manually add OSDs wh=
ich is lost one by one follow the process of add new OSD, it takes a long t=
ime to recovey.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">And now, ceph health d=
etail shows as following, all OSDs are up and in.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal">HEALTH_WARN 14 pgs backfilling; 4 pgs degraded; 2 pg=
s incomplete; 2 pgs stuck inactive; 16 pgs stuck unclean; 200 requests are =
blocked &gt; 32 sec; 2 osds have slow requests; recovery 13269/10624283 obj=
ects degraded (0.125%)<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.1019 is stuck inactive since forever, current s=
tate incomplete, last acting [44,39,35]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.13c4 is stuck inactive since forever, current s=
tate incomplete, last acting [49,66,16]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.df8 is stuck unclean for 719511.538414, current=
 state active&#43;degraded&#43;remapped&#43;backfilling, last acting [62,37=
]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.1f3e is stuck unclean for 722343.421598, curren=
t state active&#43;remapped&#43;backfilling, last acting [62,33,35,27]<o:p>=
</o:p></p>
<p class=3D"MsoNormal">pg 3.1019 is stuck unclean since forever, current st=
ate incomplete, last acting [44,39,35]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.1852 is stuck unclean for 725266.838670, curren=
t state active&#43;remapped&#43;backfilling, last acting [5,59,37,35]<o:p><=
/o:p></p>
<p class=3D"MsoNormal">pg 3.13c4 is stuck unclean since forever, current st=
ate incomplete, last acting [49,66,16]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.1848 is stuck unclean for 828659.231379, curren=
t state active&#43;degraded&#43;remapped&#43;backfilling, last acting [12,3=
7,62]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.160b is stuck unclean for 726568.972467, curren=
t state active&#43;remapped&#43;backfilling, last acting [58,33,5,57]<o:p><=
/o:p></p>
<p class=3D"MsoNormal">pg 4.252 is stuck unclean for 757159.325059, current=
 state active&#43;degraded&#43;remapped&#43;backfilling, last acting [30,17=
,60]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.9e3 is stuck unclean for 722359.550585, current=
 state active&#43;degraded&#43;remapped&#43;backfilling, last acting [0,17,=
30]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.175d is stuck unclean for 784690.950635, curren=
t state active&#43;remapped&#43;backfilling, last acting [34,57,16,60]<o:p>=
</o:p></p>
<p class=3D"MsoNormal">pg 3.16e is stuck unclean for 319022.053579, current=
 state active&#43;remapped&#43;backfilling, last acting [7,11,58,63]<o:p></=
o:p></p>
<p class=3D"MsoNormal">pg 3.1446 is stuck unclean for 723439.399481, curren=
t state active&#43;remapped&#43;backfilling, last acting [7,11,59,27]<o:p><=
/o:p></p>
<p class=3D"MsoNormal">pg 4.1130 is stuck unclean for 829487.905981, curren=
t state active&#43;remapped&#43;backfilling, last acting [24,30,32,59]<o:p>=
</o:p></p>
<p class=3D"MsoNormal">pg 4.1aff is stuck unclean for 329617.786292, curren=
t state active&#43;remapped&#43;backfilling, last acting [7,17,58,16]<o:p><=
/o:p></p>
<p class=3D"MsoNormal">pg 3.1404 is stuck unclean for 726186.450522, curren=
t state active&#43;remapped&#43;backfilling, last acting [32,33,60,12]<o:p>=
</o:p></p>
<p class=3D"MsoNormal">pg 4.1403 is stuck unclean for 780839.164866, curren=
t state active&#43;remapped&#43;backfilling, last acting [32,33,60,12]<o:p>=
</o:p></p>
<p class=3D"MsoNormal">pg 3.1f3e is active&#43;remapped&#43;backfilling, ac=
ting [62,33,35,27]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.1aff is active&#43;remapped&#43;backfilling, ac=
ting [7,17,58,16]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.1852 is active&#43;remapped&#43;backfilling, ac=
ting [5,59,37,35]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.1848 is active&#43;degraded&#43;remapped&#43;ba=
ckfilling, acting [12,37,62]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.175d is active&#43;remapped&#43;backfilling, ac=
ting [34,57,16,60]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.160b is active&#43;remapped&#43;backfilling, ac=
ting [58,33,5,57]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.1446 is active&#43;remapped&#43;backfilling, ac=
ting [7,11,59,27]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.1403 is active&#43;remapped&#43;backfilling, ac=
ting [32,33,60,12]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.1404 is active&#43;remapped&#43;backfilling, ac=
ting [32,33,60,12]<o:p></o:p></p>
<p class=3D"MsoNormal"><b>pg 3.13c4 is incomplete, acting [49,66,16]<o:p></=
o:p></b></p>
<p class=3D"MsoNormal">pg 4.1130 is active&#43;remapped&#43;backfilling, ac=
ting [24,30,32,59]<o:p></o:p></p>
<p class=3D"MsoNormal"><b>pg 3.1019 is incomplete, acting [44,39,35]<o:p></=
o:p></b></p>
<p class=3D"MsoNormal">pg 4.df8 is active&#43;degraded&#43;remapped&#43;bac=
kfilling, acting [62,37]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.9e3 is active&#43;degraded&#43;remapped&#43;bac=
kfilling, acting [0,17,30]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 4.252 is active&#43;degraded&#43;remapped&#43;bac=
kfilling, acting [30,17,60]<o:p></o:p></p>
<p class=3D"MsoNormal">pg 3.16e is active&#43;remapped&#43;backfilling, act=
ing [7,11,58,63]<o:p></o:p></p>
<p class=3D"MsoNormal">200 ops are blocked &gt; 134218 sec<o:p></o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"background:yellow;mso-highlight:ye=
llow">100 ops are blocked &gt; 134218 sec on osd.44<o:p></o:p></span></b></=
p>
<p class=3D"MsoNormal"><b><span style=3D"background:yellow;mso-highlight:ye=
llow">100 ops are blocked &gt; 134218 sec on osd.49</span><o:p></o:p></b></=
p>
<p class=3D"MsoNormal">2 osds have slow requests<o:p></o:p></p>
<p class=3D"MsoNormal">recovery 13269/10624283 objects degraded (0.125%)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">There are 2 PG is in i=
ncomplete status. And not response from ceph ph pg# query. I have checked t=
hem in each related OSD. I find that 3.13c4_head &amp; 3.1019_head are empt=
y. So I think these data are lost.
</span><span style=3D"font-family:Wingdings;color:#1F497D">L</span><span st=
yle=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I have try to mark the=
 osd.44 &amp; 49 as lost, but it has no effort.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">BTW, some PGs are in s=
tale status, I have resolved them via mkdir pg_head manually in related OSD=
.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">And some unfound Objec=
ts, I cannot use =1B$B!F=1B(Bceph pg # mark_unfound_lost revert|delete=1B$B=
!G=1B(B to resolve.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">But fortunately, these=
 objects are in the pool that I am not using now. So I remove the pool alre=
ady.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">So how to deal with th=
e blocked ops in =1B$B!F=1B(B100 ops are blocked &gt; 134218 sec on osd.44<=
/span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;color:#1F497D">=1B$B=
!(=1B(B</span><span style=3D"color:#1F497D">100 ops are blocked &gt; 134218
 sec on osd.49=1B$B!G=1B(B?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">My openstack VMs are u=
sing ceph block storage, and they are hang now. I want to save as lives VMs=
 as possible.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Best Regards!<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Meng Chen<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_1FC8FDB3BDEB4F4F9A6DBC50FBC0163601B39870SHSMSX103ccrcor_--

--===============0853787352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0853787352==--
