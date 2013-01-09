From: Matthew Anderson <matthewa@base3.com.au>
Subject: RE: OSD's slow down to a crawl
Date: Wed, 9 Jan 2013 08:52:08 +0000
Message-ID: <38A500831D3DE24B90BD200D6C8701351BB27449@Exchange2010-2.corit.local>
References: <38A500831D3DE24B90BD200D6C8701351BB15324@Exchange2010-2.corit.local>
 <50D32E83.70209@inktank.com>
 <38A500831D3DE24B90BD200D6C8701351BB15375@Exchange2010-2.corit.local>
 <50D335E1.6020204@inktank.com>
 <38A500831D3DE24B90BD200D6C8701351BB153C2@Exchange2010-2.corit.local>
 <alpine.DEB.2.00.1212200828560.15854@cobra.newdream.net>
 <38A500831D3DE24B90BD200D6C8701351BB15433@Exchange2010-2.corit.local>
 <alpine.DEB.2.00.1212200912070.16508@cobra.newdream.net>
 <38A500831D3DE24B90BD200D6C8701351BB1569E@Exchange2010-2.corit.local>
 <alpine.DEB.2.00.1212210742340.26504@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.base3.com.au ([27.106.198.3]:9993 "EHLO mail.base3.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237Ab3AIIwM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 03:52:12 -0500
In-Reply-To: <alpine.DEB.2.00.1212210742340.26504@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Sage Weil' <sage@inktank.com>
Cc: 'Mark Nelson' <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Sorry for the late follow up, I've been on a bit of a testing rampage a=
nd managed to somewhat sort the problem.

Most of the problems appears to be from the 3.7.1 kernel. It seems to h=
ave a fairly big issue with its networking stack that was causing Ceph'=
s network operations to hang. Moving back to a 3.6.8 kernel fixed this =
up. I don't know the full extent of the problem but it was reported on =
Phoronix briefly here - http://www.phoronix.com/scan.php?page=3Dnews_it=
em&px=3DMTI2Nzc

The second issue was BTRFS on both the 3.7 and 3.6.8 kernels. After run=
ning a long rados bench (10 minutes) on a fresh cluster it would often =
slow down significantly by going from 250MB/s down to a 50MB/s average.=
 Latency also increased dramatically. Restarting the OSD's fixes the is=
sue but after a while it slows right down again. In the end I re-format=
ted the cluster using XFS (and also EXT4 for benchmarks) and there wasn=
't a single issue. I had rados bench running for over 30 minutes from a=
nother machine and there wasn't a single issue.=20

At thisstage  I need to start moving into production with XFS. My test =
cluster arrives in a few weeks so I should be able to come back to the =
BTRFS issue later on as it would be very handy to have compression work=
ing.

Thanks again for your help
-Matt=A0=A0=20


-----Original Message-----
=46rom: Sage Weil [mailto:sage@inktank.com]=20
Sent: Saturday, 22 December 2012 12:02 AM
To: Matthew Anderson
Cc: 'Mark Nelson'; ceph-devel@vger.kernel.org
Subject: RE: OSD's slow down to a crawl

On Fri, 21 Dec 2012, Matthew Anderson wrote:
> Hi Sage,
>=20
> I've tried to reproduce the error again with logging on every OSD and=
=20
> got the above. RADOS bench had stalled on a write request like the=20
> last time and the attached log is the grep'd OSD log (# cat osd.25.lo=
g=20
> | grep client.9501.0:744 > freeze.log) . The OSD that stalled was 25,=
=20
> pg map is below -
>=20
> # ceph pg map 6.5d83495b
> osdmap e3775 pg 6.5d83495b (6.95b) -> up [25,31] acting [25,31]
>=20
> I hope that's what you were after, if not just let me know

We're getting closer.  The osd tried to send the reply.  Can you reprod=
uce with 'debug ms =3D 20' on the osds too, and on the client side do s=
oemthing like

 rados --debug-ms 20 --debug-objecter 20 --log-file /tmp/foo ...

Thanks!=20
sage


>=20
> Thanks again
> -Matt
>=20
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]
> Sent: Friday, 21 December 2012 1:14 AM
> To: Matthew Anderson
> Cc: 'Mark Nelson'; ceph-devel@vger.kernel.org
> Subject: RE: OSD's slow down to a crawl
>=20
> On Thu, 20 Dec 2012, Matthew Anderson wrote:
> > Hi Sage,
> >=20
> > Logs are attached. I took the osd logs from osd.24 as this is the=20
> > first osd in my SSD pool I've been testing with previously.
> >=20
> > The 4MB bench I was able to reproduce the fault by restarting my rb=
d=20
> > export which stalled after a few percent complete. When I ran the=20
> > 4MB bench it stalled early on and never received a response back=20
> > from the OSD and I terminated it after 60 seconds or so. I wasn't=20
> > able to reproduce the fault using the 4kb io size. The 4kb log=20
> > should show rados bench completing normally at a respectable speed =
of about 1MB/s.
>=20
> Let's drill into the hang.. up until that point things look okay.
>=20
> 2012-12-21 00:51:26.033622 7f6f3c042760  1 -- 172.16.0.13:0/1023886=20
> --> 172.16.0.13:6813/22233 -- osd_op(client.9503.0:185=20
> benchmark_data_KVM04_23886_object184 [write 0~4194304] 6.3ca4346e) v4=
=20
> -- ?+0 0x171ea50 con 0x171a7e0
>=20
> Do you have a log for that OSD so we can see what happened there?  It=
=20
> may also be that the replicated write is hung.  If you do
>=20
>  ceph pg map 6.3ca4346e
>=20
> you can see all OSDs storing that PG.  And/or you can grep for
> client.9503.0:185 in 172.16.0.13:6813/22233's log and see whether the=
 sub_op was sent.
>=20
> Thanks!
> sage
>=20
>=20
> >=20
> > Thanks
> > -Matt
> >=20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org=20
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> > Sent: Friday, 21 December 2012 12:30 AM
> > To: Matthew Anderson
> > Cc: 'Mark Nelson'; ceph-devel@vger.kernel.org
> > Subject: RE: OSD's slow down to a crawl
> >=20
> > Can you do a similar test, but with full logging on?
> >=20
> >  ceph tell osd.0 injectargs '--debug-ms 1 --debug-filestore 20=20
> > --debug-osd
> > 20 --debug-journal 20'
> >  rados -p ssd bench 30 write -b 4096 -t 1 --log-file /tmp/foo=20
> > --debug-ms 1
> >=20
> > That will be a single IO in flight at a time and very easy to trace=
 through the logs.  If you can post the resulting log file (/tmp/foo an=
d from osd.0), that would be awesome.
> >=20
> > Thanks!
> > sage
> >=20
> >=20
> >=20
> > On Thu, 20 Dec 2012, Matthew Anderson wrote:
> >=20
> > > # rados bench 60 write -t 256 -p ssd  Maintaining 256 concurrent=20
> > > writes of 4194304 bytes for at least 60 seconds.
> > >  Object prefix: benchmark_data_KVM03_12985
> > >    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat =
  avg lat
