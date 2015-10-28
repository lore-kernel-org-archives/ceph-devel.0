From: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>
Subject: [Newstore] FIO Read's from Cient causes OSD *** Caught signal
 (Aborted) **
Date: Wed, 28 Oct 2015 18:22:28 +0000
Message-ID: <B22CD36FB1C8D94DB1871AFD0023B0E438D409A9@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:45619 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762AbbJ1SWb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 14:22:31 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel-owner@vger.kernel.org" <ceph-devel-owner@vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We are observing a crash of OSD whenever we run FIO Read's from a clien=
t. Setup is very simple and explained as below:

1. One OSD with Ceph Version "ceph version 9.1.0-420-ge3921a8 (e3921a83=
96870be4a38ce1f1b6c35bc0829dbb68)", pulled the code from GIT and compil=
ed/Installed.
2. One Client with same version of CEPH.
3. FIO Version - fio-2.2.10-16-gd223
4. Ceph Conf as given below
5. Crash log details from log file as below
6. FIO Script as given below

CEPH Conf -

[global]
fsid =3D 9eda02e2-04b7-4eed-a85a-8471ea51528d
mon_initial_members =3D msl-dsma-spoc08
mon_host =3D 10.10.10.190
auth_cluster_required =3D cephx
auth_service_required =3D cephx
auth_client_required =3D cephx
auth_supported =3D none

#Needed for Newstore=20
osd_objectstore =3D newstore
enable experimental unrecoverable data corrupting features =3D newstore=
, rocksdb
newstore_backend =3D rocksdb

#Debug - Start Removed for=A0 now to debug
#newstore_max_dir_size =3D 4096
#newstore_sync_io =3D true
#newstore_sync_transaction =3D true
#newstore_sync_submit_transaction =3D true
#newstore_sync_wal_apply =3D true
#newstore_overlay_max =3D 0
#Debug - End

#Needed for Newstore

filestore_xattr_use_omap =3D true

osd pool default size =3D 1
rbd cache =3D false


debug_lockdep =3D 0/0
debug_context =3D 0/0
debug_crush =3D 0/0
debug_buffer =3D 0/0
debug_timer =3D 0/0
debug_filer =3D 0/0
debug_objecter =3D 0/0
debug_rados =3D 0/0
debug_rbd =3D 0/0
debug_journaler =3D 0/0
debug_objectcatcher =3D 0/0
debug_client =3D 0/0
debug_osd =3D 0/0
debug_optracker =3D 0/0
debug_objclass =3D 0/0
debug_filestore =3D 0/0
debug_journal =3D 0/0
debug_ms =3D 0/0
debug_monc =3D 0/0
debug_tp =3D 0/0
debug_auth =3D 0/0
debug_finisher =3D 0/0
debug_heartbeatmap =3D 0/0
debug_perfcounter =3D 0/0
debug_asok =3D 0/0
debug_throttle =3D 0/0
debug_mon =3D 0/0
debug_paxos =3D 0/0
debug_rgw =3D 0/0
osd_op_threads =3D 5
osd_op_num_threads_per_shard =3D 1
osd_op_num_shards =3D 25
#osd_op_num_sharded_pool_threads =3D 25
filestore_op_threads =3D 4
ms_nocrc =3D true
filestore_fd_cache_size =3D 64
filestore_fd_cache_shards =3D 32
cephx sign messages =3D false
cephx require signatures =3D false
ms_dispatch_throttle_bytes =3D 0
throttler_perf_counter =3D false

[osd]
osd_client_message_size_cap =3D 0
osd_client_message_cap =3D 0
osd_enable_op_tracker =3D false=20

