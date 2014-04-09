From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: [Share]Performance tunning on Ceph FileStore with SSD backend
Date: Wed, 9 Apr 2014 16:10:10 +0200
Message-ID: <B86BE2A5-7650-4B2A-93A3-2CA3A8C31E82@enovance.com>
References: <b93e6941-f0d2-4ea4-b516-23bd13d0431f@mailpro>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: multipart/signed; boundary="Apple-Mail=_416B6FAD-E8D3-4D31-B14B-DF4FCAEB9289"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:44167 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932804AbaDIOKR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Apr 2014 10:10:17 -0400
In-Reply-To: <b93e6941-f0d2-4ea4-b516-23bd13d0431f@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_416B6FAD-E8D3-4D31-B14B-DF4FCAEB9289
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hey Haomai,

Nice work, by an chance do you have a branch that contains all the =
changes you=92ve made?
So that people can try themselves :)

I look forward to reading more results :)

Thanks!

Cheers.
=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

On 09 Apr 2014, at 14:08, Alexandre DERUMIER <aderumier@odiso.com> =
wrote:

> Hi,
>=20
> thanks for sharing !
> (I'm looking to build a full ssd cluster too with 1TB ssd)
>=20
>>> With these, we achieve 3x-4x performance improvements on filestore =
with SSD.=20
>=20
> Do you have some iops values benchmark, before and after ?
>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Haomai Wang" <haomaiwang@gmail.com>=20
> =C0: ceph-devel@vger.kernel.org=20
> Envoy=E9: Mercredi 9 Avril 2014 12:05:19=20
> Objet: [Share]Performance tunning on Ceph FileStore with SSD backend=20=

>=20
> Hi all,=20
>=20
> I would like to share some ideas about how to improve performance on=20=

> ceph with SSD. Not much preciseness.=20
>=20
> Our ssd is 500GB and each OSD own a SSD(journal is on the same SSD).=20=

> ceph version is 0.67.5(Dumping)=20
>=20
> At first, we find three bottleneck on filestore:=20
> 1. fdcache_lock(changed in Firely release)=20
> 2. lfn_find in omap_* methods=20
> 3. DBObjectMap header=20
>=20
> According to my understanding and the docs in=20
> =
ObjectStore.h(https://github.com/ceph/ceph/blob/master/src/os/ObjectStore.=
h),=20
> I simply remove lfn_find in omap_* and fdcache_lock. I'm not fully=20
> sure the correctness of this change, but it works well still now.=20
>=20
> DBObjectMap header patch is on the pull request queue and may be=20
> merged in the next feature merge window.=20
>=20
> With things above done, we get much performance improvement in disk=20
> util and benchmark results(3x-4x).=20
>=20
> Next, we find fdcache size become the main bottleneck. For example, if=20=

> hot data range is 100GB, we need 25000(100GB/4MB) fd to cache. If hot=20=

> data range is 1TB, we need 250000(1000GB/4MB) fd to cache. With=20
> increase "filestore_fd_cache_size", the cost of lookup(FDCache) and=20
> cache miss is expensive and can't be afford. The implementation of=20
> FDCache isn't O(1). So we only can get high performance on fdcache hit=20=

> range(maybe 100GB with 10240 fdcache size) and more data exceed the=20
> size of fdcaceh will be disaster. If you want to cache more fd(102400=20=

> fdcache size), the implementation of FDCache will bring on extra CPU=20=

> cost(can't be ignore) for each op.=20
>=20
> Because of the capacity of SSD(several hundreds GB), we try to=20
> increase the size of rbd object(16MB) so less fd cache is needed. As=20=

> for FDCache implementation, we simply discard SimpleLRU but introduce=20=

> RandomCache. Now we can set much larger fdcache size(near cache all=20
> fd) with little overload.=20
>=20
> With these, we achieve 3x-4x performance improvements on filestore =
with SSD.=20
>=20
> Maybe it exists something I missed or something wrong, hope can=20
> correct me. I hope it can help to improve FileStore on SSD and push=20
> into master branch.=20
>=20
> --=20
>=20
> Best Regards,=20
>=20
> Wheat=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_416B6FAD-E8D3-4D31-B14B-DF4FCAEB9289
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTRVTCAAoJECPrkYfpbtGTHpsH/jA7hpAEcho/MIjWc4Jhowey
mBnTo9/P2hhX62qKJqO2YulbYaxlFldnEk3z5XN8pIfz/Ilh7WQDNHPJ/4NNo1Bo
9Rf9M2rhgqawqtg/nLRJESRol7H8wXkvTesILYKcTnCtL+Bf8HwkWwid0Z1Wy8op
+7gheLi1JirguShVs+KIhV/dy6KRa3a7NreG6VSc7F5EArZuNkxNj8LXW68XIV3X
KFV/GQA8blCGO5Vez+anPuPEBvAchD9BfmijEseCccJz/+Ym5AE4y6JV/H0+dlds
IUCBOuzyA5j3VjEcKII+Z7qYPWYvGu3Tdy4h9C/0tg98qK2UK8VEGVmC/k8B5HI=
=FAlr
-----END PGP SIGNATURE-----

--Apple-Mail=_416B6FAD-E8D3-4D31-B14B-DF4FCAEB9289--
