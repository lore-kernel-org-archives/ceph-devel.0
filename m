From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: changed rbd cp behavior in 0.53
Date: Fri, 16 Nov 2012 03:00:37 +0300
Message-ID: <CABYiri96Ce=va70JZFvX4bBsaDdE++mV282i2tOVXWRhx12Swg@mail.gmail.com>
References: <CABYiri8Hm2EjLsffgSp3aANPwVQ2FPYWx5q01Wkq7sk1Smp41w@mail.gmail.com>
 <50A17C8A.9020007@inktank.com> <50A43DA0.6030307@inktank.com>
 <CABYiri8UzN==BkdyrAXdGORkJedNQR82WHBn8ZPCB-izt54HOA@mail.gmail.com> <CAEP-4J8KFzUydCPs-neZaWn09GkrcMsJp1=8YO0+rQROVUOJhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36629 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab2KPAA7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 19:00:59 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2284951obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 16:00:59 -0800 (PST)
In-Reply-To: <CAEP-4J8KFzUydCPs-neZaWn09GkrcMsJp1=8YO0+rQROVUOJhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deb Barba <deb.barba@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 15, 2012 at 8:43 PM, Deb Barba <deb.barba@inktank.com> wrote:
> This is not common UNIX/posix behavior.
>
> if you just give the source a file name, it should assume "." (current
> directory) as it's location, not whatever path you started from.
>
> I would expect most UNIX users would be losing a lot of files if they try to
> copy from path x/y/z, and just provide a new name.  that would indicate they
> wanted it stashed in ".".  Not cloned in path x/y/z  .
>
> I am concerned this would confuse most users out in the field.
>
> Thanks,
> Deborah Barba

Speaking of standards, rbd layout is more closely to /dev layout, or,
at least iSCSI targets, when not specifying full path or use some
predefined default prefix make no sense at all.

>
> On Wed, Nov 14, 2012 at 10:43 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>>
>> On Thu, Nov 15, 2012 at 4:56 AM, Dan Mick <dan.mick@inktank.com> wrote:
>> >
>> >
>> > On 11/12/2012 02:47 PM, Josh Durgin wrote:
>> >>
>> >> On 11/12/2012 08:30 AM, Andrey Korolyov wrote:
>> >>>
>> >>> Hi,
>> >>>
>> >>> For this version, rbd cp assumes that destination pool is the same as
>> >>> source, not 'rbd', if pool in the destination path is omitted.
>> >>>
>> >>> rbd cp install/img testimg
>> >>> rbd ls install
>> >>> img testimg
>> >>>
>> >>>
>> >>> Is this change permanent?
>> >>>
>> >>> Thanks!
>> >>
>> >>
>> >> This is a regression. The previous behavior will be restored for 0.54.
>> >> I added http://tracker.newdream.net/issues/3478 to track it.
>> >
>> >
>> > Actually, on detailed examination, it looks like this has been the
>> > behavior
>> > for a long time; I think the wiser course would be not to change this
>> > defaulting.  One could argue the value of such defaulting, but it's also
>> > true that you can specify the source and destination pools explicitly.
>> >
>> > Andrey, any strong objection to leaving this the way it is?
>>
>> I`m not complaining -  this behavior seems more logical in the first
>> place and of course I use full path even doing something by hand.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
