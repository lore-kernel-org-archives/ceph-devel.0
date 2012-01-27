From: Christian Brunner <chb@muc.de>
Subject: ceph on XFS
Date: Fri, 27 Jan 2012 21:48:39 +0100
Message-ID: <CAO47_-8JzjxoGB_ZjVwWtdhYLJ3LoVZQyoQoSWuJ1v9W9ioSLg@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39189 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab2A0Usk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 15:48:40 -0500
Received: by vcbgb30 with SMTP id gb30so1489363vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2012 12:48:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

reading the list archives, I get the impression that XFS is the second
best alternative to btrfs. But when I start an ceph-osd on an XFS
volume, there is still a big warning:

WARNING: not btrfs or ext3.  We don't currently support file systems other
             than btrfs and ext3 (data=journal or data=ordered).  Data may be
             lost in the event of a crash.

I know that I can't use btrfs snapshots, but is it really that bad?

I'm running a recent RHEL6.2 kernel now, that has all those wonderful
optimizations, Dave Chinner was talking about.

Thanks,
Christian
