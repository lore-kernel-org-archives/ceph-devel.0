From: Sage Weil <sweil@redhat.com>
Subject: wip-addr-features
Date: Thu, 5 May 2016 11:41:17 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605051043220.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114AbcEEPlH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 May 2016 11:41:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zhjwpku@gmail.com, ceph-devel@vger.kernel.org

Hi Zhao,

We identified wip-addr as a desireable first step to fixing up the 
messenger protocol.  It has a bunch of other nice benefits as well, like 
being able to support both IPv4 and IPv6 in the same cluster.

I started rebasing the branch this morning ran into a bunch of non-trivial 
questions about how we should structure the entity_addr_t to support both 
new address types (ipv4, ipv6, xio, etc.) *and* the a new on-wire 
protocol.  But this is actually step 2...

Step 1 is to just get the feature bits plumbed down to every bit of code 
that encodes an entity_addr_t to send over the wire so that we will 
know whether to encode using the new or legacy format.  To do that, I 
pushed a simplified branch, wip-addr-features, to

	https://github.com/liewegas/ceph/commits/wip-addr-features

The are some prelim encoding patches, then a patch that makes 
entity_addr_t and entity_inst_t *optionally* accept feature bits.  Let's 
call it optional-features-patch.  This compiles cleanly, and allows either 
an existing featureless encode

  entity_addr_t foo;
  ::encode(foo, bl);             // old way we need to eliminate

or a featured encode

  entity_addr_t foo;
  ::encode(foo, bl, features);   // what we want

compile.

Then there's a patch that makes the old way not compile.  Let's call it 
required-features-patch.  This will make the compiler spit out a million 
errors for all the call sites that still need to be fixed.

Finally, there is a 'wip' commit that fixes some but not all call sites.  
This commit needs to be broken down into simple, individual changes that 
can be tested and reviewed separately.

The idea is to work with the require-features-patch applied to identify 
remaining call sites that need features to encode entity_addr_t.  Create 
small, contained patches that fix individual modules, call sites, or add 
supporting infrastructure (like the changes that expose features to OSD 
cls ops in objclass/*).

Once there are several of those, remove the require-features-patch, and 
make sure the changes are safe and clean and everything still works 
properly.  We can merge these as we go to make incremental progress.

Finally, once *everything* is fixed to pass features to addr encode sites, 
the last commit will be the require-features-patch, and we can get it all 
in master.

That will lay the foundation so that we can change the entity_addr_t 
encoding to support the new protocols and encoding, the entity_addrvec_t 
type, and so on.

(The plan is to replace most instnaces of entity_addr_t with 
entity_addrvec_t--a list of addresses instead of a single one.  And make 
entity_addrvec_t encoded with old features spit out the legacy addr with 
the legacy entity_addr_t encoding so that old clients can still function.)

We're all in #ceph-devel on irc.oftc.net--feel free to ask questions there 
or on this email thread.  Or we can do another video conf session to go 
through it.

Thanks!
sage
