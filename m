From: Damien Churchill <damoxc@gmail.com>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 19:15:51 +0100
Message-ID: <CAFtEh-e2ZVMHGhrBrAnGpXbGPPmhFo-Z3hrUHHNBgb==tNPXkQ@mail.gmail.com>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<4FB8A3A5.5090809@profihost.ag>
	<CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
	<4FB8B1CE.1080803@icukhosting.co.uk>
	<CAJafhzQp1SeGZUdUL5XszaRw-0bU0f38r3ghLgmTvZrF0oB_=w@mail.gmail.com>
	<4FBA599F.5050000@profihost.ag>
	<CAMvP8PBSxybik20238UAX6TKfqGBb=wEqmFyEHk4fSAzU_Fjxg@mail.gmail.com>
	<CANT588uxL7jrf1BfowUeer_AnDTfGjzkWVFhS4aNMaMSst_jyA@mail.gmail.com>
	<CAMvP8PADFfE-eENK_oq9_GsB0t35xd+j5yVvoh+k7qvc0pgUog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51009 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941Ab2EUSPx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 14:15:53 -0400
Received: by wibhn6 with SMTP id hn6so2688371wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 11:15:52 -0700 (PDT)
In-Reply-To: <CAMvP8PADFfE-eENK_oq9_GsB0t35xd+j5yVvoh+k7qvc0pgUog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 21 May 2012 16:36, Tomasz Paszkowski <ss7pro@gmail.com> wrote:
> Project is indeed very interesting, but requires to patch a kernel
> source. For me using lkm is safer ;)
>

I believe bcache is actually in the process of being mainlined and
moved to a device mapper target, although I could wrong about one or
more of those things.
