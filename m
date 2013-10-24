From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: [ceph-users] CephFS & Project Manila (OpenStack)
Date: Wed, 23 Oct 2013 20:14:14 -0700
Message-ID: <CAFMfnwo=QyBPaANWMvXKuxA8t4eg-FhwagbaveiTV6m3pgNwjw@mail.gmail.com>
References: <CAPYLRzg09EhsztuTLBUzVzEpxtA54cEJsO95fj3f=jV+eD_ZBg@mail.gmail.com>
	<CAFMfnwpemFVV65tqoZqU_4QRqsZ=SE=-81tgbHyxOSkYq1TdeA@mail.gmail.com>
	<alpine.DEB.2.00.1310231802380.13915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61873 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab3JXDOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Oct 2013 23:14:16 -0400
Received: by mail-lb0-f177.google.com with SMTP id u14so1381946lbd.8
        for <ceph-devel@vger.kernel.org>; Wed, 23 Oct 2013 20:14:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1310231802380.13915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

>> This is going to get horribly ugly when you add neutron into the mix, so
>> much so I'd consider this option a non-starter. If someone is using
>> openvswitch to create network overlays to isolate each tenant I can't
>> imagine this ever working.
>
> I'm not following here.  Are this only needed if ceph shares the same
> subnet as the VM?  I don't know much about how these things work, but I
> would expect that it would be possible to route IP traffic from a guest
> network to the storage network (or anywhere else, for that matter)...
>
> That aside, however, I think it would be a mistake to take the
> availability of cephfs vs nfs clients as a reason alone for a particular
> architectural approach.  One of the whole points of ceph is that we ignore
> legacy when it doesn't make sense.  (Hence rbd, not iscsi; cephfs, not
> [p]nfs.)

In an overlay world, physical VLANs have no relation to virtual
networks. An overlay is literally encapsulating layer 2 inside layer 3
and adding a VNI (virtual network identifier) and using tunnels
(VxLAN, STT, GRE, etc) to connect VMs on disparate hypervisors that
may not even have L2 connectivity to each other.  One of the core
tenants of virtual networks is providing tenants the ability to have
overlapping RFC1918 addressing, in this case you could have tenants
already utilizing the addresses used by the NFS storage at the
physical layer. Even if we could pretend that would never happen
(namespaces or jails maybe?) you would still need to provision a
distinct NFS IP per tenant and run a virtual switch that supports the
tunneling protocol used by the overlay and the southbound API used by
that overlays virtual switch to insert/remove flow information. The
only alternative to embedding a myriad of different virtual switch
protocols on the filer head would be to use a VTEP capable switch for
encapsulation. I think there are only 1-2 vendors that ship these,
Arista's 7150 and something in the Cumulus lineup.  Even if you could
get past all this I'm somewhat terrified by the proposition of
connecting the storage fabric to a tenant network, although this is
much more acute concern for public clouds.

Here's a good RFC wrt overlays if anyone is in dire need of bed time reading:

http://tools.ietf.org/html/draft-mity-nvo3-use-case-04

-- 

Kyle
