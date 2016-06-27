From: Sage Weil <sweil@redhat.com>
Subject: ceph build changes
Date: Mon, 27 Jun 2016 22:05:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606272200310.7088@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbcF0WGA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Jun 2016 18:06:00 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75FBA85545
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 22:06:00 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: adeza@redhat.com
Cc: ceph-devel@vger.kernel.org

Hey Alfredo,

Just a heads up that the changes to gitbuilder to enable cmake were pretty 
minimal.  It basically comes down to using the make-dist script to 
generate the tarball instead of running ./autogen.sh, ./configure, and 
then 'make dist' just to get the tarball.  Here's what we changed:

	https://github.com/ceph/autobuild-ceph/commit/eccdc8f61273e97710203eaae55a2c4258b64087

It's slightly annoying because older branches won't have make-dist, but 
newer branches will, and it has to do a build both ways.  Not too crazy, 
though.

The other change was that we have a new environment variable for passing 
down cmake optons that parallels the old CEPH_EXTRA_CONFIGURE_ARGS:

	https://github.com/ceph/autobuild-ceph/commit/71d02e8b2c9bd3533c44b3bf0408681ed7890248

I'm guessing we don't need that for a proper release, but in case we do, 
the script should just set both.

Anyway, with those changes, the final step is to change debian/rules and 
ceph.spec.in in ceph.git itself to build using cmake instead of autotools, 
but as long as the source tarball is coming from make-dist the ceph-build 
stuff doesn't need to know or care about that--it's all hidden by rpmbuild 
and dpkg-buildpackage/pbuilder.

As soon as the deb and rpm changes are working when built by the 
gitbuilders (basically there with debs, rpms up next) I think we should do 
a dev release through the new jenkins pipeline to demonstrate that the 
whole thing works.  Maybe the week after next?

Thanks!
sage
