From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Thu, 10 Mar 2016 10:08:13 +0100
Message-ID: <20160310100813.7b64ac08@bahia.lab.toulouse-stg.fr.ibm.com>
References: <1456933303-1225-1-git-send-email-scaleqiao@gmail.com>
	<20160309200243.5b00eea7@bahia.lab.toulouse-stg.fr.ibm.com>
	<56E08316.7070805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e06smtp06.uk.ibm.com ([195.75.94.102]:42583 "EHLO
	e06smtp06.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbcCJJI0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 04:08:26 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <gkurz@linux.vnet.ibm.com>;
	Thu, 10 Mar 2016 09:08:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 913491B08070
	for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 09:08:47 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2A98L9p49807394
	for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 09:08:21 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2A98IpW004135
	for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2016 02:08:21 -0700
In-Reply-To: <56E08316.7070805@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
Cc: Jevon Qiao <scaleqiao@gmail.com>, haomaiwang@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, sage@newdream.net, ceph-devel@vger.kernel.org, gfarnum@redhat.com

On Wed, 9 Mar 2016 13:09:58 -0700
Eric Blake <eblake@redhat.com> wrote:

> On 03/09/2016 12:02 PM, Greg Kurz wrote:
> > On Wed,  2 Mar 2016 23:41:43 +0800
> > Jevon Qiao <scaleqiao@gmail.com> wrote:
> >  =20
>=20
> >> +}
> >> +
> >> +static int cephfs_readdir_r(FsContext *ctx, V9fsFidOpenState *fs,
> >> +                            struct dirent *entry,
> >> +                            struct dirent **result)
> >> +{
> >> +    int ret; =20
>=20
> >> +   =20
> >> +    return ret; =20
> >=20
> > This function should behave like the original readdir_r() function =
from the
> > C library, but it doesn't.
> >  =20
>=20
> readdir_r() is hopelessly broken.  POSIX is withdrawing it as such.
> http://austingroupbugs.net/view.php?id=3D696
>=20
> readdir() should be all the more any sane program needs, because it
> should already be thread-safe.
>=20

I wasn't aware that readdir_r() was so badly broken. It is currently
used here:

hw/9pfs/9p-handle.c:    return readdir_r(fs->dir, entry, result);
hw/9pfs/9p-local.c:    ret =3D readdir_r(fs->dir, entry, result);
hw/9pfs/9p-proxy.c:    return readdir_r(fs->dir, entry, result);

I'll see how we can move to readdir().

> > According to the the libcephfs.h header:
> >=20
> >  * @returns 1 if the next entry was filled in, 0 if the end of the =
directory stream was reached,
> >  *          and a negative error code on failure.
> >  */
> > int ceph_readdir_r(struct ceph_mount_info *cmount, struct ceph_dir_=
result *dirp, struct dirent *de);
> >=20
> > and the readdir_r() manual page says:
> >=20
> >    The  readdir_r() function returns 0 on success.  On error, it re=
turns a
> >    positive error number (listed under ERRORS).  If the end of the =
 direc=E2=80=90
> >    tory  stream  is  reached,  readdir_r()  returns 0, and returns =
NULL in
> >    *result. =20
>=20
> readdir_r() can silently overflow buffers, with no recourse.  Its use
> should not be encouraged.
>=20

Sure... this being said, fsdev currently exposes a readdir_r operation,=
 not
a readdir one. Until we decide to change that, backends must follow the
readdir_r() API.

Cheers.

--
Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
