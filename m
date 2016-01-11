From: kefu chai <tchaikov@gmail.com>
Subject: Re: deprecation and build warnings
Date: Tue, 12 Jan 2016 01:38:10 +0800
Message-ID: <CAJE9aOP0-ZqM-ECzdM6m7pp6Xg2SbaDE0qMjA_AjqxoFV70zBw@mail.gmail.com>
References: <CAJ4mKGZmuFy39rDW6JTfPUbJ7L3xpoq3ttje1CORVNY4eCkbHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36688 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704AbcAKRiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jan 2016 12:38:10 -0500
Received: by mail-yk0-f169.google.com with SMTP id v14so345583103ykd.3
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jan 2016 09:38:10 -0800 (PST)
In-Reply-To: <CAJ4mKGZmuFy39rDW6JTfPUbJ7L3xpoq3ttje1CORVNY4eCkbHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 6, 2016 at 2:58 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> I was annoyed again at our gitbuilders being all yellow because of
> compile warnings so I went to check out how many of them are real and
> how many of them are self-inflicted warnings. I just spot-checked
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-amd64-basic/log.cgi?log=2694e1171f23166e8a11c57c7b284621498decd8,
> but much to my pleasant surprise there are only two errors:
>
> 1) we have 16 uses of rados_ioctx_pool_required_alignment, which is deprecated.
> 2) we have two uses of libec_isa.so being linked against a loadable module.
>
> Both of these are contained entirely in our unit tests. I don't know
> exactly what's going on with the second one, but I imagine it's not a
> difficult fix? For the first one, can we just stop testing it? Or in
> some way suppress the warning for those callers? I'd love to have some
> green show up on the dashboard again, so that it's not too hard to
> notice when we introduce actual build regressions. ;)

i am preparing a fix for them, at
https://github.com/tchaikov/ceph/tree/wip-kill-warnings .


> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