> > >      0       0         0         0         0         0         - =
        0
> > >      1      45        45         0         0         0         - =
        0
> > >      2      71        71         0         0         0         - =
        0
> > >      3      90        90         0         0         0         - =
        0
> > >      4     125       125         0         0         0         - =
        0
> > >      5     136       136         0         0         0         - =
        0
> > >      6     144       144         0         0         0         - =
        0
> > >      7     175       175         0         0         0         - =
        0
> > >      8     201       201         0         0         0         - =
        0
> > >      9     217       217         0         0         0         - =
        0
> > >     10     228       228         0         0         0         - =
        0
> > >     11     251       251         0         0         0         - =
        0
> > >     12     255       266        11   3.66581   3.66667   11.7027 =
  11.6013
> > >     13     255       271        16   4.92194        20   12.9795 =
  11.9979
> > >     14     255       291        36   10.2833        80   13.1795 =
  12.6478
> > >     15     255       301        46   12.2639        40   13.9424 =
  12.9123
> > >     16     255       303        48   11.9973         8   14.0277 =
  12.9579
> > >     17     255       321        66    15.526        72   15.1408 =
  13.4616
> > >     18     255       345        90   19.9956        96   15.5673 =
  13.9937
> > >     19     255       349        94   19.7851        16    15.707 =
  14.0635
> > > 2012-12-21 00:06:37.198982min lat: 11.4904 max lat: 16.4053 avg l=
at: 14.3121
> > >    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat =
  avg lat
> > >     20     255       361       106   21.1953        48   16.4053 =
  14.3121
> > >     21     255       367       112   21.3285        24   17.4263 =
  14.4795
> > >     22     255       370       115   20.9043        12   17.3579 =
  14.5544
> > >     23     255       387       132   22.9513        68   18.3185 =
  15.0867
> > >     24     255       394       139   23.1614        28   18.2868 =
  15.2504
> > >     25     255       404       149   23.8346        40    18.741 =
  15.5048
> > >     26     255       410       155   23.8407        24    19.032 =
  15.6358
> > >     27     255       410       155   22.9577         0         - =
  15.6358
> > >     28     255       410       155   22.1378         0         - =
  15.6358
> > >     29     255       411       156   21.5124   1.33333   22.6927 =
  15.6811
> > >     30     255       431       176   23.4614        80   22.6577 =
  16.4822
> > >     31     255       447       192   24.7687        64   23.2345 =
  17.0563
> > >     32     255       464       209   26.1192        68   23.3788 =
  17.5859
> > >     33     255       485       230   27.8726        84   22.8924 =
  18.1122
> > >     34     255       497       242   28.4642        48    23.563 =
  18.3693
> > >     35     255       508       253   28.9078        44   23.0516 =
  18.5935
> > >     36     255       514       259   28.7713        24   24.4415 =
  18.7278
> > >     37     255       530       275    29.723        64    23.847 =
  19.0424
> > >     38     255       541       286   30.0985        44   24.5757 =
  19.2427
> > >     39     255       544       289   29.6344        12   24.6802 =
  19.2984
> > > 2012-12-21 00:06:57.203473min lat: 11.4904 max lat: 24.6802 avg l=
at: 19.2984
> > >    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat =
  avg lat
> > >     40     255       544       289   28.8935         0         - =
  19.2984
> > >     41     255       544       289   28.1888         0         - =
  19.2984
> > >     42     255       544       289   27.5176         0         - =
  19.2984
> > >     43     255       544       289   26.8776         0         - =
  19.2984
> > >     44     255       544       289   26.2668         0         - =
  19.2984
> > >     45     255       544       289   25.6831         0         - =
  19.2984
> > >     46     255       544       289   25.1248         0         - =
  19.2984
> > >     47     255       544       289   24.5902         0         - =
  19.2984
> > >     48     255       544       289   24.0779         0         - =
  19.2984
> > >     49     255       544       289   23.5865         0         - =
  19.2984
> > >     50     255       544       289   23.1148         0         - =
  19.2984
> > >     51     255       544       289   22.6616         0         - =
  19.2984
> > >     52     255       544       289   22.2258         0         - =
  19.2984
> > >     53     255       544       289   21.8065         0         - =
  19.2984
> > >     54     255       544       289   21.4026         0         - =
  19.2984
> > >     55     255       544       289   21.0135         0         - =
  19.2984
> > >     56     255       544       289   20.6383         0         - =
  19.2984
> > >     57     255       544       289   20.2762         0         - =
  19.2984
> > >     58     255       544       289   19.9266         0         - =
  19.2984
> > >     59     255       544       289   19.5889         0         - =
  19.2984
> > > 2012-12-21 00:07:17.207782min lat: 11.4904 max lat: 24.6802 avg l=
at: 19.2984
> > >    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat =
  avg lat
> > >     60     255       544       289   19.2624         0         - =
  19.2984
> > >     61     255       544       289   18.9466         0         - =
  19.2984
> > >     62     255       544       289    18.641         0         - =
  19.2984
> > >     63     255       544       289   18.3452         0         - =
  19.2984
> > >     64     255       544       289   18.0585         0         - =
  19.2984
> > >     65     255       544       289   17.7807         0         - =
  19.2984
> > >     66     255       544       289   17.5113         0         - =
  19.2984
> > >     67     133       545       412   24.5916   17.5714   37.3574 =
  27.4834
> > >  Total time run:         68.000740
> > > Total writes made:      545
> > > Write size:             4194304
> > > Bandwidth (MB/sec):     32.058=20
> > >=20
> > > Stddev Bandwidth:       26.8837
> > > Max bandwidth (MB/sec): 96
> > > Min bandwidth (MB/sec): 0
> > > Average Latency:        29.2801
> > > Stddev Latency:         11.9768
> > > Max latency:            52.6277
> > > Min latency:            11.4904
> > >=20
> > >=20
> > >=20
> > >=20
> > > =A0=A0=A0=20
> > > ----Original Message-----
> > > From: Mark Nelson [mailto:mark.nelson@inktank.com]
> > > Sent: Thursday, 20 December 2012 11:59 PM
> > > To: Matthew Anderson
> > > Cc: ceph-devel@vger.kernel.org
> > > Subject: Re: OSD's slow down to a crawl
> > >=20
> > > Out of curiosity, if you fire up a rados bench instance on one of=
 the nodes with say, 256 concurrent writes, do any of the writes comple=
te?
> > >=20
> > > Mark
> > >=20
> > > On 12/20/2012 09:51 AM, Matthew Anderson wrote:
> > > > Hi Mark,
> > > >
> > > > Thanks for the quick reply. The log was 380MB in total so I jus=
t posted last 200 lines hoping that a trained eye might be able to spot=
 something. I'm happy to put the file up on a web server if anyone want=
