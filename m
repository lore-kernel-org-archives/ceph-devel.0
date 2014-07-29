From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: Admin Operations API Quota Get
Date: Tue, 29 Jul 2014 13:32:11 -0400
Message-ID: <53D7DA9B.2000407@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bubs.umiacs.umd.edu ([128.8.132.55]:35261 "EHLO
	bubs.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaG2Rmp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 13:42:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: derek@umiacs.umd.edu

http://ceph.com/docs/master/radosgw/adminops/#get-user-quota

I had logged a bug report[1] and I just wanted to see if anyone else was
using the admin api for radosgw to manage quotas?  We have a workaround
wrapping the command line rgwadmin but it would be very nice to be able
to just use the API.

[1] - http://tracker.ceph.com/issues/8293

-- 
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
