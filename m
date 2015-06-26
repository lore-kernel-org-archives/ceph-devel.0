From: "Erik G. Burrows" <erik@erikburrows.com>
Subject: CRC32 of messages
Date: Fri, 26 Jun 2015 09:49:04 -0700 (PDT)
Message-ID: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wsip-98-189-215-218.oc.oc.cox.net ([98.189.215.218]:50725 "EHLO
	two.erikburrows.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751900AbbFZQ4h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jun 2015 12:56:37 -0400
Received: from www.erikburrows.com (localhost [127.0.0.1])
	by two.erikburrows.com (Postfix) with ESMTP id BD8D81A2B40
	for <ceph-devel@vger.kernel.org>; Fri, 26 Jun 2015 09:49:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All,
Can someone explain to me the rationale for performing in-software CRC32
hashes of all messages through the Pipe and AsyncMessage classes?

On my servers, operf shows that 20% of the total CPU time in my benchmark
tests are being spent in the librados ceph_crc32c_sctp function. I can see
that the library is trying to use CPU accelerations if available, but what
I'd like to understand is: why checksum the messages at all?

If the messages are local, there should not be any corruption at all, and
if they are coming in over IP, then the kernel and NIC should do Layer-2/3
CRCs and reject any corrupted packets. So why re-CRC the messages at the
Ceph layer?

Thanks,
  Erik Burrows


