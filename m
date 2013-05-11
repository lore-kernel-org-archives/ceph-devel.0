From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: prep work for flattening images
Date: Sat, 11 May 2013 12:42:54 -0500
Message-ID: <518E831E.6000206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:62318 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab3EKRm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:42:56 -0400
Received: by mail-ia0-f180.google.com with SMTP id l27so177511iae.25
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:42:55 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xf4sm5625993igb.8.2013.05.11.10.42.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:42:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series of patches prepares some parent request
code to make handling the event of a mapped clone
image getting flattened easier.

					-Alex

[PATCH 1/5] rbd: get parent info on refresh
[PATCH 2/5] rbd: don't release write request until necessary
[PATCH 3/5] rbd: define rbd_dev_unparent()
[PATCH 4/5] rbd: define parent image request routines
[PATCH 5/5] rbd: reference count parent requests
