From: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Troubleshooting remapped PG's + OSD flaps
Date: Thu, 18 May 2017 19:28:36 +0000
Message-ID: <CAN-GepK6Kpsed40u99coqjdt+JAWJC71kaAuL3PMn20PAeHCBQ@mail.gmail.com>
References: <CALWuvY-oC5h6FzTRYHQ-QmUXoPOo0TnWPR5QgU13X-c8JhgpBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1195629605=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALWuvY-oC5h6FzTRYHQ-QmUXoPOo0TnWPR5QgU13X-c8JhgpBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1195629605==
Content-Type: multipart/alternative; boundary="94eb2c0c3d3ee3288e054fd16985"

--94eb2c0c3d3ee3288e054fd16985
Content-Type: text/plain; charset="UTF-8"

"340 osds: 101 up, 112 in" This is going to be your culprit.  Your CRUSH
map is in a really weird state.  How many OSDs do you have in this
cluster?  When OSDs go down, secondary OSDs take over for it, but when OSDs
get marked out, the cluster re-balances to distribute the data according to
how many replicas your settings say it should have (remapped PGs).  Your
cluster thinks it has 340 OSDs in total, it believes that 112 of them are
added to the cluster, but only 101 of them are currently up and running.
That means that it is trying to put all of your data onto those 101 OSDs.
Your settings to have 16k PGs is fine for 340 OSDs, but with 101 OSDs
you're getting the error of too many PGs per OSD.

So next steps:
1) How many OSDs do you expect to be in your Ceph cluster?
2) Did you bring your OSDs back up during your rolling restart testing
BEFORE
    a) They were marked down in the cluster?
    b) You moved onto the next node?  Additionally, did you wait for all
backfilling to finish before you proceeded to the next node?
3) Do you have enough memory in your nodes or are your OSDs being killed by
OOM killer?  I see that you have a lot of peering PGs in your status
output.  That is indicative that the OSDs are continually restarting or
being marked down for not responding.

