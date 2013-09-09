From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: subdir-objects
Date: Mon, 9 Sep 2013 07:41:54 +0200
Message-ID: <CAN04cT68i1uKRM6D7tUO+wBxjPwhtgBqTD8jBv_wyw575Q6=nw@mail.gmail.com>
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
	<CANP1eJG-AdDvskwxrzZj-UYtOpu86ephvAKJBiAEvM41BWUGpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42056 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab3IIFly (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 01:41:54 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so5483543obc.41
        for <ceph-devel@vger.kernel.org>; Sun, 08 Sep 2013 22:41:54 -0700 (PDT)
In-Reply-To: <CANP1eJG-AdDvskwxrzZj-UYtOpu86ephvAKJBiAEvM41BWUGpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Noah Watkins <noah.watkins@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 9, 2013 at 1:27 AM, Milosz Tanski <milosz@adfin.com> wrote:
> Are you using gold as a linker already instead of the traditional
> binutils bdf based ld. It does make a difference esp on large C++ code
> bases (where linking takes a lot of time).

Actually I'm using by default on code bases the size of Ceph. For me,
the time of a "make check" goes down from ~7m to ~6m, so that's a nice
improvement. Might be a good idea to set up a gitbuilder instance
using gold and let it running on the side for a while?

Roald
