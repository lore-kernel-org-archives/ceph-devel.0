From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 04/17] ceph: fix compat_ioctl for ceph_dir_operations
Date: Wed, 12 Sep 2018 18:25:16 +0200
Message-ID: <CAK8P3a3BZUG36VrqeCzyNmy0U972scPOUAqOeO7Gey3mS7d+sA@mail.gmail.com>
References: <20180912150142.157913-1-arnd@arndb.de> <20180912150142.157913-4-arnd@arndb.de>
 <9e5f6ad82a2344c095234b39224605d4@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <9e5f6ad82a2344c095234b39224605d4@AcuMS.aculab.com>
Sender: stable-owner@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, "# 3.4.x" <stable@vger.kernel.org>, Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Chengguang Xu <cgxu519@gmx.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Sep 12, 2018 at 6:10 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arnd Bergmann
> > Sent: 12 September 2018 16:01
> >
> > The ceph_ioctl function is used both for files and directories, but only
> > the files support doing that in 32-bit compat mode.
> >
> > For consistency, add the same compat handler to the dir operations
> > as well.
>
> Have you verified that all the relevant ioctl buffer structures are
> exactly the same for 32bit and 64bit applications?

I checked it now, it's fine: there are only ceph_ioctl_dataloc
and ceph_ioctl_layout structures passed here, both of which
are compatible.

I assumed that the ceph_dir_fops operations were correct
here (they are), but you are right that I should have double
checked for more bugs as I encountered one of them.

        Arnd
