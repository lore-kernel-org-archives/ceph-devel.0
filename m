From: Caspar Smit <casparsmit-lXVDXHTAWJDsq35pWSNszA@public.gmane.org>
Subject: Re: problem with degraded PG
Date: Fri, 14 Jun 2019 12:02:06 +0200
Message-ID: <CADvHm=ah+SZiZs8apTxC5Uom3NzEydSKswj0hsgC9pgTzgodxQ@mail.gmail.com>
References: <304057881.20190614111947@tlen.pl>
 <CABZ+qq=Ob4SuvFSbpN-8+NP66_rQJO2_HaNmThVwF6s8vOw+hQ@mail.gmail.com>
 <1171202508.20190614112950@tlen.pl>
 <CABZ+qqmN0zG57Oqtv3wMLHrfXEwCPfGQARewq=hkjOxmZ0=G6g@mail.gmail.com>
 <661486857.20190614115232@tlen.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4945602218892607632=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <661486857.20190614115232-wYtBgQxc//8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?UTF-8?Q?=C5=81ukasz_Chrustek?= <skidoo-wYtBgQxc//8@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4945602218892607632==
Content-Type: multipart/alternative; boundary="000000000000de9813058b45bdb7"

--000000000000de9813058b45bdb7
Content-Type: text/plain; charset="UTF-8"

Hi,

Something seems off in weight and sizes of hosts: ssdstor-a01, ssdstor-b01
and ssdstor-c01.

ssdstor-c01 has a weight of 0.4 while the size ~10TiB so i would expect the
weight to be around 10 in stead of 0.4
Same goes for the other two nodes i mentioned above.

Could you explain this?

Kind regards,
Caspar Smit



Op vr 14 jun. 2019 om 11:52 schreef Luk <skidoo-wYtBgQxc//8@public.gmane.org>:

