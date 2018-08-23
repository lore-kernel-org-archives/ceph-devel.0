From: Adrien Gillard <gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Unexpected behaviour after monitors upgrade from
 Jewel to Luminous
Date: Thu, 23 Aug 2018 21:57:13 +0200
Message-ID: <CADyh3SiDpYBnVnackpvMxaDXQ10RB365OP9A5f2MT9Qpir==Og@mail.gmail.com>
References: <CADyh3SjQkQC7U_ThSOW=XntJz+DmyoLZy7B33bM=6ADO54Xrdg@mail.gmail.com>
 <CAJ4mKGYY9ET48vzavGzUL6-zPYYFEiD9Bs+hC_96=LcBNJba=g@mail.gmail.com>
 <CADyh3SiFuRc-CN33wy_5ZpW1bFns7w3bWjXdBLgKwbLZxfqcNA@mail.gmail.com>
 <CAJ4mKGYtqQe5eb__sarwY9zcrP9WpnK1+L4aU8httiaN8hXPVA@mail.gmail.com>
 <CADyh3Sg7ynOQ9OA2Wnb9K_BFTsPDTKwucv0j1bRiMWpL7o9MMA@mail.gmail.com>
 <CADyh3Sh_mw5nOBNDUMt+8xuNF-qk+M-nOkSb2_2urV+4M4jhcw@mail.gmail.com>
 <CADyh3Sj9LZBFQ2vBge73xLAKrApooKt_heytUzhHU9QqizApgg@mail.gmail.com>
 <CAJ4mKGYFO8f6KxP7=0Ve8QhPo=Qr96vh3rpBguj1oJEqjZqnPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6547778545265758568=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGYFO8f6KxP7=0Ve8QhPo=Qr96vh3rpBguj1oJEqjZqnPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6547778545265758568==
Content-Type: multipart/alternative; boundary="000000000000fc766105741faa11"

--000000000000fc766105741faa11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We are running CentOS 7.5 with upstream Ceph packages, no remote syslog,
just default local logging.

After looking a bit deeper into pprof, --alloc_space seems to represent
allocations that happened since the program started which goes along with
the quick deallocation of the memory. --inuse_space (the default) indicates
allocation at collection. std::_Rb_tree::_M_copy uses the most memory here
but I have other samples (well, most of the others actually) where
ceph::logging::Log::create_entry has the lead.
I will look at the admin socket.

I'm adding ceph-devel, as someone might have a clue as to how to better
intepret these results.

Thank you for keeping up with this :)


On Thu, Aug 23, 2018 at 6:58 PM Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Thu, Aug 23, 2018 at 8:42 AM Adrien Gillard <gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> With a bit of profiling, it seems all the memory is allocated to
>> ceph::logging::Log::create_entry (see below)
>>
>> Shoould this be normal ? Is it because some OSDs are down and it logs th=
e
>> results of its osd_ping  ?
>>
>
> Hmm, is that where the memory is actually *staying* or was it merely
> allocated and then quickly deallocated? If you have debugging turned on t=
he
> volume of log output can be quite large, but it's a small amount kept
> resident in memory at a time. Given that you don't seem to have any logs
> over level 5 (except monc at 10) that does seem like a very strange ratio=
,
> though.
>
> Generally log messages are put into a circular buffer and then removed,
> and if the buffer gets full the thread trying to log just gets blocked. I=
'm
> not sure how you could get very large arbitrary amounts of data like that=
.
> Are you using syslog or something? I don't think that should do it, but
> that's all I can imagine.
> That or somehow the upgrade has broken the way the OSD releases memory
> back to the OS. Have you looked at the heap stats available through the
> admin socket? What distro are you running and what's the source of your
> packages?
> -Greg
>
>
>>
>> The debug level of the OSD is below also.
>>
>> Thanks,
>>
>> Adrien
>>
>>  $ pprof /usr/bin/ceph-osd osd.36.profile.0042-first.heap
>> Using local file /usr/bin/ceph-osd.
>> Using local file osd.36.profile.0042-first.heap.
>> Welcome to pprof!  For help, type 'help'.
>> (pprof) top
>> Total: 2468.0 MB
>>    519.5  21.0%  21.0%   1000.4  40.5% std::_Rb_tree::_M_copy
>>    481.0  19.5%  40.5%    481.0  19.5% std::_Rb_tree::_M_create_node
>>    384.3  15.6%  56.1%    384.3  15.6%
>> std::_Rb_tree::_M_emplace_hint_unique
>>    374.0  15.2%  71.3%    374.0  15.2%
>> ceph::buffer::create_aligned_in_mempool
>>    305.6  12.4%  83.6%    305.6  12.4% ceph::logging::Log::create_entry
>>    217.3   8.8%  92.4%    220.2   8.9% std::vector::_M_emplace_back_aux
>>    114.4   4.6%  97.1%    115.6   4.7% ceph::buffer::list::append@a51900
>>     21.4   0.9%  98.0%    210.0   8.5% OSD::heartbeat
>>     21.2   0.9%  98.8%     21.2   0.9% std::string::_Rep::_S_create
>>      4.7   0.2%  99.0%    266.2  10.8% AsyncConnection::send_message
>> (pprof)
>>
>>
>>  $ pprof /usr/bin/ceph-osd --alloc_space osd.36.profile.0042-first.heap
>> Using local file /usr/bin/ceph-osd.
>> Using local file osd.36.profile.0042.heap.
>> Welcome to pprof!  For help, type 'help'.
>> (pprof) top
>> Total: 16519.3 MB
>>  11915.7  72.1%  72.1%  11915.7  72.1% ceph::logging::Log::create_entry
>>    745.0   4.5%  76.6%    745.0   4.5% std::string::_Rep::_S_create
>>    716.9   4.3%  81.0%    716.9   4.3%
>> ceph::buffer::create_aligned_in_mempool
>>    700.2   4.2%  85.2%    703.8   4.3% std::vector::_M_emplace_back_aux
>>    671.9   4.1%  89.3%    671.9   4.1%
>> std::_Rb_tree::_M_emplace_hint_unique
>>    557.8   3.4%  92.7%   1075.2   6.5% std::_Rb_tree::_M_copy
>>    517.4   3.1%  95.8%    517.4   3.1% std::_Rb_tree::_M_create_node
>>    468.2   2.8%  98.6%    469.6   2.8% ceph::buffer::list::append@a51900
>>    122.8   0.7%  99.4%    122.8   0.7% ceph::buffer::list::append@a51d20
>>     33.3   0.2%  99.6%   7042.7  42.6% OSD::heartbeat
>> (pprof)
>>
>>
>>  $ ceph --admin-daemon /var/run/ceph/ceph-osd.36.asok config show | grep
>> debug
>>     "debug_none": "0/5",
>>     "debug_lockdep": "0/1",
>>     "debug_context": "0/1",
>>     "debug_crush": "1/1",
>>     "debug_mds": "1/5",
>>     "debug_mds_balancer": "1/5",
>>     "debug_mds_locker": "1/5",
>>     "debug_mds_log": "1/5",
>>     "debug_mds_log_expire": "1/5",
>>     "debug_mds_migrator": "1/5",
>>     "debug_buffer": "0/1",
>>     "debug_timer": "0/1",
>>     "debug_filer": "0/1",
>>     "debug_striper": "0/1",
>>     "debug_objecter": "0/1",
>>     "debug_rados": "0/5",
>>     "debug_rbd": "0/5",
>>     "debug_rbd_mirror": "0/5",
>>     "debug_rbd_replay": "0/5",
>>     "debug_journaler": "0/5",
>>     "debug_objectcacher": "0/5",
>>     "debug_client": "0/5",
>>     "debug_osd": "0/0",
>>     "debug_optracker": "0/5",
>>     "debug_objclass": "0/5",
>>     "debug_filestore": "0/0",
>>     "debug_journal": "0/0",
>>     "debug_ms": "0/5",
>>     "debug_mon": "1/5",
>>     "debug_monc": "0/10",
>>     "debug_paxos": "1/5",
>>     "debug_tp": "0/5",
>>     "debug_auth": "1/5",
>>     "debug_crypto": "1/5",
>>     "debug_finisher": "1/1",
>>     "debug_reserver": "1/1",
>>     "debug_heartbeatmap": "1/5",
>>     "debug_perfcounter": "1/5",
>>     "debug_rgw": "1/5",
>>     "debug_civetweb": "1/10",
>>     "debug_javaclient": "1/5",
>>     "debug_asok": "1/5",
>>     "debug_throttle": "1/1",
>>     "debug_refs": "0/0",
>>     "debug_xio": "1/5",
>>     "debug_compressor": "1/5",
>>     "debug_bluestore": "1/5",
>>     "debug_bluefs": "1/5",
>>     "debug_bdev": "1/3",
>>     "debug_kstore": "1/5",
>>     "debug_rocksdb": "4/5",
>>     "debug_leveldb": "4/5",
>>     "debug_memdb": "4/5",
>>     "debug_kinetic": "1/5",
>>     "debug_fuse": "1/5",
>>     "debug_mgr": "1/5",
>>     "debug_mgrc": "1/5",
>>     "debug_dpdk": "1/5",
>>     "debug_eventtrace": "1/5",
>>
>>
>> On Thu, Aug 23, 2018 at 4:27 PM Adrien Gillard <gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
>> wrote:
>>
>>> After upgrading to luminous, we see the exact same behaviour, with OSDs
>>> eating as much as 80/90 GB of memory.
>>>
>>> We'll try some memory profiling but at this point we're a bit lost. Is
>>> there any specific logs that could help us ?
>>>
>>> On Thu, Aug 23, 2018 at 2:34 PM Adrien Gillard <gillard.adrien-Re5JQEeQqe8@public.gmane.org=
m>
>>> wrote:
>>>
>>>> Well after a few hours, still nothing new in the behaviour. With half
>>>> of the OSDs (so 6 per host)  up and peering and the nodown flag set to
>>>> limit the creation of new maps, all the memory is consumed and OSDs ge=
t
>>>> killed by OOM killer.
>>>> We observe a lot of threads being created for each OSDs (roughly
>>>> between 500 and 900). As there is around 200 pg per osd, does this see=
m a
>>>> lot to you ? We see tons being created each second, most probably to
>>>> replace the threads that time out or disappear with the osd processes.
>>>>
>>>> We are preparing to upgrade the OSDs to Luminous.
>>>>
>>>> On Thu, Aug 23, 2018 at 4:05 AM Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>> wrote:
>>>>
>>>>>
>>>>>
>>>>> On Wed, Aug 22, 2018 at 6:02 PM Adrien Gillard <
>>>>> gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>
>>>>>> We 'paused' the cluster early in our investigation to avoid
>>>>>> unnecessary IO.
>>>>>> We also set the nodown flag but the OOM rate was really sustained an=
d
>>>>>> we got servers that stopped responding from time to time, so we deci=
ded to
>>>>>> lower the number of OSDs up and let them peer.
>>>>>>
>>>>>
>>>>> Right but this often also means that they need to deal with changing
>>>>> intervals or trying to set up recovery and things, plus the change in=
 which