On Thu, May 18, 2017 at 2:41 PM nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hello,
>
>
> Env;- Bluestore EC 4+1 v11.2.0 RHEL7.3 16383 PG
>
>
> We  did our resiliency testing and found OSD's keeps on flapping and
> cluster went to error state.
>
> What we did:-
>
> 1. we have 5 node cluster
> 2. poweroff/stop ceph.target on last node and waited everything seems to
> reach back to normal.
> 3. Then power up the last node and then we see this recovery stuck on
> remapped PG.
> ~~~
>  osdmap e4829: 340 osds: 101 up, 112 in; 15011 *remapped pgs*
> *~~~*
> 4. Initially all osd's reach 340, at the same time this remapped value
> reached 16384 with OSD epoch value e818
> 5. Then after 1 or 2 hour we suspect that this remapped PG value keeps on
> incremnet/decrement results the osd's started failed one by one. While we
> tested with below patch also  still no change.
> patch -
> https://github.com/ceph/ceph-ci/commit/wip-prune-past-intervals-kraken
>
>
> #ceph -s
> 2017-05-18 18:07:45.876586 7fd6bb87e700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> 2017-05-18 18:07:45.900045 7fd6bb87e700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
>     cluster cb55baa8-d5a5-442e-9aae-3fd83553824e
>      health HEALTH_ERR
>             27056 pgs are stuck inactive for more than 300 seconds
>             744 pgs degraded
>             10944 pgs down
>             3919 pgs peering
>             11416 pgs stale
>             744 pgs stuck degraded
>             15640 pgs stuck inactive
>             11416 pgs stuck stale
>             16384 pgs stuck unclean
>             744 pgs stuck undersized
>             744 pgs undersized
>             recovery 1279809/135206985 objects degraded (0.947%)
>             too many PGs per OSD (731 > max 300)
>             11/112 in osds are down
>      monmap e3: 5 mons at {PL6-CN1=
> 10.50.62.151:6789/0,PL6-CN2=10.50.62.152:6789/0,PL6-CN3=10.50.62.153:6789/0,PL6-CN4=10.50.62.154:6789/0,PL6-CN5=1
> 0.50.62.155:6789/0}
>             election epoch 22, quorum 0,1,2,3,4
> PL6-CN1,PL6-CN2,PL6-CN3,PL6-CN4,PL6-CN5
>         mgr no daemons active
>      osdmap e4827: 340 osds: 101 up, 112 in; 15011 remapped pgs
>             flags sortbitwise,require_jewel_osds,require_kraken_osds
>       pgmap v83202: 16384 pgs, 1 pools, 52815 GB data, 26407 kobjects
>             12438 GB used, 331 TB / 343 TB avail
>             1279809/135206985 objects degraded (0.947%)
>                 4512 stale+down+remapped
>                 3060 down+remapped
>                 2204 stale+down
>                 2000 stale+remapped+peering
>                 1259 stale+peering
>                 1167 down
>                  739 stale+active+undersized+degraded
>                  702 stale+remapped
>                  557 peering
>                  102 remapped+peering
>
>
>
> # ceph pg stat
> 2017-05-18 18:09:18.345865 7fe2f72ec700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> 2017-05-18 18:09:18.368566 7fe2f72ec700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> v83204: 16384 pgs: 1 inactive, 1259 stale+peering, 75 remapped, 2000
> stale+remapped+peering, 102 remapped+peering, 2204 stale+down, 739
> stale+active+undersized+degraded, 1 down+remapped+peering, 702
> stale+remapped, 557 peering, 4512 stale+down+remapped, 3060 down+remapped,
> 5 active+undersized+degraded, 1167 down; 52815 GB data, 12438 GB used, 331
> TB / 343 TB avail; 1279809/135206985 objects degraded (0.947%)
>
>
>
> Randomly capture some pg value.
> ~~~
> 3.3ffc     1646                  0     1715         0       0 3451912192
> 1646     1646 stale+active+undersized+degraded 2017-05-18 11:06:32.453158
> 846'1646  872:1634     [36,NONE,278,219,225]         36
> [36,NONE,278,219,225]             36        0'0 2017-05-18 07:14:30.303859
>             0'0 2017-05-18 07:14:30.303859
> 3.3ffb     1711                  0        0         0       0 3588227072
> 1711     1711                             down 2017-05-18 15:20:52.858840
> 846'1711 1602:1708    [150,161,NONE,NONE,83]        150
>  [150,161,NONE,NONE,83]            150        0'0 2017-05-18
> 07:14:30.303838             0'0 2017-05-18 07:14:30.303838
> 3.3ffa     1617                  0        0         0       0 3391094784
> 1617     1617                    down+remapped 2017-05-18 17:12:54.943317
> 846'1617 2525:1637        [48,292,77,277,49]         48
> [48,NONE,NONE,277,49]             48        0'0 2017-05-18 07:14:30.303807
>             0'0 2017-05-18 07:14:30.303807
> 3.3ff9     1682                  0        0         0       0 3527409664
> <(352)%20740-9664> 1682     1682                    down+remapped
> 2017-05-18 16:16:42.223632 846'1682 2195:1678     [266,79,NONE,309,258]
>    266 [NONE,NONE,NONE,NONE,258]            258        0'0 2017-05-18
> 07:14:30.303793             0'0 2017-05-18 07:14:30.303793
> ~~~
>
> ceph.conf
>
> [mon]
> mon_osd_down_out_interval = 3600
> mon_osd_reporter_subtree_level=host
> mon_osd_down_out_subtree_limit=host
> mon_osd_min_down_reporters = 4
> mon_allow_pool_delete = true
> [osd]
> bluestore = true
> bluestore_cache_size = 107374182
> bluefs_buffered_io = true
> osd_op_threads = 24
> osd_op_num_shards = 5
> osd_op_num_threads_per_shard = 2
> osd_enable_op_tracker = false
> osd_scrub_begin_hour = 1
> osd_scrub_end_hour = 7
> osd_deep_scrub_interval = 3.154e+9
> osd_max_backfills = 3
> osd_recovery_max_active = 3
> osd_recovery_op_priority = 1
>
>
>
> # ceph osd stat
> 2017-05-18 18:10:11.864303 7fedc5a98700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> 2017-05-18 18:10:11.887182 7fedc5a98700 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
>      osdmap e4829: 340 osds: 101 up, 112 in; 15011 remapped pgs ==<<<
> <<<<<<<<<<<<<< SEE this
>             flags sortbitwise,require_jewel_osds,require_kraken_osds
>
> Is there any config directive which helps to skip the remapped PG count
> while recovery process. Does Luminous v12.0.3 fixed the OSD flap issue?
>
> Awaiting for your suggestions.
>
> Thanks
> Jayaram
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--94eb2c0c3d3ee3288e054fd16985
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&quot;<font color=3D"#212121">340 osds: 101 up, 112 in&quo=
t; This is going to be your culprit.=C2=A0 Your CRUSH map is in a really we=
ird state.=C2=A0 How many OSDs do you have in this cluster?=C2=A0 When OSDs=
 go down, secondary OSDs take over for it, but when OSDs get marked out, th=
