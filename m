From: Milosz Tanski <milosz@adfin.com>
Subject: Re: subdir-objects
Date: Sun, 8 Sep 2013 19:27:32 -0400
Message-ID: <CANP1eJG-AdDvskwxrzZj-UYtOpu86ephvAKJBiAEvM41BWUGpg@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
	<CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
	<alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
	<CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
	<CA+Hcz59qJgWY2gukY8h-=c_HXj5Dxj-UCEHrEnBXZKEckWEgJg@mail.gmail.com>
	<CAN04cT6FOspeq0NEN798ChLAJUuXsV2cFnzDLbQVNj0=pO6PPw@mail.gmail.com>
	<CA+Hcz5_JRZVWn6iohEyy7iTnHTGH=tbqd+MrxaDwWbD_p3V_cQ@mail.gmail.com>
	<CA+Hcz5-BgMzomAeGna8bMGjMv4Y2MsknBaSrmHEQHB-0-yFzCQ@mail.gmail.com>
	<CAN04cT4P4ELASm1VoxmHKaje8DHiCpB-bSyMWugjOo19k6j4hg@mail.gmail.com>
	<CA+Hcz58E7OKaGto0pF_ZYoge-FcDLtc66cbqx9a9+z-=Op3YWQ@mail.gmail.com>
	<CAN04cT4Pida1ie-11ptSL7R-rgJfYyhWYQ168NLfWOAKDYKApg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60563 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab3IHX1e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Sep 2013 19:27:34 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so2713554wiw.17
        for <ceph-devel@vger.kernel.org>; Sun, 08 Sep 2013 16:27:33 -0700 (PDT)
In-Reply-To: <CAN04cT4Pida1ie-11ptSL7R-rgJfYyhWYQ168NLfWOAKDYKApg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: Noah Watkins <noah.watkins@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> The build time has improved in wip-automake somewhat (mainly because
> almost all files are now only compiled to objects once instead of
> per-target), but much of the time goes into linking.

Roald,

Are you using gold as a linker already instead of the traditional
binutils bdf based ld. It does make a difference esp on large C++ code
bases (where linking takes a lot of time).

- M


>> I was just looking through build-refactor, and it doesn't really look
>> like there is much that could be reused for the non-recrusive
>> approach. I'll leave it up for a few days, just in case.
>
> It would be great if you could look at wip-automake and see if you
> have ideas/improvements or stuff you implemented that I didn't. All
> non-automake changes that I needed to make this branch work just got
> merged to master, so this branch is now only about changes .am files.
> Of course every src/Makefile.am adjustment in master will require a
> rebase, so this branch is a real work-in-progress and gets
> force-pushed regularly :-)
>
> Roald
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
