From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Filesystems for ceph
Date: Thu, 28 Jul 2011 09:00:18 -0700
Message-ID: <CAF3hT9Cm2opst2NGb4+tPfb0ENog=J3pFL+HADoJwC7jSqk44g@mail.gmail.com>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
	<Pine.LNX.4.64.1107272136110.29447@cobra.newdream.net>
	<CAMjNe_fxSP+tjLsOtu30NRza=SfFkOGQZ8M3ypCr1maUa2O2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52939 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab1G1QAS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 12:00:18 -0400
Received: by mail-yi0-f46.google.com with SMTP id 27so1908157yia.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 09:00:18 -0700 (PDT)
In-Reply-To: <CAMjNe_fxSP+tjLsOtu30NRza=SfFkOGQZ8M3ypCr1maUa2O2Jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 28, 2011 at 12:35 AM, srimugunthan dhandapani
<srimugunthan.dhandapani@gmail.com> wrote:
> I thought that ext3/4 and btrfs are the only recommended underlying
> filesystem for ceph. I didnt know we can use xfs.
> With Glusterfs, theoretically, we can use any filesystem with extended
> attributes support as backend filesystem. Is that the same case with
> ceph too?
> Though it may not be optimal, theoretically can i use a "filesystem X"
> with extended attributes support for ceph?
> thanks,
> Mugunthan

These days you can use any filesystem with xattr support as the
backing store for Ceph, yes. btrfs is our primary target for a few
reasons (unlimited xattrs, built-in snapshots make snapshots and
consistency easier, etc) but you can stick whatever you like back
there and Ceph will handle it with writeahead journaling, manual
copying for snapshots, etc etc. :)
-Greg
