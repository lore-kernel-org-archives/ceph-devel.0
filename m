From: Loic Dachary <loic@dachary.org>
Subject: Re: reconciliation between firefly and v0.80.8.2
Date: Fri, 24 Jul 2015 19:20:09 +0200
Message-ID: <55B273C9.8070202@dachary.org>
References: <55B2708B.1020705@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RXimHLcx4Gu4RcxjJOuTOIFGlKLc4i9m2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55688 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753183AbbGXRUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2015 13:20:17 -0400
In-Reply-To: <55B2708B.1020705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RXimHLcx4Gu4RcxjJOuTOIFGlKLc4i9m2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/07/2015 19:06, Loic Dachary wrote:
> Hi Ken,
>=20
> The commits with a + are found in v0.80.8.2 and are not in firefly
>=20
> $ git rev-parse ceph/hammer
> eb69cf758eb25e7ac71e36c754b9b959edb67cee
> $ git --no-pager cherry -v ceph/firefly tags/v0.80.8.2
> + d75a9e374e6581c57461018952ed125c929aeb30 build: remove LIBPERFGLUE fr=
om LIBMDS
> - 2cbe4fb6436dc959eb54cbcc5226b5ebff974d8d init-radosgw.sysv: set ulimi=
t -n before starting daemon
> - f38b7b407325d14868c2798035282f1e29e92485 init-radosgw*: don't require=
 rgw_socket_path to be defined
> - 0ccd1d379d02da5371cebf962465757b0ac741ab Revert "rbd: ObjectCacher re=
ads can hang when reading sparse files"
> - ec711a9f30ac829f6504038063babd51f4b50488 Revert "Enforce cache size o=
n read requests"
> - c7fdbabb237a78aa7a7c282725ce438f60bc4d75 osdc: Constrain max number o=
f in-flight read requests
> + 00b6fb027bb6fccda6716ef577464d30d96959cc 0.80.8.1
> + b31da9435817d057a558c9222a246569d0a632b3 rgw: remove meta file after =
deleting bucket The meta file is deleted only if the bucket meta data is =
not synced
> - 63c67434d22d16d7f72032c596e7563c20ce3b6a rgw: use correct objv_tracke=
r for bucket instance
> - ed8fb953580a9d23c9a036c475659528d48eedff rgw: don't overwrite bucket =
/ object owner when setting acls
> + 096488b188a79fc7132e73cf88d6004f369bceb3 CephContext: Add AssociatedS=
ingletonObject to allow CephContext's singleton
> + 510df4f61367d4b93574251bd0842cc8247c9bf9 common/ceph_context: don't i=
mport std namespace
> + e4fa039c592b50f6406cecd060ed2f673cb5ee7e WorkQueue: add new ContextWQ=
 work queue
> + 78d48d89ab18479d71d7220fe9ba9c2aa9752476 WorkQueue: added virtual des=
tructor
> + b82ff103892612e6685a5c5db56082d9565881f6 librbd: add task pool / work=
 queue for AIO requests
> + f94a88f50078670eebb8a90d923fcb3477a636ac librbd: avoid blocking AIO A=
PI methods
> + 316f08e4ee65f9eda8761972ba2d337e94abcac7 librbd: add new fail method =
to AioCompletion
> + ac87e43be3ca7029a4260f4e52dff39144b7c88f Throttle: added pending_erro=
r method to SimpleThrottle
> + 09705dd9f2dcd9c54dd7a478293ec7fc60f3cf92 librbd: internal AIO methods=
 no longer return result
> + 0600f5f8cf55803da919d6d69b94ed5ed5a1ac2b tests: update librbd AIO tes=
ts to remove result code
> + 890e5bca5c71740025b2e8ff8bad863fc7e9b33e librbd: AioRequest::send no =
longer returns a result
> + 6ce86f1f1bd6cc3b7995fa5ba34507c8aa21f608 librbd: new rbd_non_blocking=
_aio config option
> + f839ef6ed214dc0847da59742b0c7fa41cceaeea tests: verify librbd blockin=
g aio code path
> - d0d8555341e297ecbbf62ed3cec179b0e2fbe14f ceph.spec: add mkcephfs to c=
eph.rpm
> - 3088167a85ba641b000deb9214b27c0681a745a8 ceph.spec.in: package mkceph=
fs on EL6
> + 08ac26392cd369d0047dfa7a70c8fe693c63ead5 0.80.8.2
>=20
> * build: remove LIBPERFGLUE from LIBMDS=20
>   is unique to v0.80.8.2 and it is unclear why it was found to be usefu=
 in isolation. An issue for firefly backport of http://tracker.ceph.com/i=
