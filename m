From: Christian Brunner <chb@muc.de>
Subject: rbd export from corrupted cluster
Date: Mon, 2 May 2011 22:16:25 +0200
Message-ID: <BANLkTi=nkcY5FYi2DGPP-aE3S8z457C8Pw@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60052 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1EBUQ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2011 16:16:26 -0400
Received: by vws1 with SMTP id 1so4518903vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 May 2011 13:16:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

after a series of hardware defects, I have a corrupted ceph cluster:

2011-05-02 18:12:31.038446    pg v8171648: 3712 pgs: 26 active, 3663
active+clean, 5 crashed+peering, 18 active+clean+inconsistent; 547 GB
data, 388 GB used, 51922 GB / 78245 GB avail; 2410/284300 degraded
(0.848%)

Now I wanted to export an rbd-image with "rbd export" and run a
filesystem-check on the image. The only problem is, that the export is
blocking on the first corrupted object. I think it would be better to
detect the failure and return some blocks filled with zero.

Is there a way to accomplish this?

Regards,
Christian
