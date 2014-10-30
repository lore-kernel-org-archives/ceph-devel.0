From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Debug messages of osd_ping and ping_reply
Date: Thu, 30 Oct 2014 08:26:35 +0000
Message-ID: <C226B0AB34511445928D9882AA519F6009AD6940@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0054.outbound.protection.outlook.com ([207.46.100.54]:40855
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758162AbaJ3I0i convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 04:26:38 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

We have a test cluster with ~500 OSD's. This cluster has multiple rbd images mapped to multiple client machines. But from past two days, only one rbd image was serving the IO's rest of the images were not used.
We are running the cluster with debug 1/1 for most of the sub modules. But the logs of OSD's are filled with the following messages.
----------------
2014-10-30 12:11:52.430542 7ff431032700  1 -- 10.242.42.172:6919/2601499 --> 10.242.42.178:0/44638 -- osd_ping(ping_reply e24581 stamp 2014-10-30 12:12:54.457189) v2 -- ?+0 0x77b32a0 con 0x1c3563c0
2014-10-30 12:11:52.430613 7ff42f82f700  1 -- 10.242.42.172:6915/2601499 <== osd.462 10.242.42.178:0/44638 337603 ==== osd_ping(ping e24581 stamp 2014-10-30 12:12:54.457189) v2 ==== 47+0+0 (2159846856 0 0) 0x27020ee0 con 0x1949db20
2014-10-30 12:11:52.430669 7ff42f82f700  1 -- 10.242.42.172:6915/2601499 --> 10.242.42.178:0/44638 -- osd_ping(ping_reply e24581 stamp 2014-10-30 12:12:54.457189) v2 -- ?+0 0x1d61ef00 con 0x1949db20
---------------

Looking at the code, these messages are coming from DispatchQueue::pre_dispatch and SimpleMessenger::_send_message. And these messages are at debug level 1 for debug_ms and approximately 200MB-400MB is occupied for these messages from each osd log.

Is there any reason these messages are present at level 1?  Can we move to debug level 5 or above?

Thanks,
Varada



________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

