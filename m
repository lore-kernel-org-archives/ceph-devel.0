From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Wed, 28 Jan 2015 15:51:00 -0600
Message-ID: <54C959C4.1010305@redhat.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com> <54B6F103.9000708@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB4EF94@FMSMSX106.amr.corp.intel.com>
Reply-To: mnelson@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070709040407010802080806"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:43211 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbbA2B6v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jan 2015 20:58:51 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so22447235qgd.11
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2015 17:58:50 -0800 (PST)
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120AB4EF94@FMSMSX106.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070709040407010802080806
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Per Sage's suggestion in the perf meeting this morning I dumped sysctl 
-a on both systems and wrote a little script to compare an arbitrary 
number of sysctl output files.  It only lists settings that have 
different values and dumps out a csv.

So far it looks like the interesting differences are in:

scheduler
numa
ipv4 (and ipv6)
vm

Script is here:

https://github.com/ceph/ceph-tools/blob/master/cbt/tools/compare_sysctl.py

Mark

On 01/27/2015 07:23 PM, Blinick, Stephen L wrote:
> Hi Mark --thanks for the detailed description!  Here's my latency #'s (local ping) on identical hardware
>
> Ubuntu 14.04LTS:  rtt min/avg/max/mdev    0.025/0.026/0.030/0.005 ms
> RHEL7:                        rtt min/avg/max/mdev    0.008/0.009/0.022/0.003ms
>
> So I am seeing a similar network stack latency difference.   Also, all the tests I did were with 'debug off' (but with other things such as message signing, crc. ) .  Maybe we could have a quick discussion on what settings are best to use when trying to get comparable numbers with memstore or all-flash setups.
>
> As far as the high concurrency test goes, that peak # of IOPS will be reached at lower concurrency (something around like t=8 probably), and at that point (the 'knee' of the latency/throughput curve), there's a pretty substantial latency difference.     Once it gets to t=256 I imagine the latency was 10+ms for both platforms.
>
> Since the last direct comparison was on older code, and the mixing of libnss/cryptopp in the builds, I think I need to rerun the comparison(at least one last time!) between the two distro's on a more recent version of code.
>
> Thanks,
>
> Stephen
>
>
>
> -----Original Message-----
> From: Mark Nelson [mailto:mark.nelson@inktank.com]
> Sent: Tuesday, January 27, 2015 2:03 PM
> To: Blinick, Stephen L; Ceph Development
> Subject: Re: Memstore performance improvements v0.90 vs v0.87
>
> Hi Stephen,
>
> Took a little longer than I wanted it to, but I finally got some results looking at RHEL7 and Ubuntu 14.04 in our test lab.  This is with a recent master pull.
>
> Tests are with rados bench to a single memstore OSD on localhost.
>
> Single Op Avg Write Latency:
>
> Ubuntu 14.04:            0.91ms
> Ubuntu 14.04 (no debug): 0.67ms
> RHEL 7:                  0.49ms
> RHEL 7 (no debug):       0.31ms
>
> Single Op Avg read Latency:
>
> Ubuntu 14.04:            0.58ms
> Ubuntu 14.04 (no debug): 0.33ms
> RHEL 7:                  0.32ms
> RHEL 7 (no debug):       0.17ms
>
> I then checked avg network latency to localhost using ping for 120s:
>
> Ubuntu 14.04: 0.025ms
> RHEL 7:       0.015ms
>
> So looking at your results, I see similar latency numbers, though not quite as dramatic (ie  Ubuntu isn't quite so bad).  I wanted to know if the latency would be hidden if enough IOs were thrown at the problem so I increased concurrent IOs to 256:
>
> 256 concurrent op Write IOPS:
>
> Ubuntu 14.04:             7199 IOPS
> Ubuntu 14.04 (no debug): 14613 IOPS
> RHEL 7:                   7784 IOPS
> REHL 7 (no debug):       17907 IOPS
>
> 256 concurrent op Read IOPS:
>
> Ubuntu 14.04:             9887 IOPS
> Ubuntu 14.04 (no debug): 20489 IOPS
> RHEL 7:                  10832 IOPS
> REHL 7 (no debug):       21257 IOPS
>
> So on one hand I'm seeing an effect similar to what you saw, but once I throw enough concurrency at the problem it seems like other things take over as the bottleneck.  With default debug logging levels the latency difference is mostly masked, but with debugging off we see at least for writes a fairly substantial difference.
>
> I collected some system utilization data during the tests and will go back and see if I can discover anything more with perf as well.  I think the two big takeaways at this point are:
>
> 1) There is definitely something interesting going on with Ubuntu vs RHEL (Maybe network related).
> 2) Our debug logging has become a major bottleneck in high IOPS scenarios (though we already kind of knew this).
>
> Mark
>
> On 01/14/2015 05:39 PM, Blinick, Stephen L wrote:
>> Haha :)  Well, my intuition is still pointing to something I've configured wrong (or had wrong).. but it will be interesting to see what it is.
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mark.nelson@inktank.com]
>> Sent: Wednesday, January 14, 2015 3:43 PM
>> To: Blinick, Stephen L; Ceph Development
>> Subject: Re: Memstore performance improvements v0.90 vs v0.87
>>
>> On 01/14/2015 04:32 PM, Blinick, Stephen L wrote:
>>> I went back and grabbed 87 and built it on RHEL7 as well, and performance is also similar (much better).  I've also run it on a few systems (Dual socket 10-core E5v2,  Dual socket 6-core E5v3).  So, it's related to my switch to RHEL7, and not to the code changes between v0.90 and v0.87.     Will post when I get more data.
>>
>> Stephen, you are practically writing press releases for the RHEL guys
>> here! ;)
>>
>> Mark
>>
>>>
>>> Thanks,
>>>
>>> Stephen
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Blinick,
>>> Stephen L
>>> Sent: Wednesday, January 14, 2015 12:06 AM
>>> To: Ceph Development
>>> Subject: Memstore performance improvements v0.90 vs v0.87
>>>
>>> In the process of moving to a new cluster (RHEL7 based) I grabbed v0.90, compiled RPM's and re-ran the simple local-node memstore test I've run on .80 - .87.  It's a single Memstore OSD and a single Rados Bench client locally on the same node.  Increasing queue depth and measuring latency /IOPS.  So far, the measurements have been consistent across different hardware and code releases (with about a 30% improvement with the OpWQ Sharding changes that came in after Firefly).
>>>
>>> These are just very early results, but I'm seeing a very large improvement in latency and throughput with v90 on RHEL7.   Next  I'm working to get lttng installed and working in RHEL7 to determine where the improvement is.   On previous levels, these measurements have been roughly the same using a real (fast) backend (i.e. NVMe flash), and I will verify here as well.   Just wondering if anyone else has measured similar improvements?
>>>
>>>
>>> 100% Reads or Writes, 4K Objects, Rados Bench
>>>
>>> ========================
>>> V0.87: Ubuntu 14.04LTS
>>>
>>> *Writes*
>>> #Thr	IOPS	Latency(ms)
>>> 1	618.80		1.61
>>> 2	1401.70		1.42
>>> 4	3962.73		1.00
>>> 8	7354.37		1.10
>>> 16	7654.67		2.10
>>> 32	7320.33		4.37
>>> 64	7424.27		8.62
>>>
>>> *Reads*
>>> #thr	IOPS	Latency(ms)
>>> 1	837.57		1.19
>>> 2	1950.00		1.02
>>> 4	6494.03		0.61
>>> 8	7243.53		1.10
>>> 16	7473.73		2.14
>>> 32	7682.80		4.16
>>> 64	7727.10		8.28
>>>
>>>
>>> ========================
>>> V0.90:  RHEL7
>>>
>>> *Writes*
>>> #Thr	IOPS	Latency(ms)
>>> 1	2558.53		0.39
>>> 2	6014.67		0.33
>>> 4	10061.33	0.40
>>> 8	14169.60	0.56
>>> 16	14355.63	1.11
>>> 32	14150.30	2.26
>>> 64	15283.33	4.19
>>>
>>> *Reads*
>>> #Thr	IOPS	Latency(ms)
>>> 1	4535.63		0.22
>>> 2	9969.73		0.20
>>> 4	17049.43	0.23
>>> 8	19909.70	0.40
>>> 16	20320.80	0.79
>>> 32	19827.93	1.61
>>> 64	22371.17	2.86
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>

