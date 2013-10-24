From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] CephFS & Project Manila (OpenStack)
Date: Wed, 23 Oct 2013 18:21:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310231802380.13915@cobra.newdream.net>
References: <CAPYLRzg09EhsztuTLBUzVzEpxtA54cEJsO95fj3f=jV+eD_ZBg@mail.gmail.com> <CAFMfnwpemFVV65tqoZqU_4QRqsZ=SE=-81tgbHyxOSkYq1TdeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59626 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3JXBVy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Oct 2013 21:21:54 -0400
In-Reply-To: <CAFMfnwpemFVV65tqoZqU_4QRqsZ=SE=-81tgbHyxOSkYq1TdeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle.bader@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Wed, 23 Oct 2013, Kyle Bader wrote:
> 
>       Option 1) The service plugs your filesystem's IP into the VM's
>       network
>       and provides direct IP access. For a shared box (like an NFS
>       server)
>       this is fairly straightforward and works well (*everything* has
>       a
>       working NFS client). It's more troublesome for CephFS, since
>       we'd need
>       to include access to many hosts, lots of operating systems don't
>       include good CephFS clients by default, and the client is
>       capable of
>       forcing some service disruptions if they misbehave or disappear
>       (most
>       likely via lease timeouts), but it may not be impossible.
> 
> 
> This is going to get horribly ugly when you add neutron into the mix, so
> much so I'd consider this option a non-starter. If someone is using
> openvswitch to create network overlays to isolate each tenant I can't
> imagine this ever working.

I'm not following here.  Are this only needed if ceph shares the same 
subnet as the VM?  I don't know much about how these things work, but I 
would expect that it would be possible to route IP traffic from a guest 
network to the storage network (or anywhere else, for that matter)...

That aside, however, I think it would be a mistake to take the 
availability of cephfs vs nfs clients as a reason alone for a particular 
architectural approach.  One of the whole points of ceph is that we ignore 
legacy when it doesn't make sense.  (Hence rbd, not iscsi; cephfs, not 
[p]nfs.)

If using manila and cephfs requires that the guest support cephfs, that 
seems perfectly reasonable to me.  It will be awkward to use today, but 
will only get easier over time.

>       Option 2) The hypervisor mediates access to the FS via some
>       pass-through filesystem (presumably P9 ? Plan 9 FS, which QEMU/KVM
>       is
>       already prepared to work with). This works better for us; the
>       hypervisor host can have a single CephFS mount that it shares
>       selectively to client VMs or something.
> 
> This seems like the only sane way to do it IMO.

I also think that an fs pass-thru (like virtfs/9p) is worth considering 
(although I prefer option 1 if we only get to choose one).  I'm not sure 
the performance is great, but for many use cases it will be fine.

(Note, however, that this will also depend on recent Linux kernel support 
as I think the 9p/virtfs bits only landed in mainline in ~2011.)

I'm not too keen on option 3 (nfs proxy on host).

One other thought about multitenancy and DoS from clients: the same thing 
is also possible using NFSv4 delegations.  Possibly even NFS3 locks (not 
sure).  Any stateful fs protocol will have the same issues.  In many 
cases, though, clients/tenants will be using isolated file sets and won't 
be able interfere with each other even when they misbehave.

Also, in many (private) cloud deployments these security/DoS/etc issues 
aren't a concern.  The capability can still be useful even with a big * 
next to it.  :)

sage
