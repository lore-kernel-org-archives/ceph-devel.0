From: Loic Dachary <loic@dachary.org>
Subject: Re: librados AIO problem diagnostic
Date: Thu, 09 Oct 2014 16:24:04 +0200
Message-ID: <54369A84.1010300@dachary.org>
References: <542BA6D4.4070207@dachary.org>	 <1412148537.6822.11.camel@sebmain.cern.ch> <542BBBE7.4000806@dachary.org>	 <1412163429.6822.20.camel@sebmain.cern.ch> <542BFCCB.4000203@dachary.org>	 <1412168988.6822.27.camel@sebmain.cern.ch>	 <1412243375.6822.38.camel@sebmain.cern.ch>	 <1412260284.4328.3.camel@sebmain.cern.ch> <542D682D.1090706@dachary.org>	 <5434E45E.8040105@dachary.org> <1412755233.17687.4.camel@sebmain.cern.ch> <1412863615.749.18.camel@sebmain.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KwAnCFa4dn4P2CIctrEAOT4RrJ1PshLj3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41117 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbaJIOYM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Oct 2014 10:24:12 -0400
In-Reply-To: <1412863615.749.18.camel@sebmain.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Ponce <sebastien.ponce@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KwAnCFa4dn4P2CIctrEAOT4RrJ1PshLj3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 09/10/2014 16:06, Sebastien Ponce wrote:
> Finally this should be fixed.
> Loic, could you retry with the new state of my branch and confirm ?

Hi Sebastien,

I commented on the pull request and scheduled a run in the gitbuilder.

Cheers

>=20
> Sebastien
>=20
> On Wed, 2014-10-08 at 10:00 +0200, Sebastien Ponce wrote:
>> It vanished again....
>> I've spent quite some time analysing the helgrind output to try to fin=
d
>> it, but so far I got nothing but problems outside this part (BTW, it
>> would be interesting to run tests systematically in helgrind, even if
>> there is a lot of false positive).
>> Now I've just seen the backtrace you've sent and this already helps a
>> lot; I did not even have a backtrace so far.
>> In conclusion, still ongoing....
>>
>> Sebastien
>>
>>
>> On Wed, 2014-10-08 at 09:14 +0200, Loic Dachary wrote:
>>> Hi Sebastien,
>>>
>>> Have you been able to reproduce it or did it vanish again ? This is a=
 tricky one ;-)
>>>
>>> Cheers
>>>
>>> On 02/10/2014 16:58, Loic Dachary wrote:
>>>>
>>>>
>>>> On 02/10/2014 16:31, Sebastien Ponce wrote:
>>>>> As mentioned in the bug, I was a bit fast in concluding I could
>>>>> reproduce the problem. I can reproduce the original one, but not th=
e
>>>>> remaining issue once the fix was applied.
>>>>>
>>>>> Loic, can you confirm that you are using the wip-9356 branch of rep=
o
>>>>> git@github.com:sponce/ceph.git ?
>>>>
>>>> Yes. I'm able to reproduce the problem with 0daddfbf1164d6ba3f38eee2=
9d2f11acfa62f2b6 from your tree https://github.com/sponce/ceph.git which =
is the head of wip-9356
>>>>
>>>> Cheers
>>>>
>>>>>
>>>>> Sebastien
>>>>>
>>>>>
>>>>> On Thu, 2014-10-02 at 11:49 +0200, Sebastien Ponce wrote:
>>>>>> Hurray, I manage to seg fault ! (sounds odd this sentence...)
>>>>>> So indeed, fresh ubuntu, debug mode does it. What I've also change=
d in
>>>>>> the meantime is the type of machine. It's still virtual, but more
>>>>>> powerful (4 cores).
>>>>>>
>>>>>> Let's debug it now...
>>>>>>
>>>>>> Sebastien
>>>>>>
>>>>>>
>>>>>> On Wed, 2014-10-01 at 15:09 +0200, Sebastien Ponce wrote:
>>>>>>> Ok, we are getting closer then.
>>>>>>> I'll try to reinstall the ubuntu machine and run with -g.
>>>>>>>
>>>>>>> Sebastien
>>>>>>>
>>>>>>> On Wed, 2014-10-01 at 15:08 +0200, Loic Dachary wrote:
>>>>>>>>
>>>>>>>> On 01/10/2014 13:37, Sebastien Ponce wrote:
>>>>>>>>> I've tried it on the RHEL6 like machine, but no luck. Or should=
 I say I
