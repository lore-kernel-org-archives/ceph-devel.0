From: Loic Dachary <loic@dachary.org>
Subject: Re: controlling erasure code chunk size
Date: Mon, 03 Feb 2014 12:35:48 +0100
Message-ID: <52EF7F14.5020108@dachary.org>
References: <52EE6128.209@dachary.org>	<3472A07E6605974CBC9BC573F1BC02E4AE6C0277@CERNXCHG41.cern.ch> <CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VjIum0BXaF56cr7nIseMnlSh6aHXuCq1W"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59609 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaBCLf4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 06:35:56 -0500
In-Reply-To: <CA+4uBUbZYrp7BV8nK37Rx4BgpiN6kXg4_K74_8ja_sLL_FvN5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VjIum0BXaF56cr7nIseMnlSh6aHXuCq1W
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The argument to get_chunk_size is the stripe width, named object_size bec=
ause the API knows nothing about stripes, it is a concept for the caller =
to implement. Say you have a desired chunk size in mind, you would:

   object_size =3D desired_chunk_size * get_data_chunk_count()
   actual_chunk_size =3D get_chunk_size(object_size)

If you have a desired stripe width / object size in mind you would:

   object_size =3D desired_stripe_width
   chunk_size =3D get_chunk_size(object_size)

Following Andreas suggestions, controlling the size of the actual chunk i=
s a matter of tweaking the alignment constraints via the erasure code plu=
gin parameters.=20

Cheers

On 02/02/2014 23:45, Samuel Just wrote:
> I assume we will use get_chunksize(desired_chunksize) *
> get_data_chunk_count() on the mon to define the stripe width (the size
> of the buffer which will be presented to the plugin for encoding) for
> the pool.  At the moment, get_chunksize(4*(2<<10)) *
> get_data_chunk_count() =3D 393216 using the jerasure plugin where
> get_data_chunk_count() =3D 4.  This seems a bit big?
> -Sam
>=20
> On Sun, Feb 2, 2014 at 8:18 AM, Andreas Joachim Peters
> <Andreas.Joachim.Peters@cern.ch> wrote:
>> Hi Loic et.al.
>>
>> I think there is now some confusion about chunk_size, alignment, packe=
tsize and the stripe_size to be used upstream.
>>
>> Algorithms with a bit-matrix require that the size per device is a mul=
tiple of (packetsize*w). Moreover the size per device and packetsize itse=
lf must be a multiple of sizeof(long/int). For other algorithms  you can =
assume the same with packetsize=3D1.
>>
>> packetsize and w influence  the performance and too small stripe_size =
on top will have negative performance effects due to the preparation of b=
ufferlist, internal buffer checks and more loops to execute for the same =
amount of data. We can also do some measurement for this but the current =
benchmark would probably not reflect this, since it measures the algorith=
mic part not the bufferlist preparation part.
>>
>> If you want to define a stripe_size it has to be a multiple of the val=
ue returned by get_chunksize  and possibly it is a large multiple but in =
total not larger than processor caches. The plugin can not define the str=
ipe_size, it defines only the alignment to be used for stripe_size and st=
ripe_size is defined outside the plugin which maybe complicates the under=
standing. We should carefully check once more the Jerasure alignment requ=
irements and our current implementation.
>>
>> To get rid of the platform dependency we could put a generic alignment=
 requirement that chunksize has to be also 64-byte aligned.
>>
>> Cheers Andreas.
>>
>>
>>
>>
>> ________________________________________
>> From: Loic Dachary [loic@dachary.org]
>> Sent: 02 February 2014 16:15
>> To: Samuel Just
>> Cc: Ceph Development; Andreas Joachim Peters
>> Subject: controlling erasure code chunk size
>>
>> [cc' ceph-devel]
>>
>> Hi Sam,
>>
>> Here is how chunks are expected to be aligned:
>>
>> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a25=
f465/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L365
>>
>>  unsigned alignment =3D k*w*packetsize*sizeof(int);
>>   if ( ((w*packetsize*sizeof(int))%LARGEST_VECTOR_WORDSIZE) )
>>     alignment =3D k*w*packetsize*LARGEST_VECTOR_WORDSIZE;
>>   return alignment;
>>
>> If you are going to encode small objects, it may very well lead to ove=
rsized chunks if packetsize is large. At the moment the default is 3072
>>
>> https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a25=
f465/src/common/config_opts.h#L406
>>
>> A value I picked when experimenting with 1MB objects encoding ( http:/=
/dachary.org/?p=3D2594 ).
>>
>> I'm not entirely sure why the alignment is calculated the way it is. A=
ndreas certainly has a better understanding on this topic.
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--VjIum0BXaF56cr7nIseMnlSh6aHXuCq1W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLvfxUACgkQ8dLMyEl6F20UwwCgvxpbkmbQWIccXyp3tuHTe4wk
MdIAn3lY8tO6SiYJ5EVnFSwrq7JB6yWS
=8bfw
-----END PGP SIGNATURE-----

--VjIum0BXaF56cr7nIseMnlSh6aHXuCq1W--
