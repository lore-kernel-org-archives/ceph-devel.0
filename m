From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: wip-librbd-caching
Date: Thu, 12 Apr 2012 12:54:37 -0700
Message-ID: <CAORUGqARGBqwXw+zLxjiyounRmFJpWJj293mwsy+7=0f6iOGcA@mail.gmail.com>
References: <4F872D48.6070801@tuxadero.com> <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62020 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762599Ab2DLTy6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 15:54:58 -0400
Received: by vcqp1 with SMTP id p1so1601578vcq.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 12:54:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Martin Mailand <martin@tuxadero.com>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Thu, Apr 12, 2012 at 12:45, Sage Weil <sage@newdream.net> wrote:
>> So maybe we could reduce the memory footprint of the cache, but keep=
 it's
>> performance.
>
> I'm not familiar with the performance implications of KSM, but the
> objectcacher doesn't modify existing buffers in place, so I suspect i=
t's a
> good candidate. =C2=A0And it looks like there's minimal effort in ena=
bling
> it...

Are the objectcacher cache entries full pages, page aligned, with no
bookkeeping data inside the page? Those are pretty much the
requirements for page-granularity dedup to work..
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