--------------070709040407010802080806
Content-Type: text/csv;
 name="ubuntu_vs_rhel7_sysctl.csv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ubuntu_vs_rhel7_sysctl.csv"

"Attribute", "ubuntu14.04", "rhel7",
"dev.cdrom.lock", "1", "0",
"dev.mac_hid.mouse_button2_keycode", "", "97",
"dev.mac_hid.mouse_button3_keycode", "", "100",
"dev.mac_hid.mouse_button_emulation", "", "0",
"dev.parport.default.spintime", "", "500",
"dev.parport.default.timeslice", "", "200",
"fs.binfmt_misc.status", "enabled", "",
"fs.dentry-state", "32974	0	45	0	0	0", "36429	0	45	0	0	0",
"fs.epoll.max_user_watches", "6735032", "6736384",
"fs.file-max", "3288305", "3269520",
"fs.file-nr", "1152	0	3288305", "928	0	3269520",
"fs.inode-nr", "26372	0", "30768	439",
"fs.inode-state", "26372	0	0	0	0	0	0", "30768	439	0	0	0	0	0",
"fs.nfs.nfs_congestion_kb", "", "183552",
"fs.nfs.nfs_mountpoint_timeout", "", "500",
"fs.quota.syncs", "578", "156",
"fscache.object_max_active", "", "12",
"fscache.operation_max_active", "", "6",
"kernel.auto_msgmni", "0", "1",
"kernel.blk_iopoll", "", "1",
"kernel.cap_last_cap", "37", "36",
"kernel.core_pattern", "/tmp/cbt/ceph/core.%e.%p.magna095.%t", "/tmp/cbt/ceph/core.%e.%p.magna038.%t",
"kernel.core_uses_pid", "1", "0",
"kernel.hostname", "magna095", "magna038",
"kernel.keys.persistent_keyring_expiry", "", "259200",
"kernel.keys.root_maxbytes", "25000000", "20000",
"kernel.keys.root_maxkeys", "1000000", "200",
"kernel.kptr_restrict", "0", "1",
"kernel.msgmni", "32000", "32768",
"kernel.ns_last_pid", "16372", "27058",
"kernel.numa_balancing_migrate_deferred", "", "16",
"kernel.numa_balancing_settle_count", "", "4",
"kernel.osrelease", "3.18.0-ceph-11305-g8260a4a", "3.13.0-37-generic",
"kernel.panic_on_warn", "0", "",
"kernel.perf_event_max_sample_rate", "50000", "25000",
"kernel.printk", "15	4	1	7", "7	4	1	7",
"kernel.prove_locking", "1", "",
"kernel.pty.nr", "1", "6",
"kernel.random.boot_id", "639e52d9-b28b-4fb3-a5f5-a4bae35fd70e", "6a391510-9d7a-4c81-b9ea-56b027ffb84f",
"kernel.random.entropy_avail", "855", "1179",
"kernel.random.uuid", "416f0246-3b7b-41de-bd99-cc9d9df2e407", "15065462-dd23-4d6a-a692-85befd46c6ac",
"kernel.sched_domain.cpu0.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu0.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu0.domain0.max_newidle_lb_cost", "1290", "",
"kernel.sched_domain.cpu0.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu0.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu0.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu0.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu0.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu0.domain1.max_newidle_lb_cost", "2496", "",
"kernel.sched_domain.cpu0.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu1.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu1.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu1.domain0.max_newidle_lb_cost", "12473", "",
"kernel.sched_domain.cpu1.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu1.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu1.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu1.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu1.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu1.domain1.max_newidle_lb_cost", "11413", "",
"kernel.sched_domain.cpu1.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu10.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu10.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu10.domain0.max_newidle_lb_cost", "4959", "",
"kernel.sched_domain.cpu10.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu10.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu10.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu10.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu10.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu10.domain1.max_newidle_lb_cost", "3940", "",
"kernel.sched_domain.cpu10.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu11.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu11.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu11.domain0.max_newidle_lb_cost", "1664", "",
"kernel.sched_domain.cpu11.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu11.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu11.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu11.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu11.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu11.domain1.max_newidle_lb_cost", "13069", "",
"kernel.sched_domain.cpu11.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu2.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu2.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu2.domain0.max_newidle_lb_cost", "2351", "",
"kernel.sched_domain.cpu2.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu2.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu2.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu2.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu2.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu2.domain1.max_newidle_lb_cost", "3835", "",
"kernel.sched_domain.cpu2.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu3.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu3.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu3.domain0.max_newidle_lb_cost", "1512", "",
"kernel.sched_domain.cpu3.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu3.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu3.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu3.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu3.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu3.domain1.max_newidle_lb_cost", "4388", "",
"kernel.sched_domain.cpu3.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu4.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu4.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu4.domain0.max_newidle_lb_cost", "1553", "",
"kernel.sched_domain.cpu4.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu4.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu4.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu4.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu4.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu4.domain1.max_newidle_lb_cost", "2772", "",
"kernel.sched_domain.cpu4.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu5.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu5.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu5.domain0.max_newidle_lb_cost", "9883", "",
"kernel.sched_domain.cpu5.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu5.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu5.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu5.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu5.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu5.domain1.max_newidle_lb_cost", "16125", "",
"kernel.sched_domain.cpu5.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu6.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu6.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu6.domain0.max_newidle_lb_cost", "3272", "",
"kernel.sched_domain.cpu6.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu6.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu6.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu6.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu6.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu6.domain1.max_newidle_lb_cost", "13899", "",
"kernel.sched_domain.cpu6.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu7.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu7.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu7.domain0.max_newidle_lb_cost", "1723", "",
"kernel.sched_domain.cpu7.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu7.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu7.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu7.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu7.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu7.domain1.max_newidle_lb_cost", "2655", "",
"kernel.sched_domain.cpu7.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu8.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu8.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu8.domain0.max_newidle_lb_cost", "5490", "",
"kernel.sched_domain.cpu8.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu8.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu8.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu8.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu8.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu8.domain1.max_newidle_lb_cost", "3843", "",
"kernel.sched_domain.cpu8.domain1.min_interval", "12", "1",
"kernel.sched_domain.cpu9.domain0.busy_factor", "32", "64",
"kernel.sched_domain.cpu9.domain0.max_interval", "4", "2",
"kernel.sched_domain.cpu9.domain0.max_newidle_lb_cost", "1204", "",
"kernel.sched_domain.cpu9.domain0.min_interval", "2", "1",
"kernel.sched_domain.cpu9.domain0.name", "SMT", "SIBLING",
"kernel.sched_domain.cpu9.domain1.busy_factor", "32", "64",
"kernel.sched_domain.cpu9.domain1.imbalance_pct", "117", "125",
"kernel.sched_domain.cpu9.domain1.max_interval", "24", "4",
"kernel.sched_domain.cpu9.domain1.max_newidle_lb_cost", "13307", "",
"kernel.sched_domain.cpu9.domain1.min_interval", "12", "1",
"kernel.sched_min_granularity_ns", "10000000", "3000000",
"kernel.sched_wakeup_granularity_ns", "15000000", "4000000",
"kernel.sem", "32000	1024000000	500	32000", "250	32000	32	128",
"kernel.shmall", "268435456", "2097152",
"kernel.shmmax", "4294967295", "33554432",
"kernel.softlockup_all_cpu_backtrace", "0", "",
"kernel.sysctl_writes_strict", "0", "",
"kernel.sysrq", "16", "1",
"kernel.tainted", "512", "0",
"kernel.threads-max", "256921", "513945",
"kernel.tracepoint_printk", "0", "",
"kernel.usermodehelper.bset", "4294967295	63", "4294967295	31",
"kernel.usermodehelper.inheritable", "4294967295	63", "4294967295	31",
"kernel.version", "#1 SMP Tue Jan 13 22:34:21 EST 2015", "#64~precise1-Ubuntu SMP Wed Sep 24 21:37:11 UTC 2014",
"net.core.netdev_rss_key", "23:d8:48:f9:3c:7c:4a:e7:93:6b:88:fc:3c:45:dc:2e:51:ed:ed:c3:71:f1:59:59:d3:e8:c0:1d:29:40:19:37:d4:01:4f:28:bd:dd:c1:2f:6d:fe:65:48:1e:3a:14:24:91:22:3c:ca", "",
"net.core.warnings", "0", "1",
"net.ipv4.conf.all.rp_filter", "0", "1",
"net.ipv4.conf.default.accept_source_route", "0", "1",
"net.ipv4.conf.eth0.accept_source_route", "0", "1",
"net.ipv4.conf.eth1.accept_source_route", "0", "1",
"net.ipv4.conf.lo.rp_filter", "0", "1",
"net.ipv4.fwmark_reflect", "0", "",
"net.ipv4.icmp_msgs_burst", "50", "",
"net.ipv4.icmp_msgs_per_sec", "1000", "",
"net.ipv4.igmp_qrv", "2", "",
"net.ipv4.ip_forward_use_pmtu", "0", "",
"net.ipv4.ipfrag_secret_interval", "0", "600",
"net.ipv4.neigh.default.base_reachable_time", "", "30",
"net.ipv4.neigh.default.retrans_time", "", "100",
"net.ipv4.neigh.eth0.base_reachable_time", "", "30",
"net.ipv4.neigh.eth0.retrans_time", "", "100",
"net.ipv4.neigh.eth1.base_reachable_time", "", "30",
"net.ipv4.neigh.eth1.retrans_time", "", "100",
"net.ipv4.neigh.lo.base_reachable_time", "", "30",
"net.ipv4.neigh.lo.retrans_time", "", "100",
"net.ipv4.tcp_autocorking", "1", "",
"net.ipv4.tcp_fwmark_accept", "0", "",
"net.ipv4.tcp_max_reordering", "300", "",
"net.ipv4.tcp_mem", "768387	1024517	1536774", "770916	1027891	1541832",
"net.ipv4.udp_mem", "768387	1024517	1536774", "770916	1027891	1541832",
"net.ipv6.anycast_src_echo_reply", "0", "",
"net.ipv6.auto_flowlabels", "0", "",
"net.ipv6.conf.all.accept_ra_from_local", "0", "",
"net.ipv6.conf.all.use_tempaddr", "0", "2",
"net.ipv6.conf.default.accept_ra_from_local", "0", "",
"net.ipv6.conf.default.use_tempaddr", "0", "2",
"net.ipv6.conf.eth0.accept_ra_from_local", "0", "",
"net.ipv6.conf.eth0.use_tempaddr", "0", "2",
"net.ipv6.conf.eth1.accept_ra_defrtr", "0", "1",
"net.ipv6.conf.eth1.accept_ra_from_local", "0", "",
"net.ipv6.conf.eth1.accept_ra_pinfo", "0", "1",
"net.ipv6.conf.eth1.accept_ra_rtr_pref", "0", "1",
"net.ipv6.conf.eth1.disable_ipv6", "1", "0",
"net.ipv6.conf.eth1.use_tempaddr", "0", "2",
"net.ipv6.conf.lo.accept_ra_from_local", "0", "",
"net.ipv6.conf.lo.use_tempaddr", "-1", "2",
"net.ipv6.flowlabel_consistency", "1", "",
"net.ipv6.fwmark_reflect", "0", "",
"net.ipv6.ip6frag_secret_interval", "0", "600",
"net.ipv6.mld_qrv", "2", "",
"net.ipv6.neigh.default.base_reachable_time", "", "30",
"net.ipv6.neigh.default.retrans_time", "", "250",
"net.ipv6.neigh.eth0.base_reachable_time", "", "30",
"net.ipv6.neigh.eth0.retrans_time", "", "250",
"net.ipv6.neigh.eth1.base_reachable_time", "", "30",
"net.ipv6.neigh.eth1.retrans_time", "", "250",
"net.ipv6.neigh.lo.base_reachable_time", "", "30",
"net.ipv6.neigh.lo.retrans_time", "", "250",
"net.iw_cm.default_backlog", "", "256",
"vm.dirty_ratio", "30", "20",
"vm.overcommit_kbytes", "0", "",
"vm.scan_unevictable_pages", "", "0",
"vm.swappiness", "30", "60",

--------------070709040407010802080806--
