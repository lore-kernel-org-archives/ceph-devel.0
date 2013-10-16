From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph puppet module
Date: Wed, 16 Oct 2013 09:02:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310160901350.22271@cobra.newdream.net>
References: <525E47AA.8060006@dachary.org> <CABZ+qqmxKFeEDfiCu8i1_sn9TZCD4_-p8+2+XFaj=+kQq_Jnvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55196 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760597Ab3JPQCX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 12:02:23 -0400
In-Reply-To: <CABZ+qqmxKFeEDfiCu8i1_sn9TZCD4_-p8+2+XFaj=+kQq_Jnvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Dan Bode <bodepd@gmail.com>

On Wed, 16 Oct 2013, Dan van der Ster wrote:
> Hi,
> We would support this. The enovance module is a good starting point if
> you will accept something that doesn't yet use all the udev magic.

My only concern is that it may be challenging to make a smooth transition 
from the old-style to new-style udev goodness.  Something to consider!

sage


> Cheers, Dan
> CERN IT
> 
> On Wed, Oct 16, 2013 at 10:00 AM, Loic Dachary <loic@dachary.org> wrote:
> > Hi Ceph,
> >
> > How about creating
> >
> > https://github.com/ceph/puppet-ceph
> >
> > to federate the development efforts for a puppet module exclusively focused on deploying / maintaining a Ceph cluster ? It looks like we are at a point in time where the fragmentation of the work created a desire for a central place. And the https://github.com/ceph/ seems agreeable to everyone involved.
> >
> > The discussion initialy started on Ceph + OpenStack + puppet but it seems sensible to separate the OpenStack specific part and host it on https://github.com/stackforge/
> >
> > The full thread that leads to this proposal is at:
> >
> > https://groups.google.com/a/puppetlabs.com/d/msg/puppet-openstack/ibnrmXBAxVg/Y3Z3e6sZoa4J
> >
> > Cheers
> >
> > --
> > Lo?c Dachary, Artisan Logiciel Libre
> > All that is necessary for the triumph of evil is that good people do nothing.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
