From: Sage Weil <sage@newdream.net>
Subject: wip-systemd
Date: Thu, 18 Jun 2015 17:10:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506181653300.15981@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbbFSALA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Jun 2015 20:11:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: osynge@suse.com, ceph-devel@vger.kernel.org

Hey Owen,

I suggest we create a wip-systemd branch where we pile in all of the fixes 
around getting systemd working properly.  Right now we're super 
conservative about merging into master to avoid breaking things but it'll 
be easier to test everything all at once and it'll help me get packages 
prepared that I can play with on this end.

What do you think?

The other pile is wip-user... I'm inclined to get systemd going 
first before adding this complexity, though!

sage