>>>>> OSDs are up creates new maps that need to be processed. If you set =
=E2=80=9Cnodown=E2=80=9D
>>>>> you can incrementally bring up OSDs while doing a better job of throt=
tling
>>>>> the map creation process and preventing a bunch of new IO when/if the=
y OOM.
>>>>>
>>>>>
>>>>> I don't know if it is the best solution but it is the middle of the
>>>>>> night here, so we'll see tomorrow morning and ponder the completion =
of the
>>>>>> upgrade.
>>>>>>
>>>>>> I agree with you Greg, it does not make sense. The cluster was
>>>>>> running great for around 6 hours after the mons upgrade...
>>>>>>
>>>>>> Finally, regarding the cache-tiering, I know it is not used a lot no=
r
>>>>>> will it be maintained over time. One of the main goal of the luminou=
s
>>>>>> upgrade is to remove it completely and switch to ec rbd.
>>>>>>
>>>>>> Thank you for your inputs !
>>>>>>
>>>>>>
>>>>>> On Wed, Aug 22, 2018 at 11:57 PM Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>>>> wrote:
>>>>>>
>>>>>>> On Wed, Aug 22, 2018 at 6:35 AM Adrien Gillard <
>>>>>>> gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>>>
>>>>>>>> Hi everyone,
>>>>>>>>
>>>>>>>> We have a hard time figuring out a behaviour encountered after
>>>>>>>> upgrading the monitors of one of our cluster from Jewel to Luminou=
s
>>>>>>>> yesterday.
>>>>>>>>
>>>>>>>> The cluster is composed of 14 OSDs hosts (2xE5-2640 v3 and 64 GB o=
f
>>>>>>>> RAM), each containing 12x4TB OSD with journals on DC grade SSDs). =
The
>>>>>>>> cluster was installed in Infernalis and upgraded to Jewel. We main=
ly use it
>>>>>>>> for RBD with a cache tier in front of an EC pool.
>>>>>>>>
>>>>>>>> We started the upgrade from Jewel 10.2.10 to Luminous 12.2.7
>>>>>>>> yesterday afternoon with the monitors and the provisionning of the=
 MGR. We
