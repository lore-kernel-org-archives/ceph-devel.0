From: Gregory Farnum <greg@gregs42.com>
Subject: =?UTF-8?Q?Re=3A_Ceph_tier=E2=80=99ing_enhancements_blue_print_for_jewe?=
	=?UTF-8?Q?l?=
Date: Tue, 9 Jun 2015 23:46:39 -0700
Message-ID: <CAC6JEv9OPeAETB4M6fdouXLwQ_ocgsPswDXw2Vdntbd7n=uKHg@mail.gmail.com>
References: <EA545303A8F8E842820A172C3D641D6E1B0628FD@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35888 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbbFJGql convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 02:46:41 -0400
Received: by ieclw1 with SMTP id lw1so28353982iec.3
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 23:46:40 -0700 (PDT)
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com. [209.85.213.172])
        by mx.google.com with ESMTPSA id rr5sm2813512igb.7.2015.06.09.23.46.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 23:46:40 -0700 (PDT)
Received: by igbzc4 with SMTP id zc4so28704143igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 23:46:39 -0700 (PDT)
In-Reply-To: <EA545303A8F8E842820A172C3D641D6E1B0628FD@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shishir Gowda <Shishir.Gowda@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 9, 2015 at 7:52 PM, Shishir Gowda <Shishir.Gowda@sandisk.co=
m> wrote:
> Hi All,
>
> We have uploaded the blueprint for the enhancements we are proposing =
for ceph tier=E2=80=99ing functionality for Jewel release @
>
> http://tracker.ceph.com/projects/ceph/wiki/Tiering-enhacement
>
> Soliciting comments/feedback for the same.

By and large this looks pretty sensible to me in a quick read. The
things I noticed:
1) There's a reference to the policy function getting passed in data
about how full the pool is. Note that while we expose stuff to cache
pool users in terms of pools, in the internal implementations the
flushing functions are based on how full the local PG is =E2=80=94 that=
's
because we don't have any up-to-date information about the global pool
(and we really can't). I imagine just substituting PG for pool in your
description should work, but if not that's something to address.

2) Are you sure you want to expose these policies via RGW? That sounds
both excessively complicated (from the UI perspective) and liable to
abuse by users. Plus it seems a little redundant =E2=80=94 I could imag=
ine
people wanting the very fastest storage, but then they should just
store those objects in RGW buckets which are stored on pools with
appropriate policies (I forget what this mechanism is called, but
there's some sort of placement thing when creating buckets). Otherwise
the enhancements for things like direct-read-from-EC-shards etc seem
to cover RGW's performance needs pretty well.

3) While a bunch of the docs and possibly some of the code imply that
you have a single cache and a single base tier, I think in general you
can set up tier chains. We want to preserve that, so the $CACHE and
$BASE language used in the tier functions needs to be capable of that.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
