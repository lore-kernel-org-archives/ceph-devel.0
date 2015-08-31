From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Improving shared backport efforts
Date: Mon, 31 Aug 2015 13:51:37 -0600
Message-ID: <CALqRxCwwgMQGP+XATjSX7TFR66xrZpvAdeKD8ykvdAi9ssMn7w@mail.gmail.com>
References: <55E3239F.7030806@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34243 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbbHaTvj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Aug 2015 15:51:39 -0400
Received: by wicjd9 with SMTP id jd9so10738732wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2015 12:51:37 -0700 (PDT)
In-Reply-To: <55E3239F.7030806@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Exactly, I didn't have the time do the actual PR myself :(

- Ken

On Sun, Aug 30, 2015 at 9:39 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ken,
>
> The tip you left at http://tracker.ceph.com/issues/12591 regarding th=
e backport of "rgw: create a tool for orphaned objects cleanup" was qui=
te useful, thank you !
>
> I'm curious about what made it inconvenient for you to push a pull re=
quest when you did that backport. Maybe you just did not have time to d=
o it, in which case all is well. But maybe it was because something in =
the backport procedures was confusing or blocking you, in which case I'=
m eager to fix it. It's really selfish of me: every backport you publis=
h is one less in the queue of the stable release team ;-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