>>>>>>>> were planning on upgrading the OSD servers today.
>>>>>>>> All went well until the cluster received the following commands, a
>>>>>>>> few hours after the upgrade :
>>>>>>>>
>>>>>>>> ceph osd pool set pool-cache-01 target_max_bytes 0
>>>>>>>> ceph osd pool set pool-cache-02 target_max_bytes 0
>>>>>>>>
>>>>>>>> (The context here is that we use this cluster for backups and set
>>>>>>>> target_max_bytes to 0 to stop the flush and give maximum ressource=
s to the
>>>>>>>> backups IOs)
>>>>>>>>
>>>>>>>> Below is an extract from the logs of one of the monitors.
>>>>>>>> The cluster started exchanging a lot over the cluster network,
>>>>>>>> apparently backfill/recovery and multiple Gbits/s, in an amount wh=
ich we've
>>>>>>>> never seen before. Due to some network uplinks sub-sizing, the tra=
ffic
>>>>>>>> could not be handled well and this lead to OSDs crashing.
>>>>>>>>
>>>>>>>
>>>>>>> This really doesn't make a ton of sense =E2=80=94 you're saying tha=
t by
>>>>>>> telling the cluster to *stop* doing flushing IO, everything went ba=
d? In
>>>>>>> terms of root causing the issue you'll obviously want to focus on t=
hat,
>>>>>>> although it may or may not be helpful in recovering things at this =
point.
>>>>>>>
>>>>>>> Do keep in mind that users running cache-tiering are increasingly
>>>>>>> uncommon, and while we still test it we aren't expanding that cover=
age and
>>>>>>> would really like to remove and replace that functionality, so you'=
re out
>>>>>>> on the far edge of things here. :/
>>>>>>>
>>>>>>> Finally, if you're still experiencing OOM issues, you may want to
>>>>>>> set the "nodown" flag =E2=80=94 that will prevent OSDs being marked=
 down, which
>>>>>>> obviously will stall IO and peering if they go down anyway, but wil=
l
>>>>>>> prevent spamming map updates that cause the cluster to OOM again.
>>>>>>> -Greg
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> At the moment we are still investigating the logs to try to
>>>>>>>> understand what happened exactly. The cluster is down. When we res=
tart the
>>>>>>>> OSDs, PG start activating and peering but at some point all the RA=
M and
>>>>>>>> swap of the servers is consumed and OSDs crash.
>>>>>>>> I tried to set the ovious cluster parameters
>>>>>>>> (osd_recovery_max_active=3D1, osd_recovery_threads=3D1, osd_max_ba=
ckfills=3D1)
>>>>>>>> and norecover, nobackfill, but when the OSDs start, we still see 4=
 or 5
>>>>>>>> Gbits/s over the cluster network.
>>>>>>>>
>>>>>>>> We are currently reconfiguring the network to try to remove the
>>>>>>>> bandwith problem and are preparing to add more RAM to the servers.
>>>>>>>>
>>>>>>>> But still, I have a couple of questions :
>>>>>>>>
>>>>>>>>  - Has anyone encoutered the issue we have with the cache ? Or hav=
e
>>>>>>>> a possible explanation ?
>>>>>>>>  - Is it normal to observe so much traffic on the cluster network
>>>>>>>> when the PG are activating / peering with norecover and nobackfill=
 set ?
