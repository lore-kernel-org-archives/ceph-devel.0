From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Very unbalanced storage
Date: Tue, 4 Sep 2012 09:48:13 -0700
Message-ID: <CADvuQRGXbS4=_-Vph=CHi0no6bQb-tqMuwhnri6Og02z6C6hFA@mail.gmail.com>
References: <50409BDC.5010006@gmail.com> <alpine.DEB.2.00.1208310904570.1531@cobra.newdream.net>
 <5041785E.3040707@gmail.com> <alpine.DEB.2.00.1208312000160.27708@cobra.newdream.net>
 <5041B204.7000008@aktzero.com> <CADvuQRGGE9hcqO+NevwTdj97hmUe2eCPCO6mBT5B-oon0zaODw@mail.gmail.com>
 <504629FB.30801@aktzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:49851 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab2IDQse (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 12:48:34 -0400
Received: by ghrr11 with SMTP id r11so1293820ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 09:48:34 -0700 (PDT)
In-Reply-To: <504629FB.30801@aktzero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 4, 2012 at 9:19 AM, Andrew Thompson <andrewkt@aktzero.com> wrote:
> Yes, it was my `data` pool I was trying to grow. After renaming and removing
> the original data pool, I can `ls` my folders/files, but not access them.

Yup, you're seeing ceph-mds being able to access the "metadata" pool,
but all the directory entries pointing at file data that resides in a
pool_id that no longer exists.

While this would be recoverable by rewriting all the directory entries
etc, the simple answer is that your file data is not easily accessible
anymore. If this is just a test filesystem, and you have a recent
backup anyway, you might just go forward with restoring that. If there
is any doubt about that, you can leave the existing content around
until you're sure you can restore the backup successfully, and you
don't really need to re-create the cluster either. If this sounds
necessary, let me know and I'll walk you through the process; but the
simple answer really is recreating the cluster from scratch, so if
this is just test data, go with that.
