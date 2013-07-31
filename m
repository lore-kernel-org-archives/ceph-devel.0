From: Luke Jing Yuan <jyluke@mimos.my>
Subject: Problem with MON after reboot
Date: Wed, 31 Jul 2013 10:25:36 +0000
Message-ID: <E0E280CCE0E1A44898C992A9190D929A4F9C9D@MBX02-TPM.mimos.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hydrobot.mimos.my ([192.228.138.101]:63697 "HELO
	hydrobot.mimos.my" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756143Ab3GaKgk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 06:36:40 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear all,

I am having an issue with MON after reboot, I had originally 3 MONs but after rebooting one of them, the quorum cannot be established. Digging through the log of the problematic MON, I found the following messages:

2013-07-31 18:04:18.536331 7f4f41bfd700  0 -- 10.4.132.18:6804/0 >> 10.4.131.21:6800/0 pipe(0x305da00 sd=28 :41077 s=1 pgs=0 cs=0 l=0).failed verifying authorize reply
2013-07-31 18:04:20.536270 7f4f48b3e700  0 cephx: verify_reply coudln't decrypt with error: error decoding block for decryption
2013-07-31 18:04:20.536276 7f4f48b3e700  0 -- 10.4.132.18:6804/0 >> 10.4.120.21:6789/0 pipe(0x305dc80 sd=27 :38003 s=1 pgs=0 cs=0 l=0).failed verifying authorize reply
2013-07-31 18:04:20.536302 7f4f41bfd700  0 cephx: verify_reply coudln't decrypt with error: error decoding block for decryption

Wonder if someone can shed some light on the issue and how to solve this problem. Thanks.

Regards,
Luke
