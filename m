From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] qa/workunits/erasure-code/bench.sh: Using correcting
 parameter name when call ceph_erasure_code_benchmark.
Date: Tue, 15 Jul 2014 23:03:23 +0300
Message-ID: <53C5890B.3000803@dachary.org>
References: <6AA21C22F0A5DA478922644AD2EC308C8880CC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ueIkE8CdENpsVr2x1aheNCF34WDbUelmB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43737 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751945AbaGOUDb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jul 2014 16:03:31 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C8880CC@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ueIkE8CdENpsVr2x1aheNCF34WDbUelmB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

This is part of a larger pull request ( https://github.com/ceph/ceph/pull=
/1875 ), specifically https://github.com/dachary/ceph/commit/64175d9d6e1c=
8f6cbdc5396e85ba8c94168afba8#diff-8a5d2cfe0db7cb75615a5f6b2245148bL53 . B=
ut it's worth applying as suggested until it gets merged, to avoid confus=
ion.

Thanks !

Reviewed-by:

On 15/07/2014 12:31, Ma, Jianpeng wrote:
> In commit bcc74879a, loic modifed the parameter name. But he forgot to
> modify the name in qa/workunits/erasure-code/bench.sh. Now modify and m=
ake
> bench.sh work.
>=20
> Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
> ---
>  qa/workunits/erasure-code/bench.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/qa/workunits/erasure-code/bench.sh b/qa/workunits/erasure-=
code/bench.sh
> index db7c490..483450b 100755
> --- a/qa/workunits/erasure-code/bench.sh
> +++ b/qa/workunits/erasure-code/bench.sh
> @@ -50,9 +50,9 @@ function bench() {
>          --iterations $iterations \
>          --size $size \
>          --erasures $erasures \
> -        --parameter erasure-code-k=3D$k \
> -        --parameter erasure-code-m=3D$m \
> -        --parameter erasure-code-directory=3D$PLUGIN_DIRECTORY)
> +        --parameter k=3D$k \
> +        --parameter m=3D$m \
> +        --parameter directory=3D$PLUGIN_DIRECTORY)
>      result=3D$($command "$@")
>      echo -e "$result\t$plugin\t$k\t$m\t$workload\t$iterations\t$size\t=
$erasures\t$command ""$@"
>  }
> --
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--ueIkE8CdENpsVr2x1aheNCF34WDbUelmB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPFiQsACgkQ8dLMyEl6F21pNQCgxJVuHuAHabXjUaFvRavCBpBI
UBYAnjVdb4IpNNyKukuRR8T1ITLtCDyz
=FbIJ
-----END PGP SIGNATURE-----

--ueIkE8CdENpsVr2x1aheNCF34WDbUelmB--
