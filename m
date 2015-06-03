From: Andrew Bartlett <abartlet@catalyst.net.nz>
Subject: Re: Interested in ceph OSD encryption and key management
Date: Wed, 03 Jun 2015 12:12:59 +1200
Message-ID: <1433290379.11787.131.camel@catalyst.net.nz>
References: <1432787005.11787.33.camel@catalyst.net.nz>
	 <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:36095 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbFCAND (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 20:13:03 -0400
In-Reply-To: <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: mbroz@redhat.com, ceph-devel@vger.kernel.org

On Thu, 2015-05-28 at 13:03 -0700, Sage Weil wrote:
> Hi Andrew,
> 
> I'm copying Milan Broz, who has looked at this ome. There was some 
> subsequent off-list discussion in Red Hat about using Petera[1] for the 
> key management, but this'll require a bit more effort than what was 
> described in that blueprint.
> 
> On Thu, 28 May 2015, Andrew Bartlett wrote:
> > David Disseldorp was good enough to point me at this proposal for ceph
> > OSD key management:
> > https://wiki.ceph.com/Planning/Blueprints/Infernalis/osd%3A_simple_ceph-mon_dm-crypt_key_management
> > 
> > I'm really interested in improving ceph on-disk encryption, and am
> > really glad folks are taking this beyond the local key storage we have
> > managed so far. 
> > 
> > So I can be part of the discussion, how do I get a login to the wiki?  I
> > would like to indicate my interest there.
> 
> The wiki logins are broken, but ignore that.. we're moving to 
> tracker.ceph.com's wiki shortly anyway.  Email is best in the meantime!
> 
> > Regarding the proposal:
> > 
> > In the default mode suggested in the wiki, my primary concern is that
> > I'm told, in a number of deployments, the monitor node is the same
> > server that also holds the OSDs, so we don't gain anything for those
> > cases over the /etc storage.
> > 
> > In those cases, the hooks suggested in the wiki will be key, as will be
> > having those configurable in ceph.conf, so ceph-deploy can just pass it
> > down to all the nodes as they are built, just as the other dmcrypt
> > options are.  
> > 
> > I would like to see three things hookable:
> >  - the command to obtain the key (on stdout)
> 
> - a command to publish/store a new key (from ceph-disk create)
> 
> >  - to encrypt the key (so we can additionally pass it
> > via gpg, a HSM or remote encrypt/decrypt service)
> >  - to decrypt the key
> 
> Not quite sure what you have in mind here?
> 
> I think the key things I'd like to see in any effort here is
> 
>  1- keep the actual decryption key in LUKS and store the LUKS key in the 
> key escrow location.  The original dm-crypt stuff kept the actual key 
> in /etc/ceph/keys, but that makes it hard to track key provenance, and 
> also fixes the encryption algorithm... LUKS is more robust.

Yes.

>  2- make the key management pluggable, so that we can use petera, 
> /etc/ceph/keys, the ceph mons, or something else.

Petera looks very much like what I was trying to home-grow, and I would
prefer that over using the monitor nodes, as those are often shared with
our storage nodes.  

Thanks for the link, I'm glad we are all thinking in the same direction!

Andrew Bartlett

-- 
Andrew Bartlett
http://samba.org/~abartlet/
Authentication Developer, Samba Team  http://samba.org
Samba Developer, Catalyst IT          http://catalyst.net.nz/services/samba




