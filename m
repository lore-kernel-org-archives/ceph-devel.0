From: Mark Kampe <mark.kampe@dreamhost.com>
Subject: moving towards release criteria
Date: Mon, 28 Nov 2011 11:01:22 -0800
Message-ID: <4ED3DA82.7030506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56509 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab1K1TBW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 14:01:22 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id AF3C5C063
	for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 11:10:26 -0800 (PST)
Received: from [192.168.107.232] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A850EC062
	for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 11:10:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

At present we are running automated nightlies to catch
problems that slip past developers or only show up on
long runs, and filing bugs when they fail ... but the
decision of whether or not we are ready to push out a
new release is not yet criterion-based.  We have to
start moving towards official release criteria.

I suggest that our initial release criteria should fall
into four categories:

   (1) functional validation

	100% passage of designated validation suites,
	with a formal process for managing the functional
	assertions to be tested (or designating specific
	assertions to be compliance-optional)
	
   (2) regression tests

	100% passage of designated regression suites,
	with a formal process for designating which
	bugs do and do not require the creation of
	new regression test cases.

   (3) performance

	individual and aggregate throughput measurements,
	and key-event timings will be made with controlled
	loads on specified hardware configuration, and
	compared against performance targets, and a formal
	process for defining the target metrics and requirements.

   (4) reliability and robustness

	a specified number of hours of (client perceived) error
	free operation under continuous load (with specified
	levels and characteristics), in the face of specified
	error injections ... and a formal process for defining
	the times, load characteristics, error injections, and
	acceptable performance.

Does this seem like the right general form for our release criteria? 
What changes would you suggest?

Once we agree on the general form of our release criteria, the next
steps are:

   (a) put some stakes in the ground for the initial requirements
       (knowing that they will evolve in scope, specificity, and
       rigour)

   (b) propose some processes for the review, approval, and
       evolution of those standards, and the communication of
       the (current) requirements and results to the community.

   (c) set a date for the first release to be subject to these
       criteria

comments?
