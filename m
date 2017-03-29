From: Alan Somers <asomers@freebsd.org>
Subject: Re: ceph-fuse is working on FreeBSD
Date: Wed, 29 Mar 2017 10:23:52 -0600
Message-ID: <CAOtMX2hVndXLxHqdwV9TuZcmbqHaEggEB9QYT1GGKwbEqPdRfw@mail.gmail.com>
References: <2133312b-b225-0060-bad8-f8aab4f4fcf7@digiware.nl>
 <CAJ4mKGbvc9fiFxbrnFpCm13-QsUNR8FF_Ka6N4eFtbD9xKk=NQ@mail.gmail.com> <e5a26f2a-ab77-e49a-3a54-e039464ef913@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33162 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754233AbdC2QX7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 12:23:59 -0400
Received: by mail-yw0-f180.google.com with SMTP id v76so14363124ywg.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 09:23:58 -0700 (PDT)
In-Reply-To: <e5a26f2a-ab77-e49a-3a54-e039464ef913@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Awesome news.  Keep up the good work, Willem.
-Alan

On Wed, Mar 29, 2017 at 10:18 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 29-3-2017 18:12, Gregory Farnum wrote:
>> Sweet! Try pjd yet? ;)
>
> I guess you missed the "slowly" part..... 8-D
>
> I was able to cp -r a small tree to it. Which I think is already a major
> one for me.
>
> That said, I know that the FreeBSD fuse interface is "fragile", and I
> have seen users complain about loose bits and pieces.
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
