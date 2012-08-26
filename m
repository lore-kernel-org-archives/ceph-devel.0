From: Gregory Farnum <greg@inktank.com>
Subject: Re: About sparse images
Date: Sun, 26 Aug 2012 12:42:20 -0700
Message-ID: <649A15670E764B2E9397EDA1919205C7@inktank.com>
References: <CAOLwVUnGz4ZvWdNo6JKHuS06YZYCeT7WjaDdGiDipRv8UZVLhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59677 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2HZTmN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 15:42:13 -0400
Received: by dady13 with SMTP id y13so2059205dad.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 12:42:13 -0700 (PDT)
In-Reply-To: <CAOLwVUnGz4ZvWdNo6JKHuS06YZYCeT7WjaDdGiDipRv8UZVLhA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sunday, August 26, 2012 at 11:11 AM, S=C3=A9bastien Han wrote:
> Hi all!
> =20
> I know that ceph images (rbd) are sparse. It's good but I have some
> interrogations about the ceph -s (-w) output. Let's say your create a
> 10G image, map it, format it and mount it. Finally you filled up the
> entire space available. You notice that the 'data' and 'used' space
> had grown. Now delete the content of your image but **not** this
> image, not now. You notice that nothing changed from the ceph output,
> it's not surprising because of the sparse capability. At this point o=
f
> time the output from the command ceph is neither right nor wrong. It
> only shows the space used by the sparse image, but it doesn't mean
> that you have 'real' data in it, just a simple object allocation. It'=
s
> not so relevant, the only solution is to remove the image (obviously)=
=2E
> My feeling is that we should be careful about the ceph's output, it's
> not a good indicator for 'real' data. Ok Ceph won't replace a
> monitoring system but I'll be happy to trust the ceph output at 100%
> :)

The output of ceph -s is intended to describe the amount of space alloc=
ated by RADOS across the OSDs. As far as any part of the Ceph project k=
nows, the objects in those RBD images are real data and can't be remove=
d.
If you're interested in removing them, subsets of the RBD clients do su=
pport TRIM operations, which will remove the objects themselves. Josh o=
r somebody will have to speak about which clients, though.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
