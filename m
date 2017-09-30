From: kefu chai <tchaikov@gmail.com>
Subject: Re: CEPH/BSD status
Date: Sat, 30 Sep 2017 13:21:42 +0800
Message-ID: <CAJE9aONWiaoSk9LqQt3cthZ0dPCOi=LyL61-zSr+aAZtpC68Gg@mail.gmail.com>
References: <b24a64ea-274e-67e7-b793-554bdf1b8bd2@digiware.nl> <4da06ef4-4b11-e26c-bede-1454d322bd5b@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:54924 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdI3FVn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Sep 2017 01:21:43 -0400
Received: by mail-oi0-f65.google.com with SMTP id u130so2386409oib.11
        for <ceph-devel@vger.kernel.org>; Fri, 29 Sep 2017 22:21:43 -0700 (PDT)
In-Reply-To: <4da06ef4-4b11-e26c-bede-1454d322bd5b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mogamat Abrahams <ma@tabits.co.za>

On Fri, Sep 29, 2017 at 5:32 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
> On 28-9-2017 09:56, Mogamat Abrahams wrote:
>> Hi,
>>
>> Can we help you with testing/feedback on this one?
>
> [ cc-ing this also to the ceph-dev list ]
>
> Hi Mogamat,
>
> Would be great. I'm currently rather occupied with my daytime job.
> So the last few weeks haven't done much.
> The FreeBSD report was rather late so some of the work has progressed a
> bit. Yesterday 12.1.1 has been released. So my first concern is to build
> and upgrade  a new luminous port package.
>
>> Which of these are still open?
>>
>>  1. Run integration tests to see if the FreeBSD daemons will work with a
>>     Linux Ceph platform.
>
> No serious testing work done. I have understood that a librbd on Mac
> works against a Linux cluster. So I would expect it to work, but it
> certainly needs to be given some thought on how to test the
> interoperability of all components. And perhaps a few structural tests
> need to be written and submitted.
>
>>  2. Compile and test the userspace RBD (Rados Block Device). This
>>     currently works but testing has been limitted.
>>  3. Investigate and see if an in-kernel RBD device could be developed
>>     akin to ggate.
>
> These 2 have been done. there is a rbd-ggate in the package that allows
> one to mount a RBD image on a device. Partition, format and just use as
> regular FS. I'm using that, and it is not a wonder of blinding
> performance (got slow testcluster hardware), but no problems.
>
>>  4. Investigate the keystore, which can be embedded in the kernel on
>>     Linux and currently prevents building Cephfs and some other parts.
>>     The first question is whether it is really required, or only KRBD
>>     requires it.
>
> I have not yet found reasons to actually use this, but then I also do
> not have a kernel-cephfs module. So that would need to be fixed/written
> first. cephfs over fuse works, but that is with fuse and thus slow.
>
>>  5. Scheduler information is not used at the moment, because the
>>     schedulers work rather differently between Linux and FreeBSD. But at
>>     a certain point in time, this will need some attention (in
>>     src/common/Thread.cc).
>
> Still open. And I do not have any information on how relevant this will
> be for FreeBSD.
>
>>  6. Improve the FreeBSD init scripts in the Ceph stack, both for testing
>>     purposes and for running Ceph on production machines. Work on
>>     ceph-disk and ceph-deploy to make it more FreeBSD- and ZFS-compatible.
>
> Some work has been done ceph-disk zap can wipe a disk.
> ceph-deploy has not had any attention at all, but I would expect most
> basic users to take a book, of blog and then they'd need ceph-deploy.
> I do all config work by hand, or use ceph-disk on pre-build ZFS volumes.
>
> In the mean time Ceph-volume has entered the stage and has an lvm
> component. Would be nice to have a matching ZFS component, perhaps even
> working with ZVOLs.
>
>>  7. Build a test cluster and start running some of the teuthology
>>     integration tests on it. Teuthology wants to build its own libvirt
>>     and that does not quite work with all the packages FreeBSD already
>>     has in place. There are many details to work out here.
>
> Started a few tries here, but still have not really goten anywhere.
> Libvirt, Qemu and teuthology setup keep me running in circles.
> It is needed to start running the more elaborate tests.
>
>>  8. Design a vitual disk implementation that can be used with bhyve and
>>     attached to an RBD image.
>
> Still open. But would be a great thing for bhyve.
> Now the problem/challange is that Ceph is GPL of one sort or the other,

please note that the most part of Ceph is licensed under LGPL 2.1.

> and bhyve is FreeBSD-lic. And mixing is going to be hard since no GPL is
> allowed in the FreeBSD base tree., so it needs to be done a package module.
>
> But the module interface for different disk providers needs to be cut
> out from the current bhyve code. If at all possible.
> Then librbd-module package goes into ports and we have worked around the
> GPL conflict.
> OR
>     Ceph needs to release librbd also under a more liberal license.
>         which could be possible, but I do not know RH and/or ceph's
>         possition on this.
> OR
>     It needs to maintained as a patch set to bhyve.
>         But that will require continuous maintenance
>         And will fast lead to bitrot
>
> Hope this helps in getting the current status a bit more clear.
> Alan Sommers is already working on getting AIO and bluestore working,
> with promising outlook.
>
> --WjW
>
>>
>> --
>> *Mogamat Abrahams*
>>
>> */TAB IT Solutions cc/*
>> Suite B, 2nd Floor, 16a Newmarket Street, Cape Town, 8000
>> www.tabits.co.za
>>
>> Cell: 0829238001
>> Office: 0210071510
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
