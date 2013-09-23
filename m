From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Object Write Latency
Date: Mon, 23 Sep 2013 15:38:58 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A52736BE@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
 <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net>,<CABZ+qqnXbycX4C_brF4eiRVb0PeA4SKf2kW_d3g8RYxwD6xFDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:51173 "EHLO
	CERNMX30.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3IWPjC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 11:39:02 -0400
In-Reply-To: <CABZ+qqnXbycX4C_brF4eiRVb0PeA4SKf2kW_d3g8RYxwD6xFDg@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>, Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We deployed 3 OSDs with an EXT4 using RapidDisk in-memory.

The FS does 140k/s append+sync and the latency is now:

~1 ms for few byte objects with single replica
~2 ms for few byte objects three replica  (instead of 65-80ms)

This gives probably the base-line of the best you can do with the current implementation.

==> the 80ms are probably just a 'feature' of the hardware (JBOD disks/controller) and we might try to find some tuning parameters to improve the latency slightly.

Could you just explain how the async api functions (is_complete, is_safe) map to the three states 

1) object is transferred from client to all OSDs and is present in memory there
2) object is written to the OSD journal
3) object is committed from OSD journal to the OSD filesystem

Is it correct that the object is visible by clients only when 3) has happened? 

Thanks for your help, 
Andreas.




