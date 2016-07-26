From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: snapshot implementation problems/options
Date: Tue, 26 Jul 2016 07:24:21 +0200
Message-ID: <20160726052421.GE658@predictor>
References: <CAJ4mKGbf-zvTkZaqqsZDOA=ZrCsq=WRP80DM3wQpXcOWxYX-hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:44314 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbcGZFYG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Jul 2016 01:24:06 -0400
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbf-zvTkZaqqsZDOA=ZrCsq=WRP80DM3wQpXcOWxYX-hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 25, 2016 at 07:41:53PM -0700, Gregory Farnum wrote:
> [..]
> Anyway, these are the things I'm thinking about right now and that
> we'll want to consider as we evaluate moving forward on snapshots and
> other features. If you have thoughts or design ideas, please speak up=
!

One thing that striked me in the past is the way the snapshot informati=
on is
kept by OSDs. In a nutshell, it's a bufferlist with pre-encoded data th=
at
OSDs keep for entire lifetime. Once we need these data, we decode the
bufferlist. One issue is that we waste time for snapshot data decode, a=
nd
another is that we waste RAM for bufferlist itself, even when the objec=
t(s)
don't have any snashots at all.
While working on new snapshots implementation, that could be taken into
account too...

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
