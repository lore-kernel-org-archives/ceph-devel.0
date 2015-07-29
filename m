From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Ceph write path optimization
Date: Wed, 29 Jul 2015 16:00:23 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDE9DFC@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDE784B@SACMBXIP01.sdcorp.global.sandisk.com>
 <75674D092A819E4189E91166C74CB90D01590D19@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0074.outbound.protection.outlook.com ([207.46.100.74]:15573
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753452AbbG2QAd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 12:00:33 -0400
In-Reply-To: <75674D092A819E4189E91166C74CB90D01590D19@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Xinxin,
I tried that but if you remove all the throttling the performance is very spiky and not usable. The peak performance is definitely more though.
I tried to do throttling based on the existing options and I was able to make constant stable performance out but that performance is low (or similar to existing one today).

Thanks & Regards
Somnath

-----Original Message-----
From: Shu, Xinxin [mailto:xinxin.shu@intel.com] 
Sent: Wednesday, July 29, 2015 12:50 AM
To: Somnath Roy; ceph-devel@vger.kernel.org
Subject: RE: Ceph write path optimization

Hi Somnath,  any performance data for journal on 128M NVRAM partition with hammer release?

Cheers,
xinxin

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Wednesday, July 29, 2015 5:08 AM
To: ceph-devel@vger.kernel.org
Subject: Ceph write path optimization

Hi,
Eventually, I have a working prototype and able to gather some performance comparison data with the changes I was talking about in the last performance meeting. Mark's suggestion of a write up was long pending, so, trying to summarize what I am trying to do.

Objective:
-----------

1. Is to saturate SSD write bandwidth with ceph + filestore.
     Most of the deployment of ceph + all flash so far (as far as I know) is having both data and journal on the same SSD. SSDs are far from saturate and the write performance of ceph is dismal (compare to HW). Can we improve that ?

2. Ceph write performance in most of the cases are not stable, can we have a stable performance out most of the time ?


Findings/Optimization so far..
------------------------------------

1. I saw in flash environment you need to reduce the filestore_max_sync_interval a lot (from default 5min) and thus the benefit of syncfs coalescing and writing is going away.

2. We have some logic to determine the max sequence number it can commit. That is adding some latency (>1 ms or so).

3. This delay is filling up journals quickly if I remove all throttles from the filestore/journal.

4. Existing throttle scheme is very difficult to tune.

5. In case of write-ahead journaling the commit file is probably redundant as we can get the last committed seq number from journal headers during next OSD start. The fact that, the sync interval we need to reduce , this extra write will only add more to WA (also one extra fsync).

The existing scheme is well suited for HDD environment, but, probably not for flash. So, I made the following changes.

1. First, I removed the extra commit seq file write and changed the journal replay stuff accordingly.

2. Each filestore Op threads is now doing O_DSYNC write followed by posix_fadvise(**fd, 0, 0, POSIX_FADV_DONTNEED);

3. I derived an algorithm that each worker thread is executing to determine the max seq it can trim the journal to.

4. Introduced a new throttle scheme that will throttle journal write based on the % space left.

5. I saw that this scheme is definitely emptying up the journal faster and able to saturate the SSD more.

6. But, even if we are not saturating any resources, if we are having both data and journal on the same drive, both writes are suffering latencies.

7. Separating out journal to different disk , the same code (and also stock)  is running faster. Not sure about the exact reason, but, something to do with underlying layer. Still investigating.

8. Now, if we want to separate out journal, SSD is *not an option*. The reason is, after some point we will be limited by SSD BW and all writes for N osds going to that SSD will wear out that SSD very fast. Also, this will be a very expensive solution considering high end journal SSD.

9. So, I started experimenting with small PCIe NVRAM partition (128 MB). So, If we have ~4GB NVRAM we can put ~32 OSDs in that(considering NVRAM durability is much higher).  The stock code as is (without throttle), the performance is becoming very spiky for obvious reason.

10. But, with the above mentioned changes, I am able to make a constant high performance out most of the time.

11. I am also trying the existing synfs codebase (without op_seq file) + the throttle scheme I mentioned in this setup to see if we can get out a stable improve performance out or not. This is still under investigation.

12. Initial benchmark with single OSD (no replication) looks promising and you can find the draft here.

       https://docs.google.com/document/d/1QYAWkBNVfSXhWbLW6nTLx81a9LpWACsGjWG8bkNwKY8/edit?usp=sharing

13. I still need to try this out by increasing number of OSDs.

14. Also, need to see how this scheme is helping both data/journal on the same SSD.

15. The main challenge I am facing in both the scheme is XFS metadata flush process (xfsaild) is choking all the processes accessing the disk when it is waking up. I can delay it till max 30 sec and if there are lot of dirty metadata, there is a performance spike down for very brief amount of time. Even if we are acknowledging writes from say NVRAM journal write, still the opthreads are doing getattrs on the XFS and those threads are getting blocked. I tried with ext4 and this problem is not there since it is writing metadata synchronously by default, but, the overall performance of ext4 is much less. I am not an expert on filesystem, so, any help on this is much appreciated.

Mark,
If we have time, we can discuss this result in tomorrow's performance meeting.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