ssues/10691 was open at http://tracker.ceph.com/issues/12461#note-1
>=20
> * rgw: remove meta file after deleting bucket The meta file is deleted =
only if the bucket meta data is not synced
>   is being tested and is patch-id identical as shown by the leading min=
us (-) which would have been an + if they were different
>=20
>   pr=3D4641 ; git fetch ceph +refs/pull/$pr/*:refs/pull/$pr/*
>   $ git --no-pager cherry -v refs/pull/4641/merge tags/v0.80.8.2 | grep=
 'rgw: remove meta file after deleting'
> - b31da9435817d057a558c9222a246569d0a632b3 rgw: remove meta file after =
deleting bucket The meta file is deleted only if the bucket meta data is =
not synced
>=20
> * The bulk of the differences from 096488b188a79fc7132e73cf88d6004f369b=
ceb3 to f839ef6ed214dc0847da59742b0c7fa41cceaeea are pending integration =
in https://github.com/ceph/ceph/pull/4854. If this pull request was merge=
d, there would still be two commits that are not patch-id identical:
>=20
> pr=3D4854 ; git fetch ceph +refs/pull/$pr/*:refs/pull/$pr/*
> git --no-pager cherry -v refs/pull/4854/merge tags/v0.80.8.2
> + d75a9e374e6581c57461018952ed125c929aeb30 build: remove LIBPERFGLUE fr=
om LIBMDS
> - 2cbe4fb6436dc959eb54cbcc5226b5ebff974d8d init-radosgw.sysv: set ulimi=
t -n before starting daemon
> - f38b7b407325d14868c2798035282f1e29e92485 init-radosgw*: don't require=
 rgw_socket_path to be defined
> - 0ccd1d379d02da5371cebf962465757b0ac741ab Revert "rbd: ObjectCacher re=
ads can hang when reading sparse files"
> - ec711a9f30ac829f6504038063babd51f4b50488 Revert "Enforce cache size o=
n read requests"
> - c7fdbabb237a78aa7a7c282725ce438f60bc4d75 osdc: Constrain max number o=
f in-flight read requests
> + 00b6fb027bb6fccda6716ef577464d30d96959cc 0.80.8.1
> + b31da9435817d057a558c9222a246569d0a632b3 rgw: remove meta file after =
deleting bucket The meta file is deleted only if the bucket meta data is =
not synced
> - 63c67434d22d16d7f72032c596e7563c20ce3b6a rgw: use correct objv_tracke=
r for bucket instance
> - ed8fb953580a9d23c9a036c475659528d48eedff rgw: don't overwrite bucket =
/ object owner when setting acls
> - 096488b188a79fc7132e73cf88d6004f369bceb3 CephContext: Add AssociatedS=
ingletonObject to allow CephContext's singleton
> - 510df4f61367d4b93574251bd0842cc8247c9bf9 common/ceph_context: don't i=
mport std namespace
> - e4fa039c592b50f6406cecd060ed2f673cb5ee7e WorkQueue: add new ContextWQ=
 work queue
> - 78d48d89ab18479d71d7220fe9ba9c2aa9752476 WorkQueue: added virtual des=
tructor
> + b82ff103892612e6685a5c5db56082d9565881f6 librbd: add task pool / work=
 queue for AIO requests
> - f94a88f50078670eebb8a90d923fcb3477a636ac librbd: avoid blocking AIO A=
PI methods
> + 316f08e4ee65f9eda8761972ba2d337e94abcac7 librbd: add new fail method =
to AioCompletion
> - ac87e43be3ca7029a4260f4e52dff39144b7c88f Throttle: added pending_erro=
r method to SimpleThrottle
> - 09705dd9f2dcd9c54dd7a478293ec7fc60f3cf92 librbd: internal AIO methods=
 no longer return result
> - 0600f5f8cf55803da919d6d69b94ed5ed5a1ac2b tests: update librbd AIO tes=
ts to remove result code
> - 890e5bca5c71740025b2e8ff8bad863fc7e9b33e librbd: AioRequest::send no =
longer returns a result
> - 6ce86f1f1bd6cc3b7995fa5ba34507c8aa21f608 librbd: new rbd_non_blocking=
_aio config option
> - f839ef6ed214dc0847da59742b0c7fa41cceaeea tests: verify librbd blockin=
g aio code path
> - d0d8555341e297ecbbf62ed3cec179b0e2fbe14f ceph.spec: add mkcephfs to c=
eph.rpm
> - 3088167a85ba641b000deb9214b27c0681a745a8 ceph.spec.in: package mkceph=
fs on EL6
> + 08ac26392cd369d0047dfa7a70c8fe693c63ead5 0.80.8.2
> The first is cosmetic:
>=20
> librbd: add task pool / work queue for AIO requests
> $ diff -u --ignore-matching-lines '^[^+-]' <(git show b82ff103892612e66=
85a5c5db56082d9565881f6) <(git show 220a23e8d99882838626d5647f9c055eefeb2=
8c6)=20
> --- /dev/fd/63	2015-07-24 18:40:24.350584528 +0200
> +++ /dev/fd/62	2015-07-24 18:40:24.350584528 +0200
> @@ -62,13 +62,12 @@
>     ImageCtx::ImageCtx(const string &image_name, const string &image_id=
,
>   		     const char *snap, IoCtx& p, bool ro)
>       : cct((CephContext*)p.cct()),
> -@@ -51,7 +69,8 @@ namespace librbd {
> -       format_string(NULL),
> +@@ -53,7 +71,7 @@ namespace librbd {
>         id(image_id), parent(NULL),
>         stripe_unit(0), stripe_count(0),
> --      object_cacher(NULL), writeback_handler(NULL), object_set(NULL)
> -+      object_cacher(NULL), writeback_handler(NULL), object_set(NULL),=

> -+      aio_work_queue(NULL)
> +       object_cacher(NULL), writeback_handler(NULL), object_set(NULL),=

> +-      pending_aio(0)
> ++      pending_aio(0), aio_work_queue(NULL)
>     {
>       md_ctx.dup(p);
>       data_ctx.dup(p);
>=20
> The second is not obvious to me
>=20
> librbd: add new fail method to AioCompletion
>=20
> $ diff -u --ignore-matching-lines '^[^+-]' <(git show 316f08e4ee65f9eda=
8761972ba2d337e94abcac7) <(git show 8ec341ee8f256e8ab91a931f6005e1ebd4b1d=
b60)=20
> --- /dev/fd/63	2015-07-24 18:45:12.837559514 +0200
> +++ /dev/fd/62	2015-07-24 18:45:12.841559500 +0200
> @@ -58,6 +57,13 @@
>  +      break;
>  +    }
>  +
> ++    if (ictx !=3D NULL) {
> ++      Mutex::Locker l(ictx->aio_lock);
> ++      assert(ictx->pending_aio !=3D 0);
> ++      --ictx->pending_aio;
> ++      ictx->pending_aio_cond.Signal();
> ++    }
> ++
>  +    if (complete_cb) {
>  +      complete_cb(rbd_comp, complete_arg);
>  +    }
> @@ -113,6 +119,14 @@
>  -	lderr(ictx->cct) << "completed invalid aio_type: " << aio_type << de=
ndl;
>  -	break;
>  -      }
> +-
> +-      {
> +-        Mutex::Locker l(ictx->aio_lock);
> +-        assert(ictx->pending_aio !=3D 0);
> +-        --ictx->pending_aio;
> +-        ictx->pending_aio_cond.Signal();
> +-      }
> +-
>  -      if (complete_cb) {
>  -	complete_cb(rbd_comp, complete_arg);
>  -      }
>=20

After a discussion with Jason Dillaman, this difference is because the v0=
=2E80.8.2 branch does not have pending_aio counters. Firefly has pending_=
aio counters and needs these additional hunks.

> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--RXimHLcx4Gu4RcxjJOuTOIFGlKLc4i9m2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWyc8kACgkQ8dLMyEl6F22PAQCfaMYfs4Y3PfEX0F8eqTUmlbAC
ZLoAn0bKNpe7iI+OTLEZHoCuLbDInjj+
=baOx
-----END PGP SIGNATURE-----

--RXimHLcx4Gu4RcxjJOuTOIFGlKLc4i9m2--
