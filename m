From: Sage Weil <sage@newdream.net>
Subject: Re: Interested in ceph OSD encryption and key management
Date: Thu, 18 Jun 2015 07:31:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506180716260.23826@cobra.newdream.net>
References: <1432787005.11787.33.camel@catalyst.net.nz> <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net> <1434508656.26942.19.camel@catalyst.net.nz> <alpine.DEB.2.00.1506162115350.16406@cobra.newdream.net> <5582C8F2.2010604@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35181 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbFRObG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2015 10:31:06 -0400
In-Reply-To: <5582C8F2.2010604@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milan Broz <mbroz@redhat.com>
Cc: Andrew Bartlett <abartlet@catalyst.net.nz>, ceph-devel@vger.kernel.org

Hi Milan-

On Thu, 18 Jun 2015, Milan Broz wrote:
> On 06/17/2015 06:16 AM, Sage Weil wrote:
> >>> The wiki logins are broken, but ignore that.. we're moving to 
> >>> tracker.ceph.com's wiki shortly anyway.  Email is best in the meantime!
> >>
> >> This proposal seems not have to have it to the new wiki.  Is it still
> >> alive?  What do we need to do to keep this moving?
> 
> I am not able to even login to wiki, seems logins are still completely broken.
> Probably nobody can edit it now?

The old wiki is frozen.. see the new wiki at 
http://tracker.ceph.com/projects/ceph/wiki (not much there yet).  Jewel 
CDS blueprints are at

	http://tracker.ceph.com/projects/ceph/wiki/Jewel

> > I can create a placeholder session.  Can you two hash out a proposal over 
> > the next week or so to discuss?  I think there are some tricky questions 
> > if petera is used if we want it to integrate with the monitors as well 
> > (e.g., leverage the monitors for updating/distributing the petera 
> > certs/keys).
> 
> Yes, but later please. We have a lot of fun with selinux and other things,
> this feature could follow later.
> 
> BTW Petera is now renamed to Deo (and should be in Fedora packaged already).

(Good to hear--petera had bad google mojo.)

> The idea was:
> 
> - use LUKS as the encryption format
> 
> - use Deo to map OSD, for more info see
>   https://github.com/npmccallum/deo
> 
>   In short, Deo will connect to MON node and negotiate key and directly
>   unlock LUKS device.
>   (New version now uses libcryptsetup direcly, so it is really one client binary.)
> 
>   There must be a service listening on MONs nodes (Deo server).
> 
>   I have no idea yet how problematic will be handling certificates here, but
>   because it ensures authentication and encrypts communication, it seems like
>   a nice design.

I think the ceph-mon piece is that we would need a monitor service that is 
responsible for storing/distributing the certs/keys.  In order to make 
them visible to Deo, we'd need them to be stored in plaintext in a simple 
directory structure in /var/lib/ceph/mon/$cluster-$id/ somewhere.  If 
we simply co-opt config-key to do this, or do this for a subset of the 
config-key namespace, this should be pretty simple.

Do you know what the server-side file/directory should look like for Deo?

>   Anyway, delegating this task to one simple tool (maintained independently
>   of Ceph) is IMHO a good idea and the whole integration should not be complicated.
>   (Moreover it will allow easy integration with FreeIPA and similar tools later.)

Yeah.  My assumption is that this is essentially swapping out the bits 
that use the ceph mons to install keys?

sage
