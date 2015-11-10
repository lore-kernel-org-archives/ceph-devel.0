From: Pete Zaitcev <zaitcev@redhat.com>
Subject: RGW multi-tenancy APIs overview
Date: Mon, 9 Nov 2015 22:10:15 -0700
Message-ID: <20151109221015.2fa7745c@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbbKJFKQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Nov 2015 00:10:16 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 40C368E259
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 05:10:16 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>

With ticket 5073 getting close to complete, we're getting the APIs mostly
nailed down. Most of them come down to selection a syntax separator
character. Unfortunately, there are several such characters. Plus,
it is not always feasible to get by with a character (in S3 at least).

So far we have the following changes:

#1 Back-end and radosgw-admin use '/' or "tenant/bucket". This is what is
literally stored in RADOS, because it's used to name bucket objects in
the .rgw pool.

#2 Buckets in Swift URLs use '\' (backslash), because there does not seem
to be a way to use '/'. Example:
 http://host.corp.com:8080/swift/v1/testen\testcont

At first, I tried URL encoding (%2f), but that didn't work: we permit '%'
in Swift container names, so there's a show-stopper compatibility problem.
So, backslash. The backslash poses a similar problem, too, but hopefuly
nobody created a container with backslash in name.

Note that strictly speaking, we don't really need this, since Swift URLs
could easily include tenant names where reference Swift places account names.
It's just easier to implement without disturbing authenthication code.

#3 S3 host addressing of buckets

This is similar to Swift and is slated to use backslash. Note that S3
prohibits it, so we're reasonably safe with this choice.

#4 S3 URL addressing of buckets

Here we must use a period. Example:
 bucket.tenant.host.corp.com

#5 Listings and redirects.

Listings present a difficulty in S3: we don't know if the name will be
used in host-based or URL-based addressing of a bucket. So, we put the
tenant of a bucket into a separate XML attribute.

Since Swift listings are always in a specific account, and thus tenant,
they are unchanged.

In addition to listings, bucket names leak into certain HTTP headers, where
we add "Tenant:" headers as appropriate.

Finally, multi-tenancy also puts user_uid namespaces under tenants as well
as bucket namespaces. That one is easy though. A '$' separator is used
consistently for it (tenant$user).

-- Pete
