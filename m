From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: clean up use of ctl_mutex
Date: Fri, 31 May 2013 20:17:52 -0500
Message-ID: <51A94BC0.4080703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45174 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab3FABRy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 21:17:54 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so5760903iea.18
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 18:17:54 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id n5sm5887867igx.1.2013.05.31.18.17.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 18:17:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This series eliminates most uses of the ctl_mutex for locking.
Its precise purpose was always a little fuzzy to me; with this
series in place it is now only used to protect looking up
ceph clients.  It also eliminates some lockdep problems
reported at unmap time.

					-Alex

[PATCH 1/5] rbd: set removing flag while holding list lock
[PATCH 2/5] rbd: protect against concurrent unmaps
[PATCH 3/5] rbd: don't hold ctl_mutex to get/put device
[PATCH 4/5] rbd: use rwsem to protect header updates
[PATCH 5/5] rbd: take a little credit
