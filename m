From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/26] ceph: fix compat_ioctl for ceph_dir_operations
Date: Wed, 17 Apr 2019 23:31:48 +0200
Message-ID: <CAK8P3a2aRKZDpLJzCW74kwQaYr-Y2txh_5NY2CkRoZFzV=Cn6Q@mail.gmail.com>
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202013.4034148-12-arnd@arndb.de>
 <20190417212312.GY2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417212312.GY2217@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, "# 3.4.x" <stable@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Apr 17, 2019 at 11:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Apr 16, 2019 at 10:19:49PM +0200, Arnd Bergmann wrote:
> > The ceph_ioctl function is used both for files and directories, but only
> > the files support doing that in 32-bit compat mode.
> >
> > For consistency, add the same compat handler to the dir operations
> > as well.
> >
> > Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  fs/ceph/dir.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index a8f429882249..7c060cb22aa3 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1785,6 +1785,7 @@ const struct file_operations ceph_dir_fops = {
> >       .open = ceph_open,
> >       .release = ceph_release,
> >       .unlocked_ioctl = ceph_ioctl,
> > +     .compat_ioctl = ceph_ioctl,
>
> Again, broken on s390 (and so's the ceph_file_ops, of course).
> It wants compat_ptr() applied to argument...

This gets changed in a later patch, I intentionally left this one
doing the same as ceph_file_fops so the patch can be
backported if necessary, without also backporting the
patch that adds compat_ptr_ioctl.

       Arnd
