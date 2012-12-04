From: Gregory Farnum <greg@inktank.com>
Subject: Re: Cephfs losing files and corrupting others
Date: Tue, 4 Dec 2012 13:57:39 -0800
Message-ID: <CAPYLRzhi=HLt3PxBgtueaGCO14CH_+UVHxztNZnfu66Hf2+Xxw@mail.gmail.com>
References: <CAD84eiF1dcE5buvTyFctXTSvB4bgEYXtpxwX7yJWiOEASmNvJA@mail.gmail.com>
	<5092F860.7040708@inktank.com>
	<CAD84eiHm84hOAi-VdgVZPvfRWOHCup6sWXpJHGvV+Wcd9sA6vQ@mail.gmail.com>
	<CAPYLRzguxttjgCVCsFF95y18UGPL9D318=R5cGRjCrwAAEMzSA@mail.gmail.com>
	<CAD84eiEDMXiXf8aFojpAFJPt=5DVZNFbnNq9BnJBxMzRrdNjrw@mail.gmail.com>
	<CAD84eiEsDxtq8-1wi8pbBfjd28woduO5vkoPk-rg7U_H8M+w2Q@mail.gmail.com>
	<CAD84eiH9L6wLR56teh6NY1Z5-Y-Cg6fD9n+nVso03pmGNKb4Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37646 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2LDV5l convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 16:57:41 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so7005038ieb.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 13:57:40 -0800 (PST)
In-Reply-To: <CAD84eiH9L6wLR56teh6NY1Z5-Y-Cg6fD9n+nVso03pmGNKb4Bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Howell <nathan.d.howell@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>, Sam Lang <sam.lang@inktank.com>

On Sun, Nov 25, 2012 at 12:45 PM, Nathan Howell
<nathan.d.howell@gmail.com> wrote:
> So when trawling through the filesystem doing checksum validation
> these popped up on the files that are filled with null bytes:
> https://gist.github.com/186ad4c5df816d44f909
>
> Is there any way to fsck today? Looks like feature #86
> http://tracker.newdream.net/issues/86 isn't implemented yet.

Yeah, unfortunately there isn't =97 fsck is one of those things that we
want to do as we prepare CephFS for production use, but we're only now
starting to move back in that direction.

The error printouts you're seeing indicate that...actually, I don't
know what they mean in this context. Hrm. In any case, Zheng Yan
contributed some patches that could impact a number of these issues,
but I still don't see how the NULL bytes could enter into it from our
end. If you can afford the disk space required to turn on "debug osd =3D
10" on the OSDs, and "debug mds =3D 10" on the MDS, that might give us =
a
clue about what's going on, if we manage to grab the logs that overlap
with the bad event (or at least the detection of it). You'll certainly
want to enable log rotation, though =97 that will generate some very
large logs.

Sorry for the slow turnaround time on this, our attention is being
pulled in a lot of directions besides CephFS and this is going to be a
hard one.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
