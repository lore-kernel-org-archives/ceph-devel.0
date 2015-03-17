From: Ken Dreyer <kdreyer@redhat.com>
Subject: regenerating man pages
Date: Tue, 17 Mar 2015 10:40:49 -0600
Message-ID: <55085911.9060800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56102 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402AbbCQQku (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Mar 2015 12:40:50 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 3AF30C63D0
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 16:40:50 +0000 (UTC)
Received: from mbp.ktdreyer.com (vpn-53-44.rdu2.redhat.com [10.10.53.44])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2HGen3B000372
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 12:40:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I had a question about the way that we're handling man pages.

In 356a749f63181d401d16371446bb8dc4f196c2a6 , "rbd: regenerate rbd(8)
man page", it looks like man/rbd.8 was regenerated from doc/man/8/rbd.rst

It seems like it would be more efficient to avoid storing man pages in
Git and generate them dynamically at build time instead?

https://github.com/ceph/ceph/blob/master/admin/manpage-howto.txt

"admin/build-doc" does a lot of things (including man page generation).
Could we simply run the "sphinx-build -b man" part at build time as a
part of "make"?

Just trying to understand what's intentional, whether I'm missing
something, etc.

- Ken
