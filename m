From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Troubleshooting incomplete PG's
Date: Fri, 31 Mar 2017 00:49:54 +0530
Message-ID: <CALWuvY-053dt8w8Aj5n-icf--v_TZ2dkEBrE8T7nTR8Hb3SeDg@mail.gmail.com>
References: <CALWuvY9pPr6FumF-d65pLrhbj1=HPNUEH74tKEOsfs=fAn_fbA@mail.gmail.com>
	<CAF-wwdGXduVn8a5xYPxo2BBtHQnAFVijPG_EvDjojyL_7f0cxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1943369474=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAF-wwdGXduVn8a5xYPxo2BBtHQnAFVijPG_EvDjojyL_7f0cxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1943369474==
Content-Type: multipart/alternative; boundary=001a113ad706f5137b054bf7931a

--001a113ad706f5137b054bf7931a
Content-Type: text/plain; charset=UTF-8

Hello Brad,

Many thanks of the info :)

ENV:-- Kracken - bluestore - EC 4+1 - 5 node cluster : RHEL7

What is the status of the down+out osd? Only one osd osd.6 down and out
from cluster.
What role did/does it play? Mostimportantly, is it osd.6? Yes, due to
underlying I/O error issue we removed this device from the cluster.

I put this parameter " osd_find_best_info_ignore_history_les = true" in
ceph.conf, and find those 22 PG's were changed to "down+remapped" . Now all
are reverted to "remapped+incomplete" state.

#ceph pg stat 2> /dev/null
v2731828: 4096 pgs: 1 incomplete, 21 remapped+incomplete, 4074
active+clean; 268 TB data, 371 TB used, 267 TB / 638 TB avail

## ceph -s
2017-03-30 19:02:14.350242 7f8b0415f700 -1 WARNING: the following dangerous
and experimental features are enabled: bluestore,rocksdb
2017-03-30 19:02:14.366545 7f8b0415f700 -1 WARNING: the following dangerous
and experimental features are enabled: bluestore,rocksdb
    cluster bd8adcd0-c36d-4367-9efe-f48f5ab5f108
     health HEALTH_ERR
            22 pgs are stuck inactive for more than 300 seconds
            22 pgs incomplete
            22 pgs stuck inactive
            22 pgs stuck unclean
     monmap e2: 5 mons at {au-adelaide=
10.50.21.24:6789/0,au-brisbane=10.50.21.22:6789/0,au-canberra=10.50.21.23:6789/0,au-melbourne=10.50.21.21:6789/0,au-sydney=10.50.21.20:6789/0
}
            election epoch 180, quorum 0,1,2,3,4
au-sydney,au-melbourne,au-brisbane,au-canberra,au-adelaide
        mgr active: au-adelaide
     osdmap e6506: 117 osds: 117 up, 117 in; 21 remapped pgs
            flags sortbitwise,require_jewel_osds,require_kraken_osds
      pgmap v2731828: 4096 pgs, 1 pools, 268 TB data, 197 Mobjects
            371 TB used, 267 TB / 638 TB avail
                4074 active+clean
                  21 remapped+incomplete
                   1 incomplete


## ceph osd dump 2>/dev/null | grep cdvr
pool 1 'cdvr_ec' erasure size 5 min_size 4 crush_ruleset 1 object_hash
rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags
hashpspool,nodeep-scrub stripe_width 65536

Inspecting affected PG *1.e4b*

# ceph pg dump 2> /dev/null | grep 1.e4b
1.e4b     50832                  0        0         0       0 73013340821
10006    10006 remapped+incomplete 2017-03-30 14:14:26.297098 3844'161662
 6506:325748 [113,66,15,73,103]        113  [NONE,NONE,NONE,73,NONE]
      73 1643'139486 2017-03-21 04:56:16.683953             0'0 2017-02-21
10:33:50.012922

When I trigger below command.

#ceph pg force_create_pg 1.e4b
pg 1.e4b now creating, ok