>>>>>>>>> was lucky ? Anyway no crash.
>>>>>>>>>
>>>>>>>>> Discussing with Dan Van Der Ster, he told me that he had once t=
he case
>>>>>>>>> where the crash was there or not depending on the libc version.=
 Just in
>>>>>>>>> case, what are you using ? On the machine I've used this mornin=
g, it's
>>>>>>>>> glibc-2.12-1.107.el6.x86_64
>>>>>>>>
>>>>>>>> I'm using=20
>>>>>>>>
>>>>>>>> ii  libc-bin                                              2.19-0=
ubuntu3=20
>>>>>>>>
>>>>>>>> and I do not have glibc installed. I'm quite sure you can reprod=
uce the problem on a fresh Ubuntu 14.04 with the following
>>>>>>>>
>>>>>>>> ./autogen.sh ; ./configure --disable-static --with-debug CFLAGS=3D=
"-Wall -g" CXXFLAGS=3D"-Wall -g"
>>>>>>>>
>>>>>>>> it fails consistently in my container. When I try with ./configu=
re it does not fail. Something is going on when there is -g instead of th=
e default flags. I checked that --disable-static and --with-debug make no=
 difference.
>>>>>>>>
>>>>>>>> Cheers
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Sebastien
>>>>>>>>>
>>>>>>>>> On Wed, 2014-10-01 at 10:31 +0200, Loic Dachary wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 01/10/2014 09:28, Sebastien Ponce wrote:
>>>>>>>>>>> Thanks for this effort !
>>>>>>>>>>> I'll look at all that this afternoon (it's mid morning here).=

>>>>>>>>>>
>>>>>>>>>> Same here : I'm in Paris ;-)
>>>>>>>>>>
>>>>>>>>>>> Concerning configure and autogen, I do the standard (naive ?)=

>>>>>>>>>>> "./autogen.sh; ./configure; make" given by the readme.
>>>>>>>>>>
>>>>>>>>>> Could you try with
>>>>>>>>>>
>>>>>>>>>> ./autogen.sh ; ./configure --disable-static --with-debug CC=3D=
'ccache gcc' CXX=3D'ccache g++' CFLAGS=3D"-Wall -g" CXXFLAGS=3D"-Wall -g"=
 ; make
>>>>>>>>>>
>>>>>>>>>> and let me know if you see a problem when running
>>>>>>>>>>
>>>>>>>>>> cd src
>>>>>>>>>> rm -fr dev out ;  mkdir -p dev ; CEPH_NUM_MON=3D1 CEPH_NUM_OSD=
=3D3 ./vstart.sh -d -n -X -l mon osd
>>>>>>>>>> ./ceph_test_rados_striper_api_aio
>>>>>>>>>>
>>>>>>>>>> I'm trying with your "./configure" on my end to check if this =
changes something.
>>>>>>>>>>
>>>>>>>>>> It's going to be a fun one ;-)
>>>>>>>>>>
>>>>>>>>>> Cheers
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Sebastien
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On Wed, 2014-10-01 at 09:01 +0200, Loic Dachary wrote:
>>>>>>>>>>>> Hi Sebastien,
>>>>>>>>>>>>
>>>>>>>>>>>> In the context of http://tracker.ceph.com/issues/9356 I'm tr=
ying to collect as much information as I can in an environment that can b=
e reconstructed to avoid interferences. Could you please let me know whic=
h ./configure line you are using ? Or which do_autogen.sh command you are=
 using.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks in advance :-)
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>>
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html=

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


--KwAnCFa4dn4P2CIctrEAOT4RrJ1PshLj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ2moQACgkQ8dLMyEl6F22TggCgxqZnVqvC1570ibrGFAM5e4ML
bBwAn3IvseR8K+vUaOUBVw4aH1cigpl8
=jtRU
-----END PGP SIGNATURE-----

--KwAnCFa4dn4P2CIctrEAOT4RrJ1PshLj3--
