From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph-fuse is working on FreeBSD
Date: Fri, 28 Apr 2017 15:01:51 -0700
Message-ID: <CAJ4mKGbGsK37n0mr2-NELWW7HL=yOQB5kaWJ87Wsf_ugPRt_ng@mail.gmail.com>
References: <2133312b-b225-0060-bad8-f8aab4f4fcf7@digiware.nl>
 <CAJ4mKGbvc9fiFxbrnFpCm13-QsUNR8FF_Ka6N4eFtbD9xKk=NQ@mail.gmail.com> <4dd8464c-7db5-f2ce-e002-ecc8cfdf0dd2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34333 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030308AbdD1WBw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Apr 2017 18:01:52 -0400
Received: by mail-io0-f172.google.com with SMTP id a103so77352161ioj.1
        for <ceph-devel@vger.kernel.org>; Fri, 28 Apr 2017 15:01:52 -0700 (PDT)
In-Reply-To: <4dd8464c-7db5-f2ce-e002-ecc8cfdf0dd2@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Eek, sorry this got lost in my inbox.

On Thu, Mar 30, 2017 at 2:59 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 29-3-2017 18:12, Gregory Farnum wrote:
>> Sweet! Try pjd yet? ;)
>
> I now know why pjd sounded so familiar. Pawel Jakub Dawidek
> <pawel@dawidek.net> was the person that ported ZFS to FreeBSD and did an
> excellent at that. I guess that this was his testbed to see if
> everything was working as should.
>
> Now my questions about this:
>  - You select UFS as testing FS?

I don't think we did anything explicit here; it's just whatever
pjd-on-linux does by default. I would guess UFS is the closest
equivalent on BSD, but can't be sure. :/

>  - What coverage do you get from running the test?

It invokes most of the fs-related syscalls in most of the ways they
can be tested? Not sure what you mean.

>
> Like what I just tried gave me tons of errors on chflags and device
> operations etc...

I'm not familiar with chflags, but as I look at the manpage that looks
like a BSD thing with a bunch of flags Linux doesn't support? So Ceph
definitely won't do well with that.
-Greg

>
> The other thing is I need to remake my cephfs, it complains it is about
> 17x to small if I look at the pgs :(
> So got to look in dimensioning cephfs.
>
> --WjW
>
>
>> On Wed, Mar 29, 2017 at 9:08 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> I needed some more skills to actually get everythingin place to get it
>>> working. But in essence I have ceph-fuse running...
>>>
>>> wjw# df | grep fuse
>>> /dev/fuse 9168256790 203540395 8964716395 2%    /zfs/home/wjw/mnt/zfs
>>> /dev/fuse 8241876992  60174336 8181702656 1%    /zfs/home/wjw/mnt/cephf
>>>
>>> wjw# ls ~/mnt/cephfs/
>>> wjw# touch ~/mnt/cephfs//test
>>> wjw# ~/mnt/cephfs/
>>> test
>>>
>>> So we are slowly getting there....
>>>
>>> --WjW
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
