From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: HSM
Date: Mon, 11 Nov 2013 10:50:47 +0100
Message-ID: <1384163447.6296.33.camel@sebmain.cern.ch>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx12.cern.ch ([188.184.36.48]:31393 "EHLO CERNMX12.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab3KKKAW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Nov 2013 05:00:22 -0500
In-Reply-To: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

It may be even more lightweight than that depending on the Mass Storage
system intrinsic capabilities.

Here at CERN, we are testing the use of ceph in the disk cache in our
Mass Storage system and the only requirements we had was to store and
retrieve a file (put/get functionality). We've thus used the rados
library with a small extension implementing striping of big files the
way you've done it in cephFS. I will actually submit a blueprint for
this extension in case you want to integrate it.
This supposed that we have our own tools and protocols to migrate/recall
files and query the status of them.

In the general case, you're pretty right that you need to store the
state of the file (some use a stub file when the file is not on disk)
and hooks after the writing of a new file and in case of read failure
(cache miss).
One difficult point though, as Tim mentioned already, is to reach
optimal usage of your tape backend. This may end up in long queuing
times (hours) for recalls and one has to handle waiting clients during
that time.

Sebastien


On Sat, 2013-11-09 at 00:33 -0800, Sage Weil wrote:
> The latest Lustre just added HSM support:
> 
> 	http://archive.hpcwire.com/hpcwire/2013-11-06/lustre_scores_business_class_upgrade_with_hsm.html
> 
> Here is a slide deck with some high-level detail:
> 	
> 	https://jira.hpdd.intel.com/secure/attachment/13185/Lustre_HSM_Design.pdf
> 
> Is anyone familiar with the interfaces and requirements of the file system 
> itself?  I don't know much about how these systems are implemented, but I 
> would guess there are relatively lightweight requirements on the fs (ceph 
> mds in our case) to keep track of file state (online or archived 
> elsewhere).  And some hooks to trigger migrations?
> 
> If anyone is interested in this area, I would be happy to help figure out 
> how to integrate things cleanly!
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


