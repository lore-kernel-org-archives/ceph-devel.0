From: Gregory Farnum <greg@inktank.com>
Subject: Re: CephFS state of art
Date: Mon, 6 Aug 2012 12:48:50 -0700
Message-ID: <CAPYLRzj7MFD27OrZh+74X9x58u2MT2R0+wHc-doxq=iukRt1PA@mail.gmail.com>
References: <CAOLwVUn_O5VHo=Fi2fQzWER9GKkNFBFUFnFK+5b0hKw1Waf8Vg@mail.gmail.com>
	<CAOLwVU=6o1KpxfDjLm7EwTWuO9=LMZXfktTaiZDBpqjhaoM3-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48925 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836Ab2HFTsv convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Aug 2012 15:48:51 -0400
Received: by lagy9 with SMTP id y9so955313lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 12:48:50 -0700 (PDT)
In-Reply-To: <CAOLwVU=6o1KpxfDjLm7EwTWuO9=LMZXfktTaiZDBpqjhaoM3-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 6, 2012 at 11:46 AM, S=E9bastien Han <han.sebastien@gmail.c=
om> wrote:
> Hi everyone,
>
> The major statement about CephFS remains the same for a couple of
> months: it's not ready for production yet. The wiki page
> http://ceph.com/docs/master/faq/#is-ceph-production-quality hasn't
> changed for ages.
>
> Is it still true?
Yes; CephFS is not ready for production yet. We haven't done much work
on it in the last 6-8 months, as we've been focusing on RADOS itself.

> If so, could please elaborate on these points? :)
There are a couple of known bugs in the filesystem that haven't been
tracked down yet, and the QA that we do on it is still very limited.
We run a lot of tests on it with working systems, but we (Inktank)
haven't done aged filesystem tests, or done good testing under failure
scenarios, etc. And multi-mds systems are entirely unreliable.
Now, I believe there are people running long-term systems that have
done so successfully =97 it depends on what features you make use of,
etc.

> How far are we from a stable release?
We really don't know enough about what work still remains to be able
to answer that question. :/
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
