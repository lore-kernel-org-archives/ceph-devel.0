From: Dave Jones <davej@redhat.com>
Subject: Re: [GIT PULL] Ceph updates for -rc1
Date: Tue, 28 Jan 2014 16:10:21 -0500
Message-ID: <20140128211021.GB1377@redhat.com>
References: <alpine.DEB.2.00.1401281032560.16427@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1401281032560.16427@cobra.newdream.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Jan 28, 2014 at 10:40:16AM -0800, Sage Weil wrote:
 > Hi Linus,
 >=20
 > Please pull the following Ceph updates from
 >=20
 >   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git=
 for-linus
 >=20
 > This is a big batch.  From Ilya we have:
 >=20
 >  - rbd support for more than ~250 mapped devices (now uses same sche=
me=20
 >    that SCSI does for device major/minor numbering)
 >  - crush updates for new mapping behaviors (will be needed for comin=
g=20
 >    erasure coding support, among other things)
 >  - preliminary support for tiered storage pools
 >=20
 > There is also a big series fixing a pile cephfs bugs with clustered =
MDSs=20
 > from Yan Zheng, ACL support for cephfs from Guangliang Zhao, ceph fs=
cache=20
 > improvements from Li Wang, improved behavior when we get ENOSPC from=
 Josh=20
 > Durgin, some readv/writev improvements from Majianpeng, and the usua=
l mix=20
 > of small cleanups.

This breaks the build for me.

fs/ceph/acl.c: In function =E2=80=98ceph_init_acl=E2=80=99:
fs/ceph/acl.c:216:3: warning: passing argument 1 of =E2=80=98posix_acl_=
create=E2=80=99 from incompatible pointer type [enabled by default]
   ret =3D posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
   ^
In file included from include/linux/posix_acl_xattr.h:12:0,
                 from fs/ceph/acl.c:25:
include/linux/posix_acl.h:96:12: note: expected =E2=80=98struct inode *=
=E2=80=99 but argument is of type =E2=80=98struct posix_acl **=E2=80=99
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_ac=
l **,
            ^
fs/ceph/acl.c:216:3: warning: passing argument 2 of =E2=80=98posix_acl_=
create=E2=80=99 makes pointer from integer without a cast [enabled by d=
efault]
   ret =3D posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
   ^
In file included from include/linux/posix_acl_xattr.h:12:0,
                 from fs/ceph/acl.c:25:
include/linux/posix_acl.h:96:12: note: expected =E2=80=98umode_t *=E2=80=
=99 but argument is of type =E2=80=98unsigned int=E2=80=99
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_ac=
l **,
            ^
fs/ceph/acl.c:216:3: warning: passing argument 3 of =E2=80=98posix_acl_=
create=E2=80=99 from incompatible pointer type [enabled by default]
   ret =3D posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
   ^
In file included from include/linux/posix_acl_xattr.h:12:0,
                 from fs/ceph/acl.c:25:
include/linux/posix_acl.h:96:12: note: expected =E2=80=98struct posix_a=
cl **=E2=80=99 but argument is of type =E2=80=98umode_t *=E2=80=99
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_ac=
l **,
            ^
fs/ceph/acl.c:216:3: error: too few arguments to function =E2=80=98posi=
x_acl_create=E2=80=99
   ret =3D posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
   ^
In file included from include/linux/posix_acl_xattr.h:12:0,
                 from fs/ceph/acl.c:25:
include/linux/posix_acl.h:96:12: note: declared here
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_ac=
l **,
            ^
fs/ceph/acl.c: In function =E2=80=98ceph_acl_chmod=E2=80=99:
fs/ceph/acl.c:252:2: warning: passing argument 1 of =E2=80=98posix_acl_=
chmod=E2=80=99 from incompatible pointer type [enabled by default]
  ret =3D posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
  ^
In file included from include/linux/posix_acl_xattr.h:12:0,
                 from fs/ceph/acl.c:25:
include/linux/posix_acl.h:95:12: note: expected =E2=80=98struct inode *=
=E2=80=99 but argument is of type =E2=80=98struct posix_acl **=E2=80=99
 extern int posix_acl_chmod(struct inode *, umode_t);
            ^
fs/ceph/acl.c:252:2: error: too many arguments to function =E2=80=98pos=
ix_acl_chmod=E2=80=99
  ret =3D posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
  ^
In file included from include/linux/posix_acl_xattr.h:12:0,
                 from fs/ceph/acl.c:25:
include/linux/posix_acl.h:95:12: note: declared here
 extern int posix_acl_chmod(struct inode *, umode_t);
