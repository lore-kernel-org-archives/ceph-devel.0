From: Sage Weil <sage@newdream.net>
Subject: Re: Interested in ceph OSD encryption and key management
Date: Tue, 16 Jun 2015 21:16:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506162115350.16406@cobra.newdream.net>
References: <1432787005.11787.33.camel@catalyst.net.nz> <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net> <1434508656.26942.19.camel@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52413 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbbFQEQp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 00:16:45 -0400
In-Reply-To: <1434508656.26942.19.camel@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Bartlett <abartlet@catalyst.net.nz>
Cc: mbroz@redhat.com, ceph-devel@vger.kernel.org

On Wed, 17 Jun 2015, Andrew Bartlett wrote:
> On Thu, 2015-05-28 at 13:03 -0700, Sage Weil wrote:
> > Hi Andrew,
> > 
> > I'm copying Milan Broz, who has looked at this ome. There was some 
> > subsequent off-list discussion in Red Hat about using Petera[1] for the 
> > key management, but this'll require a bit more effort than what was 
> > described in that blueprint.
> > 
> > On Thu, 28 May 2015, Andrew Bartlett wrote:
> > > David Disseldorp was good enough to point me at this proposal for ceph
> > > OSD key management:
> > > https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%3A_simple_ceph-mon_dm-crypt_key_management
> > > 
> > > I'm really interested in improving ceph on-disk encryption, and am
> > > really glad folks are taking this beyond the local key storage we have
> > > managed so far. 
> > > 
> > > So I can be part of the discussion, how do I get a login to the wiki?  I
> > > would like to indicate my interest there.
> > 
> > The wiki logins are broken, but ignore that.. we're moving to 
> > tracker.ceph.com's wiki shortly anyway.  Email is best in the meantime!
> 
> This proposal seems not have to have it to the new wiki.  Is it still
> alive?  What do we need to do to keep this moving?

I can create a placeholder session.  Can you two hash out a proposal over 
the next week or so to discuss?  I think there are some tricky questions 
if petera is used if we want it to integrate with the monitors as well 
(e.g., leverage the monitors for updating/distributing the petera 
certs/keys).

sage


> 
> Thanks,
> 
> Andrew Bartlett
> 
> -- 
> Andrew Bartlett
> http://samba.org/~abartlet/
> Authentication Developer, Samba Team         http://samba.org
> Samba Development and Support, Catalyst IT   http://catalyst.net.nz/services/samba
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
