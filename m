From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: clear EXISTS flag for disappearing snapshot
Date: Wed, 01 May 2013 16:29:41 -0500
Message-ID: <51818945.1040002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:58827 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159Ab3EAV3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:29:44 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so2357860iec.8
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:29:43 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id fl5sm5669861igb.9.2013.05.01.14.29.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:29:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first patch in this series puts back some functionality
that was deleted inadvertently by the previous commit.  Josh
pointed out it had disappeared.  The second one replaces a
linear search of snapshot ids with a binary search for
efficiency.

					-Alex

[PATCH 1/2] rbd: clear EXISTS flag if mapped snapshot disappears
[PATCH 2/2] rbd: use binary search for snapshot lookup