As it went to creating state, no change after that. Can you explain why
this PG showing null values after triggering "force_create_pg",?

]# ceph pg dump 2> /dev/null | grep 1.e4b
1.e4b         0                  0        0         0       0           0
  0        0            creating 2017-03-30 19:07:00.982178         0'0
     0:0                 []         -1                        []
  -1         0'0                   0.000000             0'0
  0.000000

Then I triggered below command

# ceph pg  repair 1.e4b
Error EAGAIN: pg 1.e4b has no primary osd  --<<

Could you please provide answer for below queries.

1. How to fix this "incomplete+remapped" PG issue, here all OSD's were up
and running and affected OSD marked out and removed from the cluster.
2. Will reduce min_size helps? currently it set to 4. Could you please
explain what is the impact if we reduce min_size for the current config EC
4+1
3. Is there any procedure to safely remove an affected PG? As per my
understanding I'm aware about this command.

===
#ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph --pgid 1.e4b --op
remove
===

Awaiting for your suggestions to proceed.

Thanks






On Thu, Mar 30, 2017 at 7:32 AM, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>
>
> On Thu, Mar 30, 2017 at 4:53 AM, nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hello,
> >
> > Env:-
> > 5 node, EC 4+1 bluestore kraken v11.2.0 , RHEL7.2
> >
> > As part of our resillency testing with kraken bluestore, we face more
> PG's
> > were in incomplete+remapped state. We tried to repair each PG using
> "ceph pg
> > repair <pgid>" still no luck. Then we planned to remove incomplete PG's
> > using below procedure.
> >
> >
> > #ceph health detail | grep  1.e4b
> > pg 1.e4b is remapped+incomplete, acting [2147483647,66,15,73,2147483647]
> > (reducing pool cdvr_ec min_size from 4 may help; search ceph.com/docs
> for
> > 'incomplete')
>
> "Incomplete Ceph detects that a placement group is missing information
> about
> writes that may have occurred, or does not have any healthy copies. If you
> see
> this state, try to start any failed OSDs that may contain the needed
> information."
>
> >
> > Here we shutdown the OSD's 66,15 and 73 then proceeded with below
> operation.
> >
> > #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135 --op
> list-pgs
> > #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135 --pgid
> 1.e4b
> > --op remove
> >
> > Please confirm that we are following the correct procedure to removal of
> > PG's
>
> There are multiple threads about that on this very list "pgs stuck
> inactive"
> recently for example.
>
> >
> > #ceph pg stat
> > v2724830: 4096 pgs: 1 active+clean+scrubbing+deep+repair, 1
> down+remapped,
> > 21 remapped+incomplete, 4073 active+clean; 268 TB data, 371 TB used, 267
> TB
> > / 638 TB avail
> >
> > # ceph -s
> > 2017-03-29 18:23:44.288508 7f8c2b8e5700 -1 WARNING: the following
> dangerous
> > and experimental features are enabled: bluestore,rocksdb
> > 2017-03-29 18:23:44.304692 7f8c2b8e5700 -1 WARNING: the following
> dangerous
> > and experimental features are enabled: bluestore,rocksdb
> >     cluster bd8adcd0-c36d-4367-9efe-f48f5ab5f108
> >      health HEALTH_ERR
> >             22 pgs are stuck inactive for more than 300 seconds
> >             1 pgs down
> >             21 pgs incomplete
> >             1 pgs repair
> >             22 pgs stuck inactive
> >             22 pgs stuck unclean
> >      monmap e2: 5 mons at
> > {au-adelaide=10.50.21.24:6789/0,au-brisbane=10.50.21.22:
> 6789/0,au-canberra=10.50.21.23:6789/0,au-melbourne=10.50.
> 21.21:6789/0,au-sydney=10.50.21.20:6789/0}
> >             election epoch 172, quorum 0,1,2,3,4
> > au-sydney,au-melbourne,au-brisbane,au-canberra,au-adelaide
> >         mgr active: au-brisbane
> >      osdmap e6284: 118 osds: 117 up, 117 in; 22 remapped pgs
>
> What is the status of the down+out osd? What role did/does it play? Most
> importantly, is it osd.6?
>
> >             flags sortbitwise,require_jewel_osds,require_kraken_osds
> >       pgmap v2724830: 4096 pgs, 1 pools, 268 TB data, 197 Mobjects
> >             371 TB used, 267 TB / 638 TB avail
> >                 4073 active+clean
> >                   21 remapped+incomplete
> >                    1 down+remapped
> >                    1 active+clean+scrubbing+deep+repair
> >
> >
> > #ceph osd dump | grep pool
> > pool 1 'cdvr_ec' erasure size 5 min_size 4 crush_ruleset 1 object_hash
> > rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags
> > hashpspool,nodeep-scrub stripe_width 65536
> >
> >
> >
> > Can you please suggest is there any way to wipe out these incomplete
> PG's.
>
> See the thread previously mentioned. Take note of the force_create_pg step.
>
> > Why ceph pg repair failed in this scenerio?
> > How to recover incomplete PG's to active state.
> >
> > pg query for the affected PG ended with this error. Can you please
> explain
> > what is meant by this ?
> > ---
> >                 "15(2)",
> >                 "66(1)",
> >                 "73(3)",
> >                 "103(4)",
> >                 "113(0)"
> >             ],
> >             "down_osds_we_would_probe": [
> >                 6
> >             ],
> >             "peering_blocked_by": [],
> >             "peering_blocked_by_detail": [
> >                 {
> >                     "detail": "peering_blocked_by_history_les_bound"
> >                 }
> > ----
>
> During multiple intervals osd 6 was in the up/acting set, for example;
>
>                 {
>                     "first": 1608,
>                     "last": 1645,
>                     "maybe_went_rw": 1,
>                     "up": [
>                         113,
>                         6,
>                         15,
>                         73,
>                         103
>                     ],
>                     "acting": [
>                         113,
>                         6,
>                         15,
>                         73,
>                         103
>                     ],
>                     "primary": 113,
>                     "up_primary": 113
>                 },
>
> Because we may have gone rw during that interval we need to query it and
> it is blocking progress.
>
>             "blocked_by": [
>                 6
>             ],
>
> Setting osd_find_best_info_ignore_history_les to true may help but then
> you may
> need to mark the missing OSD lost or perform some other trickery (and this
> . I
> suspect your min_size is too low, especially for a cluster of this size,
> but EC
> is not an area I know extensively so I can't say definitively. Some of your
> questions may be better suited to the ceph-devel mailing list by the way.
>
> >
> > Attaching "ceph pg 1.e4b query > /tmp/1.e4b-pg.txt" file with this mail.
> >
> > Thanks
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
>
>
>
> --
> Cheers,
> Brad
>

--001a113ad706f5137b054bf7931a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Brad,<div><br></div><div>Many thanks of the info :)<=
/div><div><br></div><div>ENV:-- Kracken - bluestore - EC 4+1 - 5 node clust=
er : RHEL7</div><div><br></div><div><span style=3D"font-size:12.8px">What i=
s the status of the down+out osd? Only one osd osd.6 down and out from clus=
ter.</span></div><div><span style=3D"font-size:12.8px">What role did/does i=
t play? Most</span><span style=3D"font-size:12.8px">importantly, is it osd.=
6? Yes, due to underlying I/O error issue we removed this device from the c=
luster.</span><br></div><div><br></div><div>I put this parameter &quot;<spa=
n style=3D"font-size:12.8px">=C2=A0osd_find_best_info_ignore_</span><wbr st=
yle=3D"font-size:12.8px"><span style=3D"font-size:12.8px">history_les =3D t=
rue&quot; in ceph.conf, and find those 22 PG&#39;s were changed to &quot;do=
wn+remapped&quot; . Now all are reverted to &quot;</span><span style=3D"fon=
t-size:12.8px">remapped+incomplete&quot; state.</span></div><div><span styl=
e=3D"font-size:12.8px"><br></span></div><div><div><span style=3D"font-size:=
12.8px">#ceph pg stat 2&gt; /dev/null</span></div><div><span style=3D"font-=
size:12.8px">v2731828: 4096 pgs: 1 incomplete, 21 remapped+incomplete, 4074=
 active+clean; 268 TB data, 371 TB used, 267 TB / 638 TB avail</span></div>=
<div style=3D"font-size:12.8px"><br></div></div><div style=3D"font-size:12.=
8px">#<span style=3D"font-size:12.8px"># ceph -s</span></div><div style=3D"=
font-size:12.8px">2017-03-30 19:02:14.350242 7f8b0415f700 -1 WARNING: the f=
ollowing dangerous and experimental features are enabled: bluestore,rocksdb=
</div><div style=3D"font-size:12.8px">2017-03-30 19:02:14.366545 7f8b0415f7=
00 -1 WARNING: the following dangerous and experimental features are enable=
d: bluestore,rocksdb</div><div style=3D"font-size:12.8px">=C2=A0 =C2=A0 clu=
ster bd8adcd0-c36d-4367-9efe-f48f5ab5f108</div><div style=3D"font-size:12.8=
px">=C2=A0 =C2=A0 =C2=A0health HEALTH_ERR</div><div style=3D"font-size:12.8=
px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 pgs are stuck inactive for=
 more than 300 seconds</div><div style=3D"font-size:12.8px">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 22 pgs incomplete</div><div style=3D"font-size:=
12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22 pgs stuck inactive</di=
v><div style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 22 pgs stuck unclean</div><div style=3D"font-size:12.8px">=C2=A0 =C2=A0 =
=C2=A0monmap e2: 5 mons at {au-adelaide=3D<a href=3D"http://10.50.21.24:678=
9/0,au-brisbane=3D10.50.21.22:6789/0,au-canberra=3D10.50.21.23:6789/0,au-me=
lbourne=3D10.50.21.21:6789/0,au-sydney=3D10.50.21.20:6789/0">10.50.21.24:67=
89/0,au-brisbane=3D10.50.21.22:6789/0,au-canberra=3D10.50.21.23:6789/0,au-m=
elbourne=3D10.50.21.21:6789/0,au-sydney=3D10.50.21.20:6789/0</a>}</div><div=
 style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elect=
ion epoch 180, quorum 0,1,2,3,4 au-sydney,au-melbourne,au-brisbane,au-canbe=
rra,au-adelaide</div><div style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mgr active: au-adelaide</div><div style=3D"font-size:12.8px">=C2=A0 =
=C2=A0 =C2=A0osdmap e6506: 117 osds: 117 up, 117 in; 21 remapped pgs</div><=
div style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fl=
ags sortbitwise,require_jewel_osds,require_kraken_osds</div><div style=3D"f=
ont-size:12.8px">=C2=A0 =C2=A0 =C2=A0 pgmap v2731828: 4096 pgs, 1 pools, 26=
8 TB data, 197 Mobjects</div><div style=3D"font-size:12.8px">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 371 TB used, 267 TB / 638 TB avail</div><div st=
yle=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 4074 active+clean</div><div style=3D"font-size:12.8px">=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 21 remapped+incomplete</d=
iv><div style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 incomplete</div><div><br></div><div><br></=
div><div>## ceph osd dump 2&gt;/dev/null | grep cdvr</div><div>pool 1 &#39;=
cdvr_ec&#39; erasure size 5 min_size 4 crush_ruleset 1 object_hash rjenkins=
 pg_num 4096 pgp_num 4096 last_change 456 flags hashpspool,nodeep-scrub str=
ipe_width 65536</div><div><br></div><div>Inspecting affected PG <b>1.e4b</b=
></div><div><br></div><div><div style=3D"font-size:12.8px"># ceph pg dump 2=
&gt; /dev/null | grep 1.e4b</div><div style=3D"font-size:12.8px">1.e4b =C2=
=A0 =C2=A0 50832 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =
=C2=A0 =C2=A0 0 73013340821 10006 =C2=A0 =C2=A010006 remapped+incomplete 20=
17-03-30 14:14:26.297098 3844&#39;161662 =C2=A06506:325748 [113,66,15,73,10=
3] =C2=A0 =C2=A0 =C2=A0 =C2=A0113 =C2=A0[NONE,NONE,NONE,73,NONE] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 73 1643&#39;139486 2017-03-21 04:56:16.6839=
53 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0&#39;0 2017-02-21 10:33:50.01=
2922</div><div style=3D"font-size:12.8px"><br></div><div style=3D"font-size=
:12.8px">When I trigger below command.</div><div style=3D"font-size:12.8px"=
><br></div><div style=3D"font-size:12.8px">#ceph pg force_create_pg 1.e4b</=
div><div style=3D"font-size:12.8px"><div style=3D"font-size:12.8px">pg 1.e4=
b now creating, ok</div><div><br></div></div><div style=3D"font-size:12.8px=
">As it went to creating state, no change after that. Can you explain why t=
his PG showing null values after triggering &quot;<span style=3D"font-size:=
12.8px">force_create_pg&quot;,?</span></div><div style=3D"font-size:12.8px"=
><br></div><div><div><span style=3D"font-size:12.8px">]# ceph pg dump 2&gt;=
 /dev/null | grep 1.e4b</span></div><div><span style=3D"font-size:12.8px">1=
