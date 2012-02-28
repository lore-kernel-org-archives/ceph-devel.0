From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: RadosGW problems with copy in s3
Date: Tue, 28 Feb 2012 14:41:08 -0800
Message-ID: <CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
	<CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
	<CAMwB3ThZ4jPis_Bb9tsf=HTnh3gLd6CNkn2XMr4xo09bO3hEiQ@mail.gmail.com>
	<CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56803 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab2B1WlK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 17:41:10 -0500
Received: by bkcik5 with SMTP id ik5so1781417bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 14:41:09 -0800 (PST)
In-Reply-To: <CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Cc: ceph-devel@vger.kernel.org

(resending to list)

On Tue, Feb 28, 2012 at 11:53 AM, S=C5=82awomir Skowron
<slawomir.skowron@gmail.com> wrote:
>
> 2012/2/28 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
> > On Tue, Feb 28, 2012 at 3:43 AM, S=C5=82awomir Skowron
> > <slawomir.skowron@gmail.com> wrote:
> >> After some parallel copy command via botto for many files everythi=
ng,
> >> going to slow down, and eventualy got timeout from nginx@radosgw.


Note that you're overwriting the same object. Is that intentional?

>
> Reproduced logs in attachment.
>

I was able to recreate the issue. The problem is specifically related
to the fact that you're overwriting the same object from 10s of
parallel threads. What happens is that our race-detection code (that
is related to the radosgw atomic object write) detects that the
underlying object has been written and it needs to reread its header
before overwriting it. This works well when there are a few writers to
the same object, but doesn't scale very well. I opened issue #2120 to
track the issue.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
