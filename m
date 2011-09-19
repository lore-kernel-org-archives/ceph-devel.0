From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH] ceph_common.sh: Do not sudo to root unless needed
Date: Mon, 19 Sep 2011 09:49:52 -0700
Message-ID: <CAORUGqDgHS0z40=_Szp-N5ToLLdR3TT2Gdhm=WSN8Cr7-=jxyg@mail.gmail.com>
References: <1316012977-13675-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:39688 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1ISQuO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2011 12:50:14 -0400
Received: by ewy28 with SMTP id 28so850437ewy.4
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2011 09:50:12 -0700 (PDT)
In-Reply-To: <1316012977-13675-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 14, 2011 at 08:09, Jim Schutt <jaschut@sandia.gov> wrote:
> Using do_root_cmd() doesn't really need to sudo to root
> if you're already root.
>
> Commit 71dc75bdafe62a098c0493ad62f2d0d2a6ca7946 causes a regression:
> when system "foo" has a sudoers config that requires a tty,
> init-ceph now fails like this:
> =C2=A0sudo: sorry, you must have a tty to run sudo
>
> when it is invoked by root with something like this:
> =C2=A0 ssh foo /etc/init.d/init-ceph start
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>

Applied as d64237a6a555944d6d35676490bc4fb7c7db965d, thank you.

(It seems I screwed up the author field in the commit, sorry about
that. I don't want to force push just to fix that; Signed-off-by gives
you credit anyway.)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
