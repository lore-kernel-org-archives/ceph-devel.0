From: Damien Churchill <damoxc@gmail.com>
Subject: Re: projects
Date: Tue, 30 Aug 2011 14:07:50 +0100
Message-ID: <CAFtEh-dZbDiF7sfXpVfpcrJKy2=E+Moo+grzU1Lh_AFCkATz1A@mail.gmail.com>
References: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43532 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab1H3NHv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Aug 2011 09:07:51 -0400
Received: by gya6 with SMTP id 6so5592329gya.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Aug 2011 06:07:50 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 29 August 2011 20:08, Sage Weil <sage@newdream.net> wrote:
> I started to make a list of smallish projects that are reasonably eas=
y for
> new developers to approach. =C2=A0The list is at
>
> http://ceph.newdream.net/wiki/Projects
>
> Any other ideas?
>
> sage
>

I've been working on some alternative python bindings [0], using
Cython instead of ctypes to wrap the libraries. It's still early days
but they're in a reasonably usable state. When I have the time I'm
going to look at wrapping the C++ headers instead of the C ones. I
started it as there weren't any py bindings for librbd and figured may
as well wrap the others whilst I'm at it. No idea if it'll be useful
for anyone else.

[0] http://github.com/ukplc/pyceph
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
