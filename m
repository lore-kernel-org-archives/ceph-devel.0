From: Simon Tian <aixt2006@gmail.com>
Subject: Re: operate one file in multi clients with libceph
Date: Thu, 19 May 2011 14:48:04 +0800
Message-ID: <BANLkTi=WBqYkes0D6VDV==FBYAhPYqMD=g@mail.gmail.com>
References: <BANLkTi=wd0+u774vRNDJZoXW_EoE9OP67Q@mail.gmail.com>
	<BANLkTinaHaWSpm81LeOHSSpkoqjDyqB5Nw@mail.gmail.com>
	<BANLkTikZYc59u1R35fJErCE_vA0+EDGSeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64029 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab1ESGsG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 02:48:06 -0400
Received: by wya21 with SMTP id 21so1726807wya.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2011 23:48:04 -0700 (PDT)
In-Reply-To: <BANLkTikZYc59u1R35fJErCE_vA0+EDGSeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel@vger.kernel.org

> The libceph API is not yet very well tested.
> Can you simply mount the filesystem from both hosts using the kernel
> client and have your application open/access the single file with the
> standard system call interface?


Hi Brian,

There are three reasons for using libceph API:
1. My application could use non-posix API, like libceph and librbd,
very conveniently and flexible.
2. If using the kernel client, performance will reduce because of the
VFS layer. I have done some test for a comparison two weeks ago.
3. If error or exception appear int the kernel client, the whole
machine may be not able to work.

Thx!
Simon
