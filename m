From: Luk <skidoo-wYtBgQxc//8@public.gmane.org>
Subject: Re: problem with degraded PG
Date: Fri, 14 Jun 2019 12:11:18 +0200
Message-ID: <889784653.20190614121118@tlen.pl>
References: <304057881.20190614111947@tlen.pl>
 <CABZ+qq=Ob4SuvFSbpN-8+NP66_rQJO2_HaNmThVwF6s8vOw+hQ@mail.gmail.com>
 <1171202508.20190614112950@tlen.pl>
 <CABZ+qqmN0zG57Oqtv3wMLHrfXEwCPfGQARewq=hkjOxmZ0=G6g@mail.gmail.com>
 <661486857.20190614115232@tlen.pl>
 <CADvHm=ah+SZiZs8apTxC5Uom3NzEydSKswj0hsgC9pgTzgodxQ@mail.gmail.com>
Reply-To: =?utf-8?Q?=C5=81ukasz_Chrustek?= <skidoo-wYtBgQxc//8@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0823888573640976993=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADvHm=ah+SZiZs8apTxC5Uom3NzEydSKswj0hsgC9pgTzgodxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Caspar Smit <casparsmit-lXVDXHTAWJDsq35pWSNszA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0823888573640976993==
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><title>Re: [ceph-users] problem with degraded PG</title>
</head>
<body>
<span style=3D" font-family:'Courier New'; font-size: 9pt;">Hi, this anothe=
r case - this three storage nodes were added few weeks ago to ssd pool. I d=
on't understand this kind of behavior also and was writing about this on ce=
ph-devel few weeks ago (didn't get answer) :/.<br>
<br>
</span><a style=3D" font-family:'Courier New'; font-size: 9pt;" href=3D"htt=
ps://www.spinics.net/lists/ceph-users/msg53130.html">https://www.spinics.ne=
t/lists/ceph-users/msg53130.html</a><br>
<br>
<span style=3D" font-family:'Courier New'; font-size: 9pt;">But this PGs wh=
ich are stuck are on diffrent root, this what You are asking is on ssd root=
 (which is default), and these 8 PG degraded are on root hdd (as You can se=
e in crushmap/osd tree).<br>
<br>
Regards<br>
Lukasz<br>
<br>
</span><table>
<tr>
<td width=3D3 bgcolor=3D #0000ff><br>
</td>
<td><span style=3D" font-family:'courier new'; font-size: 9pt;">Hi,<br>
<br>
Something seems off in weight and sizes of hosts: ssdstor-a01, ssdstor-b01 =
and ssdstor-c01.<br>
<br>
ssdstor-c01 has a weight of 0.4 while the size ~10TiB so i would expect the=
 weight to be around 10 in stead of 0.4<br>
Same goes for the other two nodes i mentioned above.<br>
<br>
Could you explain this?<br>
<br>
Kind regards,<br>
Caspar Smit<br>
<br>
<br>
Op vr 14 jun. 2019 om 11:52 schreef Luk &lt;</span><a style=3D" font-family=
:'courier new'; font-size: 9pt;" href=3D"mailto:skidoo-wYtBgQxc//8@public.gmane.org">skidoo@tlen=
.pl</a><span style=3D" font-family:'courier new'; font-size: 9pt;">&gt;:<br>
</span><table>
<tr>
<td width=3D3 bgcolor=3D #3200ff><br>
</td>
<td><span style=3D" font-family:'courier new'; font-size: 9pt;">Here is cep=
h osd tree, in first post there is also ceph osd df tree:<br>
<br>
</span><a style=3D" font-family:'courier new'; font-size: 9pt;" href=3D"htt=
ps://pastebin.com/Vs75gpwZ">https://pastebin.com/Vs75gpwZ</a><br>
<br>
<br>
<br>
<span style=3D" font-family:'courier new'; font-size: 9pt;">&gt; Ahh I was =
thinking of chooseleaf_vary_r, which you already have.<br>
&gt; So probably not related to tunables. What is your `ceph osd tree` ?<br>
<br>
&gt; By the way, 12.2.9 has an unrelated bug (details<br>
&gt; </span><a style=3D" font-family:'courier new'; font-size: 9pt;" href=
=3D"http://tracker.ceph.com/issues/36686">http://tracker.ceph.com/issues/36=
686</a><span style=3D" font-family:'courier new'; font-size: 9pt;">)<br>
&gt; AFAIU you will just need to update to v12.2.11 or v12.2.12 for that fi=
x.<br>
<br>
&gt; -- Dan<br>
<br>
&gt; On Fri, Jun 14, 2019 at 11:29 AM Luk &lt;</span><a style=3D" font-fami=
ly:'courier new'; font-size: 9pt;" href=3D"mailto:skidoo-wYtBgQxc//8@public.gmane.org">skidoo@tl=
en.pl</a><span style=3D" font-family:'courier new'; font-size: 9pt;">&gt; w=
rote:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; here is the output:<br>
&gt;&gt;<br>
&gt;&gt; ceph osd crush show-tunables<br>
&gt;&gt; {<br>
&gt;&gt; &nbsp; &nbsp; "choose_local_tries": 0,<br>
&gt;&gt; &nbsp; &nbsp; "choose_local_fallback_tries": 0,<br>
&gt;&gt; &nbsp; &nbsp; "choose_total_tries": 100,<br>
&gt;&gt; &nbsp; &nbsp; "chooseleaf_descend_once": 1,<br>
&gt;&gt; &nbsp; &nbsp; "chooseleaf_vary_r": 1,<br>
&gt;&gt; &nbsp; &nbsp; "chooseleaf_stable": 0,<br>
&gt;&gt; &nbsp; &nbsp; "straw_calc_version": 1,<br>
&gt;&gt; &nbsp; &nbsp; "allowed_bucket_algs": 22,<br>
&gt;&gt; &nbsp; &nbsp; "profile": "unknown",<br>
&gt;&gt; &nbsp; &nbsp; "optimal_tunables": 0,<br>
&gt;&gt; &nbsp; &nbsp; "legacy_tunables": 0,<br>
&gt;&gt; &nbsp; &nbsp; "minimum_required_version": "hammer",<br>
&gt;&gt; &nbsp; &nbsp; "require_feature_tunables": 1,<br>
&gt;&gt; &nbsp; &nbsp; "require_feature_tunables2": 1,<br>
&gt;&gt; &nbsp; &nbsp; "has_v2_rules": 0,<br>
&gt;&gt; &nbsp; &nbsp; "require_feature_tunables3": 1,<br>
&gt;&gt; &nbsp; &nbsp; "has_v3_rules": 0,<br>
&gt;&gt; &nbsp; &nbsp; "has_v4_buckets": 1,<br>
&gt;&gt; &nbsp; &nbsp; "require_feature_tunables5": 0,<br>
&gt;&gt; &nbsp; &nbsp; "has_v5_rules": 0<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; [root@ceph-mon-01 ~]#<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Regards<br>
&gt;&gt; Lukasz<br>
&gt;&gt;<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt; This looks like a tunables issue.<br>
&gt;&gt; &gt; What is the output of `ceph osd crush show-tunables `<br>
&gt;&gt;<br>
&gt;&gt; &gt; -- Dan<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Fri, Jun 14, 2019 at 11:19 AM Luk &lt;</span><a style=3D" =
font-family:'courier new'; font-size: 9pt;" href=3D"mailto:skidoo-wYtBgQxc//8@public.gmane.org">=
skidoo-wYtBgQxc//8@public.gmane.org</a><span style=3D" font-family:'courier new'; font-size: 9pt=
;">&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Hello,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Maybe &nbsp;somone &nbsp;was &nbsp;fighting &nbsp;with th=
is kind of stuck in ceph already.<br>
&gt;&gt; &gt;&gt; This &nbsp;is &nbsp;production &nbsp;cluster, &nbsp;can't=
/don't &nbsp;want to make wrong steps,<br>
&gt;&gt; &gt;&gt; please advice, what to do.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; After &nbsp;changing &nbsp;of &nbsp;one failed disk (it w=
as osd-7) on our cluster ceph<br>
&gt;&gt; &gt;&gt; didn't recover to HEALTH_OK, it stopped in state:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph -s<br>
&gt;&gt; &gt;&gt; &nbsp; cluster:<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; id: &nbsp; &nbsp; b6f23cff-7279-f4b0-ff91-2=
1fadac95bb5<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; health: HEALTH_WARN<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; noout,noscrub,n=
odeep-scrub flag(s) set<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Degraded data r=
edundancy: 24761/45994899 objects degraded (0.054%), 8 pgs degraded, 8 pgs =
undersized<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &nbsp; services:<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; mon: &nbsp; &nbsp; &nbsp; &nbsp;3 daemons, =
quorum ceph-mon-01,ceph-mon-02,ceph-mon-03<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; mgr: &nbsp; &nbsp; &nbsp; &nbsp;ceph-mon-03=
(active), standbys: ceph-mon-02, ceph-mon-01<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; osd: &nbsp; &nbsp; &nbsp; &nbsp;144 osds: 1=
44 up, 144 in<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; f=
lags noout,noscrub,nodeep-scrub<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; rbd-mirror: 3 daemons active<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; rgw: &nbsp; &nbsp; &nbsp; &nbsp;6 daemons a=
ctive<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &nbsp; data:<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; pools: &nbsp; 18 pools, 2176 pgs<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; objects: 15.33M objects, 49.3TiB<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; usage: &nbsp; 151TiB used, 252TiB / 403TiB =
avail<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; pgs: &nbsp; &nbsp; 24761/45994899 objects d=
egraded (0.054%)<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2168 acti=
ve+clean<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;8 &nbsp; =
&nbsp;active+undersized+degraded<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &nbsp; io:<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; client: &nbsp; 435MiB/s rd, 415MiB/s wr, 7.=
94kop/s rd, 2.96kop/s wr<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Restart of OSD didn't helped, changing choose_total_tries=
 from 50 to 100 didn't help.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I checked one of degraded PG, 10.3c4<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph pg dump 2&gt;&amp;1 | grep -w =
10.3c4<br>
&gt;&gt; &gt;&gt; 10.3c4 &nbsp; &nbsp; 3593 &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; 3593 &nbsp; &nbsp; &nbsp; &n=
bsp; 0 &nbsp; &nbsp; &nbsp; 0 14769891858 10076 &nbsp; &nbsp;10076 &nbsp; &=
nbsp;active+undersized+degraded 2019-06-13 08:19:39.802219 &nbsp;37380'7190=
0564 37380:119411139 &nbsp; &nbsp; &nbsp; [9,109] &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;9 &nbsp; &nbsp; &nbsp; [9,109] &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;9 &nbsp;33550'69130424 2019-06-08 02:28:40.508790 &nbsp;33550'=
69130424 2019-06-08 02:28:40.508790 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;18<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph pg 10.3c4 query | jq '.["peer_=
info"][] | {peer: .peer, last_update:.last_update}'<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt; &nbsp; "peer": "0",<br>
&gt;&gt; &gt;&gt; &nbsp; "last_update": "36847'71412720"<br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt; &nbsp; "peer": "109",<br>
&gt;&gt; &gt;&gt; &nbsp; "last_update": "37380'71900570"<br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt; &nbsp; "peer": "117",<br>
&gt;&gt; &gt;&gt; &nbsp; "last_update": "0'0"<br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]#<br>
&gt;&gt; &gt;&gt; I have checked space taken for this PG on storage nodes:<=
br>
&gt;&gt; &gt;&gt; here is how to check where is particular OSD (on which ph=
ysical storage node):<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
" 9 "<br>
&gt;&gt; &gt;&gt; | &nbsp;9 &nbsp;| &nbsp; stor-a02 &nbsp;| 2063G | 5386G |=
 &nbsp; 52 &nbsp; | &nbsp;1347k &nbsp;| &nbsp; 53 &nbsp; | &nbsp; 292k &nbs=
p;| exists,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
" 109 "<br>
&gt;&gt; &gt;&gt; | 109 | &nbsp; stor-a01 &nbsp;| 1285G | 4301G | &nbsp; &n=
bsp;5 &nbsp; | &nbsp;31.0k &nbsp;| &nbsp; &nbsp;6 &nbsp; | &nbsp;59.2k &nbs=
p;| exists,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# watch ceph -s<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
" 117 "<br>
&gt;&gt; &gt;&gt; | 117 | &nbsp; stor-b02 &nbsp;| 1334G | 4252G | &nbsp; 54=
 &nbsp; | &nbsp;1216k &nbsp;| &nbsp; 13 &nbsp; | &nbsp;27.4k &nbsp;| exists=
,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
" 0 "<br>
&gt;&gt; &gt;&gt; | &nbsp;0 &nbsp;| &nbsp; stor-a01 &nbsp;| 2156G | 5293G |=
 &nbsp; 58 &nbsp; | &nbsp; 387k &nbsp;| &nbsp; 29 &nbsp; | &nbsp;30.7k &nbs=
p;| exists,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]#<br>
&gt;&gt; &gt;&gt; and checking sizes on servers:<br>
&gt;&gt; &gt;&gt; stor-a01 (this PG shouldn't be on the same host):<br>
&gt;&gt; &gt;&gt; [root@stor-a01 /var/lib/ceph/osd/ceph-0/current]# du -sh =
10.3c4_*<br>
&gt;&gt; &gt;&gt; 2.4G &nbsp; &nbsp;10.3c4_head<br>
&gt;&gt; &gt;&gt; 0 &nbsp; &nbsp; &nbsp; 10.3c4_TEMP<br>
&gt;&gt; &gt;&gt; [root@stor-a01 /var/lib/ceph/osd/ceph-109/current]# du -s=
h 10.3c4_*<br>
&gt;&gt; &gt;&gt; 14G &nbsp; &nbsp; 10.3c4_head<br>
&gt;&gt; &gt;&gt; 0 &nbsp; &nbsp; &nbsp; 10.3c4_TEMP<br>
&gt;&gt; &gt;&gt; [root@stor-a01 /var/lib/ceph/osd/ceph-109/current]#<br>
&gt;&gt; &gt;&gt; stor-a02:<br>
&gt;&gt; &gt;&gt; [root@stor-a02 /var/lib/ceph/osd/ceph-9/current]# du -sh =
10.3c4_*<br>
&gt;&gt; &gt;&gt; 14G &nbsp; &nbsp; 10.3c4_head<br>
&gt;&gt; &gt;&gt; 0 &nbsp; &nbsp; &nbsp; 10.3c4_TEMP<br>
&gt;&gt; &gt;&gt; [root@stor-a02 /var/lib/ceph/osd/ceph-9/current]#<br>
&gt;&gt; &gt;&gt; stor-b02:<br>
&gt;&gt; &gt;&gt; [root@stor-b02 /var/lib/ceph/osd/ceph-117/current]# du -s=
h 10.3c4_*<br>
&gt;&gt; &gt;&gt; zsh: no matches found: 10.3c4_*<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; information about ceph:<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph versions<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; "mon": {<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; "ceph version 12.2.9 (9e30093=
2ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 3<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; },<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; "mgr": {<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; "ceph version 12.2.9 (9e30093=
2ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 3<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; },<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; "osd": {<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; "ceph version 12.2.9 (9e30093=
2ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 144<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; },<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; "mds": {},<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; "rbd-mirror": {<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; "ceph version 12.2.9 (9e30093=
2ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 3<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; },<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; "rgw": {<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; "ceph version 12.2.9 (9e30093=
2ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 6<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; },<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; "overall": {<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; "ceph version 12.2.9 (9e30093=
2ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 159<br>
&gt;&gt; &gt;&gt; &nbsp; &nbsp; }<br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; crushmap: </span><a style=3D" font-family:'courier new'; =
font-size: 9pt;" href=3D"https://pastebin.com/cpC2WmyS">https://pastebin.co=
m/cpC2WmyS</a><br>
<span style=3D" font-family:'courier new'; font-size: 9pt;">&gt;&gt; &gt;&g=
t; ceph osd tree: </span><a style=3D" font-family:'courier new'; font-size:=
 9pt;" href=3D"https://pastebin.com/XvZ2cNZZ">https://pastebin.com/XvZ2cNZZ=
</a><br>
<span style=3D" font-family:'courier new'; font-size: 9pt;">&gt;&gt; &gt;&g=
t;<br>
&gt;&gt; &gt;&gt; I'm &nbsp;cross-posting this do devel because maybe there=
 is some known bug<br>
&gt;&gt; &gt;&gt; in &nbsp;this &nbsp;particular &nbsp;version &nbsp;of &nb=
sp;ceph, &nbsp;and &nbsp;You &nbsp;could &nbsp;point &nbsp;some<br>
&gt;&gt; &gt;&gt; directions to fix this problem.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; Regards<br>
&gt;&gt; &gt;&gt; Lukasz<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Pozdrowienia,<br>
&gt;&gt; &nbsp;Luk<br>
&gt;&gt;<br>
<br>
<br>
<br>
-- <br>
Pozdrowienia,<br>
 Luk<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
</span><a style=3D" font-family:'courier new'; font-size: 9pt;" href=3D"mai=
lto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
<a style=3D" font-family:'courier new'; font-size: 9pt;" href=3D"http://lis=
ts.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinf=
o.cgi/ceph-users-ceph.com</a></td>
</tr>
</table>
</td>
</tr>
</table>
<br>
<br>
<br>
<span style=3D" font-family:'arial'; color: #c0c0c0;"><i>-- <br>
Pozdrowienia,<br>
 Luk</body></html>


--===============0823888573640976993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0823888573640976993==--
