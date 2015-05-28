From: Sage Weil <sage@newdream.net>
Subject: Re: MDS auth caps for cephfs
Date: Thu, 28 May 2015 10:32:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505281024560.6462@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <alpine.DEB.2.00.1505271427590.6462@cobra.newdream.net> <CAC6JEv85TGA32MUpSjg6bhuWJp16833HQh8pwbFvgW84S7BRyg@mail.gmail.com> <alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net>
 <CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com> <alpine.DEB.2.00.1505271542410.6462@cobra.newdream.net> <CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com> <alpine.DEB.2.00.1505271646360.6462@cobra.newdream.net>
 <CAC6JEv_Jw5S94E2yiW-g-t1Ro3gjiYXnoRKGNf=721CjoLESkA@mail.gmail.com> <alpine.DEB.2.00.1505271728250.6462@cobra.newdream.net> <CAC6JEv8pmJ-PhMUVqoP_VNsGR-STyjiyfcPqqpEQRv8x=UTjwA@mail.gmail.com> <CAANLjFqA+X7WYQ6NX_-L--vZorerSCQs6YcNSfUrurjsQFOsYA@mail.gmail.com>
 <CAC6JEv-MH=1uJD1HudhHJ=8wfg+dP3d9euhwLNEB-idsogGu+Q@mail.gmail.com> <alpine.DEB.2.00.1505280957450.6462@cobra.newdream.net> <CAANLjFrs6xrQXJHu-Z7bqw_FWmGbqbc-HT1SKBxi0=Ls2SmBbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34665 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbbE1RcH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 13:32:07 -0400
In-Reply-To: <CAANLjFrs6xrQXJHu-Z7bqw_FWmGbqbc-HT1SKBxi0=Ls2SmBbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Gregory Farnum <greg@gregs42.com>, John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Thu, 28 May 2015, Robert LeBlanc wrote:
> On Thu, May 28, 2015 at 11:02 AM, Sage Weil <sage@newdream.net> wrote:
> 
> >> > The MDS could combine a tenant ID and a UID/GID to store unique
> >> > UID/GIDs on the back end and just strip off the tenant ID when
> >> > presented to the client so there are no collisions of UID/GIDs between
> >> > tenants in the MDS.
> >>
> >> Hmm, that is another thought...
> >
> > Unless you ask Ceph to enforce the unix permissions server side, the
> > uid/gid are stored but not interpreted.  I don't think the tenant ID is
> > needed since there is no impact if the same uids are used in different
> > subtrees.  It's just up to the admin to divvy up non-overlapping subtrees
> > to the tenants...
> 
> I don't think I would expect Ceph to enforce file permissions, only
> share permissions. The file permissions should be enforced by the host
> mounting the FS.
> 
> If Ceph appends 8 bits as the Tenant ID to the 16 bit UID/GID for
> example, then Ceph only has to match and act the first 8 bits and pass
> the next 16 bits to the client. It only has to store the UID/GID and
> perms/ACLs. Then you don't have to worry about not crossing the
> streams in subtrees. If an admin later decides to provide access to
> two clients to the same subtree nothing bad will happen. The two
> clients will have to figure out between themselves what to do with
> UID/GIDs/perms/ACLs to provide the appropriate access.
> 
> If for instance a directory is shared between tenant A and B, and A
> can write and B can't, then when B tries to write because the perms
> are correct for the UID/GID on the client side, the MDS will prevent
> the write because that tenant doesn't have "share" write access on
> that directory.

This feels like it's just adding some protection for an admin that 
accidentally gives tenant A access to tenant B's subtree.  Assuming the 
subtree streams aren't crossed, it doesn't add anything, right?

> If a tenant wants to allow write access to part of a directory, then
> there has to be some level of trust that they will act responsibly. I
> can't see getting around that without implementing Kerberos and
> preventing the client from mapping to other UID/GIDs, but that really
> takes the flexibility out of the system.

There are three scenarios:

1) Each tentant in their own subtree, clients do enforcement.  They can do 
whatever they want but Ceph doesn't care because the tenant is confined.

2) Kerberos, as you say, allows the MDS to enforce permissions on shared 
directories.  You're right that you need that infrastructure before we can 
sanely, except when

3) untrusted clients are given access to a shared directory but restricted 
to act as a single user.  In this case, the MDS still enforces 
permissions, and kerberos isn't needed.  Imagine your workstation being 
allowed to mount the department file server.

In any case, doing any enforcement on the MDS is opt-in.  It *expands* 
your options by making it possible to share the same subtrees to different 
untrusted clients and still enforce permissions.  If you have a 
multi-tenant environment where data isn't shared, you can still do what 
you're suggesting and leave it to the clients...  or even run in a 
completely trusted mode like we have now where clients all mount / and can 
do whatever they want.

Does that make sense?

sage

