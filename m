From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: coding style document
Date: Thu, 14 Jul 2011 10:16:24 -0700
Message-ID: <CAF3hT9CPjOoup+UsWq4MsvxCD4zZPSL1Wu1wWnL1u=G=fJ3e9w@mail.gmail.com>
References: <CAC-hyiF3UNPoFCzYQD9V5UnvB6Y+gAKSi271U5sU-JgJvAG_Mw@mail.gmail.com>
	<CAC-hyiFm3Ua_ADTqquK2bsU-5fO3Y-s3jXt2badsdPksZDxJCg@mail.gmail.com>
	<CAC-hyiGzUR=nm8TokMwkztGWFFYG2+M-F9Ey6A_ePFf4MxVpYA@mail.gmail.com>
	<CA+qbEUOvPqv8r1+LG5ygi8dH5-Cw0+FJnVsnSfamW0N6R1kkUA@mail.gmail.com>
	<CAC-hyiE9XDTE99wox3e3-hL+eF40TyRUhfJ=kv4R_UtZcggG+g@mail.gmail.com>
	<CA+qbEUO9XRPaWnSjv3Exh1TppD7OLNZa=TsZdQKyju+G07x_Bg@mail.gmail.com>
	<CAC-hyiEx2itZ5_RtZ1XhPsPtnF7w0aockQ9+5ZDnzUGooVVdqA@mail.gmail.com>
	<CA+qbEUM7HPo9DdjyS_7Dnmq74u_gKVCJjXEf8G=_VVfiX_sJ-Q@mail.gmail.com>
	<CAC-hyiFxqSEVm5r54hitYWNaHr3DMZ1jyC4FdnCPVDqgFWdULQ@mail.gmail.com>
	<Pine.LNX.4.64.1107131518300.11118@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40999 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab1GNRQZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 13:16:25 -0400
Received: by gyh3 with SMTP id 3so196224gyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 10:16:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107131518300.11118@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Colin Patrick McCabe <colin.mccabe@dreamhost.com>, ceph-devel@vger.kernel.org

On Wed, Jul 13, 2011 at 3:28 PM, Sage Weil <sage@newdream.net> wrote:
> I buy Google's default value argument, at least as a rule of thumb. =A0=
At
> least most of the places I've used them are probably better off witho=
ut.
I was going to cry that I like default arguments, but then I
remembered what happened when I was trying to learn the journaling
code. This is a good rule.
I haven't been over the entire Google coding style document, but based
on what I've seen in this thread and the modifications I agree with
Sage's current diff.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