e cluster re-balances=C2=A0to distribute the data according to how many rep=
licas your settings say it should have (remapped PGs).=C2=A0 Your cluster t=
hinks it has 340 OSDs in total, it believes that 112 of them are added to t=
he cluster, but only 101 of them are currently up and running.=C2=A0 That m=
eans that it is trying to put all of your data onto those 101 OSDs.=C2=A0 Y=
our settings to have 16k PGs is fine for 340 OSDs, but with 101 OSDs you&#3=
9;re getting the error of too many PGs per OSD.</font><div><font color=3D"#=
212121"><br></font></div><div><font color=3D"#212121">So next steps:</font>=
</div><div><font color=3D"#212121">1) How many OSDs do you expect to be in =
your Ceph cluster?</font></div><div><font color=3D"#212121">2) Did you brin=
g your OSDs back up during your rolling restart testing BEFORE</font></div>=
<div><span style=3D"color:rgb(33,33,33)">=C2=A0 =C2=A0 a) They were marked =
down in the cluster?</span></div><div><font color=3D"#212121">=C2=A0 =C2=A0=
 b) You moved onto the next node?=C2=A0 Additionally, did you wait for all =
backfilling to finish before you proceeded to the next node?</font></div><d=
iv><font color=3D"#212121">3) Do you have enough memory in your nodes or ar=
e your OSDs being killed by OOM killer?=C2=A0 I see that you have a lot of =
peering PGs in your status output.=C2=A0 That is indicative that the OSDs a=
re continually restarting or being marked down for not responding.</font></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, May 18, 2=
017 at 2:41 PM nokia ceph &lt;<a href=3D"mailto:nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">n=
okiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div dir=3D"ltr">Hello,<div><br></div><div><div><br></div><div>Env;- Bl=
uestore EC 4+1 v11.2.0 RHEL7.3 16383 PG</div><div><br></div><div><br></div>=
<div>We =C2=A0did our resiliency testing and found OSD&#39;s keeps on flapp=
ing and cluster went to error state.=C2=A0</div><div><br></div><div>What we=
 did:-</div><div><br></div><div>1. we have 5 node cluster</div><div>2. powe=
roff/stop ceph.target on last node and waited everything seems to reach bac=
k to normal.=C2=A0</div><div>3. Then power up the last node and then we see=
 this recovery stuck on remapped PG.</div><div>~~~</div><div>=C2=A0osdmap e=