>>>>>>>>
>>>>>>>> Thank you for reading and for your input !
>>>>>>>>
>>>>>>>>
>>>>>>>> 2018-08-21 21:05:02.766969 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 6208 active+clean; 261 TB data, 385 TB use=
d, 225 TB
>>>>>>>> / 611 TB avail; 298 MB/s rd, 212 MB/s wr, 456 op/s
>>>>>>>> 2018-08-21 21:05:03.805124 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 6208 active+clean; 261 TB data, 385 TB use=
d, 225 TB
>>>>>>>> / 611 TB avail; 296 MB/s rd, 193 MB/s wr, 433 op/s
>>>>>>>> 2018-08-21 21:05:03.870690 7f10d83cc700  0
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader) e6 handle_command
>>>>>>>> mon_command({"var": "target_max_bytes", "prefix": "osd pool set", =
"pool":
>>>>>>>> "pool-cache-02", "val": "0"} v 0
>>>>>>>> ) v1
>>>>>>>> 2018-08-21 21:05:03.870749 7f10d83cc700  0 log_channel(audit) log
>>>>>>>> [INF] : from=3D'client.146529236 -' entity=3D'client.admin' cmd=3D=
[{"var":
>>>>>>>> "target_max_bytes", "prefix": "osd pool set", "pool": "pool-cache-=
02
>>>>>>>> ", "val": "0"}]: dispatch
>>>>>>>> 2018-08-21 21:05:03.913663 7f10d83cc700  0
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader) e6 handle_command
>>>>>>>> mon_command({"prefix": "osd pool stats", "format": "json"} v 0) v1
>>>>>>>> 2018-08-21 21:05:03.913745 7f10d83cc700  0 log_channel(audit) log
>>>>>>>> [DBG] : from=3D'client.? 10.25.25.3:0/4101432770'
>>>>>>>> entity=3D'client.admin' cmd=3D[{"prefix": "osd pool stats", "forma=
t": "json"}]:
>>>>>>>> dispatch
>>>>>>>> 2018-08-21 21:05:04.042835 7f10d83cc700  0
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader) e6 handle_command
>>>>>>>> mon_command({"var": "target_max_bytes", "prefix": "osd pool set", =
"pool":
>>>>>>>> "pool-cache-01", "val": "0"} v 0
>>>>>>>> ) v1
>>>>>>>> 2018-08-21 21:05:04.042894 7f10d83cc700  0 log_channel(audit) log
>>>>>>>> [INF] : from=3D'client.146565481 -' entity=3D'client.admin' cmd=3D=
[{"var":
>>>>>>>> "target_max_bytes", "prefix": "osd pool set", "pool": "pool-cache-=
01
>>>>>>>> ", "val": "0"}]: dispatch
>>>>>>>> 2018-08-21 21:05:04.813217 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 6208 active+clean; 261 TB data, 385 TB use=
d, 225 TB
>>>>>>>> / 611 TB avail; 271 MB/s rd, 181 MB/s wr, 415 op/s
>>>>>>>> 2018-08-21 21:05:04.821486 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114693 e114693: 168
>>>>>>>> total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:04.821711 7f10de377700  0
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114693 crush map has
>>>>>>>> features 432365734501548032, adjusting msgr requires
>>>>>>>> 2018-08-21 21:05:04.823032 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114693 create_pending
>>>>>>>> setting backfillfull_ratio =3D 0.9
>>>>>>>> 2018-08-21 21:05:04.823156 7f10de377700  0 log_channel(audit) log
>>>>>>>> [INF] : from=3D'client.146529236 -' entity=3D'client.admin' cmd=3D=
'[{"var":
>>>>>>>> "target_max_bytes", "prefix": "osd pool set", "pool": "pool-cache-=
0
>>>>>>>> 2", "val": "0"}]': finished
>>>>>>>> 2018-08-21 21:05:04.823280 7f10de377700  0 log_channel(audit) log
>>>>>>>> [INF] : from=3D'client.146565481 -' entity=3D'client.admin' cmd=3D=
'[{"var":
>>>>>>>> "target_max_bytes", "prefix": "osd pool set", "pool": "pool-cache-=
0
>>>>>>>> 1", "val": "0"}]': finished
>>>>>>>> 2018-08-21 21:05:04.825528 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [DBG] : osdmap e114693: 168 total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:04.844932 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 6208 active+clean; 261 TB data, 385 TB use=
d, 225 TB
>>>>>>>> / 611 TB avail; 275 MB/s rd, 192 MB/s wr, 429 op/s
>>>>>>>> 2018-08-21 21:05:05.873682 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 187 peering, 6021 active+clean; 261 TB dat=
a, 385 TB
>>>>>>>> used, 225 TB / 611 TB avail; 220 MB/s rd, 188 MB/s wr, 383
>>>>>>>> op/s
>>>>>>>> 2018-08-21 21:05:05.895414 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114694 e114694: 168
>>>>>>>> total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:05.895721 7f10de377700  0
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114694 crush map has
>>>>>>>> features 432365734501548032, adjusting msgr requires
>>>>>>>> 2018-08-21 21:05:05.905473 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114694 create_pending
>>>>>>>> setting backfillfull_ratio =3D 0.9
>>>>>>>> 2018-08-21 21:05:05.940729 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [DBG] : osdmap e114694: 168 total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:05.947921 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 204 peering, 6004 active+clean; 261 TB dat=
a, 385 TB
>>>>>>>> used, 225 TB / 611 TB avail; 201 MB/s rd, 200 MB/s wr, 355
>>>>>>>> op/s
>>>>>>>> 2018-08-21 21:05:06.912752 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114695 e114695: 168
>>>>>>>> total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:06.913104 7f10de377700  0
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114695 crush map has
>>>>>>>> features 432365734501548032, adjusting msgr requires
>>>>>>>> 2018-08-21 21:05:06.928521 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114695 create_pending
>>>>>>>> setting backfillfull_ratio =3D 0.9
>>>>>>>> 2018-08-21 21:05:06.968793 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [DBG] : osdmap e114695: 168 total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:07.001112 7f10d93ce700  1 heartbeat_map
>>>>>>>> reset_timeout 'Monitor::cpu_tp thread 0x7f10d93ce700' had timed ou=
t after 0
>>>>>>>> 2018-08-21 21:05:07.004274 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 12 unknown, 114 remapped+peering, 5 activa=
ting, 481
>>>>>>>> peering, 5596 active+clean; 261 TB data, 385 TB used, 225 T
>>>>>>>> B / 611 TB avail; 177 MB/s rd, 173 MB/s wr, 317 op/s
>>>>>>>> 2018-08-21 21:05:07.025200 7f10d8bcd700  1 heartbeat_map
>>>>>>>> reset_timeout 'Monitor::cpu_tp thread 0x7f10d8bcd700' had timed ou=
t after 0
>>>>>>>> 2018-08-21 21:05:07.948138 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114696 e114696: 168
>>>>>>>> total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:07.948487 7f10de377700  0
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114696 crush map has
>>>>>>>> features 432365734501548032, adjusting msgr requires
>>>>>>>> 2018-08-21 21:05:07.965671 7f10de377700  1
>>>>>>>> mon.clb-cph-frpar2-mon-01@0(leader).osd e114696 create_pending
>>>>>>>> setting backfillfull_ratio =3D 0.9
>>>>>>>> 2018-08-21 21:05:08.007585 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [DBG] : osdmap e114696: 168 total, 168 up, 168 in
>>>>>>>> 2018-08-21 21:05:08.052153 7f10de377700  0 log_channel(cluster) lo=
g
>>>>>>>> [INF] : pgmap 6208 pgs: 46 activating+remapped, 15 unknown, 305
>>>>>>>> remapped+peering, 11 activating, 697 peering, 8 active+remapped+ba=
ckfil
>>>>>>>> ling, 5126 active+clean; 261 TB data, 385 TB used, 225 TB / 611 TB
>>>>>>>> avail; 115 MB/s rd, 182 MB/s wr, 292 op/s; 26681/519327262 objects
>>>>>>>> misplaced (0.005%); 4856 kB/s, 3 objects/s recovering
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> ceph-users mailing list
>>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>>>>
>>>>>>>

--000000000000fc766105741faa11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>We are running CentOS 7.5 with upstream Ceph packages=
, no remote syslog, just default local logging.</div><div><br></div><div>Af=
ter looking a bit deeper into pprof, --alloc_space seems to represent alloc=
ations that happened since the program started which goes along with the qu=
ick deallocation of the memory. --inuse_space (the default) indicates alloc=
ation at collection. std::_Rb_tree::_M_copy uses the most memory here but I=
 have other samples (well, most of the others actually) where ceph::logging=
::Log::create_entry has the lead.</div><div>I will look at the admin socket=
.</div><div><br></div><div>I&#39;m adding ceph-devel, as someone might have=
 a clue as to how to better intepret these results.</div><div><br></div>Tha=
nk you for keeping up with this :)<div><br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr">On Thu, Aug 23, 2018 at 6:58 PM Gregory Farnum =
&lt;<a href=3D"mailto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">On Thu, Aug 23, 2=
018 at 8:42 AM Adrien Gillard &lt;<a href=3D"mailto:gillard.adrien-Re5JQEeQqe8@public.gmane.org=
m" target=3D"_blank">gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">With a bit=
 of profiling, it seems all the memory is allocated to=C2=A0 ceph::logging:=
:Log::create_entry (see below)<div><br></div><div>Shoould this be normal ? =
Is it because some OSDs are down and it logs the results of its osd_ping=C2=
=A0 ?</div></div></blockquote><div><br></div><div>Hmm, is that where the me=
mory is actually *staying* or was it merely allocated and then quickly deal=
located? If you have debugging turned on the volume of log output can be qu=
ite large, but it&#39;s a small amount kept resident in memory at a time. G=
iven that you don&#39;t seem to have any logs over level 5 (except monc at =
10) that does seem like a very strange ratio, though.</div><div><br></div><=
div>Generally log messages are put into a circular buffer and then removed,=
 and if the buffer gets full the thread trying to log just gets blocked. I&=
#39;m not sure how you could get very large arbitrary amounts of data like =
that. Are you using syslog or something? I don&#39;t think that should do i=
t, but that&#39;s all I can imagine.</div><div>That or somehow the upgrade =
has broken the way the OSD releases memory back to the OS. Have you looked =
at the heap stats available through the admin socket? What distro are you r=
unning and what&#39;s the source of your packages?</div><div>-Greg</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><br></di=
v><div>The debug level of the OSD is below also.</div><div><br></div><div>T=
hanks,</div><div><br></div><div>Adrien<br><div><br></div><div><div>=C2=A0$ =
pprof /usr/bin/ceph-osd osd.36.profile.0042-first.heap</div><div>Using loca=
l file /usr/bin/ceph-osd.</div><div>Using local file osd.36.profile.0042-fi=
rst.heap.</div><div>Welcome to pprof!=C2=A0 For help, type &#39;help&#39;.<=
/div><div>(pprof) top</div><div>Total: 2468.0 MB</div><div>=C2=A0 =C2=A0519=
.5=C2=A0 21.0%=C2=A0 21.0%=C2=A0 =C2=A01000.4=C2=A0 40.5% std::_Rb_tree::_M=
_copy</div><div>=C2=A0 =C2=A0481.0=C2=A0 19.5%=C2=A0 40.5%=C2=A0 =C2=A0 481=
.0=C2=A0 19.5% std::_Rb_tree::_M_create_node</div><div>=C2=A0 =C2=A0384.3=
=C2=A0 15.6%=C2=A0 56.1%=C2=A0 =C2=A0 384.3=C2=A0 15.6% std::_Rb_tree::_M_e=
mplace_hint_unique</div><div>=C2=A0 =C2=A0374.0=C2=A0 15.2%=C2=A0 71.3%=C2=
=A0 =C2=A0 374.0=C2=A0 15.2% ceph::buffer::create_aligned_in_mempool</div><=
div>=C2=A0 =C2=A0305.6=C2=A0 12.4%=C2=A0 83.6%=C2=A0 =C2=A0 305.6=C2=A0 12.=
4% ceph::logging::Log::create_entry</div><div>=C2=A0 =C2=A0217.3=C2=A0 =C2=
=A08.8%=C2=A0 92.4%=C2=A0 =C2=A0 220.2=C2=A0 =C2=A08.9% std::vector::_M_emp=
lace_back_aux</div><div>=C2=A0 =C2=A0114.4=C2=A0 =C2=A04.6%=C2=A0 97.1%=C2=
=A0 =C2=A0 115.6=C2=A0 =C2=A04.7% ceph::buffer::list::append@a51900</div><d=
iv>=C2=A0 =C2=A0 21.4=C2=A0 =C2=A00.9%=C2=A0 98.0%=C2=A0 =C2=A0 210.0=C2=A0=
 =C2=A08.5% OSD::heartbeat</div><div>=C2=A0 =C2=A0 21.2=C2=A0 =C2=A00.9%=C2=
=A0 98.8%=C2=A0 =C2=A0 =C2=A021.2=C2=A0 =C2=A00.9% std::string::_Rep::_S_cr=
eate</div><div>=C2=A0 =C2=A0 =C2=A04.7=C2=A0 =C2=A00.2%=C2=A0 99.0%=C2=A0 =
=C2=A0 266.2=C2=A0 10.8% AsyncConnection::send_message</div><div>(pprof)</d=
iv></div><div><br></div><div><br></div><div><div>=C2=A0$ pprof /usr/bin/cep=
h-osd --alloc_space osd.36.profile.0042-first.heap</div><div>Using local fi=
le /usr/bin/ceph-osd.</div><div>Using local file osd.36.profile.0042.heap.<=
/div><div>Welcome to pprof!=C2=A0 For help, type &#39;help&#39;.</div><div>=
(pprof) top</div><div>Total: 16519.3 MB</div><div>=C2=A011915.7=C2=A0 72.1%=
=C2=A0 72.1%=C2=A0 11915.7=C2=A0 72.1% ceph::logging::Log::create_entry</di=
v><div>=C2=A0 =C2=A0745.0=C2=A0 =C2=A04.5%=C2=A0 76.6%=C2=A0 =C2=A0 745.0=
=C2=A0 =C2=A04.5% std::string::_Rep::_S_create</div><div>=C2=A0 =C2=A0716.9=
=C2=A0 =C2=A04.3%=C2=A0 81.0%=C2=A0 =C2=A0 716.9=C2=A0 =C2=A04.3% ceph::buf=
fer::create_aligned_in_mempool</div><div>=C2=A0 =C2=A0700.2=C2=A0 =C2=A04.2=
%=C2=A0 85.2%=C2=A0 =C2=A0 703.8=C2=A0 =C2=A04.3% std::vector::_M_emplace_b=
ack_aux</div><div>=C2=A0 =C2=A0671.9=C2=A0 =C2=A04.1%=C2=A0 89.3%=C2=A0 =C2=
=A0 671.9=C2=A0 =C2=A04.1% std::_Rb_tree::_M_emplace_hint_unique</div><div>=
=C2=A0 =C2=A0557.8=C2=A0 =C2=A03.4%=C2=A0 92.7%=C2=A0 =C2=A01075.2=C2=A0 =
=C2=A06.5% std::_Rb_tree::_M_copy</div><div>=C2=A0 =C2=A0517.4=C2=A0 =C2=A0=
3.1%=C2=A0 95.8%=C2=A0 =C2=A0 517.4=C2=A0 =C2=A03.1% std::_Rb_tree::_M_crea=
te_node</div><div>=C2=A0 =C2=A0468.2=C2=A0 =C2=A02.8%=C2=A0 98.6%=C2=A0 =C2=
=A0 469.6=C2=A0 =C2=A02.8% ceph::buffer::list::append@a51900</div><div>=C2=
=A0 =C2=A0122.8=C2=A0 =C2=A00.7%=C2=A0 99.4%=C2=A0 =C2=A0 122.8=C2=A0 =C2=
=A00.7% ceph::buffer::list::append@a51d20</div><div>=C2=A0 =C2=A0 33.3=C2=
=A0 =C2=A00.2%=C2=A0 99.6%=C2=A0 =C2=A07042.7=C2=A0 42.6% OSD::heartbeat</d=
iv><div>(pprof)</div></div><div><br></div></div><div><br></div><div><div>=
=C2=A0$ ceph --admin-daemon /var/run/ceph/ceph-osd.36.asok config show | gr=
ep debug</div><div>=C2=A0 =C2=A0 &quot;debug_none&quot;: &quot;0/5&quot;,</=
div><div>=C2=A0 =C2=A0 &quot;debug_lockdep&quot;: &quot;0/1&quot;,</div><di=
v>=C2=A0 =C2=A0 &quot;debug_context&quot;: &quot;0/1&quot;,</div><div>=C2=
=A0 =C2=A0 &quot;debug_crush&quot;: &quot;1/1&quot;,</div><div>=C2=A0 =C2=
=A0 &quot;debug_mds&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;d=
ebug_mds_balancer&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;deb=
ug_mds_locker&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_m=
ds_log&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_mds_log_=
expire&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_mds_migr=
ator&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_buffer&quo=
t;: &quot;0/1&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_timer&quot;: &quot=
;0/1&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_filer&quot;: &quot;0/1&quot=
;,</div><div>=C2=A0 =C2=A0 &quot;debug_striper&quot;: &quot;0/1&quot;,</div=
><div>=C2=A0 =C2=A0 &quot;debug_objecter&quot;: &quot;0/1&quot;,</div><div>=
=C2=A0 =C2=A0 &quot;debug_rados&quot;: &quot;0/5&quot;,</div><div>=C2=A0 =
=C2=A0 &quot;debug_rbd&quot;: &quot;0/5&quot;,</div><div>=C2=A0 =C2=A0 &quo=
t;debug_rbd_mirror&quot;: &quot;0/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;de=
bug_rbd_replay&quot;: &quot;0/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_=
journaler&quot;: &quot;0/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_objec=
tcacher&quot;: &quot;0/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_client&=
quot;: &quot;0/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_osd&quot;: &quo=
t;0/0&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_optracker&quot;: &quot;0/5=
&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_objclass&quot;: &quot;0/5&quot;=
,</div><div>=C2=A0 =C2=A0 &quot;debug_filestore&quot;: &quot;0/0&quot;,</di=
v><div>=C2=A0 =C2=A0 &quot;debug_journal&quot;: &quot;0/0&quot;,</div><div>=
=C2=A0 =C2=A0 &quot;debug_ms&quot;: &quot;0/5&quot;,</div><div>=C2=A0 =C2=
=A0 &quot;debug_mon&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;d=
ebug_monc&quot;: &quot;0/10&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_paxo=
s&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_tp&quot;: &qu=
ot;0/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_auth&quot;: &quot;1/5&quo=
t;,</div><div>=C2=A0 =C2=A0 &quot;debug_crypto&quot;: &quot;1/5&quot;,</div=
><div>=C2=A0 =C2=A0 &quot;debug_finisher&quot;: &quot;1/1&quot;,</div><div>=
=C2=A0 =C2=A0 &quot;debug_reserver&quot;: &quot;1/1&quot;,</div><div>=C2=A0=
 =C2=A0 &quot;debug_heartbeatmap&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =
=C2=A0 &quot;debug_perfcounter&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=
=A0 &quot;debug_rgw&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;d=
ebug_civetweb&quot;: &quot;1/10&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_=
javaclient&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_asok=
&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_throttle&quot;=
: &quot;1/1&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_refs&quot;: &quot;0/=
0&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_xio&quot;: &quot;1/5&quot;,</d=
iv><div>=C2=A0 =C2=A0 &quot;debug_compressor&quot;: &quot;1/5&quot;,</div><=
div>=C2=A0 =C2=A0 &quot;debug_bluestore&quot;: &quot;1/5&quot;,</div><div>=
=C2=A0 =C2=A0 &quot;debug_bluefs&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =
=C2=A0 &quot;debug_bdev&quot;: &quot;1/3&quot;,</div><div>=C2=A0 =C2=A0 &qu=
ot;debug_kstore&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug=
_rocksdb&quot;: &quot;4/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_leveld=
b&quot;: &quot;4/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_memdb&quot;: =
&quot;4/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_kinetic&quot;: &quot;1=
/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;debug_fuse&quot;: &quot;1/5&quot;,<=
/div><div>=C2=A0 =C2=A0 &quot;debug_mgr&quot;: &quot;1/5&quot;,</div><div>=
=C2=A0 =C2=A0 &quot;debug_mgrc&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=
=A0 &quot;debug_dpdk&quot;: &quot;1/5&quot;,</div><div>=C2=A0 =C2=A0 &quot;=
debug_eventtrace&quot;: &quot;1/5&quot;,</div></div><div><br></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Aug 23, 2018 at 4:27 =
PM Adrien Gillard &lt;<a href=3D"mailto:gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D=
"_blank">gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">After upgrading to luminous, we see the exac=
t same behaviour, with OSDs eating as much as 80/90 GB of memory.<div><br><=
/div><div>We&#39;ll try some memory profiling but at this point we&#39;re a=
 bit lost. Is there any specific logs that could help us ?</div></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Aug 23, 2018 at 2:34 PM =
Adrien Gillard &lt;<a href=3D"mailto:gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_b=
lank">gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div dir=3D"ltr">Well after a few hours, still nothing new in th=
e behaviour. With half of the OSDs (so 6 per host)=C2=A0 up and peering and=
 the nodown flag set to limit the creation of new maps, all the memory is c=
onsumed and OSDs get killed by OOM killer.<div>We observe a lot of threads =
being created for each OSDs (roughly between 500 and 900). As there is arou=
nd 200 pg per osd, does this seem a lot to you ? We see tons being created =
each second, most probably to replace the threads that time out or disappea=
r with the osd processes.</div><div><br></div><div>We are preparing to upgr=
ade the OSDs to Luminous.</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr">On Thu, Aug 23, 2018 at 4:05 AM Gregory Farnum &lt;<a href=3D"mai=
lto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div><br></div><div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr">On Wed, Aug 22, 2018 at 6:02 PM Adrien Gi=
llard &lt;<a href=3D"mailto:gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">gil=
lard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr">We &#39;paused&#39; the cluster early in our investigati=
on to avoid unnecessary IO.=C2=A0<div>We also set the nodown flag but the O=
OM rate was really sustained and we got servers that stopped responding fro=
m time to time, so we decided to lower the number of OSDs up and let them p=
eer.=C2=A0</div></div></blockquote><div dir=3D"auto"><br></div><div dir=3D"=
auto">Right but this often also means that they need to deal with changing =
intervals or trying to set up recovery and things, plus the change in which=
 OSDs are up creates new maps that need to be processed. If you set =E2=80=
=9Cnodown=E2=80=9D you can incrementally bring up OSDs while doing a better=
 job of throttling the map creation process and preventing a bunch of new I=
O when/if they OOM.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div></div><div>I don=
&#39;t know if it is the best solution but it is the middle of the night he=
re, so we&#39;ll see tomorrow morning and ponder the completion of the upgr=
ade.</div><div><br></div><div>I agree with you Greg, it does not make sense=
. The cluster was running great for around 6 hours after the mons upgrade..=
.</div><div><br></div><div>Finally, regarding the cache-tiering, I know it =
is not used a lot nor will it be maintained over time. One of the main goal=
 of the luminous upgrade is to remove it completely and switch to ec rbd.</=
div><div><br></div><div>Thank you for your inputs !</div><div><br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Aug 22, 2018 at =
11:57 PM Gregory Farnum &lt;<a href=3D"mailto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D=
"_blank">gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr">On Wed, Aug 22, 2018 at 6:35 AM Adrien Gillard &lt=
;<a href=3D"mailto:gillard.adrien-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">gillard.adri=
en-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi everyone,<div><br></div><div>We have a ha=
rd time figuring out a behaviour encountered after upgrading the monitors o=
f one of our cluster from Jewel to Luminous yesterday.</div><div><br></div>=
<div>The cluster is composed of 14 OSDs hosts (2xE5-2640 v3 and 64 GB of RA=
M), each containing 12x4TB OSD with journals on DC grade SSDs). The cluster=
 was installed in Infernalis and upgraded to Jewel. We mainly use it for RB=
D with a cache tier in front of an EC pool.</div><div><br></div><div>We sta=
rted the upgrade from Jewel 10.2.10 to Luminous 12.2.7 yesterday afternoon =
with the monitors and the provisionning of the MGR. We were planning on upg=
rading the OSD servers today.</div><div>All went well until the cluster rec=
eived the following commands, a few hours after the upgrade :</div><div><br=
></div><div>ceph osd pool set pool-cache-01 target_max_bytes 0</div><div>ce=
ph osd pool set pool-cache-02 target_max_bytes 0=C2=A0=C2=A0<br></div><div>=
<br></div><div>(The context here is that we use this cluster for backups an=
d set target_max_bytes to 0 to stop the flush and give maximum ressources t=
o the backups IOs)</div><div><br></div><div>Below is an extract from the lo=
gs of one of the monitors.<br></div><div>The cluster started exchanging a l=
ot over the cluster network, apparently backfill/recovery and multiple Gbit=
s/s, in an amount which we&#39;ve never seen before. Due to some network up=
links sub-sizing, the traffic could not be handled well and this lead to OS=
Ds crashing.=C2=A0</div></div></blockquote><div><br></div><div>This really =
doesn&#39;t make a ton of sense =E2=80=94 you&#39;re saying that by telling=
 the cluster to *stop* doing flushing IO, everything went bad? In terms of =
root causing the issue you&#39;ll obviously want to focus on that, although=
 it may or may not be helpful in recovering things at this point.</div><div=
><br></div><div>Do keep in mind that users running cache-tiering are increa=
singly uncommon, and while we still test it we aren&#39;t expanding that co=
verage and would really like to remove and replace that functionality, so y=
ou&#39;re out on the far edge of things here. :/</div><div><br></div><div>F=
inally, if you&#39;re still experiencing OOM issues, you may want to set th=
e &quot;nodown&quot; flag =E2=80=94 that will prevent OSDs being marked dow=
n, which obviously will stall IO and peering if they go down anyway, but wi=
ll prevent spamming map updates that cause the cluster to OOM again.</div><=
div>-Greg</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr"><div><br></div><div>At the moment we are still investigating the logs =
to try to understand what happened exactly. The cluster is down. When we re=
start the OSDs, PG start activating and peering but at some point all the R=
AM and swap of the servers is consumed and OSDs crash.</div><div>I tried to=
 set the ovious cluster parameters (osd_recovery_max_active=3D1, osd_recove=
ry_threads=3D1, osd_max_backfills=3D1) and norecover, nobackfill, but when =
the OSDs start, we still see 4 or 5 Gbits/s over the cluster network.</div>=
<div><br></div><div>We are currently reconfiguring the network to try to re=
move the bandwith problem and are preparing to add more RAM to the servers.=
</div><div><br></div><div>But still, I have a couple of questions :</div><d=
iv><br></div><div>=C2=A0- Has anyone encoutered the issue we have with the =
cache ? Or have a possible explanation ?</div><div>=C2=A0- Is it normal to =
observe so much traffic on the cluster network when the PG are activating /=
 peering with norecover and nobackfill set ?</div><div><br></div><div>Thank=
 you for reading and for your input !</div><div>=C2=A0</div><div><br></div>=
<div><div>2018-08-21 21:05:02.766969 7f10de377700=C2=A0 0 log_channel(clust=
er) log [INF] : pgmap 6208 pgs: 6208 active+clean; 261 TB data, 385 TB used=
, 225 TB / 611 TB avail; 298 MB/s rd, 212 MB/s wr, 456 op/s</div><div>2018-=
08-21 21:05:03.805124 7f10de377700=C2=A0 0 log_channel(cluster) log [INF] :=
 pgmap 6208 pgs: 6208 active+clean; 261 TB data, 385 TB used, 225 TB / 611 =
TB avail; 296 MB/s rd, 193 MB/s wr, 433 op/s</div><div>2018-08-21 21:05:03.=
870690 7f10d83cc700=C2=A0 0 mon.clb-cph-frpar2-mon-01@0(leader) e6 handle_c=
ommand mon_command({&quot;var&quot;: &quot;target_max_bytes&quot;, &quot;pr=
efix&quot;: &quot;osd pool set&quot;, &quot;pool&quot;: &quot;pool-cache-02=
&quot;, &quot;val&quot;: &quot;0&quot;} v 0</div><div>) v1</div><div>2018-0=
8-21 21:05:03.870749 7f10d83cc700=C2=A0 0 log_channel(audit) log [INF] : fr=
om=3D&#39;client.146529236 -&#39; entity=3D&#39;client.admin&#39; cmd=3D[{&=
quot;var&quot;: &quot;target_max_bytes&quot;, &quot;prefix&quot;: &quot;osd=
 pool set&quot;, &quot;pool&quot;: &quot;pool-cache-02</div><div>&quot;, &q=
uot;val&quot;: &quot;0&quot;}]: dispatch</div><div>2018-08-21 21:05:03.9136=
63 7f10d83cc700=C2=A0 0 mon.clb-cph-frpar2-mon-01@0(leader) e6 handle_comma=
nd mon_command({&quot;prefix&quot;: &quot;osd pool stats&quot;, &quot;forma=
t&quot;: &quot;json&quot;} v 0) v1</div><div>2018-08-21 21:05:03.913745 7f1=
0d83cc700=C2=A0 0 log_channel(audit) log [DBG] : from=3D&#39;client.? <a hr=
ef=3D"http://10.25.25.3:0/4101432770" target=3D"_blank">10.25.25.3:0/410143=
2770</a>&#39; entity=3D&#39;client.admin&#39; cmd=3D[{&quot;prefix&quot;: &=
quot;osd pool stats&quot;, &quot;format&quot;: &quot;json&quot;}]: dispatch=
</div><div>2018-08-21 21:05:04.042835 7f10d83cc700=C2=A0 0 mon.clb-cph-frpa=
r2-mon-01@0(leader) e6 handle_command mon_command({&quot;var&quot;: &quot;t=
arget_max_bytes&quot;, &quot;prefix&quot;: &quot;osd pool set&quot;, &quot;=
pool&quot;: &quot;pool-cache-01&quot;, &quot;val&quot;: &quot;0&quot;} v 0<=
/div><div>) v1</div><div>2018-08-21 21:05:04.042894 7f10d83cc700=C2=A0 0 lo=
g_channel(audit) log [INF] : from=3D&#39;client.146565481 -&#39; entity=3D&=
#39;client.admin&#39; cmd=3D[{&quot;var&quot;: &quot;target_max_bytes&quot;=
, &quot;prefix&quot;: &quot;osd pool set&quot;, &quot;pool&quot;: &quot;poo=
l-cache-01</div><div>&quot;, &quot;val&quot;: &quot;0&quot;}]: dispatch</di=
v><div>2018-08-21 21:05:04.813217 7f10de377700=C2=A0 0 log_channel(cluster)=
 log [INF] : pgmap 6208 pgs: 6208 active+clean; 261 TB data, 385 TB used, 2=
