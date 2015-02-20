From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: disable pg_num warning?
Date: Fri, 20 Feb 2015 10:15:00 -0500
Message-ID: <CAGbvivKMkar+cEhNeXATp76BzPtfxdERZ=6JoieD3k57e19PxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34390 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbBTPPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 10:15:00 -0500
Received: by mail-oi0-f49.google.com with SMTP id v63so3027352oia.8
        for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2015 07:15:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is there a way to disable the warning (shown when doing "ceph -s", for
example) about the number of pgs ("too few pgs per osd") ?

Would it be considered risky to disable it?

Consider when a cluster is initially created with just a single pool,
and you don't anticipate that this pool will ever be more than a very
small percentage of the total capacity (1%, for example).  The new
calculator (http://ceph.com/pgcalc) recommends a small pg_num like
128.  However, for a cluster with 144 OSDs, this will trigger the
warning about the pg num being too small.

It seems that the calculation that triggers the warning is a little
bit too simplistic, and while it might be useful in some cases, it is
also a nuisance warning that can be ignored in some environments.  It
would be nice to tell ceph to ignore it and return a healthy status if
everything else is clean.

-Wyllys Ingersoll
