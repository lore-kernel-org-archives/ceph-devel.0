From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Re: Fwd: How does EC pools support thousands of xattrs (XFS) but no omaps?
Date: Tue, 17 May 2016 19:28:39 +0530
Message-ID: <CAOu2ZZXs+iMyCLuNubn7jYDf4858wDyGFFuk+sac6Z-CHpMGDA@mail.gmail.com>
References: <CAOu2ZZUT8hqUmatSWTX7RxzhS1oo_5R0NmZ49+k0D91QPHTOjQ@mail.gmail.com>
	<CAOu2ZZXBYeCUGhz5RpePsP6CVvh0r2d+FJHT7iHHt=RxuEPznA@mail.gmail.com>
	<alpine.DEB.2.11.1605170950410.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33149 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcEQN6l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 09:58:41 -0400
Received: by mail-wm0-f46.google.com with SMTP id g17so21194844wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2016 06:58:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605170950410.30956@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks. Why are omaps not allowed for objects in EC pools?

On Tue, May 17, 2016 at 7:22 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 17 May 2016, Chandan Kumar Singh wrote:
>> Hi
>>
>> While migrating to EC pools, I came to know that it does not support
>> omaps but it allows thousands of xattrs (XFS). Are these xattrs being
>> stored in a key-value store or in XFS file system?
>
> They are stored in XFS, until there are more than a handful, after which
> point they get stored in leveldb.  But they are *also* stored in every pg
> log event that modifies the object, so you should definitely not (ab)use
> xattrs the way you would use omap and expect the system to behave/perform!
> They are meant to be small and few.
>
> sage
