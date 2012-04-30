From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Berserker toolkit for (semi-)automated fs fuzz testing
Date: Mon, 30 Apr 2012 10:13:33 -0700
Message-ID: <CAORUGqBbL6WSt83jqoTJ5kXhbQc_SErYJUK=+yZ6nB2Mg=b=SQ@mail.gmail.com>
References: <CA+qbEUN3DZzCCJm=mLT+QczXs0nN2xE_86RJPcwCLYEKMVtcSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40119 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab2D3RNy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 13:13:54 -0400
Received: by vbbff1 with SMTP id ff1so2203580vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 10:13:53 -0700 (PDT)
In-Reply-To: <CA+qbEUN3DZzCCJm=mLT+QczXs0nN2xE_86RJPcwCLYEKMVtcSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

On Sat, Apr 28, 2012 at 17:29, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> This could be useful for testing the in-kernel Ceph client:
>
> http://www.spinics.net/lists/linux-ext4/msg31856.html

Well, that post is all about non-networked file systems.

zzuf has a network mode (-n) where it hijacks the socket calls and can
randomly mutate the bytes transferred. However, I feel like most of
the benefits of that wrapper are lost, as the Ceph network behavior
just isn't very cleanly deterministic.. even if we included the
cluster serving the client inside the System Under Test for the
fuzzing, I feel like the crashes wouldn't be very reproducible, so
fancy features of that wrapper, like the the git bisect integration,
will not be useful.

What we might want to do is run zzuf to mess with the osds etc while
exercising the usual QA suite, similar to thrashing. Not
deterministically reproducible, but would probably expose some bugs
now and then.