.e4b =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=
=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0creating 2017-03-30 19:07:00.982178 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
&#39;0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [] =C2=A0 =C2=A0 =C2=A0 =C2=A0 -1 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[] =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0&=
#39;0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.0000=
00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0&#39;0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.000000</span></div></div><div s=
tyle=3D"font-size:12.8px"><br></div></div><div style=3D"font-size:12.8px">T=
hen I triggered below command</div><div style=3D"font-size:12.8px"><br></di=
v><div style=3D"font-size:12.8px">#<span style=3D"font-size:12.8px">=C2=A0c=
eph pg =C2=A0repair 1.e4b</span></div><div style=3D"font-size:12.8px"><span=
 style=3D"font-size:12.8px">Error EAGAIN: pg 1.e4b has no primary osd =C2=
=A0--&lt;&lt;</span><br></div><div style=3D"font-size:12.8px"><span style=
=3D"font-size:12.8px"><br></span></div><div style=3D"font-size:12.8px">Coul=
d you please provide answer for below queries.</div><div style=3D"font-size=
:12.8px"><br></div><div style=3D"font-size:12.8px">1. How to fix this &quot=
;incomplete+remapped&quot; PG issue, here all OSD&#39;s were up and running=
 and affected OSD marked out and removed from the cluster.</div><div style=
