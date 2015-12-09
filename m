From: chen kael <chenji.bupt@gmail.com>
Subject: radosgw thread got blocked ,does any one seen this before
Date: Wed, 9 Dec 2015 18:36:58 +0800
Message-ID: <CAA-rZjYWZs+D+AaKgBhKBjdP-2wpCH8paMwKd7-tR_VdrCfNtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:32969 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbbLIKhA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 05:37:00 -0500
Received: by wmec201 with SMTP id c201so253108684wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Dec 2015 02:36:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,ceph-dev
  Sorry for trouble you, I am tracing a issus in radosgw

[root@ceph101 ~]# ceph -s
    cluster e063f9a5-2e80-469e-a4ce-e31f9c6b4046
     health HEALTH_WARN noout,noscrub,nodeep-scrub flag(s) set
     monmap e3: 3 mons at
{ceph101=10.150.130.101:6789/0,ceph102=10.150.130.102:6789/0,ceph103=10.150.130.103:6789/0},
election epoch 56, quorum 0,1,2 ceph101,ceph102,ceph103
     osdmap e6454: 72 osds: 72 up, 72 in
            flags noout,noscrub,nodeep-scrub
      pgmap v7088435: 1984 pgs, 15 pools, 14437 GB data, 80731 kobjects
            45379 GB used, 177 TB / 221 TB avail
                1984 active+clean
  client io 8387 kB/s rd, 4624 kB/s wr, 8353 op/s

[client.radosgw.gateway]
host = ceph-apache05
rgw dns name = **.com
keyring = /etc/ceph/ceph.client.radosgw.keyring
rgw socket path = /var/run/ceph/ceph.radosgw.gateway.fastcgi.sock
log file = /var/log/radosgw/client.radosgw.gateway.log
rgw enable usage log = true
rgw usage log tick interval = 30
rgw usage log flush threshold = 1024
rgw usage max shards = 32
rgw usage max user shards = 1
rgw_enable_ops_log = false
rgw_thread_pool_size = 2000
rgw_override_bucket_index_max_shards = 128
rgw_cache_lru_size = 100000
rgw_max_chunk_size = 4194304
rgw_cache_enabled = false


radosgw log:

2015-12-09 16:49:30.572723 7f773dbfb700  1 heartbeat_map is_healthy
'RGWProcess::m_tp thread 0x7f71e8f0f700' had timed out after 600
2015-12-09 16:49:30.572755 7f773dbfb700  1 heartbeat_map is_healthy
'RGWProcess::m_tp thread 0x7f7215556700' had timed out after 600
2015-12-09 16:49:30.572762 7f773dbfb700  1 heartbeat_map is_healthy
'RGWProcess::m_tp thread 0x7f721b960700' had timed out after 600
2015-12-09 16:49:30.663418 7f6f75d24700  1 ====== starting new request
req=0x7f6d3ef66a80 =====
2015-12-09 16:49:30.821609 7f6d715ea700  1 ====== starting new request
req=0x7f6d4231bf80 =====
2015-12-09 16:49:30.837774 7f6f75d24700  1 ====== req done
req=0x7f6d3ef66a80 http_status=200 ======
2015-12-09 16:49:30.882390 7f6d715ea700  1 ====== req done
req=0x7f6d4231bf80 http_status=200 ======


I tried ceph daemon /var/run/ceph/ceph-client.*.asok objecter_requests
,but got nothing
[root@ceph-apache05 ~]# ceph daemon /var/run/ceph/ceph-client.*.asok
objecter_requests
{ "ops": [],
  "linger_ops": [],
  "pool_ops": [],
  "pool_stat_ops": [],
  "statfs_ops": [],
  "command_ops": []}


Then I find all block threads stack is like below

Thread 2077 (Thread 0x7fad4db21700 (LWP 21224)):
#0  0x00000033b5e0b5bc in pthread_cond_wait@@GLIBC_2.3.2 () from
/lib64/libpthread.so.0
#1  0x00000000005c49cb in
BucketIndexAioManager::wait_for_completions(int, int*, int*,
std::map<int, std::basic_string<char, std::char_traits<char>,
std::allocator<char> >, std::less<int>, std::allocator<std::pair<int
const, std::basic_string<char, std::char_traits<char>,
std::allocator<char> > > > >*) ()
#2  0x0000000000559ad2 in CLSRGWConcurrentIO::operator()() ()
#3  0x000000000054273f in RGWRados::cls_bucket_head(rgw_bucket&,
std::map<std::basic_string<char, std::char_traits<char>,
std::allocator<char> >, rgw_bucket_dir_header,
std::less<std::basic_string<char, std::char_traits<char>,
std::allocator<char> > >,
std::allocator<std::pair<std::basic_string<char,
std::char_traits<char>, std::allocator<char> > const,
rgw_bucket_dir_header> > >&, std::map<int, std::basic_string<char,
std::char_traits<char>, std::allocator<char> >, std::less<int>,
std::allocator<std::pair<int const, std::basic_string<char,
std::char_traits<char>, std::allocator<char> > > > >*) ()
#4  0x0000000000542d58 in
RGWRados::update_containers_stats(std::map<std::basic_string<char,
std::char_traits<char>, std::allocator<char> >, RGWBucketEnt,
std::less<std::basic_string<char, std::char_traits<char>,
std::allocator<char> > >,
std::allocator<std::pair<std::basic_string<char,
std::char_traits<char>, std::allocator<char> > const, RGWBucketEnt> >
>&) ()
#5  0x000000000057dbe2 in RGWStatBucket::execute() ()
#6  0x00000000004d86a0 in ?? ()
#7  0x00000000004d92ea in RGWFCGXProcess::handle_request(RGWRequest*) ()
#8  0x00000000004dbcb7 in RGWProcess::RGWWQ::_process(RGWRequest*) ()
#9  0x0000003e198ad316 in ThreadPool::worker(ThreadPool::WorkThread*)
() from /usr/lib64/librados.so.2
#10 0x0000003e198aef60 in ThreadPool::WorkThread::entry() () from
/usr/lib64/librados.so.2
#11 0x00000033b5e079d1 in start_thread () from /lib64/libpthread.so.0
#12 0x00000033b5ae88fd in clone () from /lib64/libc.so.6

Most request goes well, but as times goes, threads been blocked will
be more and more, at last ,I have to restart the radosgw, Any
suggestion is welcome,Thanks a lot!
