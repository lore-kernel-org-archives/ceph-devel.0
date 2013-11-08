From: Sage Weil <sage@inktank.com>
Subject: Re: teuthology consumability
Date: Thu, 7 Nov 2013 17:08:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311071700410.17943@cobra.newdream.net>
References: <alpine.DEB.2.00.1311070711080.17943@cobra.newdream.net> <527BB190.2010302@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47409 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab3KHBIU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 20:08:20 -0500
In-Reply-To: <527BB190.2010302@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org, hugh.saunders@rackspace.co.uk

On Thu, 7 Nov 2013, Loic Dachary wrote:
> 
> Hi Sage,
> 
> On 07/11/2013 23:21, Sage Weil wrote:
> > Hey all,
> > 
> > I've had a couple different conversations with week with organizations 
> > that want to ramp up their ceph development efforts, as a big piece of 
> > that, spin up their own teuthology environments.  There has been a lot 
> > going on here, and I haven't been on the weekly calls, but I suspect 
> > things that will help them move forward include:
> > 
> > - documenting a teuthology install-from-scratch.  this would include 
> > setting up the databases, lock server, workers, etc., and will initially 
> > be long and ugly but will hopefully shrink over time.
> > 
> > - adding support for euca2ools or some other cloud client that does 
> > openstack and ec2 for creating/destroying test machines.  hopefully most 
> > of the integration points are mapped out from the downburst integration 
> > work.
> > 
> 
> I'm including Hugh Saunders on this thread : we discussed this topic 
> during the OpenStack summit this week in relation to the associated 
> ticket:
> 
> http://tracker.ceph.com/issues/6502

Great.  I would love to see someone sign up for this for the firefly cycle 
(and write up a quick blueprint).  :)
 
> > - ongoing work to collapse the locking and queuing and reporting into a 
> > unified and/or cohesive service.
> 
> It looks like it could be associated with 
> http://wiki.ceph.com/01Planning/02Blueprints/Firefly/Ceph-Brag for 
> performance related tasks. Does that sound sensible ? I'm midly drunk 
> tonight and possibly writing nonsense ;-)

Hmm, I'll go with the latter ;).  I don't think there are tickets open for 
this work, but it's been Zack's main focus these past few weeks.  The last 
glimpse I got of the web interface (just for viewing results, so far) was 
looking pretty slick, too!

sage

> 
> Cheers
> 
> > 
> > I'm probably missing things and/or vastly oversimplifying, but hopefully 
> > others can chime in an improve this list.  I think the better roadmap we 
> > have here, the easier it will be for new people to come online and focus 
> > their efforts where they will make the most difference.
> > 
> > Of course the upcomign CDS is a good place to discuss this, but something 
> > should be written down first to guide/frame that discussion.
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
