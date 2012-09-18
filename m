From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: How are you using Ceph?
Date: Mon, 17 Sep 2012 23:19:41 -0400 (EDT)
Message-ID: <2054194652.102.1347938381504.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1784724793.100.1347938272315.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1122 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283Ab2IRDZt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Sep 2012 23:25:49 -0400
In-Reply-To: <1784724793.100.1347938272315.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: f wiessner <f.wiessner@smart-weblications.de>, Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Tren Blackburn <tren@eotnetworks.com>

Hi

Just FYI, on the NFS integration front.  A pnfs files (RFC5661)-capable NFSv4 re-exporter for Ceph has been committed to the Ganesha NFSv4 server development branch.  We're continuing to enhance and elaborate this.  We have had on our (full) plates for a while to return Ceph client library changes.  We've finished pullup and rebasing of these, are doing some final testing of a couple things in preparation to push a branch for review.

Regards,

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> On Mon, 17 Sep 2012, Tren Blackburn wrote:
> > On Mon, Sep 17, 2012 at 5:05 PM, Smart Weblications GmbH - Florian
> > Wiessner <f.wiessner@smart-weblications.de> wrote:
> > >
> > > Hi,
> > >
> > > i use ceph to provide storage via rbd for our virtualization
> cluster delivering
> > > KVM based high availability Virtual Machines to my customers. I
> also use it
> > > as rbd device with ocfs2 on top of it for a 4 node webserver
> cluster as shared
> > > storage - i do this, because unfortunatelly cephfs is not ready
> yet ;)
> > >
> > Hi Florian;
> > 
> > When you say "cephfs is not ready yet", what parts about it are not
> > ready? There are vague rumblings about that in general, but I'd
> love
> > to see specific issues. I understand multiple *active* mds's are
> not
> > supported, but what other issues are you aware of?
> 
> Inktank is not yet supporting it because we do not have the QA in
> place 
> and general hardening that will make us feel comfortable recommending
> it 
> for customers.  That said, it works pretty well for most workloads. 
> In 
> particular, if you stay away from the snapshots and multi-mds, you
> should 
> be quite stable.
> 
> The engineering team here is about to do a bit of a pivot and refocus
> on 
> the file system now that the object store and RBD are in pretty good 
> shape.  That will mean both core fs/mds stability and features as well
> as 
> integration efforts (NFS/CIFS/Hadoop).
> 
> 'Ready' is in the eye of the beholder.  There are a few people using
> the 
> fs successfully in production, but not too many.
> 
> sage
> 
> 
>  > 
> > And if there's a page documenting this already, I apologize...and
> > would appreciate a link :)
> > 
> > t.
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
