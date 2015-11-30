From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 11:46:27 +0800
Message-ID: <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
References: <565B3999.3050302@digiware.nl>
	<CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
	<565B4A7F.60301@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34535 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbbK3Dq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 22:46:29 -0500
Received: by lffu14 with SMTP id u14so181155414lff.1
        for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 19:46:27 -0800 (PST)
In-Reply-To: <565B4A7F.60301@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 30, 2015 at 2:57 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
> On 29-11-2015 19:08, Haomai Wang wrote:
>
> > I guess we still expect FreeBSD support, which version do you test to
> > compile? I'd like to help to make bsd work :-)
>
> I considered it is best to develop against HEAD aka:
> 11.0-CURRENT FreeBSD 11.0-CURRENT #0 r291381: Sat Nov 28 14:22:54 CET 2015
> I'm also training configure the use as much of CLANG as possible.
>
> I would guess that by the time we get anything worth mentioning 11.0
> will be released of close to release.
> Note that the release date for 11.0 is july 2016
>
> --WjW
>

I can compile infernalis on FreeBSD 10.1 with following commands

./autogen.sh
./configure CPPFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib"
CXXFLAGS="-DGTEST_HAS_TR1_TUPLE=0" --without-tcmalloc --without-libaio
--without-libxfs
gmake

I don't know extact list of packages dependencies. But ./configure
should tell you what is missing.

Yan, Zheng
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
