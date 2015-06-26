From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: CRC32 of messages
Date: Fri, 26 Jun 2015 17:51:45 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDAE1C3@SACMBXIP01.sdcorp.global.sandisk.com>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0057.outbound.protection.outlook.com ([207.46.100.57]:29440
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752337AbbFZSKB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jun 2015 14:10:01 -0400
In-Reply-To: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Erik G. Burrows" <erik@erikburrows.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

ceph_crc32c_intel_fast is ~6 times faster than ceph_crc32c_sctp. If you are not using intel cpus or you have older intel cpus where this sse4 instruction sets are not enabled , the performance will be badly impacted as you saw. If you are building ceph yourself, make sure you have 'yasm' installed to enable ceph to detect the cpu architecture properly. BTW, hope you are aware that this crc calculation can be turned off by 'ms_nocrc = true' with giant and 'ms_crc_data = false' / 'ms_crc_header = false' post giant.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Erik G. Burrows
Sent: Friday, June 26, 2015 9:49 AM
To: ceph-devel@vger.kernel.org
Subject: CRC32 of messages

All,
Can someone explain to me the rationale for performing in-software CRC32 hashes of all messages through the Pipe and AsyncMessage classes?

On my servers, operf shows that 20% of the total CPU time in my benchmark tests are being spent in the librados ceph_crc32c_sctp function. I can see that the library is trying to use CPU accelerations if available, but what I'd like to understand is: why checksum the messages at all?

If the messages are local, there should not be any corruption at all, and if they are coming in over IP, then the kernel and NIC should do Layer-2/3 CRCs and reject any corrupted packets. So why re-CRC the messages at the Ceph layer?

Thanks,
  Erik Burrows


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

