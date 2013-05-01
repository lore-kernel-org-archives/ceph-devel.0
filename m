From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: use slab caches for frequently allocated structures
Date: Wed, 01 May 2013 16:34:20 -0500
Message-ID: <51818A5C.1080903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:48536 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410Ab3EAVeX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:34:23 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so2450675iec.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:34:23 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wx2sm5750771igb.4.2013.05.01.14.34.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:34:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series adds some slab caches for structures related
to rbd osd requests.

					-Alex

[PATCH 1/4] rbd: allocate image requests with a slab allocator
[PATCH 2/4] rbd: allocate name separate from obj_request
[PATCH 3/4] rbd: allocate object requests with a slab allocator
[PATCH 4/4] rbd: allocate image object names with a slab allocator
