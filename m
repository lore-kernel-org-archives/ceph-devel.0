From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: S3 compatibility tests
Date: Mon, 4 Apr 2011 15:00:56 -0700
Message-ID: <20110404220056.GB26652@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51113 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1DDWBA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2011 18:01:00 -0400
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id F13DE2C173
	for <ceph-devel@vger.kernel.org>; Mon,  4 Apr 2011 15:00:59 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. I just published a new git repository, s3-tests.git. It contains a
bunch of integration tests, using an S3-like API, and verifying that
the operations work the right way.

Anyone implementing an S3 clone will probably find it helpful, it's
already unveiled a dozen bugs in radsogw. New tests are welcome.

I expect it'll be licensed under the MIT license, but I want to get
explicit confirmation from Sage before I do that.

README: http://ceph.newdream.net/git/?p=s3-tests.git;a=blob;f=README.rst;hb=master

Gitweb: http://ceph.newdream.net/git/?p=s3-tests.git;a=summary

git clone git://ceph.newdream.net/s3-tests.git

-- 
:(){ :|:&};:
