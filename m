From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: how to run ceph on top of other local file system
Date: Mon, 17 Oct 2011 10:13:42 -0700
Message-ID: <CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59801 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab1JQROD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 13:14:03 -0400
Received: by eye27 with SMTP id 27so3178292eye.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2011 10:14:02 -0700 (PDT)
In-Reply-To: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Oct 17, 2011 at 10:10, sheng qiu <herbert1984106@gmail.com> wrote:
> Hi all,
>
> i am new here. i want to use ceph to build a DFS. while i see, ceph
> can only use ext3/4 and btreefs to manage the osd. how can i modify it
> to support other local file system?

Ceph works with any POSIX-compliant filesystem that supports extended
attributes. It can also use just a subdirectory of an existing
filesystem.
