From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Tue, 1 Dec 2015 12:08:24 +0100
Message-ID: <565D7FA8.3010301@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:45118 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222AbbLALId (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 06:08:33 -0500
In-Reply-To: <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mykola Golub <mgolub@mirantis.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 30-11-2015 14:21, Sage Weil wrote:
> The problem with all of the porting code in general is that it is doomed
> to break later on if we don't have (at least) ongoing build tests.  In
> order for a FreeBSD or OSX port to continue working we need VMs that run
> either gitbuilder or a jenkins job or similar so that we can tell when it
> breaks.
>
> If someone is willing to run a VM somewhere to do this we can pretty
> easily stick it on the gitbuilder page at
>
> 	http://ceph.com/gitbuilder.cgi


Hi Sage,

Could you give some pointers as to where to start running the tests.
I see a lot of "basic" tests to see if the platform is actually conformant.

So before plunging into running ceph-mon and stuff, it would perhaps be
better to actually run (parts of) the basic required tests..

Thanx,
--WjW
