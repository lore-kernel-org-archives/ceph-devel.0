From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 17:49:33 -0700
Message-ID: <CACLRD_2Qb3J_WvRSienfR6pFTunKXuFXAPbHDUs0QNTKPP0Z3g@mail.gmail.com>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
	<CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
	<Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
	<CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
	<D763974EEA9A43E08946E03484894631@dreamhost.com>
	<Pine.LNX.4.64.1204161405580.31853@cobra.newdream.net>
	<59070F5B091941E0934A1175E82717B7@dreamhost.com>
	<CAC-hyiGhHr+Pqf2z53ONZsuUfr-RKUedWU-GyteB8hB8Zgzobw@mail.gmail.com>
	<Pine.LNX.4.64.1204161736170.26253@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55459 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab2DQAte convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 20:49:34 -0400
Received: by wejx9 with SMTP id x9so3703400wej.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 17:49:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204161736170.26253@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Greg Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

It seems to me that anything done in the callback will have its own
synchronisation which users can simply use to wait for the callback to
complete.  In that case, we should not have wait_for_* wait for the
callback.
-Sam

On Mon, Apr 16, 2012 at 5:44 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 16 Apr 2012, Yehuda Sadeh Weinraub wrote:
>> wait_for_ack() : got ack or safe response, entails is_ack()
>> wait_for_safe(): got safe response, entails is_safe(), is_ack()
>> wait_for_complete(): done with the request, callback returned, entai=
ls
>> is_complete(), is_safe(), is_ack()
>
> The problem is we already have is_complete() and it means what you me=
an by
> is_ack().
>
> Either:
> 1- add new is_complete_and_cb() and wait_for_complete_and_cb(),
> =C2=A0 is_safe_and_cb() and wait_for_safe_and_cb().
> 2- make existing is_complete() mean the above (and
> =C2=A0 is_safe()/wait_for_safe() mean is_safe_and_cb()). =C2=A0is_com=
plete() will
> =C2=A0 be false when called from the callback. =C2=A0(i.e., current w=
ip branch.)
> 3- is_complete() means is complete, but wait_for_complete() waits for
> =C2=A0 complete and cb.
> 4- status quo (user has no idea when cb has been called).
>
> I like #1, personally. =C2=A0I doubt there are current users using bo=
th the cb
> and wait_for_*() methods (aside from our functional tests).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
