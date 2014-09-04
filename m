From: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Subject: ms_tcp_nodelay no effect on kernel-rbd
Date: Thu, 4 Sep 2014 11:39:38 +0000
Message-ID: <9E914F5BD7F48A4782456CEB550A4228061207A0@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0063.outbound.protection.outlook.com ([157.56.111.63]:27419
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750981AbaIDNNx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Sep 2014 09:13:53 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

In our benchmarking tests we observed that the ms_tcp_nodelay in ceph.conf option is not affecting the kernel rbd and as expected we see poor latency numbers for lower queue depths and 4K rand reads. There is significant increase in latency from qd=2  to 24 and starts tapering down for higher queue depths.
We did not find relevant kernel_setsockopt  with TCP_NODELAY in the kernel RBD/libceph (messenger.c) source. Unless we are missing something, looks like currently the kernel RBD is not setting this and this is affecting latency numbers are lower queue depths.

I have tested with userspace fio(rbd engine) and rados bench and we see similar latency behavior when ms_tcp_nodelay is set to false. However setting this to true gives consistent low latency numbers for all queue depths

Any ideas/thoughts on this?

OS Ubuntu 14.04
Kernel: 3.13.0-24-generic #46-Ubuntu SMP
Ceph: Latest Master

Regards,
Chaitanya




________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

