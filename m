From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: What would a good OSD node hardware configuration look like?
Date: Mon, 05 Nov 2012 18:13:33 +0100
Message-ID: <5097F3BD.2000904@conversis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:38284 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab2KERjq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 12:39:46 -0500
Received: from nexus.conversis.de (p5DCF725E.dip.t-dialin.net [93.207.114.94])
	by mail4.conversis.de (Postfix) with ESMTP id 1C2944C80020
	for <ceph-devel@vger.kernel.org>; Mon,  5 Nov 2012 18:13:34 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I'm thinking about building a ceph cluster and I'm wondering what a good
configuration would look like for 4-8 (and maybe more) 2HU 8-disk or 3HU
16-disk systems.
Would it make sense to make each disk an individual OSD or should I perhaps
create several raid-0 and create OSDs from those?
Also what is the best setup for the journal? If I understand it correctly
then each OSD needs its own journal and that should be a separate disk but
that would be quite wasteful it seems. Would it make sense to put in two
small SSD disks in a raid-1 configuration and create a filesystem for each
OSD journal on it?
How does the number of OSDs/Nodes affect the performance of say a single dd
operation? Will blocks be distributed over the cluster and written/read in
parallel or does the number only improve concurrency rather than benefit
single threaded workloads?

Regards,
  Dennis
