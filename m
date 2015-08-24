From: Sage Weil <sweil@redhat.com>
Subject: wip-addr
Date: Mon, 24 Aug 2015 11:01:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508241046070.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbbHXSCC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Aug 2015 14:02:02 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id CE3A28E67C
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 18:02:02 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mwatts@redhat.com, ceph-devel@vger.kernel.org

Hi Marcus,

I looked over the wip-addr branch a bit.  I have two basic 
questions/concerns:

1) In commit
	https://github.com/ceph/ceph/commit/73b09090466a43d5aceb979a4802de3f3f5bf24a 
we switch the type field from sa_family to transport_type.  This seems 
like the way to go, but we need to deal with the fact that lots of 
clusters out there are IPv6 and have AF_INET6 filled in here.  Probably 
both types should be interpreted to mean "existing/legacy IP messenger" or 
whatever we want to call SimpleMessenger/AsyncMessenger's protocol.

I think encode needs to make sure it fills in that value for the type when 
encoding the legacy entity_addr_t encoding, but could use a/the single 
valid value for the new encoding.  And any get_transport_type() accessor 
should also return the single valid value.

2) In the later commit
	https://github.com/ceph/ceph/commit/9d203a2058f76414703b4fc212a1a0a960d0c672 
you introduce a grammar for printing/parsing the addrs.  This also makes 
sense since e.g. xio uses an IP to identify an endpoint.  I think we 
should identify these based on the *protocol* and not the implementation, 
though... whether we use SimpleMessenger or AsyncMessenger is not a 
property of the address.  Maybe "tcp://" makes more sense here?  Or 
perhaps no prefix at all (a bare IP address), so that this looks the same 
as it did before in the case where the default protocol(s) are in use.

I assume the xio protocol (whether it is rdma or tcp) is closely tied to 
libxio itself.. is that right?  If so, using xio in that prefix makes 
sense.  I'd include xio somewhere in the rdma prefix though (xrdma:// and 
xtcp://)?

What do you think?

Logistically, I think the steps for getting this ready for merge are:

1) Separate out the preliminary patches that pass a feature to the addr 
encoding.. without any of the other cohortfs patches that are currently on 
this branch.  Once this builds we can merge it separately from the rest...

2) The entity_addrvec_t type.

3) The type -> transport_type switch.

4) We should make the new entity_addr_t encoding encode sockaddr piece 
more compactly instead of eating up a full 80-byte sockaddr_storage even 
for the ~8-byte IPv4 sockaddr_in.  Maybe just need to encode an 
explicit length for the sockaddr_* piece?

Something like that?
sage
