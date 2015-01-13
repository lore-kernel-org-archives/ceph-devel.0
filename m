From: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Subject: Cache pool latency impact
Date: Tue, 13 Jan 2015 11:03:43 +0000
Message-ID: <68A06213B74F1742A2C48216AE1BB6B808720E8A@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0074.outbound.protection.outlook.com ([65.55.169.74]:23424
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751569AbbAMLS1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 06:18:27 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

This is regarding cache pools and the impact of the flush/evict on the client IO latencies.

Am seeing a direct impact on the client IO latencies (making them worse) when flush/evict is triggered on the cache pool. In a constant ingress of IOs on the cache pool, the write performance is no better than without cache pool, because it is limited to the speed at which objects can be flushed/evicted to the backend pool.

The questions I have are:

1) When the flush/evict is in progress, are the writes on the cache pool blocked, either at the PG or at object granularity? Though I see a blocking flag honored per object context in ReplicatedPG::start_flush() and most of the callers seem to set the flag to be false.

2) Is there any mechanism (that I might have overlooked) to avoid this situation, by throttling the flush/evict operations on the fly? If not, shouldn't there be one?

Thanks,
-Pavan.

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

