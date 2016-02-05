From: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>
Subject: Reg:. Unable to observe the performance impact of Rbd_Cache
 parameter.
Date: Fri, 5 Feb 2016 16:36:29 +0000
Message-ID: <B22CD36FB1C8D94DB1871AFD0023B0E438D720D5@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:47494 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbcBEQkA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 11:40:00 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel-owner@vger.kernel.org" <ceph-devel-owner@vger.kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

We are trying to experiment with Rbd_Cache parameter and expect it to improve the performance when run on a "rbdimage" using FIO. Please find the below details:

1.	1 OS - CentOS7.2
2.	CEPH Code - Hammer Version - 0.94.5
3.	Ceph.conf - Please find below
4.	rbd -p pool3 bench-write im3 --io-size 4096 --io-threads 256 --io-total 10240000000 --io-pattern seq
a.	With the above command we were able to observe performance improvement by modifying Rbd_Cache (True/False)
5.	We were expecting that we could observe the same improvement if we run FIO directly on the above pool, but we don't observe any difference with or without Rbd_Cache (True/False)

It would be great if someone throw some light.

Thanks,
-Vish


Ceph.conf -


[global]
fsid = 9eda02e2-04b7-4eed-a85a-8471ea51528d

auth_cluster_required = none
auth_service_required = none
auth_client_required = none
#auth_supported = none
cephx sign messages = false
cephx require signatures = false

debug_lockdep = 0/0
debug_context = 0/0
debug_crush = 0/0
debug_buffer = 0/0
debug_timer = 0/0
debug_filer = 0/0
debug_objecter = 0/0
debug_rados = 0/0
debug_rbd = 0/0
debug_ms = 0/0
debug_monc = 0/0
debug_tp = 0/0
debug_auth = 0/0
debug_finisher = 0/0
debug_heartbeatmap = 0/0
debug_perfcounter = 0/0
debug_rgw = 0/0
debug_asok = 0/0
debug_throttle = 0/0

debug_journaler = 0/0
debug_objectcatcher = 0/0
debug_client = 0/0
debug_osd = 0/0
debug_optracker = 0/0
debug_objclass = 0/0
debug_filestore = 0/0
debug_journal = 0/0
debug_mon = 0/0
debug_paxos = 0/0

filestore_xattr_use_omap = true
osd_pool_default_size = 1
osd_pool_default_min_size = 1
osd_pool_default_pg_num = 128
osd_pool_default_pgp_num = 128

mon_pg_warn_max_object_skew = 10000
mon_pg_warn_min_per_osd = 0
mon_pg_warn_max_per_osd = 32768
osd_pg_bits = 8
osd_pgp_bits = 8

mon_compact_on_trim = false
log_to_syslog = false
log_file = /var/log/ceph/$name.log
perf = true
mutex_perf_counter = true
throttler_perf_counter = false

[mon.a]
host = Mon1
mon_addr = 10.10.10.150:6789
mon_max_pool_pg_num = 166496
mon_osd_max_split_count = 10000

[osd]
filestore_wbthrottle_enable = false
filestore_queue_max_bytes = 1048576000

filestore_queue_committing_max_bytes = 1048576000
filestore_queue_max_ops = 5000
filestore_queue_committing_max_ops = 5000
filestore_max_sync_interval = 10
filestore_fd_cache_size = 64
filestore_fd_cache_shards = 32
filestore_op_threads = 6

osd_op_threads = 32 
osd_op_num_shards = 25 
osd_op_num_threads_per_shard = 2
osd_enable_op_tracker = false
osd_client_message_size_cap = 0
osd_client_message_cap = 0
objecter_inflight_ops = 102400
objecter_inflight_op_bytes = 1048576000

ms_dispatch_throttle_bytes = 1048576000
ms_nocrc = true
throttler_perf_counter = false

[osd.0]
host = server2a
public_addr = 10.10.10.154

[client]
rbd_cache = true
rbd_cache_writethrough_until_flush = true
admin_socket = /var/run/ceph/$cluster-$type.$id.$pid.$cctid.asok
log_file = /var/log/ceph/


