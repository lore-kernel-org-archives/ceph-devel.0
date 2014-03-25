From: Loic Dachary <loic@dachary.org>
Subject: Re: GCC -msse2 portability question
Date: Tue, 25 Mar 2014 19:45:36 +0100
Message-ID: <5331CED0.8010103@dachary.org>
References: <532F3B0E.2050204@dachary.org>	<1395614070.15058.140.camel@pc2>	<5330A328.9060203@dachary.org>	<1395740605.15058.205.camel@pc2>	<533152E9.50709@dachary.org>	<1395746572.15058.219.camel@pc2> <CANP1eJEYea5=tdxPVAe7G8aY30HZGb-MqdHAhCaoigtYEX3s-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="grW4HodBVooccIuAVNbgfHAgE6QAr0dsd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:54098 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbaCYSpm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 14:45:42 -0400
In-Reply-To: <CANP1eJEYea5=tdxPVAe7G8aY30HZGb-MqdHAhCaoigtYEX3s-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--grW4HodBVooccIuAVNbgfHAgE6QAr0dsd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks, I did not know about this attribute :-)

On 25/03/2014 15:44, Milosz Tanski wrote:
> Loic,
>=20
> If you're already doing a runtime checking of these bits before
> calling the functions you want to optimize then you can use the gcc
> Function Specific Opt feature of GCC.
> http://gcc.gnu.org/onlinedocs/gcc-4.4.0/gcc/Function-Attributes.html#in=
dex-g_t_0040code_007btarget_007d-function-attribute-2259
>=20
> Basically you add a target attribute to a function (specifying use SSE =
version).
>=20
> void my_optimized_function(void* sse_vec, size_t n)
>     __attribute__ ((__target__ ("sse4.2")));
>=20
> It's available from GCC 4.4 and on. That happens to be the GCC version
> on RHEL6, Debian Squeeze, Ubuntu 10.04 LTS. Hopefully that's good
> enough and you can omit the optimization on people on platforms older
> than that.
>=20
> Best,
> - Milosz
>=20
>=20
> On Tue, Mar 25, 2014 at 7:22 AM, Laurent GUERBY <laurent@guerby.net> wr=
ote:
>> On Tue, 2014-03-25 at 10:56 +0100, Loic Dachary wrote:
>>> Hi Laurent,
>>
>> Hi Loic,
>>
>>> It occurs to me that all we're after is to enable SSE functions such =
as _mm_set_epi32. We're not trying to have the binary optimized in any im=
plicit way, it is all explicit. The problem seems to be that -msse4.2 wil=
l do both
>>>
>>> * activate _mm_set_epi32 etc functions
>>> * optimize the binary to use sse4.2 instructions
>>>
>>> Do you know of a compiler flag that would only
>>>
>>> * activate _mm_set_epi32 etc functions
>>
>> This is a function part of an Intel defined standard to access process=
or
>> feature, this standard will have one or more implementation depending =
on
>> your compiler/libc/OS. IIRC these functions are closely aligned with
>> specific processor feature, if the feature isn't there in general it
>> makes no sense to use them.
>>
>> In the particular case of  _mm_set_epi32 it seems
>> to be a data formating inline function:
>>
>> /usr/lib/gcc/x86_64-linux-gnu/4.7.2/include/emmintrin.h
>> ...
>> typedef long long __m128i __attribute__ ((__vector_size__ (16),
>> __may_alias__));
>> ...
>> extern __inline __m128i __attribute__((__gnu_inline__,
>> __always_inline__, __artificial__))
>> _mm_set_epi32 (int __q3, int __q2, int __q1, int __q0)
>> {
>>   return __extension__ (__m128i)(__v4si){ __q0, __q1, __q2, __q3 };
>> }
>>
>> Functions in this include files are using GCC builtins:
>>
>> http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/X86-Built-in-Functions.htm=
l#X86-Built-in-Functions
>>
>> To avoid any issue I wouldn't use these functions at all
>> on a non SSE machine.
>>
>> Sincerely,
>>
>> Laurent
>>
>>> and not
>>>
>>> * optimize the binary to use sse4.2 instructions
>>>
>>> ? It may be a RTFM question and I apologize for that. Reading http://=
gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#i386-an=
d-x86-64-Options it looks like this is more or less what --mtune=3Dcorei7=
-avx would do (because gf-complete uses PCLMUL when available). But it fe=
els weird to specify a specific processor model where what we need is a s=
et of features.
>>>
>>> Thanks for your help :-)
>>>
>>> On 25/03/2014 10:43, Laurent GUERBY wrote:
>>>> On Mon, 2014-03-24 at 22:27 +0100, Loic Dachary wrote:
>>>>>
>>>>> On 23/03/2014 23:34, Laurent GUERBY wrote:
>>>>>> http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Option=
s.html#i386-and-x86-64-Options
>>>>>>
>>>>>> So unless you want to run your code a very very old x86 32 bit pro=
cessor
>>>>>> "-msse" shouldn't be an issue. "-msse2" is similar.
>>>>>
>>>>> This is good to know :) Should I be worried about unintended side e=
ffects of -msse4.2 -mssse3 -msse4.1 or -mpclmul ? These are the flags tha=
t gf-complete are using, specifically.
>>>>
>>>> Hi,
>>>>
>>>> SSE4.2 will be available only in more recent
>>>> processors as documented on the page above.
>>>>
>>>> If your library already is dynamically checking for processor
>>>> feature I would advise to be conservative in your
>>>> -m flags, ie using what debian would use for maximum
>>>> x86 portability.
>>>>
>>>> Sincerely,
>>>>
>>>> Laurent
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
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--grW4HodBVooccIuAVNbgfHAgE6QAr0dsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMxztMACgkQ8dLMyEl6F207swCeJb+K6fScdx+U9GjKtEP4/K+G
XtAAnjsn3F/fNeGyt3vmqxsrZaWTlN11
=gh2D
-----END PGP SIGNATURE-----

--grW4HodBVooccIuAVNbgfHAgE6QAr0dsd--