4829: 340 osds: 101 up, 112 in; 15011 <b>remapped pgs</b></div><div><b>~~~<=
/b></div><div><div>4. Initially all osd&#39;s reach 340, at the same time t=
his remapped value reached 16384 with OSD epoch value e818</div><div>5. The=
n after 1 or 2 hour we suspect that this remapped PG value keeps on incremn=
et/decrement results the osd&#39;s started failed one by one. While we test=
ed with below patch also =C2=A0still no change.</div></div><div>patch -=C2=
=A0<a href=3D"https://github.com/ceph/ceph-ci/commit/wip-prune-past-interva=
ls-kraken" target=3D"_blank">https://github.com/ceph/ceph-ci/commit/wip-pru=
ne-past-intervals-kraken</a><br></div><div><br></div><div><br></div><div>#c=
eph -s=C2=A0</div><div>2017-05-18 18:07:45.876586 7fd6bb87e700 -1 WARNING: =
the following dangerous and experimental features are enabled: bluestore,ro=
cksdb</div><div>2017-05-18 18:07:45.900045 7fd6bb87e700 -1 WARNING: the fol=
lowing dangerous and experimental features are enabled: bluestore,rocksdb</=
div><div>=C2=A0 =C2=A0 cluster cb55baa8-d5a5-442e-9aae-3fd83553824e</div><d=
iv>=C2=A0 =C2=A0 =C2=A0health HEALTH_ERR</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 27056 pgs are stuck inactive for more than 300 seconds</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 744 pgs degraded</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10944 pgs down</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3919 pgs peering</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11416 pgs stale</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 744 pgs stuck degraded</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 15640 pgs stuck inactive</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 11416 pgs stuck stale</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 16384 pgs stuck unclean</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 744 pgs stuck undersized</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 744 pgs undersized</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 recovery 1279809/135206985 objects degraded (0.=
947%)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too many PGs per =
OSD (731 &gt; max 300)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
11/112 in osds are down</div><div>=C2=A0 =C2=A0 =C2=A0monmap e3: 5 mons at =
{PL6-CN1=3D<a href=3D"http://10.50.62.151:6789/0,PL6-CN2=3D10.50.62.152:678=
9/0,PL6-CN3=3D10.50.62.153:6789/0,PL6-CN4=3D10.50.62.154:6789/0,PL6-CN5=3D1=
" target=3D"_blank">10.50.62.151:6789/0,PL6-CN2=3D10.50.62.152:6789/0,PL6-C=
N3=3D10.50.62.153:6789/0,PL6-CN4=3D10.50.62.154:6789/0,PL6-CN5=3D1</a></div=
><div><a href=3D"http://0.50.62.155:6789/0" target=3D"_blank">0.50.62.155:6=
789/0</a>}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 election epo=
ch 22, quorum 0,1,2,3,4 PL6-CN1,PL6-CN2,PL6-CN3,PL6-CN4,PL6-CN5</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mgr no daemons active</div><div>=C2=A0 =C2=A0 =
=C2=A0osdmap e4827: 340 osds: 101 up, 112 in; 15011 remapped pgs</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags sortbitwise,require_jewel_o=
sds,require_kraken_osds</div><div>=C2=A0 =C2=A0 =C2=A0 pgmap v83202: 16384 =
pgs, 1 pools, 52815 GB data, 26407 kobjects</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 12438 GB used, 331 TB / 343 TB avail</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1279809/135206985 objects degraded (0.94=
7%)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4512 =
stale+down+remapped</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 3060 down+remapped</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 2204 stale+down</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2000 stale+remapped+peering</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1259 stale+peering</div><d=
iv>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1167 down</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0739 stale=
+active+undersized+degraded</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0702 stale+remapped</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0557 peering</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0102 remapped+peering=
</div><div><br></div><div><br></div><div><br></div><div># ceph pg stat</div=
><div>2017-05-18 18:09:18.345865 7fe2f72ec700 -1 WARNING: the following dan=
gerous and experimental features are enabled: bluestore,rocksdb</div><div>2=
017-05-18 18:09:18.368566 7fe2f72ec700 -1 WARNING: the following dangerous =
and experimental features are enabled: bluestore,rocksdb</div><div>v83204: =
16384 pgs: 1 inactive, 1259 stale+peering, 75 remapped, 2000 stale+remapped=
+peering, 102 remapped+peering, 2204 stale+down, 739 stale+active+undersize=
d+degraded, 1 down+remapped+peering, 702 stale+remapped, 557 peering, 4512 =
stale+down+remapped, 3060 down+remapped, 5 active+undersized+degraded, 1167=
 down; 52815 GB data, 12438 GB used, 331 TB / 343 TB avail; 1279809/1352069=
