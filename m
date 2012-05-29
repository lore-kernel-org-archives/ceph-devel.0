From: Tommi Virtanen <tv@inktank.com>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Tue, 29 May 2012 09:18:19 -0700
Message-ID: <CADvuQRF5zC78hySCf3gYeJkRWGa+KjMKcY==0hqBxJrLhFv9dw@mail.gmail.com>
References: <201205290944.33983.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51914 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab2E2QSk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 12:18:40 -0400
Received: by dady13 with SMTP id y13so5629341dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:18:39 -0700 (PDT)
In-Reply-To: <201205290944.33983.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Tue, May 29, 2012 at 12:44 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> On Linux, if you run OSD on ext4 filesystem, have a cephfs kernel client mount
> on the same system and no syncfs system call (as to be expected with libc6 <
> 2.14 or kernel < 2.6.39), OSD deadlocks in sys_sync(). Only reboot recovers
> the system.

This is the classic issue of memory pressure needing free memory to be
relieved. While syncfs(2) may make the hang less common, I do not
think having syncfs(2) is enough; nothing sort of having a reserved
memory pool guaranteed to be big enough to handle the request will,
and maintaining that solution is hideously complex.

Loopback NFS suffers from the exact same thing.

Apparently using ceph-fuse is enough to move so much of the processing
to user space, that the pageability of userspace memory allows the
system to recover.

Here's a fragment of the earlier conversation on this topic. Apologies
for gmane/mail clients breaking the thread, anything with that subject
line is part of the conversation:

http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/1673
