From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: throttles
Date: Mon, 12 Oct 2015 23:32:03 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F317408FA@SACMBXIP02.sdcorp.global.sandisk.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0074.outbound.protection.outlook.com ([207.46.100.74]:58794
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752076AbbJLXcL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 19:32:11 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

<<inline

Thanks & Regards
Somnath
-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Deneau, Tom
Sent: Monday, October 12, 2015 4:09 PM
To: ceph-devel@vger.kernel.org
Subject: throttles

Looking at the perf counters on my osds, I see wait counts for the following throttle related perf counters:  (This is from trying to benchmark using multiple rados bench client processes).

   throttle-filestore_bytes
[Somnath] journal_queue_max_bytes

   throttle-msgr_dispatch_throttler-client
[Somnath] ms_dispatch_throttle_bytes

   throttle-osd_client_bytes
[Somnath] osd_client_message_size_cap

   throttle-osd_client_messages
[Somnath] osd_client_message_cap

What are the config variables that would allow me to experiment with these throttle limits?
(When I look at the output from --admin-daemon osd.xx.asok config show, it's not clear which items these correspond to).

-- Tom Deneau


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

