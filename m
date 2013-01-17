From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: radosgw boto issue
Date: Thu, 17 Jan 2013 16:31:17 -0500
Message-ID: <50F86DA5.4070502@umiacs.umd.edu>
Reply-To: derek@umiacs.umd.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bubs.umiacs.umd.edu ([128.8.132.55]:37606 "EHLO
	bubs.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab3AQVmm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 16:42:42 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: derek@umiacs.umd.edu

Hi,

Has anyone used boto (python amazon S3 library) to upload files to
radosgw?  I have recently upgraded to 0.56.1 and my javascript code that
I wrote to upload from within the browser is working fine.

When I use the boto library I am getting 500 errors in my apache error logs

FastCGI: comm with server "/var/www/ceph/s3gw.fcgi" aborted: error
parsing headers: duplicate header 'Status'

I have captured the incoming request and it seems valid.

PUT /zeta/rhel5.list HTTP/1.1
Host: myobjstore.mydomain.com
Accept-Encoding: identity
Content-Length: 15909
Content-MD5: UZj3mZeD8WbVeeqFqS81vA==
Expect: 100-Continue
Date: Thu, 17 Jan 2013 19:00:37 GMT
User-Agent: Boto/2.6.0 (linux2)
Content-Type: application/octet-stream
Authorization: AWS ###:###

Found this ticket which seems very similar but is 2 years old.

  http://tracker.newdream.net/issues/439

Currently radosgw does not seem to have much in the way of logging of
the connection. It has a log file but I have never been able to get it
to log anything.  Is there anyway to get it to spit out a bit more of
what it is doing or what it is sending back to the client?

Thanks,
derek

-- 
---
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
