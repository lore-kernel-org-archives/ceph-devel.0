From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: reorder some setup operations
Date: Sat, 27 Apr 2013 07:31:33 -0500
Message-ID: <517BC525.8090403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60463 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3D0Mbf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:31:35 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so6011089iec.29
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:31:35 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xf4sm7702730igb.8.2013.04.27.05.31.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:31:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first patch of this series doesn't really belong,
but I threw it in anyway.  The other three defer doing
some initialization of an rbd device until just before
it gets activated by a call to add_disk().

					-Alex

[PATCH 1/4] rbd: fix up some sysfs stuff
[PATCH 2/4] rbd: only set device exists flag when ready
[PATCH 3/4] rbd: defer setting disk capacity
[PATCH 4/4] rbd: defer setting the mapping size and features
