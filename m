From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Tue, 8 Dec 2015 11:04:13 +0100
Message-ID: <5666AB1D.5010101@digiware.nl>
References: <565B3999.3050302@digiware.nl> <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl>
 <CAOtMX2jWDOLqmjY=S9PorKeaHDgTx5WyMo8jiV3LxOS4K67dMg@mail.gmail.com>
 <565DE234.6070505@digiware.nl>
 <CAOtMX2j5xJBnYoNdxTGGQFz-fTVX2xQka2NuyUZuOPpsft6HuA@mail.gmail.com>
 <alpine.DEB.2.00.1512011034550.19170@cobra.newdream.net>
 <565DEA60.7010608@digiware.nl>
 <CAAM7YAmzq3a_kqXE2ZgK_fp4i6QduY49aXqiWVNK3F59iZUFRA@mail.gmail.com>
 <565F5A03.7020401@digiware.nl>
 <CAAM7YA=Q6gbBbN92a9KigAXw4e_SrshQ6Q8mC1Xff+vxQQkrKw@mail.gmail.com>
 <5661DBB8.1040505@digiware.nl>
 <CAJ4mKGZ+wjum+R3=pBS8urko4D1B_D+eKjytWE_uDdFcGW6sSA@mail.gmail.com>
 <5661F358.2060401@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:25326 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933224AbbLHKEs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Dec 2015 05:04:48 -0500
In-Reply-To: <5661F358.2060401@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Sage Weil <sage@newdream.net>, Alan Somers <asomers@freebsd.org>, Mykola Golub <mgolub@mirantis.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 4-12-2015 21:11, Willem Jan Withagen wrote:

One larger problem with libraries I have is the stuff with dlopen.

In ./configure it seems that most of the code is short-circuited, and -ldl
gets appended in the Makefile.am's by default. The code there is rather 
hard
to parse.

FreeBSD has this in libc, so no specific includes needed.

Now the question is how do I cleanly fix this without breaking just
about every other platform?

Thanx,
--WjW

