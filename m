From: "changtao381" <changtao381@163.com>
Subject: Re: osd crash when deep-scrubbing
Date: Tue, 20 Oct 2015 11:04:11 +0800
Message-ID: <00a501d10ae3$ff8ed620$feac8260$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:35662 "EHLO m12-15.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbbJTDEQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Oct 2015 23:04:16 -0400
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

Jiaying Ren <mikulely <at> gmail.com> writes:

> 
> Hi, cephers:
> 
> I've encountered a problem that a pg stuck in inconsistent status:
> 
> $ ceph -s
>     cluster 27d39faa-48ae-4356-a8e3-19d5b81e179e
>      health HEALTH_ERR 1 pgs inconsistent; 34 near full osd(s); 1
> scrub errors; noout flag(s) set
>      monmap e4: 3 mons at
>
{server-61.0.yyyy.xxxxxxxxx.in=10.8.0.61:6789/0,server-62.0.yyyy.xxxxxxxxx.i
n=10.8.0.62:6789/0,server-63.0.yyyy.xxxxxxxxx.in=10.8.0.63:6789/0},
> election epoch 6706, quorum 0,1,2
>
server-61.0.yyyy.xxxxxxxxx.in,server-62.0.yyyy.xxxxxxxxx.in,server-63.0.yyyy
.xxxxxxxxx.in
>      osdmap e87808: 180 osds: 180 up, 180 in
>             flags noout
>       pgmap v29322850: 35026 pgs, 15 pools, 27768 GB data, 1905 kobjects
>             83575 GB used, 114 TB / 196 TB avail
>                35025 active+clean
>                    1 active+clean+inconsistent
>   client io 120 kB/s rd, 216 MB/s wr, 6398 op/s
> 
> `pg repair` cmd doesn't work, so I manually repaired a inconsistent
object(pool
> size is 3,I removed the object different from other two copys).after that
pg
> still in inconsistent status:
> 
> $ ceph pg dump | grep active+clean+inconsistent
> dumped all in format plain
> 3.d70   290     0       0       0       4600869888      3050    3050
>   stale+active+clean+inconsistent 2015-10-18 13:05:43.320451
>   87798'7631234   87798:10758311        [131,119,132]   131
>   [131,119,132]   131     85161'7599152   2015-10-16 14:34:21.283303
>   85161'7599152   2015-10-16 14:34:21.283303
> 
> And after restarted osd.131, the primary osd osd.131 would crash,the
straceback:
> 
>  1: /usr/bin/ceph-osd() [0x9c6de1]
>  2: (()+0xf790) [0x7f384b6b8790]
>  3: (gsignal()+0x35) [0x7f384a58a625]
>  4: (abort()+0x175) [0x7f384a58be05]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7f384ae44a5d]
>  6: (()+0xbcbe6) [0x7f384ae42be6]
>  7: (()+0xbcc13) [0x7f384ae42c13]
>  8: (()+0xbcd0e) [0x7f384ae42d0e]
>  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x13e)
[0x9cd0de]
>  10: (object_info_t::decode(ceph::buffer::list::iterator&)+0x81)
[0x7dfaf1]
>  11: (PG::_scan_snaps(ScrubMap&)+0x394) [0x84b8c4]
>  12: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t, bool,
> ThreadPool::TPHandle&)+0x27b) [0x84cdab]
>  13: (PG::chunky_scrub(ThreadPool::TPHandle&)+0x5c4) [0x85c1b4]
>  14: (PG::scrub(ThreadPool::TPHandle&)+0x181) [0x85d691]
>  15: (OSD::ScrubWQ::_process(PG*, ThreadPool::TPHandle&)+0x1c) [0x6737cc]
>  16: (ThreadPool::worker(ThreadPool::WorkThread*)+0x53d) [0x9e05dd]
>  17: (ThreadPool::WorkThread::entry()+0x10) [0x9e1760]
>  18: (()+0x7a51) [0x7f384b6b0a51]
>  19: (clone()+0x6d) [0x7f384a6409ad]
> 
> ceph version is v0.80.9, manually executes `ceph pg deep-scrub 3.d70`
would also
> cause osd crash.
> 
> Any ideas? or did I missed some logs necessary for further investigation?
> 
> Thx.
> 
> --
> Best Regards!
> Jiaying Ren(mikulely)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

I have met a problem when run 'ceph pg deep-scrub' command. It also causes
osd crash. And finally i find some sector of the disk have corrupted .so
please check dmesg info to check weather there is some disk errors


