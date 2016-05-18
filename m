From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Re: Fwd: How does EC pools support thousands of xattrs (XFS) but no omaps?
Date: Wed, 18 May 2016 08:42:06 +0530
Message-ID: <CAOu2ZZVzxUS9gaj9KCUXmDjt8A1NQuQSUJYAQbhXJ6LQ2gd4SQ@mail.gmail.com>
References: <CAOu2ZZUT8hqUmatSWTX7RxzhS1oo_5R0NmZ49+k0D91QPHTOjQ@mail.gmail.com>
	<CAOu2ZZXBYeCUGhz5RpePsP6CVvh0r2d+FJHT7iHHt=RxuEPznA@mail.gmail.com>
	<alpine.DEB.2.11.1605170950410.30956@cpach.fuggernut.com>
	<CAOu2ZZXs+iMyCLuNubn7jYDf4858wDyGFFuk+sac6Z-CHpMGDA@mail.gmail.com>
	<alpine.DEB.2.11.1605171639590.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37253 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcERDMI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 23:12:08 -0400
Received: by mail-wm0-f44.google.com with SMTP id a17so58535898wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2016 20:12:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605171639590.30956@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

I can understand the complexities now. Still, there is a little bit of
surprise element when large number of xattrs can be stored in leveldb
but not  omaps. Are these xattrs not being erasure coded and
distributed over nodes? When EC pools are space efficient alternative
to replicated pools, not having omaps defeats the purpose for anyone
who uses omaps extensively. I can guess that some users might be
storing the key-value kind of metadata in some external store.

On Wed, May 18, 2016 at 2:11 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 17 May 2016, Chandan Kumar Singh wrote:
>> Thanks. Why are omaps not allowed for objects in EC pools?
>
> Because it doesn't make much sense to erasure code small key=value pairs
> over lots of nodes.  Values are too small to be individually encoded
> sensibly, and packing them together would require a layer of complexity.
> It could presumably be done, but we didn't do it, and have yet to hear
> from someone who really needs it.
>
> sage
>
>
>
>>
>> On Tue, May 17, 2016 at 7:22 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 17 May 2016, Chandan Kumar Singh wrote:
>> >> Hi
>> >>
>> >> While migrating to EC pools, I came to know that it does not support
>> >> omaps but it allows thousands of xattrs (XFS). Are these xattrs being
>> >> stored in a key-value store or in XFS file system?
>> >
>> > They are stored in XFS, until there are more than a handful, after which
>> > point they get stored in leveldb.  But they are *also* stored in every pg
>> > log event that modifies the object, so you should definitely not (ab)use
>> > xattrs the way you would use omap and expect the system to behave/perform!
>> > They are meant to be small and few.
>> >
>> > sage
>>
>>
