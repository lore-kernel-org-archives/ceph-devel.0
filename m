From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: A design for CephFS forward scrub with multiple MDS
Date: Wed, 21 Sep 2016 11:04:26 -0400
Message-ID: <1A5A8262-2ECD-4C5D-9B77-AFBC3A0BFF5C@redhat.com>
References: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
 <CAJ4mKGYo+P3JHH4OyzdAtmfx5JaMCT+xCzPLA45=BK50KJLAhg@mail.gmail.com>
 <448CAE51-31E6-43FD-9BF0-CDEEA982493E@redhat.com>
 <CAJ4mKGaCZbU1aRNmUJsz8ZY++EKRrRFRyYigye9bdy7ztmw7Pg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f174.google.com ([209.85.213.174]:33553 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934935AbcIUPE3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 11:04:29 -0400
Received: by mail-yb0-f174.google.com with SMTP id 2so28180631ybv.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 08:04:28 -0700 (PDT)
In-Reply-To: <CAJ4mKGaCZbU1aRNmUJsz8ZY++EKRrRFRyYigye9bdy7ztmw7Pg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>


> Well, we can't keep these inodes around the way the code currently
> works: unless I'm much mistaken, nothing is keeping them updated so
> they're just out-of-date copies of metadata. PIN_SCRUBQUEUE exists to
> keep inodes in-memory once on the scrub queue but it was explicitly
> never designed to interact with multi-mds systems and needs to be
> cleaned up; the current behavior is just broken. Luckily, there are
> some not-too-ridiculous solutions.
> * We already freeze a subtree before exporting it. I don't remember if
> that involves actually touching every in-memory CDentry/CInode
> underneath, or marking a flag on the root?
> * We obviously walk our way through the whole subtree when bundling it
> up for export
> So, in one of those passes (or in a new one tacked on to freezing), we
> can detect that an inode is on the scrub queue and remove it.

There’s also:
* Represent the stack of inodes with a different data structure (like an inode_t). Then we could leave the current behavior intact. 

Your subtree bundling suggestion does look interesting, though. I’ll look into it.

