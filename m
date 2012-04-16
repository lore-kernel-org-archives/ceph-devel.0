From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 12:37:51 -0700
Message-ID: <CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
	<CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
	<Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56945 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab2DPThw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 15:37:52 -0400
Received: by bkcik5 with SMTP id ik5so3963898bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 12:37:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 16, 2012 at 12:00 PM, Sage Weil <sage@newdream.net> wrote:
>
> I pushed a wip-2301 that does this. =A0The downside to this approach =
is that
> the is_safe() and is_complete() methods will return false until after=
 the
> callback returns, which includes the callback itself. =A0So a callbac=
k that
> assumes that is_complete() will return true will be wrong.
>
> If that's not okay, the alternative is to make the wait_for_complete(=
)
> actually be a wait_for_complete_and_callback_has_returned(). =A0That =
drops
> the symmetry between wait_for_complete() and is_complete(), which is
> awkward.
>
maybe is_ack(), is_safe() and is_complete()?

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
