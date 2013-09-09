From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: subdir-objects
Date: Mon, 9 Sep 2013 07:37:12 +0200
Message-ID: <CAN04cT63xDdq3cLVHyhkMOfCch=jMqjqC23k5QvFL4KBP8_zPA@mail.gmail.com>
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
	<alpine.DEB.2.00.1309081615100.19576@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37162 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab3IIFhN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 01:37:13 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so5570383obc.10
        for <ceph-devel@vger.kernel.org>; Sun, 08 Sep 2013 22:37:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309081615100.19576@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <noah.watkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 9, 2013 at 1:16 AM, Sage Weil <sage@inktank.com> wrote:
> I took a quick look and it looks pretty great.  The builds are coming back
> okay, too.. any compelling reason not to merge it now?

Nope, not really. I'll do some last build checks at the end of today
(monday over here) and then send you a pull request.

> BTW, Roald, I think the obj_bencher cct change did something strange...
> see http://tracker.ceph.com/issues/6256.  Trying to reproduce it now.

I was wondering when the first bug would show, but I see you've
already fixed it...

Roald
