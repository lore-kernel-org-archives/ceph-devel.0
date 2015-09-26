From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: [ceph-users] occasional failure to unmap rbd
Date: Sat, 26 Sep 2015 06:30:57 -0400 (EDT)
Message-ID: <160143584.22201489.1443263457606.JavaMail.zimbra@redhat.com>
References: <56057393.5040203@commerceguys.com> <CAOi1vP_mHfYjtT+-eKxbvxgpPtgYoc+388oKbzC1=L-mU-euAA@mail.gmail.com> <5605793C.8030403@commerceguys.com> <1C5AFAFE-8302-4D33-B9B7-5A097F86BA27@schermer.cz> <560587E0.2070905@commerceguys.com> <10495960.22183031.1443236081004.JavaMail.zimbra@redhat.com> <CAOi1vP-2xZ44yUVxO_5k5BykHJPGWzY9PusynChG9tAGGefcjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:39141 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbbIZKa7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Sep 2015 06:30:59 -0400
In-Reply-To: <CAOi1vP-2xZ44yUVxO_5k5BykHJPGWzY9PusynChG9tAGGefcjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks!
I completely overlooked that -;

 Shinobu

----- Original Message -----
From: "Ilya Dryomov" <idryomov@gmail.com>
To: "Shinobu Kinjo" <skinjo@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Saturday, September 26, 2015 5:52:50 PM
Subject: Re: [CEPH-DEVEL] [ceph-users] occasional failure to unmap rbd

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
