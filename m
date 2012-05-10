From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Designing a cluster guide
Date: Thu, 10 May 2012 15:23:40 +0200
Message-ID: <4FABC15C.3030500@profihost.ag>
References: <4FABAFE9.5060202@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40525 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab2EJNXl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 09:23:41 -0400
In-Reply-To: <4FABAFE9.5060202@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

the "Designing a cluster guide"
http://wiki.ceph.com/wiki/Designing_a_cluster is pretty good but it
still leaves some questions unanswered.

It mentions for example "Fast CPU" for the mds system. What does fast
mean? Just the speed of one core? Or is ceph designed to use multi core?
Is multi core or more speed important?

The Cluster Design Recommendations mentions to seperate all Daemons on
dedicated machines. Is this also for the MON useful? As they're so
leightweight why not running them on the OSDs?

Regarding the OSDs is it fine to use an SSD Raid 1 for the journal and
perhaps 22x SATA Disks in a Raid 10 for the FS or is this quite absurd
and you should go for 22x SSD Disks in a Raid 6?  Is it more useful the
use a Raid 6 HW Controller or the btrfs raid?

Use single socket Xeon for the OSDs or Dual Socket?

Thanks and greets
Stefan
