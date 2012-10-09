From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: workqueue changes
Date: Tue, 09 Oct 2012 14:28:33 -0700
Message-ID: <50749701.8010208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41979 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab2JIV2h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:28:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5687617pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 14:28:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These patches change the flags passed when creating the ceph
messenger work queue.  They're done in two distinct steps
so their separate effects can more easily be isolated.

     [PATCH 1/2] libceph: mark ceph_msgr_wq reentrant
     [PATCH 2/2] libceph: mark ceph_msgr_wq unbounded

					-Alex
