From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] occasional failure to unmap rbd
Date: Sat, 26 Sep 2015 11:52:50 +0300
Message-ID: <CAOi1vP-2xZ44yUVxO_5k5BykHJPGWzY9PusynChG9tAGGefcjg@mail.gmail.com>
References: <56057393.5040203@commerceguys.com>
	<CAOi1vP_mHfYjtT+-eKxbvxgpPtgYoc+388oKbzC1=L-mU-euAA@mail.gmail.com>
	<5605793C.8030403@commerceguys.com>
	<1C5AFAFE-8302-4D33-B9B7-5A097F86BA27@schermer.cz>
	<560587E0.2070905@commerceguys.com>
	<10495960.22183031.1443236081004.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36508 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbbIZIww (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Sep 2015 04:52:52 -0400
Received: by wicgb1 with SMTP id gb1so47112936wic.1
        for <ceph-devel@vger.kernel.org>; Sat, 26 Sep 2015 01:52:50 -0700 (PDT)
In-Reply-To: <10495960.22183031.1443236081004.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Sep 26, 2015 at 5:54 AM, Shinobu Kinjo <skinjo@redhat.com> wrote:
> I think it's more helpful to put returned value in:
>
> # ./src/krbd.cc
> 530       cerr << "rbd: sysfs write failed" << std::endl;
>
> like:
>
> 530       cerr << "rbd: sysfs write failed (" << r << ")" << std::endl;
>
> So that we exactly know what **write** complains about.
> Because **write** has some return values in case of error.
>
> What do you think?

It's already doing that:

rbd: sysfs write failed
rbd: unmap failed: (16) Device or resource busy

sysfs_write_rbd_remove() return value is propagated up and reported.
The code is written in such a way that return values are preserved and
never overwritten (hopefully!).

Thanks,

                Ilya