25 TB / 611 TB avail; 271 MB/s rd, 181 MB/s wr, 415 op/s</div><div>2018-08-=
21 21:05:04.821486 7f10de377700=C2=A0 1 mon.clb-cph-frpar2-mon-01@0(leader)=
.osd e114693 e114693: 168 total, 168 up, 168 in</div><div>2018-08-21 21:05:=
04.821711 7f10de377700=C2=A0 0 mon.clb-cph-frpar2-mon-01@0(leader).osd e114=
693 crush map has features 432365734501548032, adjusting msgr requires</div=
><div>2018-08-21 21:05:04.823032 7f10de377700=C2=A0 1 mon.clb-cph-frpar2-mo=
n-01@0(leader).osd e114693 create_pending setting backfillfull_ratio =3D 0.=
9</div><div>2018-08-21 21:05:04.823156 7f10de377700=C2=A0 0 log_channel(aud=
it) log [INF] : from=3D&#39;client.146529236 -&#39; entity=3D&#39;client.ad=
min&#39; cmd=3D&#39;[{&quot;var&quot;: &quot;target_max_bytes&quot;, &quot;=
prefix&quot;: &quot;osd pool set&quot;, &quot;pool&quot;: &quot;pool-cache-=
0</div><div>2&quot;, &quot;val&quot;: &quot;0&quot;}]&#39;: finished</div><=
div>2018-08-21 21:05:04.823280 7f10de377700=C2=A0 0 log_channel(audit) log =
[INF] : from=3D&#39;client.146565481 -&#39; entity=3D&#39;client.admin&#39;=
 cmd=3D&#39;[{&quot;var&quot;: &quot;target_max_bytes&quot;, &quot;prefix&q=
