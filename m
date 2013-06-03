From: Samuel Just <sam.just@inktank.com>
Subject: Re: rationale for a PGLog::merge_old_entry case
Date: Mon, 3 Jun 2013 13:28:07 -0700
Message-ID: <CA+4uBUaN7p8kJw5o8i0L9WxQ5j9UmrAb09N6a8jFiQAWkVYSpg@mail.gmail.com>
References: <51AB2803.9010807@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:44345 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab3FCU2J convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 16:28:09 -0400
Received: by mail-ea0-f177.google.com with SMTP id j14so1649055eak.22
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jun 2013 13:28:08 -0700 (PDT)
In-Reply-To: <51AB2803.9010807@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

In all three cases, we know the authoritative log does not contain an
entry for oe.soid, therefore:

If oe.prior_version > log.tail, we must already have processed an
earlier entry for that object resulting in the object being correctly
marked missing (or not) (specifically, the entry for
oe.prior_version).

If log.tail >=3D oe.prior_version > eversion_t(), the missing entry
should have need set at oe.prior_version (revise_need).
oe.prior_version cannot be divergent because all divergent entries
must fall within the log (otherwise, we would have backfilled).

If oe.prior_version =3D=3D eversion_t(), the object no longer exists, a=
nd
the object should be removed from the missing set.

Hope that helps.
-Sam

On Sun, Jun 2, 2013 at 4:09 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> TL;DR:
>
> When there no new entry, what is the rationale for merge_old_entry to=
 remove the object from missing only if the tail is eversion_t() and th=
e object prior_version is also eversion_t() ?
> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa7=
6245e57d/src/osd/PGLog.cc#L330
>
> Long version:
>
> The conditions are created with:
>
>     info.log_tail =3D eversion_t();
>     oe.soid.hash =3D 1;
>     oe.op =3D pg_log_entry_t::DELETE;
>     oe.prior_version =3D eversion_t();
>
>     missing.add(oe.soid, eversion_t(1,1), eversion_t());
>
> as shown in
> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa7=
6245e57d/src/test/osd/TestPGLog.cc#L467
> I double checked with gdb and when called with
>
> EXPECT_FALSE(merge_old_entry(t, oe, info, remove_snap, dirty_log));
> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa7=
6245e57d/src/test/osd/TestPGLog.cc#L481
>
> it reaches
>
> missing.rm(oe.soid, missing.missing[oe.soid].need);
> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa7=
6245e57d/src/osd/PGLog.cc#L330
>
> and the expected side effects are observed:
>
>     EXPECT_FALSE(dirty_log);
>     EXPECT_TRUE(remove_snap.empty());
>     EXPECT_TRUE(t.empty());
>     EXPECT_FALSE(missing.have_missing());
>     EXPECT_TRUE(log.empty());
>     EXPECT_EQ(0U, ondisklog.length());
> https://github.com/dachary/ceph/blob/f58299db098d5f18c817b516fa6ffaa7=
6245e57d/src/test/osd/TestPGLog.cc#L483
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
