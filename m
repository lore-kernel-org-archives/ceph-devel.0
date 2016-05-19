From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Initial proposal for bluestore compression control and statistics
Date: Thu, 19 May 2016 19:57:08 +0200
Message-ID: <20160519175708.GE22208@predictor>
References: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:56431 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932216AbcESRy5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 May 2016 13:54:57 -0400
Content-Disposition: inline
In-Reply-To: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 19, 2016 at 08:27:02PM +0300, Igor Fedotov wrote:
> Hi cephers,
>=20
> please find my initial proposal with regard to bluestore compression
> control and related statistics.
>=20
> Any comments/thoughts are highly appreciated.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> COMPRESSION CONTROL OPTIONS
>=20
> One can see following means to control  compression at BlueStore leve=
l.
>=20
> 1) Per-store setting to enable/disable compression and specify
> default compression method
>=20
> bluestore_compression =3D <zlib | snappy> / <force | optional | disab=
le>
>=20
> E.g.
>=20
> bluestore_compression =3D zlib/force
>=20
> The first token denotes default/applied compression algorithm.
> The second one:
>=20
> 'force' - enables compression for any objects
>=20
> 'optional' - burden the caller with the need to enable compression
> by different means (see below)
>=20
> 'disable' - unconditionally disables any compression for the store.
>=20
> This option is definitely useful for testing/debugging and has
> probably limited use in production.

If one uses Ceph for storage of pre-compressed data, having an option t=
o
disable additional (Ceph-side) compression would be desireable, at leas=
t on
per-Ceph level, but at least per-pool setting would be better.=20
Regarding optional - see below.

> 2) Per-object compression specification. One should be able to
> enable/disable compression for specific object.
>=20
> Following sub-option can be provided:
>=20
>   a) Specify compression mode (along with disablement option) at
> object creation
>=20
>   b) Specify compression mode at arbitrary moment via specific
> method/ioctl call. Compression to be applied for subsequent write
> requests
>=20
>   c) Force object compression/decompression at arbitrary moment via
> specific method/ioctl call. Existing object content to be
> compressed/decompressed and appropriate mode to be set for
> subsequent write requests.
>=20
>   d) Disable compression for short-lived objects if corresponding
> hint has been provided via set_alloc_hint2 call. See PR at https://gi=
thub.com/ceph/ceph/pull/6208/files/306c5e148cd2f538b3b6c8c2a1a3d5f38ef8=
e15a#r63775941
>=20
> Along with specific compression algorithm one should be able to
> specify default algorithm selection. E.g. user can specify 'default'
> compression for an object instead of specific 'zlib' or 'snappy'
> value.
>=20
> This way one can avoid the need to care about the proper algorithm
> selection for each object.
>=20
> Default algorithm to be taken from the store setting (see above)
>=20
> Such an option provides pretty good level of flexibility. Upper
> level can introduce additional logic to control compression this
> way, e.g. enable/disable it for specific pools or dynamically
> control depending on how compressible object content is.

I would also add ability to set minimum acceptable compression ratio,
with at least two options (any and no-expand). "Any" would store compre=
ssed
objects regardless how well they've compressed and "No-expand" would st=
ore
object in compressed format only if compressed size is smaller than
uncompressed size. For zlib, this is more than possible (see "Maximum
expansion factor" at http://www.zlib.net/zlib_tech.html) and storing
doubly-compressed data will yield higher cpu and memory usage while
accessing object *and* more storage being utilized. Additional option (=
set
in percentage or bytes) specifying actual minimum acceptable compressio=
n
ratio would improve on this idea further, and for example, improve read
performance on large images (tens of gigabytes) that were compressed by=
 only
few hundred megabytes.=20

> 3) Per-write request compression control.
>=20
> This option provides the highest level of flexibility but is
> probably an overkill.
>=20
> Any rationales to have it?

See above. If we're going to have per-block compression flag, then writ=
ing
compressed format data only if the compression actually shrunk the data
would improve read performance later.

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