Crash details from the log:
=A0 -194> 2015-10-28 10:54:40.792957 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba915510
=A0 -193> 2015-10-28 10:54:40.792959 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba916590
=A0 -192> 2015-10-28 10:54:40.792962 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba914990
=A0 -191> 2015-10-28 10:54:40.792965 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba916490
=A0 -190> 2015-10-28 10:54:40.792968 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba916090
=A0 -189> 2015-10-28 10:54:40.792971 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba915c10
=A0 -188> 2015-10-28 10:54:40.792975 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba917190
=A0 -187> 2015-10-28 10:54:40.792977 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba916810
=A0 -186> 2015-10-28 10:54:40.792980 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba914790
=A0 -185> 2015-10-28 10:54:40.792983 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba915e10
=A0 -184> 2015-10-28 10:54:40.792986 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba915f10
=A0 -183> 2015-10-28 10:54:40.792988 7f15862e8700=A0 2 newstore(/var/li=
b/ceph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba915f90
 -182> 2015-10-28 10:54:40.792992 7f15862e8700=A0 2 newstore(/var/lib/c=
eph/osd/ceph-0) _do_wal_transaction prepared aio 0x7f15ba914510
 ...
=20
=A0=A0 -10> 2015-10-28 10:55:45.240480 7f1577366700=A0 5 newstore(/var/=
lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1.b=
1 0x7f15a025acf0)
=A0=A0=A0 -9> 2015-10-28 10:55:45.240830 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -8> 2015-10-28 10:55:45.241135 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -7> 2015-10-28 10:55:45.241418 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -6> 2015-10-28 10:55:45.241674 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -5> 2015-10-28 10:55:45.241913 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -4> 2015-10-28 10:55:45.242150 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -3> 2015-10-28 10:55:45.242391 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -2> 2015-10-28 10:55:45.242614 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0 -1> 2015-10-28 10:55:45.242885 7f1577366700=A0 5 newstore(/va=
r/lib/ceph/osd/ceph-0) queue_transactions existing 0x7f15a0ac1180 osr(1=
=2Eb1 0x7f15a025acf0)
=A0=A0=A0=A0 0> 2015-10-28 10:55:54.323685 7f156e354700 -1 *** Caught s=
ignal (Aborted) **
in thread 7f156e354700

ceph version 9.1.0-420-ge3921a8 (e3921a8396870be4a38ce1f1b6c35bc0829dbb=
68)
1: (()+0x80b70a) [0x7f159c91670a]
2: (()+0x10340) [0x7f159afef340]
3: (gsignal()+0x39) [0x7f1599116cc9]
4: (abort()+0x148) [0x7f159911a0d8]
5: (__gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f1599a21535]
6: (()+0x5e6d6) [0x7f1599a1f6d6]
7: (()+0x5e703) [0x7f1599a1f703]
8: (()+0x5e922) [0x7f1599a1f922]
9: (ceph::buffer::list::iterator_impl<false>::copy(unsigned int, char*)=
+0xa5) [0x7f159ca12955]
10: (void decode<unsigned long, unsigned long>(std::map<unsigned long, =
unsigned long, std::less<unsigned long>, std::allocator<std::pair<unsig=
ned long const, unsigned long> > >&, ceph::buffer::list::iterator&)+0x2=
e) [0x7f159c600fae]
11: (ReplicatedPG::do_osd_ops(ReplicatedPG::OpContext*, std::vector<OSD=
Op, std::allocator<OSDOp> >&)+0x2aa4) [0x7f159c5b0314]
12: (ReplicatedPG::prepare_transaction(ReplicatedPG::OpContext*)+0x97) =
[0x7f159c5cdf77]
13: (ReplicatedPG::execute_ctx(ReplicatedPG::OpContext*)+0x890) [0x7f15=
9c5cedb0]
14: (ReplicatedPG::do_op(std::shared_ptr<OpRequest>&)+0x3552) [0x7f159c=
5d3732]
15: (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&, ThreadPool::=
TPHandle&)+0x705) [0x7f159c56d835]
16: (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::shared_ptr<OpReques=
t>, ThreadPool::TPHandle&)+0x3bd) [0x7f159c45d02d]
17: (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest>&)+0x5d)=
 [0x7f159c45d24d]
18: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*=
)+0x8a9) [0x7f159c481649]
19: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x85f) [=
0x7f159c9f5caf]
20: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f159c9f7bb=
0]
21: (()+0x8182) [0x7f159afe7182]
22: (clone()+0x6d) [0x7f15991da47d]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is neede=
d to interpret this.

--- logging levels ---
=A0=A0 0/ 5 none
=A0=A0 0/ 0 lockdep
=A0=A0 0/ 0 context
=A0=A0 0/ 0 crush
=A0=A0 1/ 5 mds
=A0=A0 1/ 5 mds_balancer
=A0=A0 1/ 5 mds_locker
=A0=A0 1/ 5 mds_log
=A0=A0 1/ 5 mds_log_expire
=A0=A0 1/ 5 mds_migrator
=A0=A0 0/ 0 buffer
=A0=A0 0/ 0 timer
=A0=A0 0/ 0 filer
=A0=A0 0/ 1 striper
=A0=A0 0/ 0 objecter
=A0=A0 0/ 0 rados
=A0=A0 0/ 0 rbd
=A0=A0 0/ 5 rbd_replay
=A0=A0 0/ 0 journaler
=A0=A0 0/ 5 objectcacher
=A0=A0 0/ 0 client
=A0=A0 0/ 0 osd
=A0=A0 0/ 0 optracker
=A0=A0 0/ 0 objclass
=A0=A0 0/ 0 filestore
=A0=A0 1/ 3 keyvaluestore
=A0=A0 0/ 0 journal
=A0=A0 0/ 0 ms
=A0=A0 0/ 0 mon
=A0=A0 0/ 0 monc
=A0=A0 0/ 0 paxos
=A0=A0 0/ 0 tp
=A0=A0 0/ 0 auth
=A0=A0 1/ 5 crypto
=A0=A0 0/ 0 finisher
=A0=A0 0/ 0 heartbeatmap
=A0=A0 0/ 0 perfcounter
=A0=A0 0/ 0 rgw
=A0=A0 1/10 civetweb
=A0=A0 1/ 5 javaclient
=A0=A0 0/ 0 asok
=A0=A0 0/ 0 throttle
=A0=A0 0/ 0 refs
=A0=A0 1/ 5 xio
=A0=A0 1/ 5 compressor
=A0=A0 1/ 5 newstore
=A0 -2/-2 (syslog threshold)
=A0 -1/-1 (stderr threshold)
=A0 max_recent=A0=A0=A0=A0 10000
=A0 max_new=A0=A0=A0=A0=A0=A0=A0=A0 1000
=A0 log_file /var/log/ceph/ceph-osd.0.log
--- end dump of recent events ---

=46IO Script -=20

######################################################################
# Example test for the RBD engine.
#=20
# Runs a 4k random write test against a RBD via librbd
#
# NOTE: Make sure you have either a RBD named 'fio_test' or change
#=A0=A0=A0=A0=A0=A0 the rbdname parameter.
######################################################################
[global]
#logging
#write_iops_log=3Dwrite_iops_log
#write_bw_log=3Dwrite_bw_log
#write_lat_log=3Dwrite_lat_log
#ioengine=3Dlibaio
ioengine=3Drbd
clientname=3Dadmin
direct=3D1
pool=3Dpool1
rbdname=3Dim1
rw=3Drandread or randwrite
bs=3D8k
numjobs=3D16
time_based=3D1
runtime=3D300
ramp_time=3D60

[rbd_iodepth32]
iodepth=3D128

Any pointers as to what could be the issue will be greatly appreciated.

Thanks,
-Vish
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
