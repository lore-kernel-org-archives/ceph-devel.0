From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Tue, 1 Dec 2015 19:08:52 +0100
Message-ID: <565DE234.6070505@digiware.nl>
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
 <CAOtMX2jWDOLqmjY=S9PorKeaHDgTx5WyMo8jiV3LxOS4K67dMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:55350 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbbLASJQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 13:09:16 -0500
In-Reply-To: <CAOtMX2jWDOLqmjY=S9PorKeaHDgTx5WyMo8jiV3LxOS4K67dMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Somers <asomers@freebsd.org>
Cc: Sage Weil <sage@newdream.net>, Mykola Golub <mgolub@mirantis.com>, "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 1-12-2015 18:22, Alan Somers wrote:
> I did some work porting Ceph to FreeBSD, but got distracted and
> stopped about two years ago.  You may find this port useful, though it
> will probably need to be updated:
>
> https://people.freebsd.org/~asomers/ports/net/ceph/

I'll chcek that one as well...

> Also, there's one major outstanding issue that I know of.  It breaks
> interoperability between FreeBSD and Linux Ceph nodes.  I posted a
> patch to fix it, but it doesn't look like it's been merged yet.
> http://tracker.ceph.com/issues/6636

In the issues I find:
====
Updated by Sage Weil almost 2 years ago

     Status changed from New to Verified
Updated by Sage Weil almost 2 years ago

     Assignee set to Noah Watkins
====

Probably left at that point because there was no presure to actually commit?

--WjW
