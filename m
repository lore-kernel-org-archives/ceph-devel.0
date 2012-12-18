From: Rutger ter Borg <rutger@terborg.net>
Subject: Rados consistency model
Date: Tue, 18 Dec 2012 09:51:03 +0100
Message-ID: <kapapl$ud5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54834 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab2LRIvP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Dec 2012 03:51:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Tksta-0002Pd-FA
	for ceph-devel@vger.kernel.org; Tue, 18 Dec 2012 09:51:26 +0100
Received: from gl-95017.prolocation.net ([62.204.95.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 09:51:26 +0100
Received: from rutger by gl-95017.prolocation.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 09:51:26 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Dear list,

I have a question regarding concurrency guarantees of Rados. Suppose I 
have two nodes, say A and B, both running a process, and both using the 
same rados storage pool, maybe connected through different OSDs. Suppose 
node A updates an object in the storage pool, and after completion 
immediately notifies B (through its own messaging layer) that that 
specific object has been updated. Then, can I assume that, if B re-reads 
that object, it will always get the updated one? If not, what would be 
the recommended way of notifying B?

IOW, what kind of consistency model should I assume?

Thanks,

Rutger


