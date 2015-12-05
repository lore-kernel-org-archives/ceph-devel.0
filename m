From: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Subject: Re: Compiling for FreeBSD, Clang refuses to compile a test
Date: Sat, 5 Dec 2015 21:02:11 +0800
Message-ID: <CANE=7sX5w36vhpN6TGNc4e_LBEsxcZokzEJX-Qs63zUbS4ynLA@mail.gmail.com>
References: <565B3999.3050302@digiware.nl>
	<CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
	<565B4A7F.60301@digiware.nl>
	<CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
	<20151130065812.GA20205@gmail.com>
	<alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
	<565D7FA8.3010301@digiware.nl>
	<alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
	<565DA3B5.1070608@digiware.nl>
	<alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
	<565DC9D4.7060701@digiware.nl>
	<565DEC36.10102@digiware.nl>
	<565F5E28.8020706@digiware.nl>
	<5660106F.90202@digiware.nl>
	<5662DEEB.7060208@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36159 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbLENCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Dec 2015 08:02:11 -0500
Received: by oiww189 with SMTP id w189so79784886oiw.3
        for <ceph-devel@vger.kernel.org>; Sat, 05 Dec 2015 05:02:11 -0800 (PST)
In-Reply-To: <5662DEEB.7060208@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I think "const int k = 12; const int m = 4" would pass the compile?

2015-12-05 20:56 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
> src/test/erasure-code/TestErasureCodeIsa.cc
>
> contains snippets, function definition like:
>
> buffer::ptr enc[k + m];
>   // create buffers with a copy of the original data to be able to compare
> it after decoding
>   {
>     for (int i = 0; i < (k + m); i++) {
>
> Clang refuses because the [k+m] size in not known at compiletime.
> Suggesting to tempate this.
>
> How would one normally handle this?
>
> I've temporarily made it fixed size 1024*1024.
> But I'm not sure if that is big enough
>
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Xinze Chi
