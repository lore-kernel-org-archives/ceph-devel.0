From: Sage Weil <sweil@redhat.com>
Subject: on-the-wire encryption, addrs, and cephx
Date: Thu, 5 May 2016 08:57:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49243 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbcEEM5H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 May 2016 08:57:07 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C939BC00075A
	for <ceph-devel@vger.kernel.org>; Thu,  5 May 2016 12:57:05 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u45Cv3Xc007946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 5 May 2016 08:57:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

We had a call last night (Marcus, Haomai, Yehuda, our GSoC student Zhao, 
and me) to discuss on-the-wire encryption.  The main concern was how the 
decision to encrypt would be wired in, so we spent most of an hour 
reviewing what the current auth handshake/negotiation code does and what 
our options were for changing it to securely support this.

The requirements were:

 - the ability to securely encrypt sessions between new clients/servers
 - the ability to also support unencrypted sessions between old clients 
and new servers (for the transition period)
 - tune the 'require' options to distinguish between clients and cluster 
(mon/osd/mds) hosts.

There are several problems with our current auth and cephx code that 
prevent a trivial solution (using the existing cephx session key to 
encrypt) from working:

 - the mon auth negotiation happens by exchanging MAuth messages, a 
layer above the messenger, making a transition from unauthenticated to 
encrypted or signed awkward.  (Notably, signing isn't supported 
here now either.)
 - the messenger handshake exchanges feature bits without including them 
in the authentication handshake, which means making a decision like 
"encrypt if it is supported" would not be not secure.

The current messenger handshake does not lend itself to clean negotiation 
of optional features until feature bits are exchanged (insecurely) several 
steps along in the process, making extensions awkward.  Although we could 
hack it to switch to a new (more secure) protocol once peers decide they 
both support it, it would be ugly, and would force us to support the 
legacy protocol indefinitely (as opposed to deprecating it after a few 
releases).

So, the current plan is:

1) Create a new messenger handshake protocol that addresses the flaws in 
the current approach (secure feature negotation, mon authentication in 
messenger layer).  Marcus is doing some background research to identify 
what protocols we should model or use here.  We cannot drop the basic 
properties of messenger (e.g., async message exhange) by switching to 
something RPC based, for example.

(We talked about whether just jumping into a Kerberos world wholesale 
makes sense or would help here, and decided that although we could do what 
cephx does with kerberos, doing so doesn't change any of the protocol 
pieces--and in fact krb5 would effectivel slot in as an alternative, 
pluggable auth mode next to cephx.  As we go through this process we 
should verify that a native kerberos approach fits in properly.)

2) We will finish the long-awaited wip-addr refactor.  This will provide:

   - better typing of entity_addr_t with a transport and/or protocol type, 
so that we can distinguish between endpoints that speak the legacy vs new 
messenger protocol.

   - the ability to list multiple endpoints for daemons where currently we 
have only one.  This way each daemon can bind to two ports, one speaking 
legacy and one speaking v2.  When encoding the addrvec for legacy clients, 
we would include only the legacy addr.

3) The above works great for most daemons, but the monitors themselves 
also have to support both legacy and v2 connections.  Conveniently, we 
also just got an IANA port assignment and need to transition to using that 
anyway.  We can make monitors listen to legacy connections on 6789 and v2 
connections on the new port 3300.

4) Finally, we can put all the new features in the new protocol.  We want 
to support auth_none (no validation or authentication), authentication 
only, authentication and signing (integrity but not secrecy), and full 
encryption.

Notes from our call are on this etherpad:

	http://pad.ceph.com/p/on-the-wire-encryption

The design for the new protocol (1) and work on the wip-addr refactor (2) 
can start now and proceed in parallel.  Zhao is going to start with (2).  

There are a few questions:

- Should we bother implementing v2 for SimpleMessenger?  I think no.

- Should we work on native kerberos as an auth type at the same time?  It 
would be nice to do this while desiging the v2 protocol to ensure that we 
don't box ourselves into a corner.  OTOH, I don't think we have anyone to 
spare to do it and it's not really a priority.  (We also don't want to 
make kerberos a dependency, so we can't/shouldn't abandon cephx.)  If 
there is a new contributor who is interested in doing kerberos support, 
now would be the time to speak up.

Comments, questions welcome!

sage
