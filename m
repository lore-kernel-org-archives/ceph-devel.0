From: Michal Jarzabek <stiopa@gmail.com>
Subject: Re: make check, src/test/ceph-disk.sh fails on Mint
Date: Sat, 16 May 2015 23:07:59 +0100
Message-ID: <CAEFDAA57-DJXu6Co5yLb=rienFbc6wm9HmachwGu5wpO=eo70A@mail.gmail.com>
References: <CAEFDAA6rAJeS80+Qrg=orzug++YWmGee31KYu1=pLy2s3HDYiQ@mail.gmail.com>
	<5557B713.70905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34876 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbbEPWIB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 May 2015 18:08:01 -0400
Received: by wicmx19 with SMTP id mx19so33522770wic.0
        for <ceph-devel@vger.kernel.org>; Sat, 16 May 2015 15:07:59 -0700 (PDT)
In-Reply-To: <5557B713.70905@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: ceph-devel@vger.kernel.org

Well, I do run it on Linux Mint, but rest of the tests passes without
any problems. So I was wondering if there was any simple way to fix
this one as well.

On Sat, May 16, 2015 at 10:30 PM, David Zafman <dzafman@redhat.com> wrote:
>
> Is something really broken?  Or are you just on an unsupported platform?
>
> David
>
>
> On 5/16/15 8:49 AM, Michal Jarzabek wrote:
>>
>> ceph_detect_init.exc.UnsupportedPlatform: Platform is not supported.:
>
>
