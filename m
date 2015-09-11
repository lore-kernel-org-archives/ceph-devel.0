From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: osd: new pool flags: noscrub, nodeep-scrub
Date: Fri, 11 Sep 2015 15:47:05 +0300
Message-ID: <20150911124704.GB12899@gmail.com>
References: <20150911064256.GA12899@gmail.com>
 <CAJ4mKGZPXnH+z=aBp7vLY35pj4JXq6c_Sq1PFknWj5y0fs2-zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35129 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbIKMrI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 08:47:08 -0400
Received: by wicge5 with SMTP id ge5so61667293wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 05:47:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGZPXnH+z=aBp7vLY35pj4JXq6c_Sq1PFknWj5y0fs2-zQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 11, 2015 at 11:08:29AM +0100, Gregory Farnum wrote:
> On Fri, Sep 11, 2015 at 7:42 AM, Mykola Golub <mgolub@mirantis.com> w=
rote:
> > Hi,
> >
> > I would like to add new pool flags: noscrub and nodeep-scrub, to be
> > able to control scrubbing on per pool basis. In our case it could b=
e
> > helpful in order to disable scrubbing on cache pools, which does no=
t
> > work well right now, but I can imagine other scenarios where it cou=
ld
> > be useful too.
>=20
> Can you talk more about this? It sounds to me like maybe you dislike
> the performance impact of scrubbing, but it's fairly important in
> terms of data integrity. I don't think we want to permanently disable
> them. A corruption in the cache pool isn't any less important than in
> the backing pool =E2=80=94 it will eventually get flushed, and it's w=
here all
> the reads will be handled!

I was talking about this:

http://tracker.ceph.com/issues/8752

(false-negative on a caching pool). Although the best solution is
definitely to fix the bug, I am not sure it will be resolved soon (the
bug is open for a year). Still these false-negatives are annoying, as
they complicate monitoring for real inconsistent pgs. In this case I
might want to disable periodic scrub for caching pools, as a
workaround (I could do scrub for them manually though).

This might be not the best example where these flags could be helpful
(I just came to the idea when thinking about a workaround for that
problem, and this looked useful to me in general). We already have
'ceph osd set no[deep-]scrub', and users use it to temporary resolve
high I/O load. Being able to do this per pool looks useful too.

You might have pools of different importance for you, and disabling
scrub for some of them might be ok.

--=20
Mykola Golub
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
