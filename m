From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: persistent background write activity
Date: Sun, 21 Nov 2010 14:11:53 -0800
Message-ID: <AANLkTin-suY5HC4HzbkD8fxhPwDOYqKWpJAvRZ5uVbut@mail.gmail.com>
References: <AANLkTinWULKcXLmkyqtVc2T38OTh7ZTWOhYa1hfm==By@mail.gmail.com>
	<AANLkTin3eD80Q5=uu3EdgwM=8PQOy3e_jnDWiY1sSmQe@mail.gmail.com>
	<AANLkTinTGVC3+pOFX33JMDp4YcbjAxvgPckKnd4T2+Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47757 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab0KUWLz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Nov 2010 17:11:55 -0500
Received: by ewy5 with SMTP id 5so1358783ewy.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Nov 2010 14:11:54 -0800 (PST)
In-Reply-To: <AANLkTinTGVC3+pOFX33JMDp4YcbjAxvgPckKnd4T2+Ng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ravi Pinjala <pstatic@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Nov 21, 2010 at 1:44 PM, Ravi Pinjala <pstatic@gmail.com> wrote:
> Ah, that's good to know.
>
> How should I start isolating what's causing it? "ceph -w" doesn't
> indicate that anything's going on, and I'm not sure where to look for
> more detailed information about what ceph's up to.
>
> --Ravi
Well, if you have logging on you can look and see what they're doing
(at a pretty low level). If you don't have it on, you can start it by
using injectargs
(http://ceph.newdream.net/wiki/Monitor_commands#injectargs, you can
actually use it on all the systems even though the describes the mds)
and setting up the appropriate debug options. They're listed here (the
ones preceded by "debug" :) :
http://ceph.newdream.net/wiki/Ceph.conf#options_defined_in_src.2Fconfig.cc

Looking at the PG map might also show you something, although that'd
probably be captured by changing amounts of data showing up via ceph
-w.

What version of ceph are you running right now? I think there's some
background scrubbing stuff that got pushed in recently.
-Greg
