From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ping_pong test of ceph
Date: Sun, 30 Oct 2011 19:03:05 -0700
Message-ID: <CAF3hT9CkNdi4UFgAPhqy9xzk8s_7Tz6bqG5aTW3k87oxfEEt7g@mail.gmail.com>
References: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
	<CAF3hT9BEhwGVeiud0fDmBscB2KKc1uAJxvAEGQZ2KAW6pWOhTg@mail.gmail.com>
	<CAMwsgzNkgd0gYf_LNELWfB8Fd5e7HP0v=R8wgAOG8jkEXUxG9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47120 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab1JaCDG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Oct 2011 22:03:06 -0400
Received: by iaby12 with SMTP id y12so6635300iab.19
        for <ceph-devel@vger.kernel.org>; Sun, 30 Oct 2011 19:03:06 -0700 (PDT)
In-Reply-To: <CAMwsgzNkgd0gYf_LNELWfB8Fd5e7HP0v=R8wgAOG8jkEXUxG9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mowang da <whooya.xxl@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Oct 30, 2011 at 6:21 PM, mowang da <whooya.xxl@gmail.com> wrote:
> hi all,
> this bug has been fixed yet? i can't find any information of it.
> thanks for your help.

Yes, it was fixed a while ago in our master branch and is fixed in our
last couple of releases. (Our newest is v0.37.)
As the problem was in the MDS server, to see this fix you only need to
upgrade the userspace packages. :)
-Greg
