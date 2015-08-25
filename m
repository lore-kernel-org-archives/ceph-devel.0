From: Marcus Watts <mwatts@redhat.com>
Subject: Re: wip-addr
Date: Tue, 25 Aug 2015 06:06:12 -0400
Message-ID: <20150825100612.GA23852@pika.b.linuxbox.com>
References: <alpine.DEB.2.00.1508241046070.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755058AbbHYKFt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Aug 2015 06:05:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id B0D31A3023
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2015 10:05:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1508241046070.13116@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 24, 2015 at 11:01:45AM -0700, Sage Weil wrote:
...
> I looked over the wip-addr branch a bit.  I have two basic 
> questions/concerns:
> 
> 1) In commit
> 	https://github.com/ceph/ceph/commit/73b09090466a43d5aceb979a4802de3f3f5bf24a 
> we switch the type field from sa_family to transport_type.  This seems 
> like the way to go, but we need to deal with the fact that lots of 
> clusters out there are IPv6 and have AF_INET6 filled in here.  Probably 
> both types should be interpreted to mean "existing/legacy IP messenger" or 
> whatever we want to call SimpleMessenger/AsyncMessenger's protocol.
> 
> I think encode needs to make sure it fills in that value for the type when 
> encoding the legacy entity_addr_t encoding, but could use a/the single 
> valid value for the new encoding.  And any get_transport_type() accessor 
> should also return the single valid value.

With cohortfs I had the luxury of ignoring existing installations.

I think I concluded at the time that probably most real systems
had '0' stored here.
Yes, if there are things that have "junk" here, they'll need to be handled
appropriately - I think it can be mostly fixed by just having decode map
transport_type "AF_INET6" (which is probably 10) to 0.  AF_INET is 2,
so maybe that too.  People switching *back* to older code after using
new code won't be so happy - would probably need a patch for older code
if that's a concern.

If there's code out there that thinks get_transport_type() returns an address
family, that will need fixing.  something like,
	get_address_family(){ return in_addr->ss_family; }
but I didn't find any code that actually needed this.

> 
> 2) In the later commit
> 	https://github.com/ceph/ceph/commit/9d203a2058f76414703b4fc212a1a0a960d0c672 
> you introduce a grammar for printing/parsing the addrs.  This also makes 
> sense since e.g. xio uses an IP to identify an endpoint.  I think we 
> should identify these based on the *protocol* and not the implementation, 
> though... whether we use SimpleMessenger or AsyncMessenger is not a 
> property of the address.  Maybe "tcp://" makes more sense here?  Or 
> perhaps no prefix at all (a bare IP address), so that this looks the same 
> as it did before in the case where the default protocol(s) are in use.
> 
> I assume the xio protocol (whether it is rdma or tcp) is closely tied to 
> libxio itself.. is that right?  If so, using xio in that prefix makes 
> sense.  I'd include xio somewhere in the rdma prefix though (xrdma:// and 
> xtcp://)?

Code base I had didn't have async messenger as a transport type; if that
needs to be addressable independently of simple messenger it will need a
prefix.  I had a prefixless address decode as simple messenger - I
can make this more obvious than "unsigned type = 0;".

I had these prefixes,
	sm
	rdma
	xtcp
but I can easily pick others.  I figured rdma didn't need an x since
there didn't seem to be much chance anybody would want a non-xio version
of rdma.

> 
> What do you think?
> 
> Logistically, I think the steps for getting this ready for merge are:
> 
> 1) Separate out the preliminary patches that pass a feature to the addr 
> encoding.. without any of the other cohortfs patches that are currently on 
> this branch.  Once this builds we can merge it separately from the rest...
> 
> 2) The entity_addrvec_t type.
> 
> 3) The type -> transport_type switch.

There's a lot of cohortfs glop that still needs to go away in this branch.

I hadn't thought of structuring the patch that way.  I can do it,
but the encoding feature will be tedious to split out.
There's a bunch of cascading stuff after entity_addrvec_t which
could go into a series of further patches, monmap, and so forth,
not all of which exist yet.

> 
> 4) We should make the new entity_addr_t encoding encode sockaddr piece 
> more compactly instead of eating up a full 80-byte sockaddr_storage even 
> for the ~8-byte IPv4 sockaddr_in.  Maybe just need to encode an 
> explicit length for the sockaddr_* piece?

Yes, this could be made more memory efficient.  It's mainly a matter
of making sure the constructor gets the proper amount of memory.
There's a C hack to do this, but I remember seeing a c++ technique
that was a bit less hackish.

A sockaddr_in is actually 16 bytes of which the last 8 are dummy
padding (sin_zero).  (And there there are some systems that
actually check to be sure they're 0.)

BSD4.4 derived systems have a length coded into sockaddr too - but on
linux it's usually possible to get by without storing the length, and
I don't think ceph will need to do so.

...

					-Marcus Watts
