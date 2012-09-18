From: Sage Weil <sage@inktank.com>
Subject: Re: How are you using Ceph?
Date: Mon, 17 Sep 2012 19:32:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209171925270.1944@cobra.newdream.net>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com> <5057BAD0.8080201@smart-weblications.de> <CANLRBox_=RgEq=wOS9S8B-WxUtKvST1biyQu_8+-vXcc5kSw-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55702 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436Ab2IRCcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Sep 2012 22:32:39 -0400
In-Reply-To: <CANLRBox_=RgEq=wOS9S8B-WxUtKvST1biyQu_8+-vXcc5kSw-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: f.wiessner@smart-weblications.de, Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 17 Sep 2012, Tren Blackburn wrote:
> On Mon, Sep 17, 2012 at 5:05 PM, Smart Weblications GmbH - Florian
> Wiessner <f.wiessner@smart-weblications.de> wrote:
> >
> > Hi,
> >
> > i use ceph to provide storage via rbd for our virtualization cluster delivering
> > KVM based high availability Virtual Machines to my customers. I also use it
> > as rbd device with ocfs2 on top of it for a 4 node webserver cluster as shared
> > storage - i do this, because unfortunatelly cephfs is not ready yet ;)
> >
> Hi Florian;
> 
> When you say "cephfs is not ready yet", what parts about it are not
> ready? There are vague rumblings about that in general, but I'd love
> to see specific issues. I understand multiple *active* mds's are not
> supported, but what other issues are you aware of?

Inktank is not yet supporting it because we do not have the QA in place 
and general hardening that will make us feel comfortable recommending it 
for customers.  That said, it works pretty well for most workloads.  In 
particular, if you stay away from the snapshots and multi-mds, you should 
be quite stable.

The engineering team here is about to do a bit of a pivot and refocus on 
the file system now that the object store and RBD are in pretty good 
shape.  That will mean both core fs/mds stability and features as well as 
integration efforts (NFS/CIFS/Hadoop).

'Ready' is in the eye of the beholder.  There are a few people using the 
fs successfully in production, but not too many.

sage


 > 
> And if there's a page documenting this already, I apologize...and
> would appreciate a link :)
> 
> t.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
