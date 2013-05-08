From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: fix some bugs
Date: Wed, 08 May 2013 17:06:13 -0500
Message-ID: <518ACC55.7090100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:60057 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab3EHWGO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 18:06:14 -0400
Received: by mail-ob0-f180.google.com with SMTP id xk17so117018obc.25
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 15:06:14 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id w7sm283771obx.9.2013.05.08.15.06.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 May 2013 15:06:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series is mostly bug fixes of varying degrees of importance.
The last one is a simple cleanup.  These patches are available in
the "review/wip-rbd-cleanup-2" branch of the ceph-client git
git repository.

					-Alex

[PATCH 1/5] rbd: fix an incorrect assertion condition
[PATCH 2/5] rbd: support reading parent page data
[PATCH 3/5] rbd: set mapping read-only flag in rbd_add()
[PATCH 4/5] rbd: only set up watch for mapped images
[PATCH 5/5] rbd: kill rbd_img_request_get()
