From: Sage Weil <sweil@redhat.com>
Subject: wip-mdscap
Date: Wed, 8 Jul 2015 13:10:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507081304320.28782@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550AbbGHUKh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 Jul 2015 16:10:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jashank42@gmail.com, nishtha3rai@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Nistha, Jashan,

I was helping Nishtha get debugging working in MDSAuthCap and ended up 
fixing a few other issues with wip-mdscap:

 - it now takes a CephContext *cct, which means you can add debug lines 
inside MDSAuthCaps.cc like so:

  ldout(cct, 10) << "debug foo blah" << dendl;

and it will show up in the mds log.

 - I fixed the MDSCapMatch::allow_all() so that it returns true when path 
== "" (instead of "/").. this fixes several of the unittest_mds_authcap 
tests.

 - I fixed the other tests to not include a leading /, which fixes the 
rest.

 - Fixed the get_projected_parent_dn() call.

Jashan, not sure how far you got after we spoke earlier, but I'd suggest 
going this route and making the paths you pass into is_capable() *not* 
include any leading /.

I pushed it all as wip-mdscap.  If possible it'll help to rebase what 
you're working with on top of this branch.

I'm going to try to make a point of being on IRC around 9am ET (6:30 IST) 
to check in with Nishtha.  Jashan, if you are also available around that 
time it would be great to touch base with you then as well.

Thanks!
sage