uot;: &quot;osd pool set&quot;, &quot;pool&quot;: &quot;pool-cache-0</div><=
div>1&quot;, &quot;val&quot;: &quot;0&quot;}]&#39;: finished</div><div>2018=
-08-21 21:05:04.825528 7f10de377700=C2=A0 0 log_channel(cluster) log [DBG] =
: osdmap e114693: 168 total, 168 up, 168 in</div><div>2018-08-21 21:05:04.8=
44932 7f10de377700=C2=A0 0 log_channel(cluster) log [INF] : pgmap 6208 pgs:=
 6208 active+clean; 261 TB data, 385 TB used, 225 TB / 611 TB avail; 275 MB=
/s rd, 192 MB/s wr, 429 op/s</div><div>2018-08-21 21:05:05.873682 7f10de377=
700=C2=A0 0 log_channel(cluster) log [INF] : pgmap 6208 pgs: 187 peering, 6=
021 active+clean; 261 TB data, 385 TB used, 225 TB / 611 TB avail; 220 MB/s=
 rd, 188 MB/s wr, 383</div><div>op/s</div><div>2018-08-21 21:05:05.895414 7=
f10de377700=C2=A0 1 mon.clb-cph-frpar2-mon-01@0(leader).osd e114694 e114694=
: 168 total, 168 up, 168 in</div><div>2018-08-21 21:05:05.895721 7f10de3777=
00=C2=A0 0 mon.clb-cph-frpar2-mon-01@0(leader).osd e114694 crush map has fe=
atures 432365734501548032, adjusting msgr requires</div><div>2018-08-21 21:=
05:05.905473 7f10de377700=C2=A0 1 mon.clb-cph-frpar2-mon-01@0(leader).osd e=
114694 create_pending setting backfillfull_ratio =3D 0.9</div><div>2018-08-=
21 21:05:05.940729 7f10de377700=C2=A0 0 log_channel(cluster) log [DBG] : os=
dmap e114694: 168 total, 168 up, 168 in</div><div>2018-08-21 21:05:05.94792=
1 7f10de377700=C2=A0 0 log_channel(cluster) log [INF] : pgmap 6208 pgs: 204=
 peering, 6004 active+clean; 261 TB data, 385 TB used, 225 TB / 611 TB avai=
