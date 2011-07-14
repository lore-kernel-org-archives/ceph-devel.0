From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: coding style document
Date: Thu, 14 Jul 2011 14:40:27 -0700
Message-ID: <CA+qbEUOSiYK=VSiajYQ7_SKNj0_jYf0VcyMRtma-=+mpjZM_Ow@mail.gmail.com>
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
	<CAF3hT9CPjOoup+UsWq4MsvxCD4zZPSL1Wu1wWnL1u=G=fJ3e9w@mail.gmail.com>
	<Pine.LNX.4.64.1107141056250.29636@cobra.newdream.net>
	<CAF3hT9DysGui-hh22unPU+Z9n1bVx87XHovX3sSfCtyLNNHSsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40669 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab1GNVk3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 17:40:29 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 20495C07E
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 14:40:34 -0700 (PDT)
Received: from mail-fx0-f52.google.com (mail-fx0-f52.google.com [209.85.161.52])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id C28FAC079
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 14:40:33 -0700 (PDT)
Received: by fxd18 with SMTP id 18so1640323fxd.11
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 14:40:27 -0700 (PDT)
In-Reply-To: <CAF3hT9DysGui-hh22unPU+Z9n1bVx87XHovX3sSfCtyLNNHSsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Jul 14, 2011 at 1:37 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> I've been going over the Google Coding Style document and noticed a
> few other things that probably merit discussion/a diff:
> 1) It says not to use streams, except for logging. We don't do a lot
> of text output other than logging, but in the few places we do it
> (program help text, for instance) I believe we use stream.s

I don't think it's really worth changing all the program help text
output to use fprintf. cout and cerr are fine enough for that.

On a semi-related note, I never liked std::ifstream and std::ofstream
because I feel like proper error handling was more awkward with these
than with fprintf. The streams don't even return an error code, they
just set an error bit which you are supposed to periodically check. So
it might be worth using fprintf in these cases.

> 2) Under the "Integer Types" section, they prefer not to use unsigned
> types except for bit patterns. They explicitly state that values which
> are not allowed to be <0 should be checked with asserts, rather than
> guaranteed by the type. This isn't the case for any of our current
> code and I'm not sure it's worth changing.

The rationale is that signed/unsigned bugs can occur pretty frequently
because of the way C/C++ handles type promotion.

For example, what does this print?
>  unsigned int foo = 2;
>  int bar = -1;
>  if (foo < bar)
>    printf("foo < bar\n");

Well, bar gets promoted to unsigned int, making it the largest
possible unsigned int.

That's why GCC now has the "comparison between signed/unsigned"
warning. But even with this active, mixing signed and unsigned forces
you to litter your code with typecasts to avoid the warning, which is
not ideal.

So I sort of see where they're coming from on that. I don't think it's
worth changing our current code, and there are some places where I
really think we should use unsigned in the future, but in general, if
you don't need it, don't use it.

cheers,
Colin
