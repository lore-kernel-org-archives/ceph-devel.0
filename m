From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: use slab caches in messenger and osd osd client
Date: Wed, 01 May 2013 16:37:22 -0500
Message-ID: <51818B12.4010307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:43669 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932876Ab3EAVhY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:37:24 -0400
Received: by mail-ia0-f180.google.com with SMTP id t4so38086iag.11
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:37:24 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id y5sm5730257igg.7.2013.05.01.14.37.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:37:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series adds slab caches to some frequently-allocated
data structures in the messenger and the osd client.

					-Alex

[PATCH 1/3] libceph: allocate ceph messages with a slab allocator
[PATCH 2/3] libceph: allocate ceph message data with a slab
[PATCH 3/3] libceph: use slab cache for osd client requests
