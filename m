From: Guang Yang <guangyy@gmail.com>
Subject: Journal Disk Cache - on or off
Date: Fri, 29 Jan 2016 09:37:33 -0800
Message-ID: <CAKtk8hceHCVqZpiA0cCu-17-oJmTgvUihHJujyTcggpzYc-75Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35340 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449AbcA2Rhe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 12:37:34 -0500
Received: by mail-yk0-f176.google.com with SMTP id r207so33678999ykd.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jan 2016 09:37:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hi Sage,
I found a thread discussing whether we could turn on disk cache with
new kernel or not -
http://www.spinics.net/lists/ceph-devel/msg06173.html

From within that thread, you mentioned that since the fsync/fdatasync
would flush the disk cache as well, we could actually turn on the
cache without worrying about the data safety.

Is that true if journal_dio is being used (by default), in which case
O_DIRECT | O_DSYNC is being used to write journal rather than
fsync(2)?

Thanks,
Guang
