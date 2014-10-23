From: "Zhang, Jian" <jian.zhang@intel.com>
Subject: RE: 10/22/2014 Weekly Ceph Performance Meeting
Date: Thu, 23 Oct 2014 07:37:01 +0000
Message-ID: <51FC7A40FB29414D88A121A7FFEF9A4710F9B0AC@SHSMSX104.ccr.corp.intel.com>
References: <5447BD83.8000303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53194 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbaJWHiv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 03:38:51 -0400
In-Reply-To: <5447BD83.8000303@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, "Duan, Jiangang" <jiangang.duan@intel.com>

Hi all, 
Regarding on the cache tiering performance topic discussed on yesterday's meeting: 
  - Need to test performance with commit to avoid promotion on first read:
            https://github.com/ceph/ceph/commit/79d1aff1821bc9f21477636df4d0d4e57f2cd008
Zhiqiang actually did some tests based on https://github.com/ceph/ceph/commit/0ed3adc1e0a74bf9548d1d956aece11f019afee0 . 
We actually observed with Promote on 2nd read,  we can get up to 2x IOPS improvement, (although still far below expectation), and 66% improvement on latency on the following test configuration. 

Test configuration: 
* Hardware: 
2 OSD nodes with 10G Nic, each with 8x 1T HDD and 6x 400G DC3700 SSD, 2 SSDs used for Journal, while 4 SSD used for cache tiering. 
* Cache Tiering Setting: 
Cache size: 1000G (target_max_bytes: 1000000000000); Dirty ratio: 20% (cache_target_dirty_ratio: 0.2); Full ratio: 20% (cache_target_full_ratio: 0.2)
* Benchmark:
Fio 4K random Read/write/Mixed tests. 
* Results:
Without cache tiering, the performance for 4K random read is: 1021, with latency ~3000ms (QD=256). 
With cache tiering, the performance for 4K random read is: 359, with latency ~6000ms.
With cache tiering + promote on second read, 4K random read performance is: ~800, with latency ~1500ms. 

We can share the data either during CDS https://wiki.ceph.com/Planning/Blueprints/Hammer/osd%3A_tiering%3A_fine-grained_promotion_unit  or next weekly performance meeting. 

Thanks
Jian


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
Sent: Wednesday, October 22, 2014 10:22 PM
To: ceph-devel@vger.kernel.org
Subject: 10/22/2014 Weekly Ceph Performance Meeting

Hi All,

Meeting is on at 8AM PST as usual!  Here's the links:

Etherpad URL:
http://pad.ceph.com/p/performance_weekly

To join the Meeting:
https://bluejeans.com/268261044

To join via Browser:
https://bluejeans.com/268261044/browser

To join with Lync:
https://bluejeans.com/268261044/lync


To join via Room System:
Video Conferencing System: bjn.vc -or- 199.48.152.152 Meeting ID: 268261044

To join via Phone:
1) Dial:
           +1 408 740 7256
           +1 888 240 2560(US Toll Free)
           +1 408 317 9253(Alternate Number)
           (see all numbers - http://bluejeans.com/numbers)
2) Enter Conference ID: 268261044

Mark
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
