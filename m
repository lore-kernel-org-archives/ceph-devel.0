From: Samuel Just <sjust@redhat.com>
Subject: Re: Data-at-rest compression at EC pools blueprint
Date: Wed, 30 Sep 2015 11:40:49 -0700
Message-ID: <CAN=+7FUzyWRJ+PWbuJv1T2=uORFTPmr8_XRpMthAiy10oT+caQ@mail.gmail.com>
References: <560C0356.90401@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38001 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbbI3Skt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Sep 2015 14:40:49 -0400
Received: by igxx6 with SMTP id x6so37750883igx.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Sep 2015 11:40:49 -0700 (PDT)
In-Reply-To: <560C0356.90401@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Seems like a reasonable start.  Quick back-of-the-envelope calculation
suggests 2k of (logical_offset, compressed_offset) pairs per 1MB of
data with 8MB/pair and 4k chunks, which is probably ok to stuff into
an xattr.  You should restructure the blueprint to make it independent
of EC.  ReplicatedPG can do this before feeding the writes to the
backend (whichever backend is used) -- the pool alignment parameter
could be set on a replicated pool to enforce aligned appends on a
compressed replicated pool.
-Sam

On Wed, Sep 30, 2015 at 8:44 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Folks,
>
> I've just added a blueprint about adding compression to EC pools as per our
> previous discussion.
> Please find it at
> http://tracker.ceph.com/projects/ceph/wiki/Submissions
>
> Not sure I did that in proper manner - by attaching a new file. Other
> blueprints look different at this page. Can't undo though.
> Sorry about that.
>
> And please point out different way to publish my blueprint if needed.
>
> Any way - comments and reviews on the content are welcome.
>
> Thanks.,
> Igor.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
