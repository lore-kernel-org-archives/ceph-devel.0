From: Sage Weil <sage@inktank.com>
Subject: bobtail-deploy
Date: Fri, 26 Apr 2013 13:46:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304261341300.13630@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33872 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3DZUqF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 16:46:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tamil.muthamizhan@inktank.com, alexandre.marangone@inktank.com
Cc: ceph-devel@vger.kernel.org

I merged in the bobtail-dc branch (which had a pile of ceph-disk-* 
backports for ceph-deploy and chef) and backported all of the more recent 
ceph-disk changes.  The result is pushed to bobtail-deploy.

I suspect we aren't as concerned about making this work ceph-deploy/chef 
on el6 distros, but it would be nice for others to be eable to use 
ceph-deploy to build a bobtail cluster (not just cuttlefish).

Making sure these backports also work with current chef users will also 
give us better confidence that their bobtail->cuttlefish upgrade will be 
problem-free.

If there is anyone else out there using chef or ceph-deploy and the new 
ceph-disk-* tools on bobtail, please take a look!

sage

