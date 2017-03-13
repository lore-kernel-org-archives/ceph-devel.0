From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [Ceph-community] RBD vs. librbd exclusive lock
Date: Mon, 13 Mar 2017 08:13:22 -0400
Message-ID: <CA+aFP1C9dUbjOy0_n4-EP5_jbawZRCRwgNQ4eX+RveBkzgdvMA@mail.gmail.com>
References: <CAMtNT-AMwPK6Azz5ZErnWJr7oTBXUhMq-H_1im1+oi9EdnDyxA@mail.gmail.com>
 <CAMtNT-CyN3VvXWfnvJuTgC5POtuAwJYnc6pJbFcai7UXR=7RNw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34101 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdCMMNc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Mar 2017 08:13:32 -0400
Received: by mail-lf0-f45.google.com with SMTP id z15so40631633lfd.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Mar 2017 05:13:24 -0700 (PDT)
In-Reply-To: <CAMtNT-CyN3VvXWfnvJuTgC5POtuAwJYnc6pJbFcai7UXR=7RNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lyu Jesse <jesse.js.lyu@gmail.com>
Cc: ceph-devel@ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Mar 13, 2017 at 4:06 AM, Lyu Jesse <jesse.js.lyu@gmail.com> wrote:
> FYI.
>
> 2017-03-13 16:01 GMT+08:00 Lyu Jesse <jesse.js.lyu@gmail.com>:
>>
>> Hi guys,
>>
>> I tested the RBD exclusive lock and found that the exclusive lock could be
>> acquired by the lasted new client using the nbd+librbd way.
>>
>> my question is that:
>> 1. is there any difference between rbd lock add/remove CMDs and librbd
>> exclusive lock

The rbd CLI lock add/remove commands are advisory locks. Unless you
have additional tooling around the use of them, nothing would prevent
multiple clients from sending concurrent IO to the image.

>> 2.using the nbd+librbd，is the newest client has the highest priority to
>> grab the exclusive lock

The clients will cooperatively exchange the exclusive lock if required
if write IOs are issued. There is an optional "--exclusive" flag that
will disable this coordinated lock exchange and will result in one
client owning the lock until it quits.

>> 3. In my test case by using the nbd+librbd，after losing the exclusive lock
>> ,the old client can still write to the rbd

I suspect you are seeing the coordinated lock exchange. Any reason why
you have the image double-mapped?

>> we are using the nbd+librbd and mount the rbd image as ext4 filesystem.
>>
>>
>> Best Regards,
>> Jesse Lyu
>
>
>
> _______________________________________________
> Ceph-community mailing list
> Ceph-community@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-community-ceph.com
>



-- 
Jason
