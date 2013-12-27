From: Sage Weil <sage@inktank.com>
Subject: Re: SMART monitoring
Date: Thu, 26 Dec 2013 18:17:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312261807240.2168@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B68565E03@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55186 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab3L0CRF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Dec 2013 21:17:05 -0500
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B68565E03@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

On Fri, 27 Dec 2013, James Harper wrote:
> What would be the best approach to integrate SMART with ceph, for the 
> predictive failure case?

Currently (as you know) we don't do anything with SMART.  It is obviously 
important for the entire system, but I'm unsure whether it should be 
something that ceph-osd is doing as part of the cluster, or whether it is 
better handled by another generic agent that is monitoring the hosts in 
your cluster.  

I think the question comes down to whether Ceph should take some internal 
action based on the information, or whether that is better handled by some 
external monitoring agent.  For example, an external agent might collect 
SMART info into graphite, and every so often do some predictive analysis 
and mark out disks that are expected to fail soon.

I'd love to see some consensus form around what this should look like...

> Assuming you agree with SMART diagnosis of an impending failure, would 
> it be better to automatically start migrating data off the OSD (reduce 
> the weight to 0?), or to just prompt the user to replace the disk (which 
> requires no monitoring on ceph's part)? The former would ensure that 
> redundancy is maintained at all times without any user interaction.

We definitely want to mark the disk 'out' or reweight it to zero so that 
redudancy is never unnecessarily reduced.

> And what about the bad sector case? Assuming you are using something 
> like btrfs with redundant copies of metadata, and assuming that is 
> enough to keep the metadata consistent, what should be done in the case 
> of a small number of fs errors? Can ceph handle getting an i/o error on 
> one of its files inside the osd and just read from the replica, or 
> should the entire osd just be failed and let ceph rebalance the data 
> itself?

If the failure is masked by the fs, Ceph doesn't care.  Currently, if Ceph 
sees any error on write, we 'fail' the entire ceph-osd process.  On read, 
this is configurable (filestore fail eio), but also defaults to true.  
This may seem like overkill, but if we are getting read failures, this is 
a not-completely-horrible signal that the drive may fail more 
spectacularly later, and it avoids having to cope with the complexity of a 
partial failure.  Also note that since we are doing a deep-scrub with some 
regularity (which reads every byte stored and compares across replicas), 
the cluster will automatically fail drives that start issuing latent read 
errors.

sage
