From: Ken Dreyer <kdreyer@redhat.com>
Subject: Ceph's custom apache: ok to drop?
Date: Fri, 12 Dec 2014 10:12:00 -0700
Message-ID: <548B21E0.80102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36437 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030303AbaLLRMC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Dec 2014 12:12:02 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBCHC1G6005762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 12 Dec 2014 12:12:02 -0500
Received: from mbp.ktdreyer.com (vpn-59-61.rdu2.redhat.com [10.10.59.61])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sBCHC11W001173
	for <ceph-devel@vger.kernel.org>; Fri, 12 Dec 2014 12:12:01 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

The Apache fork that we ship on Ceph.com
(https://github.com/ceph/apache2) is several versions behind upstream
and has a couple CVEs by now.

I've heard from the developers (I don't remember if it was Dan, Yehuda,
or someone else) refer on IRC to the idea that the changes in our Ceph
Apache fork were cosmetic, and it's ok to simply use upstream Apache.

I wanted to confirm this with a wider audience: it's ok to stop
maintaining and shipping our custom Apache?

In other words, we would remove references to our custom Apache from
Teuthology, and our docs, and eventually from our repositories?


-----

Diving into our changes, there are two patches that we have on top of
Apache 2.2.22:

1. "rgw: don't unset Content-Length header on HEAD response (this was
being done when content length was 0)"
https://github.com/ceph/apache2/commit/5ae1b4a081b05fcacf55e7114eec87d9b2a0a5da
. (See also the original patch submission at
http://tracker.ceph.com/issues/897)

2. "don't complain on badly formatted expectations"
https://github.com/ceph/apache2/commit/0d9948f1e483386adef0841896484db8422127b2

Both of these were submitted to Apache upstream in December 2013 (thread
on apache-dev "Ceph patches for httpd") and merged in
http://svn.apache.org/r1554303 .

So his will be controllable via new directives in httpd 2.5:
"HttpContentLengthHeadZero" (defaults to off, ie, continue to squelch
the zero-length header) and HttpExpectStrict (defaults to off, ie,
continue to log the error).

So for httpd 2.5 we have something that gives us what we need.
