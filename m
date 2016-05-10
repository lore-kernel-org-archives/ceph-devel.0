From: Sage Weil <sweil@redhat.com>
Subject: Re: "1 hosts down" health warning?
Date: Tue, 10 May 2016 08:11:37 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605100809380.15518@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605091232040.1841@cpach.fuggernut.com> <184215728.1353.1462860350329@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50767 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbcEJMLZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 May 2016 08:11:25 -0400
In-Reply-To: <184215728.1353.1462860350329@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 10 May 2016, Wido den Hollander wrote:
> > Op 9 mei 2016 om 18:36 schreef Sage Weil <sweil@redhat.com>:
> > 
> > 
> > We have a feature (mon_osd_reporter_subtree_level = host) that makes it so 
> > that if an entire host is down (or whatever the configured hierarchy 
> > level is) the osds aren't automatically marked out after 5 minutes.
> > 
> > This is confusing on an actual cluster because you see something like
> > 
> >             48/5661 in osds are down
> > 
> > bit it never clears.  It's not until you look at the ceph osd tree output 
> > that you can see why they aren't getting marked out.
> > 
> > It would be great if the health warning said something like
> > 
> >             48/5661 in osds are down
> >             1/142 hosts are down (accounting for 48/48 down osds)
> > 
> > and the health detail said something like
> > 
> >   host foo is down with 48 OSDs
> > 
> > I think this would be pretty easy to implement given the mon is 
> > already doing the subtree-based checks.
> > 
> > Thoughts? Any takers?
> 
> Seems like a good thing to have. I wouldn't say 'host', since 
> 'mon_osd_reporter_subtree_level' could be set to rack or row if you want 
> to.
> 
> Maybe:
> 
>             480/6720 in osds are down
>             1/14 of CRUSH type 'rack' are down (accounting for 480/480 down osds)

Yeah.  I was thinking it'd be

             1/14 ${type}s are down (accounting for 480/480 down osds)

e.g.,

             1/14 racks are down (accounting for 480/480 down osds)

just because concise is usually better.

sage