l; 201 MB/s rd, 200 MB/s wr, 355</div><div>op/s</div><div>2018-08-21 21:05:=
06.912752 7f10de377700=C2=A0 1 mon.clb-cph-frpar2-mon-01@0(leader).osd e114=
695 e114695: 168 total, 168 up, 168 in</div><div>2018-08-21 21:05:06.913104=
 7f10de377700=C2=A0 0 mon.clb-cph-frpar2-mon-01@0(leader).osd e114695 crush=
 map has features 432365734501548032, adjusting msgr requires</div><div>201=
8-08-21 21:05:06.928521 7f10de377700=C2=A0 1 mon.clb-cph-frpar2-mon-01@0(le=
ader).osd e114695 create_pending setting backfillfull_ratio =3D 0.9</div><d=
iv>2018-08-21 21:05:06.968793 7f10de377700=C2=A0 0 log_channel(cluster) log=
 [DBG] : osdmap e114695: 168 total, 168 up, 168 in</div><div>2018-08-21 21:=
05:07.001112 7f10d93ce700=C2=A0 1 heartbeat_map reset_timeout &#39;Monitor:=
:cpu_tp thread 0x7f10d93ce700&#39; had timed out after 0</div><div>2018-08-=
21 21:05:07.004274 7f10de377700=C2=A0 0 log_channel(cluster) log [INF] : pg=
map 6208 pgs: 12 unknown, 114 remapped+peering, 5 activating, 481 peering, =
5596 active+clean; 261 TB data, 385 TB used, 225 T</div><div>B / 611 TB ava=
il; 177 MB/s rd, 173 MB/s wr, 317 op/s</div><div>2018-08-21 21:05:07.025200=
 7f10d8bcd700=C2=A0 1 heartbeat_map reset_timeout &#39;Monitor::cpu_tp thre=
