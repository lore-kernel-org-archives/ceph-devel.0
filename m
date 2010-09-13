From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Questions about ceph
Date: Mon, 13 Sep 2010 08:11:57 -0700
Message-ID: <AANLkTi=Z-EcGa2QQDJmJWTycBchmeqah1Ni2uARrm-M=@mail.gmail.com>
References: <AANLkTi=3RgYs8yE6Q+yPjEEsMvX5Bt-x9qK__WzMs_JW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:32859 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab0IMPL6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Sep 2010 11:11:58 -0400
Received: by qyk33 with SMTP id 33so5329938qyk.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Sep 2010 08:11:58 -0700 (PDT)
In-Reply-To: <AANLkTi=3RgYs8yE6Q+yPjEEsMvX5Bt-x9qK__WzMs_JW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mag Gam <magawake@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 13, 2010 at 4:16 AM, Mag Gam <magawake@gmail.com> wrote:
> Do ceph clients need fuse module? or is the file system provided
> natively thru the ceph module?
No, clients don't need the FUSE module if you're using the in-kernel client.

> Is the filesystem POSIX compliant?
Yes! Being POSIX-compliant is one of Ceph's missions in life.

> For the underlying filesystem does it have to be BRTFS? We are a heavy XFS
> and ext2 shop for performance.
The underlying FS doesn't need to be btrfs, but it generally has
better performance and consistency guarantees while using Ceph than
other FSes will. Ceph uses some btrfs-only ioctls to control on-disk
state for guaranteed consistency, and advanced features like snapshots
will go faster with btrfs since it supports them natively (other FSes
require lots of full copies with snapshots). Remember that the FS
characteristics of something running on [Ceph on ext2] will be very
different from running on [ext2].
Sage can talk more about this, though; he does a lot of random things
to make the on-disk stuff work nicely under different configurations.

> We are very excited about this filesystem and we would like to start
> using it and start contributing by benchmarking it and submitted any
> bug reports to stabilize it for distributions.
:) Thanks for looking at Ceph!
-Greg
