From: "Chen, Xiaoxi" <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Unable to start ceph monitor in V0.59
Date: Thu, 21 Mar 2013 11:23:23 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC62079F@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0096275195=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org' (ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0096275195==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6F3FA899187F0043BA1827A69DA2F7CC62079FSHSMSX102ccrcorpi_"

--_000_6F3FA899187F0043BA1827A69DA2F7CC62079FSHSMSX102ccrcorpi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi List,

         I cannot start my monitor when I update my cluster to v0.59, pls n=
ote that I am not trying to upgrade,but by reinstall the ceph software stac=
k and rerunning mkcephfs.  I have seen that the monitor change a lot after =
0.58, is the mkcephfs still have bugs ?

Below is the log:


2013-03-21 08:17:41.127576 7f71c3610780  0 ceph version 0.59 (cbae6a435c628=
99f857775f66659de052fb0e759), process ceph-mon, pid 1550
2013-03-21 08:17:41.131271 7f71c3610780  1 unable to open monitor store at =
/data/mon.ceph1
2013-03-21 08:17:41.131281 7f71c3610780  1 check for old monitor store form=
at
2013-03-21 08:17:41.131409 7f71c3610780  1 store(/data/mon.ceph1) mount
2013-03-21 08:17:41.131430 7f71c3610780  1 store(/data/mon.ceph1) mount
2013-03-21 08:17:41.131659 7f71c3610780  1 found old GV monitor store forma=
t -- should convert!
2013-03-21 08:17:41.136476 7f71c3610780  1 store(/data/mon.ceph1) mount
2013-03-21 08:17:46.098118 7f71c3610780  1 _convert_paxos first gv 2 last g=
v 475156
2013-03-21 08:17:47.131667 7f71c3610780  0 convert finished conversion
2013-03-21 08:17:47.185261 7f71c3610780  1 mon.ceph1@-1(probing) e1 preinit=
 fsid 6d4e68d7-8959-4e8e-90c9-7e43f508f16a
2013-03-21 08:17:47.220874 7f71c3610780  0 mon.ceph1@-1(probing) e1  my ran=
k is now 0 (was -1)
2013-03-21 08:17:47.220905 7f71c3610780  1 mon.ceph1@0(probing) e1 win_stan=
dalone_election
2013-03-21 08:17:47.221808 7f71c3610780  0 log [INF] : mon.ceph1@0 won lead=
er election with quorum 0
2013-03-21 08:17:47.238542 7f71c3610780  0 log [INF] : pgmap v217425: 10368=
 pgs: 140 active+clean, 3 stale+active+recovering, 2 stal
e, 67 stale+active, 2 active+recovery_wait, 99 stale+active+clean, 819 peer=
ing, 5 stale+active+degraded+wait_backfill, 3 stale+activ
e+recovery_wait, 3760 down+peering, 12 stale+active+recovering+degraded, 30=
5 stale+peering, 3977 stale+down+peering, 1135 stale+acti
ve+degraded, 2 stale+active+degraded+backfilling, 4 stale+active+degraded+r=
emapped+wait_backfill, 6 incomplete, 1 stale+remapped+pee
ring, 17 stale+incomplete, 1 stale+active+degraded+remapped, 8 active+recov=
ering; 2717 GB data, 2015 GB used, 15441 GB / 17457 GB av
ail; 90413/1391836 degraded (6.496%); 250/695918 unfound (0.036%)
2013-03-21 08:17:47.239560 7f71c3610780  0 log [INF] : mdsmap e1: 0/0/1 up
2013-03-21 08:17:47.240448 7f71c3610780  0 log [INF] : osdmap e5056: 80 osd=
s: 25 up, 25 in


2013-03-21 08:17:47.241019 7f71c3610780  0 log [INF] : monmap e1: 1 mons at=
 {ceph1=3D192.168.10.11:6789/0}
2013-03-21 08:17:47.441000 7f71bc1d1700 -1 auth/none/AuthNoneServiceHandler=
.h: In function 'virtual int AuthNoneServiceHandler::hand
le_request(ceph::buffer::list::iterator&, ceph::bufferlist&, uint64_t&, Aut=
hCapsInfo&, uint64_t*)' thread 7f71bc1d1700 time 2013-03-
21 08:17:47.440030
auth/none/AuthNoneServiceHandler.h: 35: FAILED assert(0)

ceph version 0.59 (cbae6a435c62899f857775f66659de052fb0e759)