> Here is ceph osd tree, in first post there is also ceph osd df tree:
>
> https://pastebin.com/Vs75gpwZ
>
>
>
> > Ahh I was thinking of chooseleaf_vary_r, which you already have.
> > So probably not related to tunables. What is your `ceph osd tree` ?
>
> > By the way, 12.2.9 has an unrelated bug (details
> > http://tracker.ceph.com/issues/36686)
> > AFAIU you will just need to update to v12.2.11 or v12.2.12 for that fix.
>
> > -- Dan
>
> > On Fri, Jun 14, 2019 at 11:29 AM Luk <skidoo-wYtBgQxc//8@public.gmane.org> wrote:
> >>
> >> Hi,
> >>
> >> here is the output:
> >>
> >> ceph osd crush show-tunables
> >> {
> >>     "choose_local_tries": 0,
> >>     "choose_local_fallback_tries": 0,
> >>     "choose_total_tries": 100,
> >>     "chooseleaf_descend_once": 1,
> >>     "chooseleaf_vary_r": 1,
> >>     "chooseleaf_stable": 0,
> >>     "straw_calc_version": 1,
> >>     "allowed_bucket_algs": 22,
> >>     "profile": "unknown",
> >>     "optimal_tunables": 0,
> >>     "legacy_tunables": 0,
> >>     "minimum_required_version": "hammer",
> >>     "require_feature_tunables": 1,
> >>     "require_feature_tunables2": 1,
> >>     "has_v2_rules": 0,
> >>     "require_feature_tunables3": 1,
> >>     "has_v3_rules": 0,
> >>     "has_v4_buckets": 1,
> >>     "require_feature_tunables5": 0,
> >>     "has_v5_rules": 0
> >> }
> >>
> >> [root@ceph-mon-01 ~]#
> >>
> >> --
> >> Regards
> >> Lukasz
> >>
> >> > Hi,
> >> > This looks like a tunables issue.
> >> > What is the output of `ceph osd crush show-tunables `
> >>
> >> > -- Dan
> >>
> >> > On Fri, Jun 14, 2019 at 11:19 AM Luk <skidoo-wYtBgQxc//8@public.gmane.org> wrote:
> >> >>
> >> >> Hello,
> >> >>
> >> >> Maybe  somone  was  fighting  with this kind of stuck in ceph
> already.
> >> >> This  is  production  cluster,  can't/don't  want to make wrong
> steps,
> >> >> please advice, what to do.
> >> >>
> >> >> After  changing  of  one failed disk (it was osd-7) on our cluster
> ceph
> >> >> didn't recover to HEALTH_OK, it stopped in state:
> >> >>
> >> >> [root@ceph-mon-01 ~]# ceph -s
> >> >>   cluster:
> >> >>     id:     b6f23cff-7279-f4b0-ff91-21fadac95bb5
> >> >>     health: HEALTH_WARN
> >> >>             noout,noscrub,nodeep-scrub flag(s) set
> >> >>             Degraded data redundancy: 24761/45994899 objects
> degraded (0.054%), 8 pgs degraded, 8 pgs undersized
> >> >>
> >> >>   services:
> >> >>     mon:        3 daemons, quorum ceph-mon-01,ceph-mon-02,ceph-mon-03
> >> >>     mgr:        ceph-mon-03(active), standbys: ceph-mon-02,
> ceph-mon-01
> >> >>     osd:        144 osds: 144 up, 144 in
> >> >>                 flags noout,noscrub,nodeep-scrub
> >> >>     rbd-mirror: 3 daemons active
> >> >>     rgw:        6 daemons active
> >> >>
> >> >>   data:
> >> >>     pools:   18 pools, 2176 pgs
> >> >>     objects: 15.33M objects, 49.3TiB
> >> >>     usage:   151TiB used, 252TiB / 403TiB avail
> >> >>     pgs:     24761/45994899 objects degraded (0.054%)
> >> >>              2168 active+clean
> >> >>              8    active+undersized+degraded
> >> >>
> >> >>   io:
> >> >>     client:   435MiB/s rd, 415MiB/s wr, 7.94kop/s rd, 2.96kop/s wr
> >> >>
> >> >> Restart of OSD didn't helped, changing choose_total_tries from 50 to
> 100 didn't help.
> >> >>
> >> >> I checked one of degraded PG, 10.3c4
> >> >>
> >> >> [root@ceph-mon-01 ~]# ceph pg dump 2>&1 | grep -w 10.3c4
> >> >> 10.3c4     3593                  0     3593         0       0
> 14769891858 10076    10076    active+undersized+degraded 2019-06-13
> 08:19:39.802219  37380'71900564 37380:119411139       [9,109]          9
>    [9,109]              9  33550'69130424 2019-06-08 02:28:40.508790
> 33550'69130424 2019-06-08 02:28:40.508790            18
> >> >>
> >> >>
> >> >> [root@ceph-mon-01 ~]# ceph pg 10.3c4 query | jq '.["peer_info"][] |
> {peer: .peer, last_update:.last_update}'
> >> >> {
> >> >>   "peer": "0",
> >> >>   "last_update": "36847'71412720"
> >> >> }
> >> >> {
> >> >>   "peer": "109",
> >> >>   "last_update": "37380'71900570"
> >> >> }
> >> >> {
> >> >>   "peer": "117",
> >> >>   "last_update": "0'0"
> >> >> }
> >> >>
> >> >>
> >> >> [root@ceph-mon-01 ~]#
> >> >> I have checked space taken for this PG on storage nodes:
> >> >> here is how to check where is particular OSD (on which physical
> storage node):
> >> >> [root@ceph-mon-01 ~]# ceph osd status 2>&1 | grep " 9 "
> >> >> |  9  |   stor-a02  | 2063G | 5386G |   52   |  1347k  |   53   |
>  292k  | exists,up |
> >> >> [root@ceph-mon-01 ~]# ceph osd status 2>&1 | grep " 109 "
> >> >> | 109 |   stor-a01  | 1285G | 4301G |    5   |  31.0k  |    6   |
> 59.2k  | exists,up |
> >> >> [root@ceph-mon-01 ~]# watch ceph -s
> >> >> [root@ceph-mon-01 ~]# ceph osd status 2>&1 | grep " 117 "
> >> >> | 117 |   stor-b02  | 1334G | 4252G |   54   |  1216k  |   13   |
> 27.4k  | exists,up |
> >> >> [root@ceph-mon-01 ~]# ceph osd status 2>&1 | grep " 0 "
> >> >> |  0  |   stor-a01  | 2156G | 5293G |   58   |   387k  |   29   |
> 30.7k  | exists,up |
> >> >> [root@ceph-mon-01 ~]#
> >> >> and checking sizes on servers:
> >> >> stor-a01 (this PG shouldn't be on the same host):
> >> >> [root@stor-a01 /var/lib/ceph/osd/ceph-0/current]# du -sh 10.3c4_*
> >> >> 2.4G    10.3c4_head
> >> >> 0       10.3c4_TEMP
> >> >> [root@stor-a01 /var/lib/ceph/osd/ceph-109/current]# du -sh 10.3c4_*
> >> >> 14G     10.3c4_head
> >> >> 0       10.3c4_TEMP
> >> >> [root@stor-a01 /var/lib/ceph/osd/ceph-109/current]#
> >> >> stor-a02:
> >> >> [root@stor-a02 /var/lib/ceph/osd/ceph-9/current]# du -sh 10.3c4_*
> >> >> 14G     10.3c4_head
> >> >> 0       10.3c4_TEMP
> >> >> [root@stor-a02 /var/lib/ceph/osd/ceph-9/current]#
> >> >> stor-b02:
> >> >> [root@stor-b02 /var/lib/ceph/osd/ceph-117/current]# du -sh 10.3c4_*
> >> >> zsh: no matches found: 10.3c4_*
> >> >>
> >> >> information about ceph:
> >> >> [root@ceph-mon-01 ~]# ceph versions
> >> >> {
> >> >>     "mon": {
> >> >>         "ceph version 12.2.9
> (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 3
> >> >>     },
> >> >>     "mgr": {
> >> >>         "ceph version 12.2.9
> (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 3
> >> >>     },
> >> >>     "osd": {
> >> >>         "ceph version 12.2.9
> (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 144
> >> >>     },
> >> >>     "mds": {},
> >> >>     "rbd-mirror": {
> >> >>         "ceph version 12.2.9
> (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 3
> >> >>     },
> >> >>     "rgw": {
> >> >>         "ceph version 12.2.9
> (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 6
> >> >>     },
> >> >>     "overall": {
> >> >>         "ceph version 12.2.9
> (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)": 159
> >> >>     }
> >> >> }
> >> >>
> >> >> crushmap: https://pastebin.com/cpC2WmyS
> >> >> ceph osd tree: https://pastebin.com/XvZ2cNZZ
> >> >>
> >> >> I'm  cross-posting this do devel because maybe there is some known
> bug
> >> >> in  this  particular  version  of  ceph,  and  You  could  point
> some
> >> >> directions to fix this problem.
> >> >>
> >> >> --
> >> >> Regards
> >> >> Lukasz
> >> >>
> >>
> >>
> >>
> >> --
> >> Pozdrowienia,
> >>  Luk
> >>
>
>
>
> --
> Pozdrowienia,
>  Luk
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000de9813058b45bdb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Something seems off in weight and s=
izes of hosts: ssdstor-a01, ssdstor-b01 and ssdstor-c01.<div><br></div><div=
>ssdstor-c01 has a weight of 0.4 while the size ~10TiB so i would expect th=
e weight to be around 10 in stead of 0.4</div><div>Same goes for the other =
two nodes i mentioned above.</div><div><br></div><div>Could you explain thi=
s?<br></div><div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Kind regards,<b=
r>Caspar Smit<br><br></div></div></div><br></div></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Op vr 14 jun. 2019 o=
m 11:52 schreef Luk &lt;<a href=3D"mailto:skidoo-wYtBgQxc//8@public.gmane.org">skidoo-wYtBgQxc//8@public.gmane.org</a=
>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Here is c=
eph osd tree, in first post there is also ceph osd df tree:<br>
<br>
<a href=3D"https://pastebin.com/Vs75gpwZ" rel=3D"noreferrer" target=3D"_bla=
nk">https://pastebin.com/Vs75gpwZ</a><br>
<br>
<br>
<br>
&gt; Ahh I was thinking of chooseleaf_vary_r, which you already have.<br>
&gt; So probably not related to tunables. What is your `ceph osd tree` ?<br=
>
<br>
&gt; By the way, 12.2.9 has an unrelated bug (details<br>
&gt; <a href=3D"http://tracker.ceph.com/issues/36686" rel=3D"noreferrer" ta=
rget=3D"_blank">http://tracker.ceph.com/issues/36686</a>)<br>
&gt; AFAIU you will just need to update to v12.2.11 or v12.2.12 for that fi=
x.<br>
<br>
&gt; -- Dan<br>
<br>
&gt; On Fri, Jun 14, 2019 at 11:29 AM Luk &lt;<a href=3D"mailto:skidoo@tlen=
.pl" target=3D"_blank">skidoo-wYtBgQxc//8@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; here is the output:<br>
&gt;&gt;<br>
&gt;&gt; ceph osd crush show-tunables<br>
&gt;&gt; {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;choose_local_tries&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;choose_local_fallback_tries&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;choose_total_tries&quot;: 100,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;chooseleaf_descend_once&quot;: 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;chooseleaf_vary_r&quot;: 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;chooseleaf_stable&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;straw_calc_version&quot;: 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;allowed_bucket_algs&quot;: 22,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;profile&quot;: &quot;unknown&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;optimal_tunables&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;legacy_tunables&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;minimum_required_version&quot;: &quot;ham=
mer&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;require_feature_tunables&quot;: 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;require_feature_tunables2&quot;: 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;has_v2_rules&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;require_feature_tunables3&quot;: 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;has_v3_rules&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;has_v4_buckets&quot;: 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;require_feature_tunables5&quot;: 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;has_v5_rules&quot;: 0<br>
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
&gt;&gt; &gt; On Fri, Jun 14, 2019 at 11:19 AM Luk &lt;<a href=3D"mailto:sk=
idoo-wYtBgQxc//8@public.gmane.org" target=3D"_blank">skidoo-wYtBgQxc//8@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Hello,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Maybe=C2=A0 somone=C2=A0 was=C2=A0 fighting=C2=A0 with th=
is kind of stuck in ceph already.<br>
&gt;&gt; &gt;&gt; This=C2=A0 is=C2=A0 production=C2=A0 cluster,=C2=A0 can&#=
39;t/don&#39;t=C2=A0 want to make wrong steps,<br>
&gt;&gt; &gt;&gt; please advice, what to do.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; After=C2=A0 changing=C2=A0 of=C2=A0 one failed disk (it w=
as osd-7) on our cluster ceph<br>
&gt;&gt; &gt;&gt; didn&#39;t recover to HEALTH_OK, it stopped in state:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph -s<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0cluster:<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0id:=C2=A0 =C2=A0 =C2=A0b6f23cff-7279-f=
4b0-ff91-21fadac95bb5<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0health: HEALTH_WARN<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0noout,nosc=
rub,nodeep-scrub flag(s) set<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Degraded d=
ata redundancy: 24761/45994899 objects degraded (0.054%), 8 pgs degraded, 8=
 pgs undersized<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0services:<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0mon:=C2=A0 =C2=A0 =C2=A0 =C2=A0 3 daem=
ons, quorum ceph-mon-01,ceph-mon-02,ceph-mon-03<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0mgr:=C2=A0 =C2=A0 =C2=A0 =C2=A0 ceph-m=
on-03(active), standbys: ceph-mon-02, ceph-mon-01<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0osd:=C2=A0 =C2=A0 =C2=A0 =C2=A0 144 os=
ds: 144 up, 144 in<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0flags noout,noscrub,nodeep-scrub<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0rbd-mirror: 3 daemons active<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0rgw:=C2=A0 =C2=A0 =C2=A0 =C2=A0 6 daem=
ons active<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0data:<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0pools:=C2=A0 =C2=A018 pools, 2176 pgs<=
br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0objects: 15.33M objects, 49.3TiB<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0usage:=C2=A0 =C2=A0151TiB used, 252TiB=
 / 403TiB avail<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0pgs:=C2=A0 =C2=A0 =C2=A024761/45994899=
 objects degraded (0.054%)<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2168 acti=
ve+clean<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8=C2=A0 =
=C2=A0 active+undersized+degraded<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0io:<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0client:=C2=A0 =C2=A0435MiB/s rd, 415Mi=
B/s wr, 7.94kop/s rd, 2.96kop/s wr<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Restart of OSD didn&#39;t helped, changing choose_total_t=
ries from 50 to 100 didn&#39;t help.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I checked one of degraded PG, 10.3c4<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph pg dump 2&gt;&amp;1 | grep -w =
10.3c4<br>
&gt;&gt; &gt;&gt; 10.3c4=C2=A0 =C2=A0 =C2=A03593=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A03593=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A00 14769891858 10076=C2=A0 =
=C2=A0 10076=C2=A0 =C2=A0 active+undersized+degraded 2019-06-13 08:19:39.80=
2219=C2=A0 37380&#39;71900564 37380:119411139=C2=A0 =C2=A0 =C2=A0 =C2=A0[9,=
109]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 9=C2=A0 =C2=A0 =C2=A0 =C2=A0[9,109]=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 9=C2=A0 33550&#39;69130424=
 2019-06-08 02:28:40.508790=C2=A0 33550&#39;69130424 2019-06-08 02:28:40.50=
8790=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 18<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph pg 10.3c4 query | jq &#39;.[&q=
uot;peer_info&quot;][] | {peer: .peer, last_update:.last_update}&#39;<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0&quot;peer&quot;: &quot;0&quot;,<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0&quot;last_update&quot;: &quot;36847&#39;7141=
2720&quot;<br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0&quot;peer&quot;: &quot;109&quot;,<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0&quot;last_update&quot;: &quot;37380&#39;7190=
0570&quot;<br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0&quot;peer&quot;: &quot;117&quot;,<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0&quot;last_update&quot;: &quot;0&#39;0&quot;<=
br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]#<br>
&gt;&gt; &gt;&gt; I have checked space taken for this PG on storage nodes:<=
br>
&gt;&gt; &gt;&gt; here is how to check where is particular OSD (on which ph=
ysical storage node):<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
&quot; 9 &quot;<br>
&gt;&gt; &gt;&gt; |=C2=A0 9=C2=A0 |=C2=A0 =C2=A0stor-a02=C2=A0 | 2063G | 53=
86G |=C2=A0 =C2=A052=C2=A0 =C2=A0|=C2=A0 1347k=C2=A0 |=C2=A0 =C2=A053=C2=A0=
 =C2=A0|=C2=A0 =C2=A0292k=C2=A0 | exists,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
&quot; 109 &quot;<br>
&gt;&gt; &gt;&gt; | 109 |=C2=A0 =C2=A0stor-a01=C2=A0 | 1285G | 4301G |=C2=
=A0 =C2=A0 5=C2=A0 =C2=A0|=C2=A0 31.0k=C2=A0 |=C2=A0 =C2=A0 6=C2=A0 =C2=A0|=
=C2=A0 59.2k=C2=A0 | exists,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# watch ceph -s<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
&quot; 117 &quot;<br>
&gt;&gt; &gt;&gt; | 117 |=C2=A0 =C2=A0stor-b02=C2=A0 | 1334G | 4252G |=C2=
=A0 =C2=A054=C2=A0 =C2=A0|=C2=A0 1216k=C2=A0 |=C2=A0 =C2=A013=C2=A0 =C2=A0|=
=C2=A0 27.4k=C2=A0 | exists,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph osd status 2&gt;&amp;1 | grep =
&quot; 0 &quot;<br>
&gt;&gt; &gt;&gt; |=C2=A0 0=C2=A0 |=C2=A0 =C2=A0stor-a01=C2=A0 | 2156G | 52=
93G |=C2=A0 =C2=A058=C2=A0 =C2=A0|=C2=A0 =C2=A0387k=C2=A0 |=C2=A0 =C2=A029=
=C2=A0 =C2=A0|=C2=A0 30.7k=C2=A0 | exists,up |<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]#<br>
&gt;&gt; &gt;&gt; and checking sizes on servers:<br>
&gt;&gt; &gt;&gt; stor-a01 (this PG shouldn&#39;t be on the same host):<br>
&gt;&gt; &gt;&gt; [root@stor-a01 /var/lib/ceph/osd/ceph-0/current]# du -sh =
10.3c4_*<br>
&gt;&gt; &gt;&gt; 2.4G=C2=A0 =C2=A0 10.3c4_head<br>
&gt;&gt; &gt;&gt; 0=C2=A0 =C2=A0 =C2=A0 =C2=A010.3c4_TEMP<br>
&gt;&gt; &gt;&gt; [root@stor-a01 /var/lib/ceph/osd/ceph-109/current]# du -s=
h 10.3c4_*<br>
&gt;&gt; &gt;&gt; 14G=C2=A0 =C2=A0 =C2=A010.3c4_head<br>
&gt;&gt; &gt;&gt; 0=C2=A0 =C2=A0 =C2=A0 =C2=A010.3c4_TEMP<br>
&gt;&gt; &gt;&gt; [root@stor-a01 /var/lib/ceph/osd/ceph-109/current]#<br>
&gt;&gt; &gt;&gt; stor-a02:<br>
&gt;&gt; &gt;&gt; [root@stor-a02 /var/lib/ceph/osd/ceph-9/current]# du -sh =
10.3c4_*<br>
&gt;&gt; &gt;&gt; 14G=C2=A0 =C2=A0 =C2=A010.3c4_head<br>
&gt;&gt; &gt;&gt; 0=C2=A0 =C2=A0 =C2=A0 =C2=A010.3c4_TEMP<br>
&gt;&gt; &gt;&gt; [root@stor-a02 /var/lib/ceph/osd/ceph-9/current]#<br>
&gt;&gt; &gt;&gt; stor-b02:<br>
&gt;&gt; &gt;&gt; [root@stor-b02 /var/lib/ceph/osd/ceph-117/current]# du -s=
h 10.3c4_*<br>
&gt;&gt; &gt;&gt; zsh: no matches found: 10.3c4_*<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; information about ceph:<br>
&gt;&gt; &gt;&gt; [root@ceph-mon-01 ~]# ceph versions<br>
&gt;&gt; &gt;&gt; {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;mon&quot;: {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ceph version 12.2.=
9 (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)&quot;: 3<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;mgr&quot;: {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ceph version 12.2.=
9 (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)&quot;: 3<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;osd&quot;: {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ceph version 12.2.=
9 (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)&quot;: 144<b=
r>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;mds&quot;: {},<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;rbd-mirror&quot;: {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ceph version 12.2.=
9 (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)&quot;: 3<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;rgw&quot;: {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ceph version 12.2.=
9 (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)&quot;: 6<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0&quot;overall&quot;: {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ceph version 12.2.=
9 (9e300932ef8a8916fb3fda78c58691a6ab0f4217) luminous (stable)&quot;: 159<b=
r>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;&gt; }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; crushmap: <a href=3D"https://pastebin.com/cpC2WmyS" rel=
=3D"noreferrer" target=3D"_blank">https://pastebin.com/cpC2WmyS</a><br>
&gt;&gt; &gt;&gt; ceph osd tree: <a href=3D"https://pastebin.com/XvZ2cNZZ" =
rel=3D"noreferrer" target=3D"_blank">https://pastebin.com/XvZ2cNZZ</a><br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I&#39;m=C2=A0 cross-posting this do devel because maybe t=
here is some known bug<br>
&gt;&gt; &gt;&gt; in=C2=A0 this=C2=A0 particular=C2=A0 version=C2=A0 of=C2=
=A0 ceph,=C2=A0 and=C2=A0 You=C2=A0 could=C2=A0 point=C2=A0 some<br>
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
&gt;&gt;=C2=A0 Luk<br>
&gt;&gt;<br>
<br>
<br>
<br>
-- <br>
Pozdrowienia,<br>
=C2=A0Luk<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--000000000000de9813058b45bdb7--

--===============4945602218892607632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4945602218892607632==--
