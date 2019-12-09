From: Yanhu Cao <gmayyyha@gmail.com>
Subject: Re: [PATCH] ceph: check set quota operation support before syncing setxattr.
Date: Mon, 9 Dec 2019 10:13:41 +0800
Message-ID: <CAB9OAC3eH89pA4EORu93gE+r9LJ7CW_gBYr4dSn0u3K3+p7T8w@mail.gmail.com>
References: <20191204031005.2638-1-gmayyyha@gmail.com> <20191204103629.GA22244@hermes.olymp>
 <CAB9OAC2vzPy=ELYzDRjBvA6m8T8AvwdJugS2NoCczwD1+Xb36Q@mail.gmail.com> <20191205102433.GA5758@hermes.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205102433.GA5758@hermes.olymp>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: jlayton@kernel.org, sage@redhat.com, idryomov@gmail.com, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Dec 5, 2019 at 6:24 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> On Thu, Dec 05, 2019 at 10:42:46AM +0800, Yanhu Cao wrote:
> > On Wed, Dec 4, 2019 at 6:36 PM Luis Henriques <lhenriques@suse.com> wro=
te:
> > >
> > > On Wed, Dec 04, 2019 at 11:10:05AM +0800, Yanhu Cao wrote:
> > > > Environment
> > > > -----------
> > > > ceph version: 12.2.*
> > > > kernel version: 4.19+
> > > >
> > > > setfattr quota operation actually sends op to MDS, and settings
> > > > effective. but kclient outputs 'Operation not supported'. This may =
confuse
> > > > users' understandings.
> > >
> > > What exactly do you mean by "settings effective"?  There have been
> > > changes in the way CephFS quotas work in mimic and, if you're using a
> > > Luminous cluster (12.2.*) the kernel client effectively does *not*
> > > support quotas -- you'll be able to exceed the quotas you've tried to
> > > set because the client won't be checking the limits.  Thus, -EOPNOTSU=
PP
> > > seems appropriate for this scenario.
> > >
> > > I guess that the confusing part is that the xattr is actually set in
> > > that case, but the kernel client won't be able to use it to validate
> > > quotas in the filesystem tree because realms won't be created.
> > >
> > Yes. we use kcephfs+nfs for CentOS6.*, it does not support ceph-fuse(12=
.2.*).
> > The operating system of other applications is CentOS7.*, which uses
> > ceph-fuse and can get quota settings set by kclient.
>
> Ok, so if I understand correctly, you're setting quotas with the kernel
> client but actually using ceph-fuse on CentOS7 (I'm assuming a Luminous
> cluster).  This should work fine for the fuse-client, but please note
> that the kernel client will not respect quotas.
Yes. do with fuse-client now.

>
> Anyway, the ideal solution for this would be for the kernel to not set
> the xattr if the cluster doesn't support the new quotas format
> introduced in Mimic.  Unfortunately, the only way we have to find that
> out is to set the xattr and see if we get a snap_realm.
Therefore, I think that if kclient is incompatible with the ceph
version, logically, op should not be sent to MDS.

Thanks.
BRs

>
> Cheers,
> --
> Lu=C3=ADs
>
> >
> > Thanks.
> > BRs
> >
> > > Cheers,
> > > --
> > > Lu=C3=ADs
> > > >
> > > > If the kernel version and ceph version are not compatible, should c=
heck
> > > > quota operations are supported first, then do sync_setxattr.
> > > >
> > > > reference: https://docs.ceph.com/docs/master/cephfs/quota/
> > > >
> > > > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > > > ---
> > > >  fs/ceph/xattr.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > > > index cb18ee637cb7..189aace75186 100644
> > > > --- a/fs/ceph/xattr.c
> > > > +++ b/fs/ceph/xattr.c
> > > > @@ -1132,8 +1132,8 @@ int __ceph_setxattr(struct inode *inode, cons=
t char *name,
> > > >                                   "during filling trace\n", inode);
> > > >               err =3D -EBUSY;
> > > >       } else {
> > > > -             err =3D ceph_sync_setxattr(inode, name, value, size, =
flags);
> > > > -             if (err >=3D 0 && check_realm) {
> > > > +             err =3D 0;
> > > > +             if (check_realm) {
> > > >                       /* check if snaprealm was created for quota i=
node */
> > > >                       spin_lock(&ci->i_ceph_lock);
> > > >                       if ((ci->i_max_files || ci->i_max_bytes) &&
> > > > @@ -1142,6 +1142,8 @@ int __ceph_setxattr(struct inode *inode, cons=
t char *name,
> > > >                               err =3D -EOPNOTSUPP;
> > > >                       spin_unlock(&ci->i_ceph_lock);
> > > >               }
> > > > +             if (err =3D=3D 0)
> > > > +                     err =3D ceph_sync_setxattr(inode, name, value=
, size, flags);
> > > >       }
> > > >  out:
> > > >       ceph_free_cap_flush(prealloc_cf);
> > > > --
> > > > 2.21.0 (Apple Git-122.2)
> > > >
