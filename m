From: Pete Zaitcev <zaitcev@redhat.com>
Subject: vstart and Python bindings
Date: Wed, 24 Feb 2016 23:37:18 -0700
Message-ID: <20160224233718.6a8c7569@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58584 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757140AbcBYGhT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Feb 2016 01:37:19 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id E08A1254F
	for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 06:37:18 +0000 (UTC)
Received: from lembas.zaitcev.lan ([10.3.113.6])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1P6bID0019316
	for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 01:37:18 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I did a git pull today and rebuilt. Ran vstart, and it produced a
Python traceback, ending with:

ImportError: No module named rados

Oooookay... This box never had Python bindings installed, but okay,
someone innovated something. Fine, I thought. Installed python-rados,
and ./ceph -w tracebacks:

Traceback (most recent call last):
  File "./ceph", line 953, in <module>
    retval = main()
  File "./ceph", line 778, in main
    run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
AttributeError: 'Rados' object has no attribute 'monitor_log'

Of course. The system version of pybind is obsolete, but ./ceph gets
wrong one. Actually, it's not even getting built from .pyx anymore.

Could whoever did all this please undo?

-- Pete
