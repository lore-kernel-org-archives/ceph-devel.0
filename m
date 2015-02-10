From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: wip-auth
Date: Tue, 10 Feb 2015 05:36:08 +0100 (CET)
Message-ID: <1808166356.223642.1423542968864.JavaMail.zimbra@oxygem.tv>
References: <alpine.DEB.2.00.1501221512580.19192@cobra.newdream.net> <3649A15A2562B54294DE14BCE5AC79120AB4E6A6@FMSMSX106.amr.corp.intel.com> <alpine.DEB.2.00.1501261554360.18846@cobra.newdream.net> <20150130081013.3f615803@doppio> <alpine.DEB.2.00.1501300831300.25803@cobra.newdream.net> <54D2AA3A.1070800@redhat.com> <999603781.7886589.1423208704771.JavaMail.zimbra@oxygem.tv> <54D8FB52.9060800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41692 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbbBJEgL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 23:36:11 -0500
In-Reply-To: <987318816.223626.1423542893540.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, Stephen L Blinick <stephen.l.blinick@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>o far we don't really know, but suspect kernel/networking related=20
>>things. sysctl -a showed some differences in various vm/numa/ipv4=20
>>settings. Simply changing settings around might be a good first step,=
=20
>>but if it's kernel related that might be tougher to track down. The=20
>>first step was to make sure it wasn't due to auth as that was suspect=
 as=20
>>well, but it seems to be an independent issue.=20

Ok thanks.
I'll try to compare too next month between debian and centos

----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "Sage Weil" <sweil@redhat.com>, "Andreas Bluemle" <andreas.bluemle@=
itxperts.de>, "Stephen L Blinick" <stephen.l.blinick@intel.com>, "ceph-=
devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Lundi 9 F=C3=A9vrier 2015 19:24:18
Objet: Re: wip-auth

Hi Alex,=20

So far we don't really know, but suspect kernel/networking related=20
things. sysctl -a showed some differences in various vm/numa/ipv4=20
settings. Simply changing settings around might be a good first step,=20
but if it's kernel related that might be tougher to track down. The=20
first step was to make sure it wasn't due to auth as that was suspect a=
s=20
well, but it seems to be an independent issue.=20

Mark=20

