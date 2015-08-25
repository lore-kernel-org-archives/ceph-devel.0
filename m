From: Sage Weil <sweil@redhat.com>
Subject: Re: wip-addr
Date: Tue, 25 Aug 2015 07:08:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508250606500.13116@cobra.newdream.net>
References: <alpine.DEB.2.00.1508241046070.13116@cobra.newdream.net> <20150825100612.GA23852@pika.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686AbbHYOIm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Aug 2015 10:08:42 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 7A7E180B5A
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2015 14:08:42 +0000 (UTC)
In-Reply-To: <20150825100612.GA23852@pika.b.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 25 Aug 2015, Marcus Watts wrote:
> On Mon, Aug 24, 2015 at 11:01:45AM -0700, Sage Weil wrote:
> ...
> > I looked over the wip-addr branch a bit.  I have two basic 
> > questions/concerns:
> > 
> > 1) In commit
> > 	https://github.com/ceph/ceph/commit/73b09090466a43d5aceb979a4802de3f3f5bf24a 
> > we switch the type field from sa_family to transport_type.  This seems 
> > like the way to go, but we need to deal with the fact that lots of 
> > clusters out there are IPv6 and have AF_INET6 filled in here.  Probably 
> > both types should be interpreted to mean "existing/legacy IP messenger" or 
> > whatever we want to call SimpleMessenger/AsyncMessenger's protocol.
> > 
> > I think encode needs to make sure it fills in that value for the type when 
> > encoding the legacy entity_addr_t encoding, but could use a/the single 
> > valid value for the new encoding.  And any get_transport_type() accessor 
> > should also return the single valid value.
> 
> With cohortfs I had the luxury of ignoring existing installations.
> 
> I think I concluded at the time that probably most real systems
> had '0' stored here.

Oh, you're right--this is always 0 currently, so we're in good shape.

> Yes, if there are things that have "junk" here, they'll need to be handled
> appropriately - I think it can be mostly fixed by just having decode map
> transport_type "AF_INET6" (which is probably 10) to 0.  AF_INET is 2,
> so maybe that too.  People switching *back* to older code after using
> new code won't be so happy - would probably need a patch for older code
> if that's a concern.
> 
> If there's code out there that thinks get_transport_type() returns an address
> family, that will need fixing.  something like,
> 	get_address_family(){ return in_addr->ss_family; }
> but I didn't find any code that actually needed this.

There's already a {get,set}_family() that return ss_family, so I think 
we're okay there.

The main thing with entity_addr_t (and entity_addrvec_t) is that when the 
new feature is not present we'll want to encode in the old format.  I 
wonder if the best thing to do here is silently drop the type if it is 
non-zero here.  We could assert and blow up, but that is a bit dramatic.

The underlying strategy here is to replace (the old) entity_addr_t with 
entity_addrvec_t in most places, and when encoding the addrvec without the 
new feature, encode only the first addr in its compat form.  That way, as 
long as the first addr in the list is always IPv4 or IPv6 and the standard 
protocol, old clients will be happy.

If we make the addrvec ordered by preference, that may be problematic, 
since we'd always prefer the legacy protocol in rdma environments.  
Perhaps it would be better to make the compat addrvec encode pick out the 
first type 0 addr?  That's more robust anyway...

