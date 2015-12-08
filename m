From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, Clang refuses to compile a test
Date: Tue, 8 Dec 2015 01:29:55 +0100
Message-ID: <56662483.30101@digiware.nl>
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
 <565DC9D4.7060701@digiware.nl> <565DEC36.10102@digiware.nl>
 <565F5E28.8020706@digiware.nl> <5660106F.90202@digiware.nl>
 <5662DEEB.7060208@digiware.nl>
 <CANE=7sX5w36vhpN6TGNc4e_LBEsxcZokzEJX-Qs63zUbS4ynLA@mail.gmail.com>
 <5665FDD3.90000@digiware.nl>
 <CAEFDAA4T8VraUL90PvDEnkvOF9Q_6rinKfRgpG-CGMBeVz9pcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:26020 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755944AbbLHAac (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Dec 2015 19:30:32 -0500
In-Reply-To: <CAEFDAA4T8VraUL90PvDEnkvOF9Q_6rinKfRgpG-CGMBeVz9pcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Jarzabek <stiopa@gmail.com>
Cc: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 7-12-2015 23:19, Michal Jarzabek wrote:
> Hi Willem,
>
> If you look at line 411 and 412 you will have variables k and m
> defined. They are not changed anywhere(I think), so the sizes must be
> big enough.
> As Xinze mentioned just add const in front of it:
> const int k = 12
> const int m = 4
> and it should fix the compile error.
>
> buffer::ptr enc[k + m] works with gcc, because of the compiler
> extension, but it's not standard
> c++(https://gcc.gnu.org/onlinedocs/gcc/Variable-Length.html)
>
> I will submit patch to  change it.

That is exactly what I have done to get things compiling.
Have not yet gotten to the state that everything builds to start testing.

--WjW
