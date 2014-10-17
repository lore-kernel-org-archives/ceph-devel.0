From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: The Async messenger benchmark with latest master
Date: Fri, 17 Oct 2014 20:37:55 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282298FF@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0080.outbound.protection.outlook.com ([157.56.111.80]:6512
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750765AbaJQUjw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Oct 2014 16:39:52 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage/Haomai,

I did some 4K Random Read benchmarking with latest master having Async messenger changes and result looks promising.

My configuration:
---------------------

1 node, 8 SSDs, 8OSDs, 3 pools , each has 3 images. ~2000 Pg cluster wide
Cpu : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz, dual socket, HT enabled, 40 cores.
Used krbd as client.


1 clinet node with 3 rbd images on 3 different pools:
-------------------------------------------------------------------
Master :
---------

~203k IOPS, ~90% latencies within 4msec, total read : ~5.2TB

    lat (usec) : 4=0.01%, 10=0.01%, 50=0.01%, 100=0.01%, 250=0.03%
    lat (usec) : 500=0.86%, 750=3.72%, 1000=7.19%
    lat (msec) : 2=39.17%, 4=41.45%, 10=7.26%, 20=0.24%, 50=0.06%
    lat (msec) : 100=0.03%, 250=0.01%, 500=0.01%

cpu: ~1-2 % idle

Giant:
------

~196k IOPS, ~89-90% latencies within 4msec, total read : ~5.3TB

    lat (usec) : 250=0.01%, 500=0.51%, 750=2.71%, 1000=6.03%
    lat (msec) : 2=34.32%, 4=45.74%, 10=10.46%, 20=0.21%, 50=0.02%
    lat (msec) : 100=0.01%, 250=0.01%

cpu: ~2% idle

2 clients with 3 rbd images each on 3 different pools:
-------------------------------------------------------------------

Master :
---------

~207K iops, ~70% latencies within 4msec, Total read: ~5.99 TB

    lat (usec) : 250=0.03%, 500=0.63%, 750=2.67%, 1000=5.21%
    lat (msec) : 2=25.12%, 4=36.19%, 10=24.80%, 20=3.16%, 50=1.34%
    lat (msec) : 100=0.66%, 250=0.18%, 500=0.01%

cpu: ~0-1 % idle

Giant:
--------
~199K iops, ~64% latencies within 4msec, Total read: ~5.94 TB

    lat (usec) : 250=0.01%, 500=0.25%, 750=1.47%, 1000=3.45%
    lat (msec) : 2=21.22%, 4=36.69%, 10=30.63%, 20=4.28%, 50=1.70%
    lat (msec) : 100=0.28%, 250=0.02%, 500=0.01%

cpu: ~1% idle


So, in summary the master with Async messenger has improved both in iops and latency.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

