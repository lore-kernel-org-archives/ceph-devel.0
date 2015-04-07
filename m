From: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Subject: RGW rados handles
Date: Tue, 7 Apr 2015 14:03:37 +0000
Message-ID: <68A06213B74F1742A2C48216AE1BB6B8087B4697@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0065.outbound.protection.outlook.com ([65.55.169.65]:3344
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755681AbbDGOS1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 10:18:27 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: "yehuda@redhat.com" <yehuda@redhat.com>

Hi,

As part of characterizing RGW read performance, have observed that there is a single RADOS connection that is consumed by so many RGW worker threads, resulting in some amount of serialization at that level. Making the RADOS handles multiple, and shared across the worker threads in a RR fashion, have yielded a factor of ~50% improvement (for read requests) in throughput and with much better response times on my setup (will share the configuration and results in due course).

Wanted to understand if there is a constraint in having single RADOS instance per RGW, that could otherwise be a configurable option, for which I have a PR in pipeline.

Thanks,
-Pavan.

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

