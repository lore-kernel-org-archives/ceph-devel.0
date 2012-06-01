From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: "rbd rm image" slow with big images ?
Date: Fri, 01 Jun 2012 15:51:19 +0200
Message-ID: <2839159.qIikQGmnXF@pc10>
References: <b4c574f6-49bf-4d36-b8f2-526bcccb4c71@mailpro> <4FC7B528.30609@widodh.nl> <Pine.LNX.4.64.1205311118150.28422@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:55535 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759921Ab2FANv1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Jun 2012 09:51:27 -0400
In-Reply-To: <Pine.LNX.4.64.1205311118150.28422@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am Donnerstag, 31. Mai 2012, 11:19:44 schrieben Sie:
> On Thu, 31 May 2012, Wido den Hollander wrote:
> > Hi,
> > 
> > > Is it the normal behaviour ? Maybe some xfs tuning could help ?
> > 
> > It's in the nature of RBD.
> 
> Yes.
> 
> That said, the current implementation is also stupid: it's doing a single
> io at a time.  #2256 (next sprint) will parallelize this to make it go
> much faster (probably an order of magnitude?).

Will it speed up copy operations as well? Those are a lot more important in 
practice... A delete operation I can usually just fire off and leave running 
in the background, but if I'm running a copy operation, there's usually 
something else waiting (like starting a virtual server that's waiting for its 
disk) that cannot proceed until the copy is actually finished.

On another note, it looks to me (correct me if I'm wrong) like rbd copy 
operations always involve copying all the data objects from the source volume 
to the machine on which the rbd command is running, and then back to the 
cluster, even if that machine isn't even part of the cluster. Are there any 
plans to streamline this?

Regards,
	Guido
