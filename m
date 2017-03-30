From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph-fuse is working on FreeBSD
Date: Thu, 30 Mar 2017 11:59:15 +0200
Message-ID: <4dd8464c-7db5-f2ce-e002-ecc8cfdf0dd2@digiware.nl>
References: <2133312b-b225-0060-bad8-f8aab4f4fcf7@digiware.nl>
 <CAJ4mKGbvc9fiFxbrnFpCm13-QsUNR8FF_Ka6N4eFtbD9xKk=NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:60496 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932977AbdC3J7Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 05:59:24 -0400
In-Reply-To: <CAJ4mKGbvc9fiFxbrnFpCm13-QsUNR8FF_Ka6N4eFtbD9xKk=NQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 29-3-2017 18:12, Gregory Farnum wrote:
> Sweet! Try pjd yet? ;)

I now know why pjd sounded so familiar. Pawel Jakub Dawidek
<pawel@dawidek.net> was the person that ported ZFS to FreeBSD and did an
excellent at that. I guess that this was his testbed to see if
everything was working as should.

Now my questions about this:
 - You select UFS as testing FS?
 - What coverage do you get from running the test?

Like what I just tried gave me tons of errors on chflags and device
operations etc...

The other thing is I need to remake my cephfs, it complains it is about
17x to small if I look at the pgs :(
So got to look in dimensioning cephfs.

--WjW


> On Wed, Mar 29, 2017 at 9:08 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> I needed some more skills to actually get everythingin place to get it
>> working. But in essence I have ceph-fuse running...
>>
>> wjw# df | grep fuse
>> /dev/fuse 9168256790 203540395 8964716395 2%    /zfs/home/wjw/mnt/zfs
>> /dev/fuse 8241876992  60174336 8181702656 1%    /zfs/home/wjw/mnt/cephf
>>
>> wjw# ls ~/mnt/cephfs/
>> wjw# touch ~/mnt/cephfs//test
>> wjw# ~/mnt/cephfs/
>> test
>>
>> So we are slowly getting there....
>>
>> --WjW
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

