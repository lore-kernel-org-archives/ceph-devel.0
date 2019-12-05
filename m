From: Yanhu Cao <gmayyyha@gmail.com>
Subject: Re: [PATCH] ceph: check set quota operation support before syncing setxattr.
Date: Thu, 5 Dec 2019 10:42:46 +0800
Message-ID: <CAB9OAC2vzPy=ELYzDRjBvA6m8T8AvwdJugS2NoCczwD1+Xb36Q@mail.gmail.com>
References: <20191204031005.2638-1-gmayyyha@gmail.com> <20191204103629.GA22244@hermes.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204103629.GA22244@hermes.olymp>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: jlayton@kernel.org, sage@redhat.com, idryomov@gmail.com, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Dec 4, 2019 at 6:36 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> On Wed, Dec 04, 2019 at 11:10:05AM +0800, Yanhu Cao wrote:
> > Environment
> > -----------
> > ceph version: 12.2.*
> > kernel version: 4.19+
> >
> > setfattr quota operation actually sends op to MDS, and settings
> > effective. but kclient outputs 'Operation not supported'. This may conf=
use
> > users' understandings.
>
> What exactly do you mean by "settings effective"?  There have been
> changes in the way CephFS quotas work in mimic and, if you're using a
> Luminous cluster (12.2.*) the kernel client effectively does *not*
> support quotas -- you'll be able to exceed the quotas you've tried to
> set because the client won't be checking the limits.  Thus, -EOPNOTSUPP
> seems appropriate for this scenario.
>
> I guess that the confusing part is that the xattr is actually set in
> that case, but the kernel client won't be able to use it to validate
> quotas in the filesystem tree because realms won't be created.
>
Yes. we use kcephfs+nfs for CentOS6.*, it does not support ceph-fuse(12.2.*=
).
The operating system of other applications is CentOS7.*, which uses
ceph-fuse and can get quota settings set by kclient.

Thanks.
BRs

> Cheers,
> --
> Lu=C3=ADs
> >
> > If the kernel version and ceph version are not compatible, should check
> > quota operations are supported first, then do sync_setxattr.
> >
> > reference: https://docs.ceph.com/docs/master/cephfs/quota/
> >
> > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > ---
> >  fs/ceph/xattr.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index cb18ee637cb7..189aace75186 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -1132,8 +1132,8 @@ int __ceph_setxattr(struct inode *inode, const ch=
ar *name,
> >                                   "during filling trace\n", inode);
> >               err =3D -EBUSY;
> >       } else {
> > -             err =3D ceph_sync_setxattr(inode, name, value, size, flag=
s);
> > -             if (err >=3D 0 && check_realm) {
> > +             err =3D 0;
> > +             if (check_realm) {
> >                       /* check if snaprealm was created for quota inode=
 */
> >                       spin_lock(&ci->i_ceph_lock);
> >                       if ((ci->i_max_files || ci->i_max_bytes) &&
> > @@ -1142,6 +1142,8 @@ int __ceph_setxattr(struct inode *inode, const ch=
ar *name,
> >                               err =3D -EOPNOTSUPP;
> >                       spin_unlock(&ci->i_ceph_lock);
> >               }
> > +             if (err =3D=3D 0)
> > +                     err =3D ceph_sync_setxattr(inode, name, value, si=
ze, flags);
> >       }
> >  out:
> >       ceph_free_cap_flush(prealloc_cf);
> > --
> > 2.21.0 (Apple Git-122.2)
> >