85 objects degraded (0.947%)</div><div><br></div><div><br></div><div><br></=
div><div>Randomly capture some pg value.</div><div>~~~</div><div>3.3ffc =C2=
=A0 =C2=A0 1646 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00 =C2=A0 =C2=A0 1715 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =
0 3451912192 1646 =C2=A0 =C2=A0 1646 stale+active+undersized+degraded 2017-=
05-18 11:06:32.453158 846&#39;1646 =C2=A0872:1634 =C2=A0 =C2=A0 [36,NONE,27=
8,219,225] =C2=A0 =C2=A0 =C2=A0 =C2=A0 36 =C2=A0 =C2=A0 [36,NONE,278,219,22=
5] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 36 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0&#39;0 2017-05-18 07:14:30.303859 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0&#39;0 2017-05-18 07:14:30.303859</div><div>3.3ffb =C2=A0 =C2=A0 1711 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 358=
8227072 1711 =C2=A0 =C2=A0 1711 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 down 2017-05-18 15:=
20:52.858840 846&#39;1711 1602:1708 =C2=A0 =C2=A0[150,161,NONE,NONE,83] =C2=
=A0 =C2=A0 =C2=A0 =C2=A0150 =C2=A0 =C2=A0[150,161,NONE,NONE,83] =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0150 =C2=A0 =C2=A0 =C2=A0 =C2=A00&#39;0 2017-=
05-18 07:14:30.303838 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0&#39;0 201=
7-05-18 07:14:30.303838</div><div>3.3ffa =C2=A0 =C2=A0 1617 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 3391094784 1617 =
=C2=A0 =C2=A0 1617 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0down+remapped 2017-05-18 17:12:54.943317 846&#39;1617 2525:163=
7 =C2=A0 =C2=A0 =C2=A0 =C2=A0[48,292,77,277,49] =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 48 =C2=A0 =C2=A0 [48,NONE,NONE,277,49] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 48 =C2=A0 =C2=A0 =C2=A0 =C2=A00&#39;0 2017-05-18 07:14:30.303807 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0&#39;0 2017-05-18 07:14:30.303807</=
div><div>3.3ff9 =C2=A0 =C2=A0 1682 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 0 <a href=3D"tel:(352)%20740-9664" value=3D"=
+13527409664" target=3D"_blank">3527409664</a> 1682 =C2=A0 =C2=A0 1682 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0down+rema=
pped 2017-05-18 16:16:42.223632 846&#39;1682 2195:1678 =C2=A0 =C2=A0 [266,7=
9,NONE,309,258] =C2=A0 =C2=A0 =C2=A0 =C2=A0266 [NONE,NONE,NONE,NONE,258] =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0258 =C2=A0 =C2=A0 =C2=A0 =C2=A00&#=
39;0 2017-05-18 07:14:30.303793 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
&#39;0 2017-05-18 07:14:30.303793</div><div>~~~</div><div><br></div><div>ce=
ph.conf</div><div><br></div><div>[mon]</div><div>mon_osd_down_out_interval =
=3D 3600</div><div>mon_osd_reporter_subtree_level=3Dhost</div><div>mon_osd_=
down_out_subtree_limit=3Dhost</div><div>mon_osd_min_down_reporters =3D 4</d=
iv><div>mon_allow_pool_delete =3D true</div><div>[osd]</div><div>bluestore =
=3D true</div><div>bluestore_cache_size =3D 107374182</div><div>bluefs_buff=
ered_io =3D true</div><div>osd_op_threads =3D 24</div><div>osd_op_num_shard=
s =3D 5</div><div>osd_op_num_threads_per_shard =3D 2</div><div>osd_enable_o=
p_tracker =3D false</div><div>osd_scrub_begin_hour =3D 1</div><div>osd_scru=
b_end_hour =3D 7</div><div>osd_deep_scrub_interval =3D 3.154e+9</div><div>o=
sd_max_backfills =3D 3</div><div>osd_recovery_max_active =3D 3</div><div>os=
d_recovery_op_priority =3D 1</div><div><br></div><div><br></div><div><br></=
div><div># ceph osd stat</div><div>2017-05-18 18:10:11.864303 7fedc5a98700 =
-1 WARNING: the following dangerous and experimental features are enabled: =
bluestore,rocksdb</div><div>2017-05-18 18:10:11.887182 7fedc5a98700 -1 WARN=
ING: the following dangerous and experimental features are enabled: bluesto=
re,rocksdb</div><div>=C2=A0 =C2=A0 =C2=A0osdmap e4829: 340 osds: 101 up, 11=
2 in; 15011 remapped pgs =3D=3D&lt;&lt;&lt; &lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt=
;&lt;&lt;&lt;&lt;&lt;&lt; SEE this=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 flags sortbitwise,require_jewel_osds,require_kraken_osds<=
/div><div><br></div><div>Is there any config directive which helps to skip =
the remapped PG count while recovery process. Does Luminous v12.0.3 fixed t=
he OSD flap issue?=C2=A0</div></div><div><br></div><div>Awaiting for your s=
uggestions.=C2=A0</div><div><br></div><div>Thanks</div><div>Jayaram</div></=
div>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div>

--94eb2c0c3d3ee3288e054fd16985--

--===============1195629605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1195629605==--
