From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: subdir-objects
Date: Sun, 8 Sep 2013 01:01:39 +0200
Message-ID: <CAN04cT4Pida1ie-11ptSL7R-rgJfYyhWYQ168NLfWOAKDYKApg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:37839 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3IGXBk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Sep 2013 19:01:40 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so5372604oag.31
        for <ceph-devel@vger.kernel.org>; Sat, 07 Sep 2013 16:01:40 -0700 (PDT)
In-Reply-To: <CA+Hcz58E7OKaGto0pF_ZYoge-FcDLtc66cbqx9a9+z-=Op3YWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Noah, Sage,

The build time has improved in wip-automake somewhat (mainly because
almost all files are now only compiled to objects once instead of
per-target), but much of the time goes into linking.

> I was just looking through build-refactor, and it doesn't really look
> like there is much that could be reused for the non-recrusive
> approach. I'll leave it up for a few days, just in case.

It would be great if you could look at wip-automake and see if you
have ideas/improvements or stuff you implemented that I didn't. All
non-automake changes that I needed to make this branch work just got
merged to master, so this branch is now only about changes .am files.
Of course every src/Makefile.am adjustment in master will require a
rebase, so this branch is a real work-in-progress and gets
force-pushed regularly :-)

Roald
