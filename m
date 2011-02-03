From: Brian Chrisman <brchrisman@gmail.com>
Subject: block level diffs in rbd/librados snapshots?
Date: Thu, 3 Feb 2011 09:11:44 -0800
Message-ID: <AANLkTikYU1uy+W9JGwLYwHzYo22s8CEfpFbhubJc0osi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54677 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552Ab1BCRLp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 12:11:45 -0500
Received: by vws16 with SMTP id 16so803133vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Feb 2011 09:11:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm wondering whether I can get block level diff data from the
underlying rados storage to allow me to perform a kind of 'block level
incremental backup' facility.
I can't quite tell from the documentation whether this would be
supported via snapshotting (ie, can I get a map/list of blocks which
have been changed since I created a snapshot on Monday?)

Thanks,
Brian
