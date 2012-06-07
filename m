From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 07 Jun 2012 20:37:49 +0200
Message-ID: <3039502.NLSCFOhhFU@pc10>
References: <21601270.dfB0BsVfyn@pc10> <47203FB1-758C-46E9-A49A-6F9896B663DC@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart5424442.xxeI8DM9ba"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:35706 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228Ab2FGShy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jun 2012 14:37:54 -0400
In-Reply-To: <47203FB1-758C-46E9-A49A-6F9896B663DC@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--nextPart5424442.xxeI8DM9ba
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 7. Juni 2012, 20:18:52 schrieb Stefan Priebe:
> I think the test script would help a lot so others can test too.

Okay, I've attached the program. It's barely 2 KB. You need Boost 1.45+, CMake 
2.6+ and Crypto++ to compile it.

Warning: This will fill up your harddisk completely, which is not a good idea 
on in-production machines.

	Guido
--nextPart5424442.xxeI8DM9ba
Content-Disposition: attachment; filename="iotester.tgz"
Content-Transfer-Encoding: base64
Content-Type: application/x-compressed-tar; name="iotester.tgz"

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

--nextPart5424442.xxeI8DM9ba--

