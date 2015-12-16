From: Sage Weil <sweil@redhat.com>
Subject: cmake
Date: Wed, 16 Dec 2015 09:33:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379AbbLPRdH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Dec 2015 12:33:07 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id BC9F1C0B2B5B
	for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 17:33:07 +0000 (UTC)
Received: from redhat.com ([10.3.112.19])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBGHX6pd005095
	for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 12:33:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The work to transition to cmake has stalled somewhat.  I've tried to use 
it a few times but keep running into issues that make it unusable for me.  
Not having make check is a big one, but I think the hackery required to 
get that going points to the underlying problem(s).

I seems like the main problem is that automake puts all build targets in 
src/ and cmake spreads them all over build/*.  This makes that you can't 
just add ./ to anything that would normally be in your path (or, 
PATH=.:$PATH, and then run, say, ../qa/workunits/cephtool/test.sh).  
There's a bunch of kludges in vstart.sh to make it work that I think 
mostly point to this issue (and the .libs things).  Is there simply an 
option we can give cmake to make it put built binaries directly in build/?

Stepping back a bit, it seems like the goals should be

1. Be able to completely replace autotools.  I don't fancy maintaining 
both in parallel.

2. Be able to run vstart etc from the build dir.

3. Be able to run ./ceph[-anything] from the build dir, or put the build 
dir in the path.  (I suppose we could rely in a make install step, but 
that seems like more hassle... hopefully it's not neceesary?)

4. make check has to work

5. Use make-dist.sh to generate a release tarball (not make dist)

6. gitbuilders use make-dist.sh and cmake to build packages

7. release process uses make-dist.sh and cmake to build a relelase

I'm probably missing something?

Should we set a target of doing the 10.0.2 or .3 with cmake?

sage