ad 0x7f10d8bcd700&#39; had timed out after 0</div><div>2018-08-21 21:05:07.=
948138 7f10de377700=C2=A0 1 mon.clb-cph-frpar2-mon-01@0(leader).osd e114696=
 e114696: 168 total, 168 up, 168 in</div><div>2018-08-21 21:05:07.948487 7f=
10de377700=C2=A0 0 mon.clb-cph-frpar2-mon-01@0(leader).osd e114696 crush ma=
p has features 432365734501548032, adjusting msgr requires</div><div>2018-0=
8-21 21:05:07.965671 7f10de377700=C2=A0 1 mon.clb-cph-frpar2-mon-01@0(leade=
r).osd e114696 create_pending setting backfillfull_ratio =3D 0.9</div><div>=
2018-08-21 21:05:08.007585 7f10de377700=C2=A0 0 log_channel(cluster) log [D=
BG] : osdmap e114696: 168 total, 168 up, 168 in</div><div>2018-08-21 21:05:=
08.052153 7f10de377700=C2=A0 0 log_channel(cluster) log [INF] : pgmap 6208 =
pgs: 46 activating+remapped, 15 unknown, 305 remapped+peering, 11 activatin=
g, 697 peering, 8 active+remapped+backfil</div><div>ling, 5126 active+clean=
; 261 TB data, 385 TB used, 225 TB / 611 TB avail; 115 MB/s rd, 182 MB/s wr=
, 292 op/s; 26681/519327262 objects misplaced (0.005%); 4856 kB/s, 3 object=
s/s recovering</div></div><div><br></div></div>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div></div>
</blockquote></div>
</blockquote></div></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div></div>
</blockquote></div>

--000000000000fc766105741faa11--

--===============6547778545265758568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6547778545265758568==--
