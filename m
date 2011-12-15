From: Sage Weil <sage@newdream.net>
Subject: Re: Perf counters assert error
Date: Wed, 14 Dec 2011 17:48:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112141747460.12793@cobra.newdream.net>
References: <138631751.2978.1323906826560.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39581 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab1LOBsG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 20:48:06 -0500
In-Reply-To: <138631751.2978.1323906826560.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Noah,

I just pushed a fix for this.  Please let me know if that doesn't sort it 
out for you!

sage


On Wed, 14 Dec 2011, Noah Watkins wrote:

> I got this assertion with the latest master.
> 
> Thanks,
> Noah
> 
> nwatkins@piha:~$ hadoop fs -ls
> 11/12/14 15:51:57 INFO ceph.CephFileSystem: initialize:Ceph initialization arguments: CephFSInterface --log-file /tmp/client.log --debug_client 20 --debug_ms 20 -m 192.168.141.123:6789 --client-readahead-max-periods=1
> common/perf_counters.cc: In function 'void PerfCountersCollection::remove(PerfCounters*)', in thread '7f82d022b700'
> common/perf_counters.cc: 52: FAILED assert(i != m_loggers.end())
>  ceph version 0.39-124-g1430c8a (commit:1430c8abaa37ee8ae4795907773b9b350fc5189a)
>  1: (PerfCountersCollection::remove(PerfCounters*)+0x222) [0x7f8285e67062]
>  2: (Client::shutdown()+0x215) [0x7f8285d1ca75]
>  3: (ceph_mount()+0x11c) [0x7f8285d151ec]
>  4: (Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1initializeClient()+0x39d) [0x7f8284cb57bd]
>  5: [0x7f82cc29bc88]
>  ceph version 0.39-124-g1430c8a (commit:1430c8abaa37ee8ae4795907773b9b350fc5189a)
>  1: (PerfCountersCollection::remove(PerfCounters*)+0x222) [0x7f8285e67062]
>  2: (Client::shutdown()+0x215) [0x7f8285d1ca75]
>  3: (ceph_mount()+0x11c) [0x7f8285d151ec]
>  4: (Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1initializeClient()+0x39d) [0x7f8284cb57bd]
>  5: [0x7f82cc29bc88]
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> Aborted
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
