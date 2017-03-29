From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph-fuse is working on FreeBSD
Date: Wed, 29 Mar 2017 18:18:13 +0200
Message-ID: <e5a26f2a-ab77-e49a-3a54-e039464ef913@digiware.nl>
References: <2133312b-b225-0060-bad8-f8aab4f4fcf7@digiware.nl>
 <CAJ4mKGbvc9fiFxbrnFpCm13-QsUNR8FF_Ka6N4eFtbD9xKk=NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:41233 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbdC2QST (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 29 Mar 2017 12:18:19 -0400
In-Reply-To: <CAJ4mKGbvc9fiFxbrnFpCm13-QsUNR8FF_Ka6N4eFtbD9xKk=NQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 29-3-2017 18:12, Gregory Farnum wrote:
> Sweet! Try pjd yet? ;)

I guess you missed the "slowly" part..... 8-D

I was able to cp -r a small tree to it. Which I think is already a major
one for me.

That said, I know that the FreeBSD fuse interface is "fragile", and I
have seen users complain about loose bits and pieces.

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