On 02/06/2015 01:45 AM, Alexandre DERUMIER wrote:=20
> Hi Mark,=20
>=20
> do you known why rhel7 is faster than ubuntu ? (the difference seem t=
o be quite huge)=20
>=20
>=20
> Not sure it's related, but I have found a bug report on ubuntu,=20
> about irqbalance not working correctly on ubuntu 14.04=20
> https://bugs.launchpad.net/ubuntu/+source/irqbalance/+bug/1379065=20
>=20
>=20
> ----- Mail original -----=20
> De: "Mark Nelson" <mark.nelson@inktank.com>=20
> =C3=80: "Sage Weil" <sweil@redhat.com>, "Andreas Bluemle" <andreas.bl=
uemle@itxperts.de>=20
> Cc: "Stephen L Blinick" <stephen.l.blinick@intel.com>, "ceph-devel" <=
ceph-devel@vger.kernel.org>=20
> Envoy=C3=A9: Jeudi 5 F=C3=A9vrier 2015 00:24:42=20
> Objet: Re: wip-auth=20
>=20
> Hi All,=20
>=20
> I completed some tests with wip-auth to the memstore on ubuntu earlie=
r=20
> today. Basic gist of it is that the improvements in wip-auth help but=
=20
> don't quite get us to what can be achieved with auth disabled. RHEL7=20
> (without auth) continues to do very well in latency bound situations.=
=20
> Next up will be to see if how much this matters when testing against =
on=20
> SSDs.=20
>=20
> Here are the results:=20
>=20
> sync 4k object writes=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>=20
> Ceph OS Auth Avg Lat (ms) Avg IOPS=20
> ----------------------------------------------------------------=20
> master Ubuntu 14.04 Yes 0.99 1007=20
> Wip-auth Ubuntu 14.04 Yes 0.81 1237=20
> master Ubuntu 14.04 No 0.64 1549=20
> Wip-auth Ubuntu 14.04 No 0.65 1563=20
> master RHEL7 No 0.32 3158=20
>=20
> sync 4k object reads=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>=20
> Ceph OS Auth Avg Lat (ms) Avg IOPS=20
> ----------------------------------------------------------------=20
> master Ubuntu 14.04 Yes 0.59 1695=20
> Wip-auth Ubuntu 14.04 Yes 0.41 2409=20
> master Ubuntu 14.04 No 0.29 3425=20
> Wip-auth Ubuntu 14.04 No 0.29 3474=20
> master RHEL7 No 0.17 5853=20
>=20
> 256 concurrent 4k object writes=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=20
>=20
> Ceph OS Auth Avg Lat (ms) Avg IOPS=20
> ----------------------------------------------------------------=20
> master Ubuntu 14.04 Yes 40.39 6339=20
> Wip-auth Ubuntu 14.04 Yes 26.22 9763=20
> master Ubuntu 14.04 No 17.46 14662=20
> Wip-auth Ubuntu 14.04 No 17.34 14759=20
> master RHEL7 No 14.93 17139=20
>=20
> 256 concurrent 4k object reads=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=20
>=20
> Ceph OS Auth Avg Lat (ms) Avg IOPS=20
> ----------------------------------------------------------------=20
> master Ubuntu 14.04 Yes 31.47 8134=20
> Wip-auth Ubuntu 14.04 Yes 19.81 12922=20
> master Ubuntu 14.04 No 12.82 19968=20
> Wip-auth Ubuntu 14.04 No 12.75 20080=20
> master RHEL7 No 12.04 21257=20
>=20
> Mark=20
>=20
> On 01/30/2015 03:08 PM, Sage Weil wrote:=20
>> Hi Andreas,=20
>>=20
>> It looks like that was a stale sha1, but the newer one was also=20
>> broken. I've retested and it's working for me now. See latest wip-au=
th,=20
>> sha1 0c21a7875059bef80842756dfb003f47cc2d66a6.=20
>>=20
>> Thanks!=20
>> sage=20
>>=20
>> On Fri, 30 Jan 2015, Andreas Bluemle wrote:=20
>>=20
>>> Hi Sage,=20
>>>=20
>>> I tried to integrate wip-auth into my 0.91 build environment.=20
>>>=20
>>> I had not been able to start the cluster successfully: ceph-mon=20
>>> crashes with a segmentation fault in CryptoKey::encrypt()=20
>>> (see attachment).=20
>>>=20
>>> This happens when linking with libnss or libcryptopp (version 5.6.2=
).=20
>>>=20
>>> I created the patch to add wip-auth based on github=20
>>> pull request 3523 and was able to use this patch directly=20
>>> with 0.91 with only a minor adaptation for common/ceph_context.h:=20
>>> the 0.91 version of ceph_context.h did not know anything about=20
>>> the experimental "class CephContextObs".=20
>>>=20
>>> wip-auth commit ID is 1a0507a2940f6edcc2bf9533cfa6c210b0b41933.=20
>>>=20
>>> As my build environment is rpm, I had to modify the invocation=20
>>> of the configure script in the spec file instead of the do_autogen.=
sh=20
>>> script.=20
>>>=20
>>>=20
>>> Best Regards=20
>>>=20
>>> Andreas Bluemle=20
>>>=20
>>>=20
>>> On Tue, 27 Jan 2015 09:18:45 -0800 (PST)=20
>>> Sage Weil <sweil@redhat.com> wrote:=20
>>>=20
>>>> I spent some time focusing on just CryptoKey::encrypt(). I=20
>>>> benchmarked 100,000 encrypts of 128 bytes and got, at baseline,=20
>>>>=20
>>>> cryptopp: 100000 encoded in 0.655651=20
>>>> libnss : 100000 encoded in 1.288786=20
>>>>=20
>>>> Ouch! With a (fixed) version of my earlier patch that avoids=20
>>>> uselessly copying the input buffer:=20
>>>>=20
>>>> 100000 encoded in 1.231977=20
>>>>=20
>>>> With a patch that puts the key structures in CryptoKey instead of=20
>>>> recreating them each time:=20
>>>>=20
>>>> 100000 encoded in 0.396208 -- ~70% improvement over original=20
>>>>=20
>>>> This is pushed to wip-auth. There's also a patch that caches key=20
>>>> structs for crypopp.. it now takes=20
>>>>=20
>>>> 100000 encoded in 0.440758 -- ~33% improvement over original=20
>>>>=20
>>>> (Not that almost anybody will ever care; we use libnss by default =
for=20
>>>> both rpm and deb distros.)=20
>>>>=20
>>>> So, yay, nss is now a bit faster. What I'm not completely certain=20
>>>> about is whether the structures I've preserved are truly stateless=
=20
>>>> (and can be shared across threads, etc.). They encrypt/decrypt=20
>>>> methods are const so, if the libraries are const-correct, it shoul=
d=20
>>>> be fine... but perhaps someone familiar with nss and/or crypto++ c=
an=20
>>>> review this?=20
>>>>=20
>>>> This is pushed to the latest wip-auth branch:=20
>>>>=20
>>>> https://github.com/ceph/ceph/commits/wip-auth=20
>>>>=20
>>>> Andreas and Stephen, what effect does this have on your numbers?=20
>>>>=20
>>>> Thanks!=20
>>>> sage=20
>>>>=20
>>>>=20
>>>> On Mon, 26 Jan 2015, Blinick, Stephen L wrote:=20
>>>>=20
>>>>> Good to know, I was wondering why the spec file defaulted to=20
>>>>> lib-nss.. the dpkg-build for debian packages just uses whatever=20
>>>>> configuration you had built, and I believe that will use=20
>>>>> libcryptopp if the dependency is installed on the build machine=20
>>>>> (last I looked).=20
>>>>>=20
>>>>> I forgot to mention the numbers below were based on v.91.=20
>>>>>=20
>>>>> Thanks,=20
>>>>>=20
>>>>> Stephen=20
>>>>>=20
>>>>> -----Original Message-----=20
>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil=20
>>>>> Sent: Monday, January 26, 2015 10:24 AM To: Blinick, Stephen L=20
>>>>> Cc: andreas.bluemle@itxperts.de; ceph-devel@vger.kernel.org=20
>>>>> Subject: RE: wip-auth=20
>>>>>=20
>>>>> On Mon, 26 Jan 2015, Blinick, Stephen L wrote:=20
>>>>>> I noticed that the spec file for building RPM's defaults to=20
>>>>>> building with libnss, instead of libcrypto++. Since the=20
>>>>>> measurements I'd done so far were from those RPM's I rebuilt wit=
h=20
>>>>>> libcrypto++.. so FWIW here is the difference between those two o=
n=20
>>>>>> my system, memstore backend with a single OSD, and single=20
>>>>>> client.=20
>>>>>>=20
>>>>>> Dual socket Xeon E5 2620v3, 64GB Memory, RHEL7=20
>>>>>> Kernel: 3.10.0-123.13.2.el7=20
>>>>>>=20
>>>>>> 100% 4K Writes, 1xOSD w/ Rados Bench=20
>>>>>> libnss |=20
>>>>>> Cryptopp # QD IOPS Latency(ms) |=20
>>>>>> IOPS Latency(ms) IOPS Improvement % 16=20
>>>>>> 14432.57 1.11 | 18896.60 0.85=20
>>>>>> 30.93% 100% 4K Reads, 1xOSD w/ Rados=20
>>>>>> Bench libnss | Cryptopp # QD IOPS Latency(ms) | IOPS Latency(ms)=
=20
>>>>>> IOPS Improvement % 16 19532.53 0.82 | 25708.70 0.62 31.62%=20
>>>>>=20
>>>>> Yikes, 30%! I think this definitely worth some effort. We=20
>>>>> switched to libnss because it has the weird government=20
>>>>> certfiications that everyone wants and is more prevalent. crypto+=
+=20
>>>>> is also not packaged for Red Hat distros at all (presumably for=20
>>>>> that reason).=20
>>>>>=20
>>>>> I suspect that most of the overhead is in the encryption context=20
>>>>> setup and can be avoided with a bit of effort..=20
>>>>>=20
>>>>> sage=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> Thanks,=20
>>>>>>=20
>>>>>> Stephen=20
>>>>>>=20
>>>>>> -----Original Message-----=20
>>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil=
=20
>>>>>> Sent: Thursday, January 22, 2015 4:56 PM=20
>>>>>> To: andreas.bluemle@itxperts.de=20
>>>>>> Cc: ceph-devel@vger.kernel.org=20
>>>>>> Subject: wip-auth=20
>>>>>>=20
>>>>>> Hi Andreas,=20
>>>>>>=20
>>>>>> I took a look at the wip-auth I mentioned in the security call=20
>>>>>> last week... and the patch didn't work at all. Sorry if you=20
>>>>>> wasted any time trying it.=20
>>>>>>=20
>>>>>> Anyway, I fixed it up so that it actually worked and made one=20
>>>>>> other optimization. It would be great to hear what latencies you=
=20
>>>>>> measure with the changes in place.=20
>>>>>>=20
>>>>>> Also, it might be worth trying --with-cryptopp (or --with-nss if=
=20
>>>>>> you built cryptopp by default) to see if there is a difference.=20
>>>>>> There is a ton of boilerplate setting up encryption contexts and=
=20
>>>>>> key structures and so on that I suspect could be cached (perhaps=
=20
>>>>>> stashed in the CryptoKey struct?) with a bit of effort. See=20
>>>>>>=20
>>>>>> https://github.com/ceph/ceph/blob/master/src/auth/Crypto.cc#L99-=
L213=20
>>>>>>=20
>>>>>> sage=20
>>>>>> --=20
>>>>>> To unsubscribe from this list: send the line "unsubscribe=20
>>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.or=
g=20
>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l=20
>>>>>>=20
>>>>>>=20
>>>>> --=20
>>>>> To unsubscribe from this list: send the line "unsubscribe=20
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org=
=20
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=
=20
>>>>> -- To unsubscribe from this list: send the line "unsubscribe=20
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org=
=20
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=
=20
>>>>>=20
>>>>>=20
>>>>=20
>>>>=20
>>>=20
>>>=20
>>>=20
>>> --=20
>>> Andreas Bluemle mailto:Andreas.Bluemle@itxperts.de=20
>>> ITXperts GmbH http://www.itxperts.de=20
>>> Balanstrasse 73, Geb. 08 Phone: (+49) 89 89044917=20
>>> D-81541 Muenchen (Germany) Fax: (+49) 89 89044910=20
>>>=20
>>> Company details: http://www.itxperts.de/imprint.htm=20
>>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
