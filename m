From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: towards a user-mode diagnostic log mechanism
Date: Tue, 10 Jan 2012 15:25:19 -0800
Message-ID: <CAORUGqDCBaOA_N2+Lw+tyhDc3wjGBjEnnBYZO-=aMaNoRycoPw@mail.gmail.com>
References: <4EEFF614.8040207@dreamhost.com> <CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63561 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852Ab2AJXZl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2012 18:25:41 -0500
Received: by wgbdr10 with SMTP id dr10so144640wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2012 15:25:40 -0800 (PST)
In-Reply-To: <CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Mark Kampe <mark.kampe@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Jan 5, 2012 at 20:09, Colin McCabe <cmccabe@alumni.cmu.edu> wro=
te:
> Getting the system time is a surprisingly expensive operation, and
> this poses a problem for logging system designers. =C2=A0You can use =
the
> rdtsc CPU instruction, but unfortunately on some architectures CPU
> frequency scaling makes it very inaccurate. =C2=A0Even when it is acc=
urate,
> it's not synchronized between multiple CPUs.

Google leads me to http://pastebin.com/9csWfDvx which is a simple
benchmark that happily does a gettimeofday call in about 28
nanoseconds on my Macbook Air. This is not where the bottleneck is.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