=3D"font-size:12.8px">2. Will reduce min_size helps? currently it set to 4.=
 Could you please explain what is the impact if we reduce min_size for the =
current config EC 4+1</div><div style=3D"font-size:12.8px">3. Is there any =
procedure to safely remove an affected PG? As per my understanding I&#39;m =
aware about this command.</div><div style=3D"font-size:12.8px"><br></div><d=
iv style=3D"font-size:12.8px">=3D=3D=3D</div><div style=3D"font-size:12.8px=
"><span style=3D"font-size:12.8px">#ceph-objectstore-tool --data-path /var/=
lib/ceph/osd/ceph --pgid 1.e4b --op remove</span><br></div><div>=3D=3D=3D</=
div><div><br></div><div>Awaiting for your suggestions to proceed.=C2=A0</di=
v><div><br></div><div>Thanks</div><div><br></div><div style=3D"font-size:12=
.8px"><br></div><div style=3D"font-size:12.8px"><br></div><div style=3D"fon=
t-size:12.8px"><br></div><div style=3D"font-size:12.8px"><br></div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Mar 30, 201=
7 at 7:32 AM, Brad Hubbard <span dir=3D"ltr">&lt;<a href=3D"mailto:bhubbard=
@redhat.com" target=3D"_blank">bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On Thu, Mar 30, 2017 at 4:53 AM, nokia ceph &lt;<a href=3D"mailto:nokiaceph=
users-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; Env:-<br>
&gt; 5 node, EC 4+1 bluestore kraken v11.2.0 , RHEL7.2<br>
&gt;<br>
&gt; As part of our resillency testing with kraken bluestore, we face more =
PG&#39;s<br>
&gt; were in incomplete+remapped state. We tried to repair each PG using &q=
uot;ceph pg<br>
&gt; repair &lt;pgid&gt;&quot; still no luck. Then we planned to remove inc=
omplete PG&#39;s<br>
&gt; using below procedure.<br>
&gt;<br>
&gt;<br>
&gt; #ceph health detail | grep=C2=A0 1.e4b<br>
&gt; pg 1.e4b is remapped+incomplete, acting [2147483647,66,15,73,<wbr>2147=
483647]<br>
&gt; (reducing pool cdvr_ec min_size from 4 may help; search <a href=3D"htt=
p://ceph.com/docs" rel=3D"noreferrer" target=3D"_blank">ceph.com/docs</a> f=
or<br>
&gt; &#39;incomplete&#39;)<br>
<br>
</span>&quot;Incomplete Ceph detects that a placement group is missing info=
rmation about<br>
writes that may have occurred, or does not have any healthy copies. If you =
see<br>
this state, try to start any failed OSDs that may contain the needed<br>
information.&quot;<br>
<span class=3D""><br>
&gt;<br>
&gt; Here we shutdown the OSD&#39;s 66,15 and 73 then proceeded with below =
operation.<br>
&gt;<br>
&gt; #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135 --op lis=
t-pgs<br>
&gt; #ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-135 --pgid 1=
.e4b<br>
&gt; --op remove<br>
&gt;<br>
&gt; Please confirm that we are following the correct procedure to removal =
of<br>
&gt; PG&#39;s<br>
<br>
</span>There are multiple threads about that on this very list &quot;pgs st=
uck inactive&quot;<br>
recently for example.<br>
<span class=3D""><br>
&gt;<br>
&gt; #ceph pg stat<br>
&gt; v2724830: 4096 pgs: 1 active+clean+scrubbing+deep+<wbr>repair, 1 down+=
remapped,<br>
&gt; 21 remapped+incomplete, 4073 active+clean; 268 TB data, 371 TB used, 2=
67 TB<br>
&gt; / 638 TB avail<br>
&gt;<br>
&gt; # ceph -s<br>
&gt; 2017-03-29 18:23:44.288508 7f8c2b8e5700 -1 WARNING: the following dang=
erous<br>
&gt; and experimental features are enabled: bluestore,rocksdb<br>
&gt; 2017-03-29 18:23:44.304692 7f8c2b8e5700 -1 WARNING: the following dang=
erous<br>
&gt; and experimental features are enabled: bluestore,rocksdb<br>
&gt;=C2=A0 =C2=A0 =C2=A0cluster bd8adcd0-c36d-4367-9efe-<wbr>f48f5ab5f108<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 health HEALTH_ERR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A022 pgs are stuck inacti=
ve for more than 300 seconds<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 pgs down<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A021 pgs incomplete<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 pgs repair<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A022 pgs stuck inactive<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A022 pgs stuck unclean<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 monmap e2: 5 mons at<br>
&gt; {au-adelaide=3D<a href=3D"http://10.50.21.24:6789/0,au-brisbane=3D10.5=
0.21.22:6789/0,au-canberra=3D10.50.21.23:6789/0,au-melbourne=3D10.50.21.21:=
6789/0,au-sydney=3D10.50.21.20:6789/0" rel=3D"noreferrer" target=3D"_blank"=
>10.50.21.24:6789/<wbr>0,au-brisbane=3D10.50.21.22:<wbr>6789/0,au-canberra=
=3D10.50.21.<wbr>23:6789/0,au-melbourne=3D10.50.<wbr>21.21:6789/0,au-sydney=
=3D10.50.<wbr>21.20:6789/0</a>}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0election epoch 172, quo=
rum 0,1,2,3,4<br>
&gt; au-sydney,au-melbourne,au-<wbr>brisbane,au-canberra,au-<wbr>adelaide<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mgr active: au-brisbane<br>
&gt;=C2=A0 =C2=A0 =C2=A0 osdmap e6284: 118 osds: 117 up, 117 in; 22 remappe=
d pgs<br>
<br>
</span>What is the status of the down+out osd? What role did/does it play? =
Most<br>
importantly, is it osd.6?<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags sortbitwise,requi=
re_jewel_<wbr>osds,require_kraken_osds<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pgmap v2724830: 4096 pgs, 1 pools, 268 TB da=
ta, 197 Mobjects<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0371 TB used, 267 TB / 6=
38 TB avail<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04073 acti=
ve+clean<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A021=
 remapped+incomplete<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=
 down+remapped<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=
 active+clean+scrubbing+deep+<wbr>repair<br>
&gt;<br>
&gt;<br>
&gt; #ceph osd dump | grep pool<br>
&gt; pool 1 &#39;cdvr_ec&#39; erasure size 5 min_size 4 crush_ruleset 1 obj=
ect_hash<br>
&gt; rjenkins pg_num 4096 pgp_num 4096 last_change 456 flags<br>
&gt; hashpspool,nodeep-scrub stripe_width 65536<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Can you please suggest is there any way to wipe out these incomplete P=
G&#39;s.<br>
<br>
</span>See the thread previously mentioned. Take note of the force_create_p=
g step.<br>
<span class=3D""><br>
&gt; Why ceph pg repair failed in this scenerio?<br>
&gt; How to recover incomplete PG&#39;s to active state.<br>
&gt;<br>
&gt; pg query for the affected PG ended with this error. Can you please exp=
lain<br>
&gt; what is meant by this ?<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;15(=
2)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;66(=
1)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;73(=
3)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;103=
(4)&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;113=
(0)&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;down_osds_we_woul=
d_probe&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;peering_blocked_b=
y&quot;: [],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;peering_blocked_b=
y_detail&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;detail&quot;: &quot;peering_blocked_by_history_<wbr>les_bound&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; ----<br>
<br>
</span>During multiple intervals osd 6 was in the up/acting set, for exampl=
e;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;first&quot;: 1608,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;last&quot;: 1645,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;maybe_went_rw&quot;: 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;up&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 113,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 6,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 15,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 73,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 103<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;acting&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 113,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 6,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 15,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 73,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 103<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;primary&quot;: 113,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;up_primary&quot;: 113<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
<br>
Because we may have gone rw during that interval we need to query it and it=
 is blocking progress.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;blocked_by&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
<br>
Setting osd_find_best_info_ignore_<wbr>history_les to true may help but the=
n you may<br>
need to mark the missing OSD lost or perform some other trickery (and this =
. I<br>
suspect your min_size is too low, especially for a cluster of this size, bu=
t EC<br>
is not an area I know extensively so I can&#39;t say definitively. Some of =
your<br>
questions may be better suited to the ceph-devel mailing list by the way.<b=
r>
<span class=3D""><br>
&gt;<br>
&gt; Attaching &quot;ceph pg 1.e4b query &gt; /tmp/1.e4b-pg.txt&quot; file =
with this mail.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/c=
eph-users-ceph.<wbr>com</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
Cheers,<br>
Brad<br>
</font></span></blockquote></div><br></div>

--001a113ad706f5137b054bf7931a--

--===============1943369474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1943369474==--
