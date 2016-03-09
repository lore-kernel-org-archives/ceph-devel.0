From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/9pfs: Add CephFS support in VirtFS
Date: Wed, 9 Mar 2016 13:09:58 -0700
Message-ID: <56E08316.7070805@redhat.com>
References: <1456933303-1225-1-git-send-email-scaleqiao@gmail.com>
 <20160309200243.5b00eea7@bahia.lab.toulouse-stg.fr.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sW1QBR5PMfPDfgI694v96IWJeUOP5JxRT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45489 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934080AbcCIUKB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Mar 2016 15:10:01 -0500
In-Reply-To: <20160309200243.5b00eea7@bahia.lab.toulouse-stg.fr.ibm.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, Jevon Qiao <scaleqiao@gmail.com>
Cc: haomaiwang@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, sage@newdream.net, ceph-devel@vger.kernel.org, gfarnum@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sW1QBR5PMfPDfgI694v96IWJeUOP5JxRT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/2016 12:02 PM, Greg Kurz wrote:
> On Wed,  2 Mar 2016 23:41:43 +0800
> Jevon Qiao <scaleqiao@gmail.com> wrote:
>=20

>> +}
>> +
>> +static int cephfs_readdir_r(FsContext *ctx, V9fsFidOpenState *fs,
>> +                            struct dirent *entry,
>> +                            struct dirent **result)
>> +{
>> +    int ret;

>> +   =20
>> +    return ret;
>=20
> This function should behave like the original readdir_r() function from=
 the
> C library, but it doesn't.
>=20

readdir_r() is hopelessly broken.  POSIX is withdrawing it as such.
http://austingroupbugs.net/view.php?id=3D696

readdir() should be all the more any sane program needs, because it
should already be thread-safe.

> According to the the libcephfs.h header:
>=20
>  * @returns 1 if the next entry was filled in, 0 if the end of the dire=
ctory stream was reached,
>  *          and a negative error code on failure.
>  */
> int ceph_readdir_r(struct ceph_mount_info *cmount, struct ceph_dir_resu=
lt *dirp, struct dirent *de);
>=20
> and the readdir_r() manual page says:
>=20
>    The  readdir_r() function returns 0 on success.  On error, it return=
s a
>    positive error number (listed under ERRORS).  If the end of the  dir=
ec=E2=80=90
>    tory  stream  is  reached,  readdir_r()  returns 0, and returns NULL=
 in
>    *result.

readdir_r() can silently overflow buffers, with no recourse.  Its use
should not be encouraged.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sW1QBR5PMfPDfgI694v96IWJeUOP5JxRT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJW4IMWAAoJEKeha0olJ0NqFPgIAKKyw9G54zQYSgXAhCUqu+VL
GR/jh3gB1g9b73iri6ZTJ9Lb3zZIEGGrjZ7+ctCKVp+hzId2WltVoTxhOVDYsGa1
3Qwsxvs1h4mNnnHQs7d1XyIYiXQShTMNBXqxBbNpyMzWJ6/AE9NWWzsgbycIqWsP
/7/Q8wwp6GHtx/JWCeo5RpiXEop0btQYMSkdGIYhdThMiV0gCUgSrS17XNhKVqro
xiBXE/e70WHELtRLjLx6HbejXr4QT7o3RwHknZsHj6eeFtkrvdvbLwM7Q5XC2EpD
yoYgVdWLix5GT+6UxIba+mCyEuT0RS2aCCojEGad6hKcnnl1OWN4SGhl17qb36Q=
=qjCb
-----END PGP SIGNATURE-----

--sW1QBR5PMfPDfgI694v96IWJeUOP5JxRT--