> > 2) In the later commit
> > 	https://github.com/ceph/ceph/commit/9d203a2058f76414703b4fc212a1a0a960d0c672 
> > you introduce a grammar for printing/parsing the addrs.  This also makes 
> > sense since e.g. xio uses an IP to identify an endpoint.  I think we 
> > should identify these based on the *protocol* and not the implementation, 
> > though... whether we use SimpleMessenger or AsyncMessenger is not a 
> > property of the address.  Maybe "tcp://" makes more sense here?  Or 
> > perhaps no prefix at all (a bare IP address), so that this looks the same 
> > as it did before in the case where the default protocol(s) are in use.
> > 
> > I assume the xio protocol (whether it is rdma or tcp) is closely tied to 
> > libxio itself.. is that right?  If so, using xio in that prefix makes 
> > sense.  I'd include xio somewhere in the rdma prefix though (xrdma:// and 
> > xtcp://)?
> 
> Code base I had didn't have async messenger as a transport type; if that
> needs to be addressable independently of simple messenger it will need a
> prefix.  I had a prefixless address decode as simple messenger - I
> can make this more obvious than "unsigned type = 0;".
> 
> I had these prefixes,
> 	sm
> 	rdma
> 	xtcp
> but I can easily pick others.  I figured rdma didn't need an x since
> there didn't seem to be much chance anybody would want a non-xio version
> of rdma.

The key thing is that the addr property is the *protocol* not the 
implementation, so from addr's perspective SimpleMessenger and 
AsyncMessenger are indistinguishable.  How about

  tcp    - legacy protocol (simple or async, whatever use has configured)
  xrdma  - xio over rdma
  xtcp   - xio over tcp

where the tcp:// is parsed (if present) but left off when rendering 
output, so when using the legacy protocol nothing looks 
different?

> > Logistically, I think the steps for getting this ready for merge are:
> > 
> > 1) Separate out the preliminary patches that pass a feature to the addr 
> > encoding.. without any of the other cohortfs patches that are currently on 
> > this branch.  Once this builds we can merge it separately from the rest...
> > 
> > 2) The entity_addrvec_t type.
> > 
> > 3) The type -> transport_type switch.
> 
> There's a lot of cohortfs glop that still needs to go away in this branch.
> 
> I hadn't thought of structuring the patch that way.  I can do it,
> but the encoding feature will be tedious to split out.
> There's a bunch of cascading stuff after entity_addrvec_t which
> could go into a series of further patches, monmap, and so forth,
> not all of which exist yet.

It looks like c728926a86e1410f959011d24700bb07bad1dc2c adds 
entity_addrvec_t and adds feature to encoding all over the place... but 
doesn't actually use addrvec at all yet.  I'd separate the addrvec 
declaration into its own patch (just ignore it for now), and build a 
new branch on master that

 1- makes entity_addr_t require featuers when encoding, and
 2- cherry-pick the patches adding the feature arg

Once that whole cleanup is complete and builds, the rest will be much 
easier... and IMO we should keep the two separate.  This first piece will 
effectively be a no-op (entity_addr_t encoding doesn't yet depend on 
the feature).  Unfortunately it's the hardest part since we need to make 
sure we have the peer features available in all sorts of awkward 
places...

> > 4) We should make the new entity_addr_t encoding encode sockaddr piece 
> > more compactly instead of eating up a full 80-byte sockaddr_storage even 
> > for the ~8-byte IPv4 sockaddr_in.  Maybe just need to encode an 
> > explicit length for the sockaddr_* piece?
> 
> Yes, this could be made more memory efficient.  It's mainly a matter
> of making sure the constructor gets the proper amount of memory.
> There's a C hack to do this, but I remember seeing a c++ technique
> that was a bit less hackish.
> 
> A sockaddr_in is actually 16 bytes of which the last 8 are dummy
> padding (sin_zero).  (And there there are some systems that
> actually check to be sure they're 0.)
> 
> BSD4.4 derived systems have a length coded into sockaddr too - but on
> linux it's usually possible to get by without storing the length, and
> I don't think ceph will need to do so.

I suspect the only way to really do this is put the sockaddr_whatever on 
the heap.  Most entity_addr_t users put it on the stack or embed it in 
other structures, so having it variable sized is not an option.  That has 
a cost, although with an 80-byte sockaddr_storage it may well be worth 
it...  We should probably embed a sockaddr_in[6] and transparently spill 
out to the heap only when exotic addr types are used?

Anyway, that part can come later... the first hurdle is the feature bits 
passed to encode().

sage
