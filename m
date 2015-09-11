From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: osd: new pool flags: noscrub, nodeep-scrub
Date: Fri, 11 Sep 2015 11:08:29 +0100
Message-ID: <CAJ4mKGZPXnH+z=aBp7vLY35pj4JXq6c_Sq1PFknWj5y0fs2-zQ@mail.gmail.com>
References: <20150911064256.GA12899@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35165 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbbIKKIb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 06:08:31 -0400
Received: by wicge5 with SMTP id ge5so56654470wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 03:08:29 -0700 (PDT)
In-Reply-To: <20150911064256.GA12899@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 11, 2015 at 7:42 AM, Mykola Golub <mgolub@mirantis.com> wro=
te:
> Hi,
>
> I would like to add new pool flags: noscrub and nodeep-scrub, to be
> able to control scrubbing on per pool basis. In our case it could be
> helpful in order to disable scrubbing on cache pools, which does not
> work well right now, but I can imagine other scenarios where it could
> be useful too.

Can you talk more about this? It sounds to me like maybe you dislike
the performance impact of scrubbing, but it's fairly important in
terms of data integrity. I don't think we want to permanently disable
them. A corruption in the cache pool isn't any less important than in
the backing pool =E2=80=94 it will eventually get flushed, and it's whe=
re all
the reads will be handled!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
