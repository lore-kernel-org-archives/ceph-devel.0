From: Loic Dachary <loic@dachary.org>
Subject: Re: librados AIO problem diagnostic
Date: Thu, 02 Oct 2014 16:58:53 +0200
Message-ID: <542D682D.1090706@dachary.org>
References: <542BA6D4.4070207@dachary.org>	 <1412148537.6822.11.camel@sebmain.cern.ch> <542BBBE7.4000806@dachary.org>	 <1412163429.6822.20.camel@sebmain.cern.ch> <542BFCCB.4000203@dachary.org>	 <1412168988.6822.27.camel@sebmain.cern.ch>	 <1412243375.6822.38.camel@sebmain.cern.ch> <1412260284.4328.3.camel@sebmain.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Db0KUPTbUN83ria2mUJ08LP9Kvnrxq0wg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36712 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752846AbaJBO7A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 10:59:00 -0400
In-Reply-To: <1412260284.4328.3.camel@sebmain.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Ponce <sebastien.ponce@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Db0KUPTbUN83ria2mUJ08LP9Kvnrxq0wg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 02/10/2014 16:31, Sebastien Ponce wrote:
> As mentioned in the bug, I was a bit fast in concluding I could
> reproduce the problem. I can reproduce the original one, but not the
> remaining issue once the fix was applied.
>=20
> Loic, can you confirm that you are using the wip-9356 branch of repo
> git@github.com:sponce/ceph.git ?

Yes. I'm able to reproduce the problem with 0daddfbf1164d6ba3f38eee29d2f1=
1acfa62f2b6 from your tree https://github.com/sponce/ceph.git which is th=
e head of wip-9356

Cheers

>=20
> Sebastien
>=20
>=20
> On Thu, 2014-10-02 at 11:49 +0200, Sebastien Ponce wrote:
>> Hurray, I manage to seg fault ! (sounds odd this sentence...)
>> So indeed, fresh ubuntu, debug mode does it. What I've also changed in=

>> the meantime is the type of machine. It's still virtual, but more
>> powerful (4 cores).
>>
>> Let's debug it now...
>>
>> Sebastien
>>
>>
>> On Wed, 2014-10-01 at 15:09 +0200, Sebastien Ponce wrote:
>>> Ok, we are getting closer then.
>>> I'll try to reinstall the ubuntu machine and run with -g.
>>>
>>> Sebastien
>>>
>>> On Wed, 2014-10-01 at 15:08 +0200, Loic Dachary wrote:
>>>>
>>>> On 01/10/2014 13:37, Sebastien Ponce wrote:
>>>>> I've tried it on the RHEL6 like machine, but no luck. Or should I s=
ay I
>>>>> was lucky ? Anyway no crash.
>>>>>
>>>>> Discussing with Dan Van Der Ster, he told me that he had once the c=
ase
>>>>> where the crash was there or not depending on the libc version. Jus=
t in
>>>>> case, what are you using ? On the machine I've used this morning, i=
t's
>>>>> glibc-2.12-1.107.el6.x86_64
>>>>
>>>> I'm using=20
>>>>
>>>> ii  libc-bin                                              2.19-0ubun=
tu3=20
>>>>
>>>> and I do not have glibc installed. I'm quite sure you can reproduce =
the problem on a fresh Ubuntu 14.04 with the following
>>>>
>>>> ./autogen.sh ; ./configure --disable-static --with-debug CFLAGS=3D"-=
Wall -g" CXXFLAGS=3D"-Wall -g"
>>>>
>>>> it fails consistently in my container. When I try with ./configure i=
t does not fail. Something is going on when there is -g instead of the de=
fault flags. I checked that --disable-static and --with-debug make no dif=
ference.
>>>>
>>>> Cheers
>>>>
>>>>>
>>>>> Sebastien
>>>>>
>>>>> On Wed, 2014-10-01 at 10:31 +0200, Loic Dachary wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 01/10/2014 09:28, Sebastien Ponce wrote:
>>>>>>> Thanks for this effort !
>>>>>>> I'll look at all that this afternoon (it's mid morning here).
>>>>>>
>>>>>> Same here : I'm in Paris ;-)
>>>>>>
>>>>>>> Concerning configure and autogen, I do the standard (naive ?)
>>>>>>> "./autogen.sh; ./configure; make" given by the readme.
>>>>>>
>>>>>> Could you try with
>>>>>>
>>>>>> ./autogen.sh ; ./configure --disable-static --with-debug CC=3D'cca=
che gcc' CXX=3D'ccache g++' CFLAGS=3D"-Wall -g" CXXFLAGS=3D"-Wall -g" ; m=
ake
>>>>>>
>>>>>> and let me know if you see a problem when running
>>>>>>
>>>>>> cd src
>>>>>> rm -fr dev out ;  mkdir -p dev ; CEPH_NUM_MON=3D1 CEPH_NUM_OSD=3D3=
 ./vstart.sh -d -n -X -l mon osd
>>>>>> ./ceph_test_rados_striper_api_aio
>>>>>>
>>>>>> I'm trying with your "./configure" on my end to check if this chan=
ges something.
>>>>>>
>>>>>> It's going to be a fun one ;-)
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>>>
>>>>>>> Sebastien
>>>>>>>
>>>>>>>
>>>>>>> On Wed, 2014-10-01 at 09:01 +0200, Loic Dachary wrote:
>>>>>>>> Hi Sebastien,
>>>>>>>>
>>>>>>>> In the context of http://tracker.ceph.com/issues/9356 I'm trying=
 to collect as much information as I can in an environment that can be re=
constructed to avoid interferences. Could you please let me know which ./=
configure line you are using ? Or which do_autogen.sh command you are usi=
ng.
>>>>>>>>
>>>>>>>> Thanks in advance :-)
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Db0KUPTbUN83ria2mUJ08LP9Kvnrxq0wg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQtaC0ACgkQ8dLMyEl6F22P2wCfXw91EyuPicIsML78aCSl5nvM
vDkAn3UUMxgVmMdbU1E0qDAgZJmgxfqD
=JLDf
-----END PGP SIGNATURE-----

--Db0KUPTbUN83ria2mUJ08LP9Kvnrxq0wg--