s to review it in full.
> > > >
> > > > It doesn't appear to be memory or CPU related. In it's hung sta=
te (both read and write are not responding at the moment, I have a VM h=
ung trying to shutdown and an rbd stuck exporting ) all of the OSD's si=
t around 0.3% CPU usage, ~300MB of ram and no IO wait. The server has r=
oughly 40GB RAM free and is easily 90% idle. Iotop shows no IO coming f=
rom any of the Ceph-OSD's.
> > > >
> > > > The admin socket showed no ops in flight but the performance du=
mp, perhistoric ops and config are below. I did notice that the age of =
some of the ops was quite high considering things were actively trying =
to write to the cluster.
> > > > # ceph --admin-daemon ./ceph-osd.24.asok perf dump
> > > >
> > > > {"filestore":{"journal_queue_max_ops":500,"journal_queue_ops":0=
,
> > > > "j
> > > > ou
> > > > rn
> > > > al_ops":20868,"journal_queue_max_bytes":104857600,"journal_queu=
e
> > > > _b
> > > > yt
> > > > es
> > > > ":0,"journal_bytes":1710397238,"journal_latency":{"avgcount":20=
868,"
> > > > su
> > > > m":185.268022000},"journal_wr":13354,"journal_wr_bytes":{"avgco=
unt":
> > > > 13
> > > > 354,"sum":1770647552},"op_queue_max_ops":500,"op_queue_ops":0,"=
ops":
> > > > 20
> > > > 868,"op_queue_max_bytes":104857600,"op_queue_bytes":0,"bytes":1=
7
> > > > 10
> > > > 23
> > > > 25
> > > > 83,"apply_latency":{"avgcount":20868,"sum":508.896737000},"comm=
itting"
> > > > :0,"commitcycle":339,"commitcycle_interval":{"avgcount":339,"su=
m":
> > > > 17
> > > > 08
> > > > .284725000},"commitcycle_latency":{"avgcount":339,"sum":13.2418=
5
> > > > 00
> > > > 00
> > > > },
> > > > "journal_full":0},"mutex-FileJournal::completions_lock":{"wait"=
:{"
> > > > av
> > > > gc
> > > > ount":0,"sum":0.000000000}},"mutex-FileJournal::finisher_lock":=
{"wait"
> > > > :{"avgcount":0,"sum":0.000000000}},"mutex-FileJournal::write_lo=
ck"
> > > > :{
> > > > "w
> > > > ait":{"avgcount":0,"sum":0.000000000}},"mutex-FileJournal::writ=
e
> > > > q_
> > > > lo
> > > > ck
> > > > ":{"wait":{"avgcount":0,"sum":0.000000000}},"mutex-JOS::ApplyMa=
nager::
> > > > apply_lo
> > >  ck":{"wai
> > > t":{"avgcount":0,"sum":0.000000000}},"mutex-JOS::ApplyManager::co=
m
> > > _l
> > > oc
> > > k":{"wait":{"avgcount":0,"sum":0.000000000}},"mutex-JOS::SubmitMa=
n
> > > ag
> > > er
> > > ::lock":{"wait":{"avgcount":0,"sum":0.000000000}},"osd":{"opq":0,=
"
> > > op
> > > _w
> > > ip":0,"op":31753,"op_in_bytes":797806224,"op_out_bytes":172841404=
8,"
> > > op
> > > _latency":{"avgcount":31753,"sum":82.183373000},"op_r":24945,"op_=
r
> > > _o
> > > ut
> > > _bytes":1728414048,"op_r_latency":{"avgcount":24945,"sum":16.8336=
8
> > > 90
> > > 00
> > > },"op_w":6808,"op_w_in_bytes":797806224,"op_w_rlat":{"avgcount":6=
808,"
> > > sum":38.223006000},"op_w_latency":{"avgcount":6808,"sum":65.34968=
4
> > > 00
> > > 0}
> > > ,"op_rw":0,"op_rw_in_bytes":0,"op_rw_out_bytes":0,"op_rw_rlat":{"=
a
> > > vg
> > > co
> > > unt":0,"sum":0.000000000},"op_rw_latency":{"avgcount":0,"sum":0.0=
0
> > > 00
> > > 00
> > > 000},"subop":5700,"subop_in_bytes":813224156,"subop_latency":{"av=
g
> > > co
> > > un
> > > t":5700,"sum":26.877085000},"subop_w":0,"subop_w_in_bytes":813224=
156,"
> > > subop_w_latency":{"avgcount":5700,"sum":26.877085000},"subop_pull=
":0,"
> > > subop_pull_latency":{"avgcount":0,"sum":0.000000000},"subop_push"=
:
> > > 0,
> > > "s
> > > ubop_push_
> > >  in_bytes"
> > > :0,"subop_push_latency":{"avgcount":0,"sum":0.000000000},"pull":0=
,
> > > "p
> > > us
> > > h":0,"push_out_bytes":0,"push_in":0,"push_in_bytes":0,"recovery_o=
ps"
> > > :0
> > > ,"loadavg":359,"buffer_bytes":0,"numpg":2486,"numpg_primary":1214=
,
> > > "n
> > > um
> > > pg_replica":1272,"numpg_stray":0,"heartbeat_to_peers":4,"heartbea=
t
> > > _f
> > > ro
> > > m_peers":0,"map_messages":44,"map_message_epochs":184,"map_messag=
e
> > > _e
> > > po
> > > ch_dups":174},"throttle-filestore_bytes":{"val":0,"max":104857600=
,
> > > "g
> > > et
> > > ":0,"get_sum":0,"get_or_fail_fail":0,"get_or_fail_success":0,"tak=
e":
> > > 20
> > > 868,"take_sum":1710397238,"put":13354,"put_sum":1710397238,"wait"=
:{"
> > > av
> > > gcount":0,"sum":0.000000000}},"throttle-filestore_ops":{"val":0,"=
max":
> > > 500,"get":0,"get_sum":0,"get_or_fail_fail":0,"get_or_fail_success=
":0,"
> > > take":20868,"take_sum":20868,"put":13354,"put_sum":20868,"wait":{=
"
> > > av
> > > gc
> > > ount":0,"sum":0.000000000}},"throttle-msgr_dispatch_throttler-cli=
ent":
> > > {"val":0,"max":104857600,"get":31657,"get_sum":795546573,"get_or_=
f
> > > ai
> > > l_
> > > fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":31657=
,
> > > "p
> > > ut
> > > _sum":7955
> > >  46573,"wa
> > > it":{"avgcount":0,"sum":0.000000000}},"throttle-msgr_dispatch_thr=
o
> > > tt
> > > le
> > > r-cluster":{"val":0,"max":104857600,"get":18913,"get_sum":8280112=
9
> > > 3,
> > > "g
> > > et_or_fail_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,=
"put"
> > > :18913,"put_sum":828011293,"wait":{"avgcount":0,"sum":0.000000000=
}
> > > },
> > > "t
> > > hrottle-msgr_dispatch_throttler-hbclient":{"val":0,"max":10485760=
0,"
> > > ge
> > > t":4260,"get_sum":200220,"get_or_fail_fail":0,"get_or_fail_succes=
s":
> > > 0,
> > > "take":0,"take_sum":0,"put":4260,"put_sum":200220,"wait":{"avgcou=
nt"
> > > :0
> > > ,"sum":0.000000000}},"throttle-msgr_dispatch_throttler-hbserver":=
{
> > > "v
> > > al
> > > ":0,"max":104857600,"get":4236,"get_sum":199092,"get_or_fail_fail=
":0,"
> > > get_or_fail_success":0,"take":0,"take_sum":0,"put":4236,"put_sum"=
:
> > > 19
> > > 90
> > > 92,"wait":{"avgcount":0,"sum":0.000000000}},"throttle-osd_client_=
b
> > > yt
> > > es
> > > ":{"val":0,"max":524288000,"get":31308,"get_sum":795353720,"get_o=
r
> > > _f
> > > ai
> > > l_fail":0,"get_or_fail_success":0,"take":0,"take_sum":0,"put":376=
7
> > > 1, "p ut_sum":795353720,"wait":{"avgcount":0,"sum":0.000000000}}}
> > > >
> > > > # ceph --admin-daemon ./ceph-osd.24.asok dump_historic_ops
> > > >
> > > >         { "description": "osd_op(client.7636.0:101498 rb.0.122c=
=2E6b8b4567.000000000357 [write 3600384~4096] 6.42463fe3)",
> > > >            "received_at": "2012-12-20 23:34:42.012131",
> > > >            "age": "75.428051",
> > > >            "duration": "0.009988",
> > > >            "flag_point": "waiting for sub ops",
> > > >            "client_info": { "client": "client.7636",
> > > >                "tid": 101498},
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:34:42.012317",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:34:42.012425",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:34:42.012678",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:34:42.012720",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:34:42.012815",
> > > >                    "event": "sub_op_sent"},
> > > >                  { "time": "2012-12-20 23:34:42.012958",
> > > >                    "event": "commit_queued_for_journal_write"},
> > > >                  { "time": "2012-12-20 23:34:42.013033",
> > > >                    "event": "write_thread_in_journal_buffer"},
> > > >                  { "time": "2012-12-20 23:34:42.013745",
> > > >                    "event": "journaled_completion_queued"},
> > > >                  { "time": "2012-12-20 23:34:42.013803",
> > > >                    "event": "op_commit"},
> > > >                  { "time": "2012-12-20 23:34:42.017414",
> > > >                    "event": "sub_op_commit_rec"},
> > > >                  { "time": "2012-12-20 23:34:42.022066",
> > > >                    "event": "op_applied"},
> > > >                  { "time": "2012-12-20 23:34:42.022119",
> > > >                    "event": "done"}]},
> > > >          { "description": "osd_sub_op_reply(client.7636.0:10149=
8 6.1fe3 42463fe3\/rb.0.122c.6b8b4567.000000000357\/head\/\/6 [] ondisk=
, result =3D 0)",
> > > >            "received_at": "2012-12-20 23:34:42.017048",
> > > >            "age": "75.423134",
> > > >            "duration": "0.000411",
> > > >            "flag_point": "started",
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:34:42.017218",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:34:42.017363",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:34:42.017401",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:34:42.017459",
> > > >                    "event": "done"}]},
> > > >          { "description": "osd_op(client.7636.0:101502 rb.0.122=
c.6b8b4567.000000000064 [write 1512448~61440] 6.a241e34d)",
> > > >            "received_at": "2012-12-20 23:34:49.851021",
> > > >            "age": "67.589161",
> > > >            "duration": "0.007114",
> > > >            "flag_point": "waiting for sub ops",
> > > >            "client_info": { "client": "client.7636",
> > > >                "tid": 101502},
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:34:49.851276",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:34:49.851429",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:34:49.851616",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:34:49.851648",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:34:49.851712",
> > > >                    "event": "sub_op_sent"},
> > > >                  { "time": "2012-12-20 23:34:49.851770",
> > > >                    "event": "commit_queued_for_journal_write"},
> > > >                  { "time": "2012-12-20 23:34:49.851915",
> > > >                    "event": "write_thread_in_journal_buffer"},
> > > >                  { "time": "2012-12-20 23:34:49.853956",
> > > >                    "event": "journaled_completion_queued"},
> > > >                  { "time": "2012-12-20 23:34:49.853992",
> > > >                    "event": "op_commit"},
> > > >                  { "time": "2012-12-20 23:34:49.857016",
> > > >                    "event": "sub_op_commit_rec"},
> > > >                  { "time": "2012-12-20 23:34:49.858077",
> > > >                    "event": "op_applied"},
> > > >                  { "time": "2012-12-20 23:34:49.858135",
> > > >                    "event": "done"}]},
> > > >          { "description": "osd_sub_op_reply(client.7636.0:10150=
2 6.234d a241e34d\/rb.0.122c.6b8b4567.000000000064\/head\/\/6 [] ondisk=
, result =3D 0)",
> > > >            "received_at": "2012-12-20 23:34:49.856762",
> > > >            "age": "67.583420",
> > > >            "duration": "0.000308",
> > > >            "flag_point": "started",
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:34:49.856869",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:34:49.856969",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:34:49.857001",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:34:49.857070",
> > > >                    "event": "done"}]},
> > > >          { "description": "osd_op(client.7636.0:101504 rb.0.122=
c.6b8b4567.00000000012c [write 1658880~2048] 6.92d2c38c)",
> > > >            "received_at": "2012-12-20 23:35:34.351518",
> > > >            "age": "23.088664",
> > > >            "duration": "0.009430",
> > > >            "flag_point": "waiting for sub ops",
> > > >            "client_info": { "client": "client.7636",
> > > >                "tid": 101504},
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:35:34.351714",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:35:34.351811",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:35:34.352030",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:35:34.352071",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:35:34.352146",
> > > >                    "event": "sub_op_sent"},
> > > >                  { "time": "2012-12-20 23:35:34.352213",
> > > >                    "event": "commit_queued_for_journal_write"},
> > > >                  { "time": "2012-12-20 23:35:34.352287",
> > > >                    "event": "write_thread_in_journal_buffer"},
> > > >                  { "time": "2012-12-20 23:35:34.355390",
> > > >                    "event": "journaled_completion_queued"},
> > > >                  { "time": "2012-12-20 23:35:34.355475",
> > > >                    "event": "op_commit"},
> > > >                  { "time": "2012-12-20 23:35:34.356661",
> > > >                    "event": "sub_op_commit_rec"},
> > > >                  { "time": "2012-12-20 23:35:34.360894",
> > > >                    "event": "op_applied"},
> > > >                  { "time": "2012-12-20 23:35:34.360948",
> > > >                    "event": "done"}]},
> > > >          { "description": "osd_sub_op_reply(client.7636.0:10150=
4 6.38c 92d2c38c\/rb.0.122c.6b8b4567.00000000012c\/head\/\/6 [] ondisk,=
 result =3D 0)",
