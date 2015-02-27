From: Andrew Gaul <andrew@gaul.org>
Subject: s3-tests development
Date: Thu, 26 Feb 2015 18:37:35 -0800
Message-ID: <20150227023734.GE21215@sherlock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay02.pair.com ([209.68.5.16]:2798 "HELO relay02.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbbB0CoU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 21:44:20 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello cephalopods, I use s3-tests to test S3Proxy[1], Apache jclouds,
and an internal project.  While s3-tests has good functionality as it
exists, the project has not progressed much over the last six months.  I
have submitted over 20 pull requests to fix incorrect tests and for
additional test coverage but most remain unreviewed[2].  Further
s3-tests remains biased towards Ceph and not the AWS de facto standard,
failing to run against the latter due to TooManyBuckets failures[3].
Finally some features like V4 signature support[4] will require more
extensive changes.  We are at-risk of diverging; how can we best move
forward together?

[1] https://github.com/andrewgaul/s3proxy
[2] https://github.com/ceph/s3-tests/pulls?q=is%3Aopen+is%3Apr
[3] https://github.com/ceph/s3-tests/issues/25
[4] https://github.com/ceph/s3-tests/issues/35

-- 
Andrew Gaul
http://gaul.org/
