From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: Fwd: Reduce read latency and bandwidth for ec pool
Date: Tue, 17 Mar 2015 09:58:39 +0100
Message-ID: <5507ECBF.9030404@dachary.org>
References: <CANE=7sUo7tMT=kyuN86vs5b13nnqY9wpOuNuf=_z=P7UXKc+sg@mail.gmail.com>	<CANE=7sVcY5sCaHUSFn+MDkAYzeewa767ziXXLqNiSCXhnG4s-g@mail.gmail.com>	<5507DC67.2030800@dachary.org>	<CANE=7sV1CQA=ZV5ELihrE4DZNGN5=4c07uP4Pv2w8LLpzqWabA@mail.gmail.com>	<CANE=7sWb3EXwwpEN_suc0JVNrm46YggVhO7sekG51w5reiMocg@mail.gmail.com>	<5507DF9E.5050903@dachary.org>	<CANE=7sUR-Wdsat=3mBHW4SWrxSJPOC4svrZkwBMYQnWQFJ5VCw@mail.gmail.com>	<5507E82A.9010306@dachary.org> <CANE=7sWF+fm-UNA+krFUEMwTKzCJHJeaaCY_aq4yHLXvhV=Yzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lpsgv4G1GRtm2pwSqVlmQ143hXmODgIn4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59385 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753753AbbCQI6m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 04:58:42 -0400
In-Reply-To: <CANE=7sWF+fm-UNA+krFUEMwTKzCJHJeaaCY_aq4yHLXvhV=Yzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinze Chi <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lpsgv4G1GRtm2pwSqVlmQ143hXmODgIn4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/03/2015 09:45, Xinze Chi wrote:
> Sorry, I have not measure it.
>=20
> But I think it should really reduce latency when hit miss in cache
> pool and do_proxy_read.

Interesting. I bet Jason or Josh have an opinion about this.

Cheers

>=20
> 2015-03-17 16:39 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>
>>
>> On 17/03/2015 09:05, Xinze Chi wrote:
>>> RBD.
>>
>> Did you measure that RBD does a significant amount of reads that would=
 be optimized in this way ?
>>
>>> Maybe we could use tier pool.
>>>
>>> Thanks
>>>
>>> 2015-03-17 16:02 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>
>>>>
>>>> On 17/03/2015 08:52, Xinze Chi wrote:
>>>>> ---------- Forwarded message ----------
>>>>> From: Xinze Chi <xmdxcxz@gmail.com>
>>>>> Date: 2015-03-17 15:52 GMT+08:00
>>>>> Subject: Re: Fwd: Reduce read latency and bandwidth for ec pool
>>>>> To: Loic Dachary <loic@dachary.org>
>>>>>
>>>>>
>>>>> Yes, In my VDI environment, client read 4k every time. If we can re=
ad
>>>>> object from only shard. It would reduce the latency and bandwidth a=

>>>>> lot.
>>>>
>>>> I'm curious about your workload. Are you using RadosGW ? RBD ?
>>>>
>>>>> Thanks.
>>>>>
>>>>> 2015-03-17 15:48 GMT+08:00 Loic Dachary <loic@dachary.org>:
>>>>>> Hi,
>>>>>>
>>>>>> On 17/03/2015 08:27, Xinze Chi wrote:
>>>>>>> hi, loic:
>>>>>>>
>>>>>>>    I have an idea which could reduce read latency and bandwidth f=
or ec pool.
>>>>>>>
>>>>>>>    But, I don't know whether it is feasible.
>>>>>>>
>>>>>>>    Such as ec pool stripe_width =3D 16384 =3D 4 * 4096,  K =3D 4,=
 M =3D2
>>>>>>>
>>>>>>>    So ceph will partition the total of 16384 bytes to 4 data chun=
k,
>>>>>>> and encoding 2 parity chunk
>>>>>>>
>>>>>>>    shard_0 include 0 - (4096-1) in original data;
>>>>>>>    shard_1 include 4096 - (4096*2 - 1) in original data;
>>>>>>>    shard_2 include 4096*2 - (4096 * 3 -1) in original data;
>>>>>>>    shard_3 include 4096*3 - (4096 * 4 - 1) in original data
>>>>>>>    shard_4 include parity chunk
>>>>>>>    shard_5 include parity chunk
>>>>>>>
>>>>>>>     Now if client read (offset 0, len 4096) from object, it shoul=
d
>>>>>>> read 4 shard (from 0-3) and decode all this 4 chunk.
>>>>>>>
>>>>>>>     But, this example, maybe we can compute the destination shard=

>>>>>>> based on ec pool config ,read offset and read len , we only read
>>>>>>>
>>>>>>> shard_0 and return it to client, because shard_0 has include all =
data
>>>>>>> as client need.
>>>>>>
>>>>>> That optimization makes sense to me. I guess you're interested in =
having small objects in the pool and only read a few bytes at a time ?
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>>>
>>>>>>>     Wait for your comment.
>>>>>>>
>>>>>>>     Thanks.
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--lpsgv4G1GRtm2pwSqVlmQ143hXmODgIn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUH7L8ACgkQ8dLMyEl6F232lgCgoD4WCgeU2woNH7vEkcTgeamD
D60An1F7e9zRwk0QGubMKIzTOVDqrqLB
=aKrF
-----END PGP SIGNATURE-----

--lpsgv4G1GRtm2pwSqVlmQ143hXmODgIn4--
