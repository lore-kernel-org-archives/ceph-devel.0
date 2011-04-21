From: Zenon Panoussis <oracle@provocation.net>
Subject: Scrubbing
Date: Thu, 21 Apr 2011 17:56:52 +0200
Message-ID: <4DB053C4.2020704@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:41389 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1DUP45 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 11:56:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

Two OSDs, 264 pgs on each. This is killing the OSD:

2011-04-21 17:49:52.673431    pg v102789: 528 pgs: 299 active+clean, 229 active+clean+scrubbing; 5675 MB data, 26696 MB used, 395 GB / 446 GB avail

Is there some way to tell it to favour serial scrubbing over
parallel?

Z