--_000_6F3FA899187F0043BA1827A69DA2F7CC62079FSHSMSX102ccrcorpi_
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
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
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
/* Page Definitions */
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
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi List,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; I cannot start my monitor when I update my cluster to v0.=
59, pls note that I am not trying to upgrade,but by reinstall the ceph soft=
ware stack and rerunning mkcephfs. &nbsp;I have seen that the monitor chang=
e a lot
 after 0.58, is the mkcephfs still have bugs ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Below is the log:<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:41.127576 7f71=
c3610780&nbsp; 0 ceph version 0.59 (cbae6a435c62899f857775f66659de052fb0e75=
9), process ceph-mon, pid 1550<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:41.131271 7f71=
c3610780&nbsp; 1 unable to open monitor store at /data/mon.ceph1<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:41.131281 7f71=
c3610780&nbsp; 1 check for old monitor store format<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:41.131409 7f71=
c3610780&nbsp; 1 store(/data/mon.ceph1) mount<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:41.131430 7f71=
c3610780&nbsp; 1 store(/data/mon.ceph1) mount<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:41.131659 7f71=
c3610780&nbsp; 1 found old GV monitor store format -- should convert!<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:41.136476 7f71=
c3610780&nbsp; 1 store(/data/mon.ceph1) mount<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:46.098118 7f71=
c3610780&nbsp; 1 _convert_paxos first gv 2 last gv 475156<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.131667 7f71=
c3610780&nbsp; 0 convert finished conversion<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.185261 7f71=
c3610780&nbsp; 1 mon.ceph1@-1(probing) e1 preinit fsid 6d4e68d7-8959-4e8e-9=
0c9-7e43f508f16a<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.220874 7f71=
c3610780&nbsp; 0 mon.ceph1@-1(probing) e1&nbsp; my rank is now 0 (was -1)<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.220905 7f71=
c3610780&nbsp; 1 mon.ceph1@0(probing) e1 win_standalone_election<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.221808 7f71=
c3610780&nbsp; 0 log [INF] : mon.ceph1@0 won leader election with quorum 0<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.238542 7f71=
c3610780&nbsp; 0 log [INF] : pgmap v217425: 10368 pgs: 140 active&#43;clean=
, 3 stale&#43;active&#43;recovering, 2 stal<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">e, 67 stale&#43;active, 2 activ=
e&#43;recovery_wait, 99 stale&#43;active&#43;clean, 819 peering, 5 stale&#4=
3;active&#43;degraded&#43;wait_backfill, 3 stale&#43;activ<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">e&#43;recovery_wait, 3760 down&=
#43;peering, 12 stale&#43;active&#43;recovering&#43;degraded, 305 stale&#43=
;peering, 3977 stale&#43;down&#43;peering, 1135 stale&#43;acti<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ve&#43;degraded, 2 stale&#43;ac=
tive&#43;degraded&#43;backfilling, 4 stale&#43;active&#43;degraded&#43;rema=
pped&#43;wait_backfill, 6 incomplete, 1 stale&#43;remapped&#43;pee<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ring, 17 stale&#43;incomplete, =
1 stale&#43;active&#43;degraded&#43;remapped, 8 active&#43;recovering; 2717=
 GB data, 2015 GB used, 15441 GB / 17457 GB av<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ail; 90413/1391836 degraded (6.=
496%); 250/695918 unfound (0.036%)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.239560 7f71=
c3610780&nbsp; 0 log [INF] : mdsmap e1: 0/0/1 up<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.240448 7f71=
c3610780&nbsp; 0 log [INF] : osdmap e5056: 80 osds: 25 up, 25 in<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.241019 7f71=
c3610780&nbsp; 0 log [INF] : monmap e1: 1 mons at {ceph1=3D192.168.10.11:67=
89/0}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2013-03-21 08:17:47.441000 7f71=
bc1d1700 -1 auth/none/AuthNoneServiceHandler.h: In function 'virtual int Au=
thNoneServiceHandler::hand<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">le_request(ceph::buffer::list::=
iterator&amp;, ceph::bufferlist&amp;, uint64_t&amp;, AuthCapsInfo&amp;, uin=
t64_t*)' thread 7f71bc1d1700 time 2013-03-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">21 08:17:47.440030<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">auth/none/AuthNoneServiceHandle=
r.h: 35: FAILED assert(0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ceph version 0.59 (cbae6a435c62=
899f857775f66659de052fb0e759)<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_6F3FA899187F0043BA1827A69DA2F7CC62079FSHSMSX102ccrcorpi_--

--===============0096275195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0096275195==--