> > > >            "received_at": "2012-12-20 23:35:34.356286",
> > > >            "age": "23.083896",
> > > >            "duration": "0.000421",
> > > >            "flag_point": "started",
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:35:34.356489",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:35:34.356598",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:35:34.356640",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:35:34.356707",
> > > >                    "event": "done"}]},
> > > >          { "description": "osd_op(client.7636.0:101512 rb.0.122=
c.6b8b4567.000000000357 [write 3731456~4096] 6.42463fe3)",
> > > >            "received_at": "2012-12-20 23:35:42.133103",
> > > >            "age": "15.307079",
> > > >            "duration": "0.008357",
> > > >            "flag_point": "waiting for sub ops",
> > > >            "client_info": { "client": "client.7636",
> > > >                "tid": 101512},
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:35:42.133315",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:35:42.133427",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:35:42.133684",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:35:42.133723",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:35:42.133796",
> > > >                    "event": "sub_op_sent"},
> > > >                  { "time": "2012-12-20 23:35:42.133908",
> > > >                    "event": "commit_queued_for_journal_write"},
> > > >                  { "time": "2012-12-20 23:35:42.133995",
> > > >                    "event": "write_thread_in_journal_buffer"},
> > > >                  { "time": "2012-12-20 23:35:42.136965",
> > > >                    "event": "journaled_completion_queued"},
> > > >                  { "time": "2012-12-20 23:35:42.137025",
> > > >                    "event": "op_commit"},
> > > >                  { "time": "2012-12-20 23:35:42.138456",
> > > >                    "event": "sub_op_commit_rec"},
> > > >                  { "time": "2012-12-20 23:35:42.141408",
> > > >                    "event": "op_applied"},
> > > >                  { "time": "2012-12-20 23:35:42.141460",
> > > >                    "event": "done"}]},
> > > >          { "description": "osd_sub_op_reply(client.7636.0:10151=
2 6.1fe3 42463fe3\/rb.0.122c.6b8b4567.000000000357\/head\/\/6 [] ondisk=
, result =3D 0)",
> > > >            "received_at": "2012-12-20 23:35:42.138087",
> > > >            "age": "15.302095",
> > > >            "duration": "0.000410",
> > > >            "flag_point": "started",
> > > >            "events": [
> > > >                  { "time": "2012-12-20 23:35:42.138248",
> > > >                    "event": "waiting_for_osdmap"},
> > > >                  { "time": "2012-12-20 23:35:42.138363",
> > > >                    "event": "reached_pg"},
> > > >                  { "time": "2012-12-20 23:35:42.138443",
> > > >                    "event": "started"},
> > > >                  { "time": "2012-12-20 23:35:42.138497",
> > > >                    "event": "done"}]}]}
> > > >
> > > >     # ceph --admin-daemon ./ceph-osd.24.asok config show { "nam=
e":=20
> > > > "osd.24",
> > > >    "cluster": "ceph",
> > > >    "none": "0\/5",
> > > >    "lockdep": "0\/1",
> > > >    "context": "0\/1",
> > > >    "crush": "1\/1",
> > > >    "mds": "1\/5",
> > > >    "mds_balancer": "1\/5",
> > > >    "mds_locker": "1\/5",
> > > >    "mds_log": "1\/5",
> > > >    "mds_log_expire": "1\/5",
> > > >    "mds_migrator": "1\/5",
> > > >    "buffer": "0\/1",
> > > >    "timer": "0\/1",
> > > >    "filer": "0\/1",
> > > >    "striper": "0\/1",
> > > >    "objecter": "0\/1",
> > > >    "rados": "0\/5",
> > > >    "rbd": "0\/5",
> > > >    "journaler": "0\/5",
> > > >    "objectcacher": "0\/5",
> > > >    "client": "0\/5",
> > > >    "osd": "0\/5",
> > > >    "optracker": "0\/5",
> > > >    "objclass": "0\/5",
> > > >    "filestore": "1\/3",
> > > >    "journal": "1\/3",
> > > >    "ms": "0\/5",
> > > >    "mon": "1\/5",
> > > >    "monc": "0\/10",
> > > >    "paxos": "0\/5",
> > > >    "tp": "0\/5",
> > > >    "auth": "1\/5",
> > > >    "crypto": "1\/5",
> > > >    "finisher": "1\/1",
> > > >    "heartbeatmap": "1\/5",
> > > >    "perfcounter": "1\/5",
> > > >    "rgw": "1\/5",
> > > >    "hadoop": "1\/5",
> > > >    "javaclient": "1\/5",
> > > >    "asok": "1\/5",
> > > >    "throttle": "1\/1",
> > > >    "host": "KVM04",
> > > >    "fsid": "00000000-0000-0000-0000-000000000000",
> > > >    "public_addr": ":\/0",
> > > >    "cluster_addr": ":\/0",
> > > >    "public_network": "",
> > > >    "cluster_network": "",
> > > >    "num_client": "1",
> > > >    "monmap": "",
> > > >    "mon_host": "",
> > > >    "lockdep": "false",
> > > >    "admin_socket": "\/var\/run\/ceph\/ceph-osd.24.asok",
> > > >    "daemonize": "true",
> > > >    "pid_file": "\/var\/run\/ceph\/osd.24.pid",
> > > >    "chdir": "\/",
> > > >    "max_open_files": "0",
> > > >    "fatal_signal_handlers": "true",
> > > >    "log_file": "\/var\/log\/ceph\/osd.24.log",
> > > >    "log_max_new": "1000",
> > > >    "log_max_recent": "100000",
> > > >    "log_to_stderr": "false",
> > > >    "err_to_stderr": "true",
> > > >    "log_to_syslog": "false",
> > > >    "err_to_syslog": "false",
> > > >    "log_flush_on_exit": "true",
> > > >    "clog_to_monitors": "true",
> > > >    "clog_to_syslog": "false",
> > > >    "mon_cluster_log_to_syslog": "false",
> > > >    "mon_cluster_log_file": "\/var\/log\/ceph\/ceph.log",
> > > >    "key": "",
> > > >    "keyfile": "",
> > > >    "keyring": "\/srv\/ceph\/osd\/osd.24\/keyring",
> > > >    "heartbeat_interval": "5",
> > > >    "heartbeat_file": "",
> > > >    "perf": "true",
> > > >    "ms_tcp_nodelay": "true",
> > > >    "ms_initial_backoff": "0.2",
> > > >    "ms_max_backoff": "15",
> > > >    "ms_nocrc": "false",
> > > >    "ms_die_on_bad_msg": "false",
> > > >    "ms_dispatch_throttle_bytes": "104857600",
> > > >    "ms_bind_ipv6": "false",
> > > >    "ms_bind_port_min": "6800",
> > > >    "ms_bind_port_max": "7100",
> > > >    "ms_rwthread_stack_bytes": "1048576",
> > > >    "ms_tcp_read_timeout": "900",
> > > >    "ms_inject_socket_failures": "0",
> > > >    "ms_inject_delay_type": "",
> > > >    "ms_inject_delay_max": "1",
> > > >    "ms_inject_delay_probability": "0",
> > > >    "mon_data": "\/var\/lib\/ceph\/mon\/ceph-24",
> > > >    "mon_initial_members": "",
> > > >    "mon_sync_fs_threshold": "5",
> > > >    "mon_tick_interval": "5",
> > > >    "mon_subscribe_interval": "300",
> > > >    "mon_osd_laggy_halflife": "3600",
> > > >    "mon_osd_laggy_weight": "0.3",
> > > >    "mon_osd_adjust_heartbeat_grace": "true",
> > > >    "mon_osd_adjust_down_out_interval": "true",
> > > >    "mon_osd_auto_mark_in": "false",
> > > >    "mon_osd_auto_mark_auto_out_in": "true",
> > > >    "mon_osd_auto_mark_new_in": "true",
> > > >    "mon_osd_down_out_interval": "300",
> > > >    "mon_osd_min_up_ratio": "0.3",
> > > >    "mon_osd_min_in_ratio": "0.3",
> > > >    "mon_lease": "5",
> > > >    "mon_lease_renew_interval": "3",
> > > >    "mon_lease_ack_timeout": "10",
> > > >    "mon_clock_drift_allowed": "0.05",
> > > >    "mon_clock_drift_warn_backoff": "5",
> > > >    "mon_accept_timeout": "10",
> > > >    "mon_pg_create_interval": "30",
> > > >    "mon_pg_stuck_threshold": "300",
> > > >    "mon_osd_full_ratio": "0.95",
> > > >    "mon_osd_nearfull_ratio": "0.85",
> > > >    "mon_globalid_prealloc": "100",
> > > >    "mon_osd_report_timeout": "900",
> > > >    "mon_force_standby_active": "true",
> > > >    "mon_min_osdmap_epochs": "500",
> > > >    "mon_max_pgmap_epochs": "500",
> > > >    "mon_max_log_epochs": "500",
> > > >    "mon_max_osd": "10000",
> > > >    "mon_probe_timeout": "2",
> > > >    "mon_slurp_timeout": "10",
> > > >    "mon_slurp_bytes": "262144",
> > > >    "mon_client_bytes": "104857600",
> > > >    "mon_daemon_bytes": "419430400",
> > > >    "mon_max_log_entries_per_event": "4096",
> > > >    "paxos_max_join_drift": "10",
> > > >    "paxos_propose_interval": "1",
> > > >    "paxos_min_wait": "0.05",
> > > >    "clock_offset": "0",
> > > >    "auth_cluster_required": "none",
> > > >    "auth_service_required": "none",
> > > >    "auth_client_required": "none",
> > > >    "auth_supported": "none",
> > > >    "cephx_require_signatures": "false",
> > > >    "cephx_sign_messages": "true",
> > > >    "auth_mon_ticket_ttl": "43200",
> > > >    "auth_service_ticket_ttl": "3600",
> > > >    "mon_client_hunt_interval": "3",
> > > >    "mon_client_ping_interval": "10",
> > > >    "mon_client_max_log_entries_per_message": "1000",
> > > >    "mon_max_pool_pg_num": "65536",
> > > >    "client_cache_size": "16384",
> > > >    "client_cache_mid": "0.75",
> > > >    "client_use_random_mds": "false",
> > > >    "client_mount_timeout": "30",
> > > >    "client_tick_interval": "1",
> > > >    "client_trace": "",
> > > >    "client_readahead_min": "131072",
> > > >    "client_readahead_max_bytes": "0",
> > > >    "client_readahead_max_periods": "4",
> > > >    "client_snapdir": ".snap",
> > > >    "client_mountpoint": "\/",
> > > >    "client_notify_timeout": "10",
> > > >    "client_caps_release_delay": "5",
> > > >    "client_oc": "true",
> > > >    "client_oc_size": "209715200",
> > > >    "client_oc_max_dirty": "104857600",
> > > >    "client_oc_target_dirty": "8388608",
> > > >    "client_oc_max_dirty_age": "5",
> > > >    "client_oc_max_objects": "1000",
> > > >    "client_debug_force_sync_read": "false",
> > > >    "client_debug_inject_tick_delay": "0",
> > > >    "fuse_use_invalidate_cb": "false",
> > > >    "fuse_big_writes": "true",
> > > >    "fuse_debug": "false",
> > > >    "objecter_tick_interval": "5",
> > > >    "objecter_timeout": "10",
> > > >    "objecter_inflight_op_bytes": "104857600",
> > > >    "objecter_inflight_ops": "1024",
> > > >    "journaler_allow_split_entries": "true",
> > > >    "journaler_write_head_interval": "15",
> > > >    "journaler_prefetch_periods": "10",
> > > >    "journaler_prezero_periods": "5",
> > > >    "journaler_batch_interval": "0.001",
> > > >    "journaler_batch_max": "0",
> > > >    "mds_data": "\/var\/lib\/ceph\/mds\/ceph-24",
> > > >    "mds_max_file_size": "1099511627776",
> > > >    "mds_cache_size": "100000",
> > > >    "mds_cache_mid": "0.7",
> > > >    "mds_mem_max": "1048576",
> > > >    "mds_dir_commit_ratio": "0.5",
> > > >    "mds_dir_max_commit_size": "90",
> > > >    "mds_decay_halflife": "5",
> > > >    "mds_beacon_interval": "4",
> > > >    "mds_beacon_grace": "15",
> > > >    "mds_blacklist_interval": "1440",
> > > >    "mds_session_timeout": "60",
> > > >    "mds_session_autoclose": "300",
> > > >    "mds_reconnect_timeout": "45",
> > > >    "mds_tick_interval": "5",
> > > >    "mds_dirstat_min_interval": "1",
> > > >    "mds_scatter_nudge_interval": "5",
> > > >    "mds_client_prealloc_inos": "1000",
> > > >    "mds_early_reply": "true",
> > > >    "mds_use_tmap": "true",
> > > >    "mds_default_dir_hash": "2",
> > > >    "mds_log": "true",
> > > >    "mds_log_skip_corrupt_events": "false",
> > > >    "mds_log_max_events": "-1",
> > > >    "mds_log_max_segments": "30",
> > > >    "mds_log_max_expiring": "20",
> > > >    "mds_bal_sample_interval": "3",
> > > >    "mds_bal_replicate_threshold": "8000",
> > > >    "mds_bal_unreplicate_threshold": "0",
> > > >    "mds_bal_frag": "false",
> > > >    "mds_bal_split_size": "10000",
> > > >    "mds_bal_split_rd": "25000",
> > > >    "mds_bal_split_wr": "10000",
> > > >    "mds_bal_split_bits": "3",
> > > >    "mds_bal_merge_size": "50",
> > > >    "mds_bal_merge_rd": "1000",
> > > >    "mds_bal_merge_wr": "1000",
> > > >    "mds_bal_interval": "10",
> > > >    "mds_bal_fragment_interval": "5",
> > > >    "mds_bal_idle_threshold": "0",
> > > >    "mds_bal_max": "-1",
> > > >    "mds_bal_max_until": "-1",
> > > >    "mds_bal_mode": "0",
> > > >    "mds_bal_min_rebalance": "0.1",
> > > >    "mds_bal_min_start": "0.2",
> > > >    "mds_bal_need_min": "0.8",
> > > >    "mds_bal_need_max": "1.2",
> > > >    "mds_bal_midchunk": "0.3",
> > > >    "mds_bal_minchunk": "0.001",
> > > >    "mds_bal_target_removal_min": "5",
> > > >    "mds_bal_target_removal_max": "10",
> > > >    "mds_replay_interval": "1",
> > > >    "mds_shutdown_check": "0",
> > > >    "mds_thrash_exports": "0",
> > > >    "mds_thrash_fragments": "0",
> > > >    "mds_dump_cache_on_map": "false",
> > > >    "mds_dump_cache_after_rejoin": "false",
> > > >    "mds_verify_scatter": "false",
> > > >    "mds_debug_scatterstat": "false",
> > > >    "mds_debug_frag": "false",
> > > >    "mds_debug_auth_pins": "false",
> > > >    "mds_debug_subtrees": "false",
> > > >    "mds_kill_mdstable_at": "0",
> > > >    "mds_kill_export_at": "0",
> > > >    "mds_kill_import_at": "0",
> > > >    "mds_kill_link_at": "0",
> > > >    "mds_kill_rename_at": "0",
> > > >    "mds_wipe_sessions": "false",
> > > >    "mds_wipe_ino_prealloc": "false",
> > > >    "mds_skip_ino": "0",
> > > >    "max_mds": "1",
> > > >    "mds_standby_for_name": "",
> > > >    "mds_standby_for_rank": "-1",
> > > >    "mds_standby_replay": "false",
> > > >    "osd_auto_upgrade_tmap": "true",
> > > >    "osd_tmapput_sets_uses_tmap": "false",
> > > >    "osd_max_backfills": "10",
> > > >    "osd_backfill_full_ratio": "0.85",
> > > >    "osd_backfill_retry_interval": "10",
> > > >    "osd_uuid": "00000000-0000-0000-0000-000000000000",
> > > >    "osd_data": "\/srv\/ceph\/osd\/osd.24",
> > > >    "osd_journal": "\/dev\/sda3",
> > > >    "osd_journal_size": "5120",
> > > >    "osd_max_write_size": "90",
> > > >    "osd_max_pgls": "1024",
> > > >    "osd_client_message_size_cap": "524288000",
> > > >    "osd_pg_bits": "6",
> > > >    "osd_pgp_bits": "6",
> > > >    "osd_min_rep": "1",
> > > >    "osd_max_rep": "10",
> > > >    "osd_pool_default_crush_rule": "0",
> > > >    "osd_pool_default_size": "2",
> > > >    "osd_pool_default_min_size": "0",
> > > >    "osd_pool_default_pg_num": "8",
> > > >    "osd_pool_default_pgp_num": "8",
> > > >    "osd_map_dedup": "true",
> > > >    "osd_map_cache_size": "500",
> > > >    "osd_map_message_max": "100",
> > > >    "osd_op_threads": "2",
> > > >    "osd_disk_threads": "1",
> > > >    "osd_recovery_threads": "1",
> > > >    "osd_recover_clone_overlap": "true",
> > > >    "osd_backfill_scan_min": "64",
> > > >    "osd_backfill_scan_max": "512",
> > > >    "osd_op_thread_timeout": "30",
> > > >    "osd_recovery_thread_timeout": "30",
> > > >    "osd_snap_trim_thread_timeout": "3600",
> > > >    "osd_scrub_thread_timeout": "60",
> > > >    "osd_scrub_finalize_thread_timeout": "600",
> > > >    "osd_remove_thread_timeout": "3600",
> > > >    "osd_command_thread_timeout": "600",
> > > >    "osd_age": "0.8",
> > > >    "osd_age_time": "0",
> > > >    "osd_heartbeat_addr": ":\/0",
> > > >    "osd_heartbeat_interval": "6",
> > > >    "osd_heartbeat_grace": "20",
> > > >    "osd_mon_heartbeat_interval": "30",
> > > >    "osd_mon_report_interval_max": "120",
> > > >    "osd_mon_report_interval_min": "5",
> > > >    "osd_mon_ack_timeout": "30",
> > > >    "osd_min_down_reporters": "1",
> > > >    "osd_min_down_reports": "3",
> > > >    "osd_default_data_pool_replay_window": "45",
> > > >    "osd_preserve_trimmed_log": "false",
> > > >    "osd_auto_mark_unfound_lost": "false",
> > > >    "osd_recovery_delay_start": "0",
> > > >    "osd_recovery_max_active": "50",
> > > >    "osd_recovery_max_chunk": "8388608",
> > > >    "osd_recovery_forget_lost_objects": "false",
> > > >    "osd_max_scrubs": "1",
> > > >    "osd_scrub_load_threshold": "0.5",
> > > >    "osd_scrub_min_interval": "300",
> > > >    "osd_scrub_max_interval": "86400",
> > > >    "osd_deep_scrub_interval": "604800",
> > > >    "osd_deep_scrub_stride": "524288",
> > > >    "osd_auto_weight": "false",
> > > >    "osd_class_dir": "\/usr\/local\/lib\/rados-classes",
> > > >    "osd_check_for_log_corruption": "false",
> > > >    "osd_use_stale_snap": "false",
> > > >    "osd_rollback_to_cluster_snap": "",
> > > >    "osd_default_notify_timeout": "30",
> > > >    "osd_kill_backfill_at": "0",
> > > >    "osd_min_pg_log_entries": "1000",
> > > >    "osd_op_complaint_time": "30",
> > > >    "osd_command_max_records": "256",
> > > >    "osd_op_log_threshold": "5",
> > > >    "osd_verify_sparse_read_holes": "false",
> > > >    "osd_debug_drop_ping_probability": "0",
> > > >    "osd_debug_drop_ping_duration": "0",
> > > >    "osd_debug_drop_pg_create_probability": "0",
> > > >    "osd_debug_drop_pg_create_duration": "1",
> > > >    "osd_debug_drop_op_probability": "0",
> > > >    "osd_op_history_size": "20",
> > > >    "osd_op_history_duration": "600",
> > > >    "osd_target_transaction_size": "300",
> > > >    "osd_client_op_priority": "63",
> > > >    "osd_recovery_op_priority": "10",
> > > >    "filestore": "false",
> > > >    "filestore_index_retry_probability": "0",
> > > >    "filestore_debug_omap_check": "false",
> > > >    "filestore_xattr_use_omap": "false",
> > > >    "filestore_max_inline_xattr_size": "512",
> > > >    "filestore_max_inline_xattrs": "2",
> > > >    "filestore_max_sync_interval": "5",
> > > >    "filestore_min_sync_interval": "0.01",
> > > >    "filestore_btrfs_snap": "true",
> > > >    "filestore_btrfs_clone_range": "true",
> > > >    "filestore_fsync_flushes_journal_data": "false",
> > > >    "filestore_fiemap": "false",
> > > >    "filestore_flusher": "true",
> > > >    "filestore_flusher_max_fds": "512",
> > > >    "filestore_flush_min": "65536",
> > > >    "filestore_sync_flush": "false",
> > > >    "filestore_journal_parallel": "false",
> > > >    "filestore_journal_writeahead": "false",
> > > >    "filestore_journal_trailing": "false",
> > > >    "filestore_queue_max_ops": "500",
> > > >    "filestore_queue_max_bytes": "104857600",
> > > >    "filestore_queue_committing_max_ops": "500",
> > > >    "filestore_queue_committing_max_bytes": "104857600",
> > > >    "filestore_op_threads": "2",
> > > >    "filestore_op_thread_timeout": "60",
> > > >    "filestore_op_thread_suicide_timeout": "180",
> > > >    "filestore_commit_timeout": "600",
> > > >    "filestore_fiemap_threshold": "4096",
> > > >    "filestore_merge_threshold": "10",
> > > >    "filestore_split_multiple": "2",
> > > >    "filestore_update_to": "1000",
> > > >    "filestore_blackhole": "false",
> > > >    "filestore_dump_file": "",
> > > >    "filestore_kill_at": "0",
> > > >    "filestore_fail_eio": "true",
> > > >    "journal_dio": "true",
> > > >    "journal_aio": "false",
> > > >    "journal_block_align": "true",
> > > >    "journal_max_write_bytes": "10485760",
> > > >    "journal_max_write_entries": "100",
> > > >    "journal_queue_max_ops": "500",
> > > >    "journal_queue_max_bytes": "104857600",
> > > >    "journal_align_min_size": "65536",
> > > >    "journal_replay_from": "0",
> > > >    "journal_zero_on_create": "false",
> > > >    "rbd_cache": "false",
> > > >    "rbd_cache_size": "33554432",
> > > >    "rbd_cache_max_dirty": "25165824",
> > > >    "rbd_cache_target_dirty": "16777216",
> > > >    "rbd_cache_max_dirty_age": "1",
> > > >    "nss_db_path": "",
> > > >    "rgw_data": "\/var\/lib\/ceph\/radosgw\/ceph-24",
> > > >    "rgw_enable_apis": "s3, swift, swift_auth, admin",
> > > >    "rgw_cache_enabled": "true",
> > > >    "rgw_cache_lru_size": "10000",
> > > >    "rgw_socket_path": "",
> > > >    "rgw_dns_name": "",
> > > >    "rgw_swift_url": "",
> > > >    "rgw_swift_url_prefix": "swift",
> > > >    "rgw_swift_auth_url": "",
> > > >    "rgw_swift_auth_entry": "auth",
> > > >    "rgw_keystone_url": "",
> > > >    "rgw_keystone_admin_token": "",
> > > >    "rgw_keystone_accepted_roles": "Member, admin",
> > > >    "rgw_keystone_token_cache_size": "10000",
> > > >    "rgw_keystone_revocation_interval": "900",
> > > >    "rgw_admin_entry": "admin",
> > > >    "rgw_enforce_swift_acls": "true",
> > > >    "rgw_swift_token_expiration": "86400",
> > > >    "rgw_print_continue": "true",
> > > >    "rgw_remote_addr_param": "REMOTE_ADDR",
> > > >    "rgw_op_thread_timeout": "600",
> > > >    "rgw_op_thread_suicide_timeout": "0",
> > > >    "rgw_thread_pool_size": "100",
> > > >    "rgw_num_control_oids": "8",
> > > >    "rgw_cluster_root_pool": ".rgw.root",
> > > >    "rgw_log_nonexistent_bucket": "false",
> > > >    "rgw_log_object_name": "%Y-%m-%d-%H-%i-%n",
> > > >    "rgw_log_object_name_utc": "false",
> > > >    "rgw_usage_max_shards": "32",
> > > >    "rgw_usage_max_user_shards": "1",
> > > >    "rgw_enable_ops_log": "true",
> > > >    "rgw_enable_usage_log": "true",
> > > >    "rgw_ops_log_rados": "true",
> > > >    "rgw_ops_log_socket_path": "",
> > > >    "rgw_ops_log_data_backlog": "5242880",
> > > >    "rgw_usage_log_flush_threshold": "1024",
> > > >    "rgw_usage_log_tick_interval": "30",
> > > >    "rgw_intent_log_object_name": "%Y-%m-%d-%i-%n",
> > > >    "rgw_intent_log_object_name_utc": "false",
> > > >    "rgw_init_timeout": "30",
> > > >    "rgw_mime_types_file": "\/etc\/mime.types",
> > > >    "rgw_gc_max_objs": "32",
> > > >    "rgw_gc_obj_min_wait": "7200",
> > > >    "rgw_gc_processor_max_time": "3600",
> > > >    "rgw_gc_processor_period": "3600",
> > > >    "rgw_s3_success_create_obj_status": "0",
> > > >    "rgw_resolve_cname": "false",
> > > >    "rgw_obj_stripe_size": "4194304",
> > > >    "rgw_extended_http_attrs": "",
> > > >    "mutex_perf_counter": "false",
> > > >    "internal_safe_to_start_threads": "true"}
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Mark Nelson [mailto:mark.nelson@inktank.com]
> > > > Sent: Thursday, 20 December 2012 11:28 PM
> > > > To: Matthew Anderson
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Subject: Re: OSD's slow down to a crawl
> > > >
> > > > Hi Matt,
> > > >
> > > > Yeah, your log is looking pretty sparse!  I imagine Sam will ha=
ve a lot of questions for you.  Out of curiosity have you looked at any=
 io/cpu/memory stats when things slow down?  sysprof may come in handy =
if it looks like it's CPU related.  Also, check out the OSD admin socke=
t.
> > > > Sebastien Han made a nice little blog entry describing it:
> > > >
> > > > http://www.sebastien-han.fr/blog/2012/08/14/ceph-admin-socket/
> > > >
> > > > You can get a lot of information about the current state of thi=
ngs.
> > > >
> > > > Mark
> > > >
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"=20
> > > in the body of a message to majordomo@vger.kernel.org More=20
> > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >=20
> > >=20
> >=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
