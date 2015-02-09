From: Mark Nelson <mnelson@redhat.com>
Subject: Re: wip-auth
Date: Mon, 09 Feb 2015 12:24:18 -0600
Message-ID: <54D8FB52.9060800@redhat.com>
References: <alpine.DEB.2.00.1501221512580.19192@cobra.newdream.net> <3649A15A2562B54294DE14BCE5AC79120AB43257@ORSMSX152.amr.corp.intel.com> <alpine.DEB.2.00.1501260921250.3895@cobra.newdream.net> <3649A15A2562B54294DE14BCE5AC79120AB4E6A6@FMSMSX106.amr.corp.intel.com> <alpine.DEB.2.00.1501261554360.18846@cobra.newdream.net> <20150130081013.3f615803@doppio> <alpine.DEB.2.00.1501300831300.25803@cobra.newdream.net> <54D2AA3A.1070800@redhat.com> <999603781.7886589.1423208704771.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35186 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933560AbbBISYb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Feb 2015 13:24:31 -0500
In-Reply-To: <999603781.7886589.1423208704771.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sweil@redhat.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, Stephen L Blinick <stephen.l.blinick@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Alex,

So far we don't really know, but suspect kernel/networking related=20
things.  sysctl -a showed some differences in various vm/numa/ipv4=20
settings.  Simply changing settings around might be a good first step,=20
but if it's kernel related that might be tougher to track down.  The=20
first step was to make sure it wasn't due to auth as that was suspect a=
s=20
well, but it seems to be an independent issue.

Mark

On 02/06/2015 01:45 AM, Alexandre DERUMIER wrote:
> Hi Mark,
>
> do you known why rhel7 is faster than ubuntu ? (the difference seem t=
o be quite huge)
>
>
> Not sure it's related, but I have found a bug report on ubuntu,
> about irqbalance not working correctly on ubuntu 14.04
> https://bugs.launchpad.net/ubuntu/+source/irqbalance/+bug/1379065
>
>
> ----- Mail original -----
> De: "Mark Nelson" <mark.nelson@inktank.com>
> =C3=80: "Sage Weil" <sweil@redhat.com>, "Andreas Bluemle" <andreas.bl=
uemle@itxperts.de>
> Cc: "Stephen L Blinick" <stephen.l.blinick@intel.com>, "ceph-devel" <=
ceph-devel@vger.kernel.org>
> Envoy=C3=A9: Jeudi 5 F=C3=A9vrier 2015 00:24:42
> Objet: Re: wip-auth
>
> Hi All,
>
> I completed some tests with wip-auth to the memstore on ubuntu earlie=
r
> today. Basic gist of it is that the improvements in wip-auth help but
> don't quite get us to what can be achieved with auth disabled. RHEL7
> (without auth) continues to do very well in latency bound situations.
> Next up will be to see if how much this matters when testing against =
on
> SSDs.
>
> Here are the results:
>
> sync 4k object writes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Ceph OS Auth Avg Lat (ms) Avg IOPS
> ----------------------------------------------------------------
> master Ubuntu 14.04 Yes 0.99 1007
> Wip-auth Ubuntu 14.04 Yes 0.81 1237
> master Ubuntu 14.04 No 0.64 1549
> Wip-auth Ubuntu 14.04 No 0.65 1563
> master RHEL7 No 0.32 3158
>
> sync 4k object reads
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Ceph OS Auth Avg Lat (ms) Avg IOPS
> ----------------------------------------------------------------
> master Ubuntu 14.04 Yes 0.59 1695
> Wip-auth Ubuntu 14.04 Yes 0.41 2409
> master Ubuntu 14.04 No 0.29 3425
> Wip-auth Ubuntu 14.04 No 0.29 3474
> master RHEL7 No 0.17 5853
>
> 256 concurrent 4k object writes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> Ceph OS Auth Avg Lat (ms) Avg IOPS
> ----------------------------------------------------------------
> master Ubuntu 14.04 Yes 40.39 6339
> Wip-auth Ubuntu 14.04 Yes 26.22 9763
> master Ubuntu 14.04 No 17.46 14662
> Wip-auth Ubuntu 14.04 No 17.34 14759
> master RHEL7 No 14.93 17139
>
> 256 concurrent 4k object reads
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> Ceph OS Auth Avg Lat (ms) Avg IOPS
> ----------------------------------------------------------------
> master Ubuntu 14.04 Yes 31.47 8134
> Wip-auth Ubuntu 14.04 Yes 19.81 12922
> master Ubuntu 14.04 No 12.82 19968
> Wip-auth Ubuntu 14.04 No 12.75 20080
> master RHEL7 No 12.04 21257
>
> Mark
>
> On 01/30/2015 03:08 PM, Sage Weil wrote:
>> Hi Andreas,
>>
>> It looks like that was a stale sha1, but the newer one was also
>> broken. I've retested and it's working for me now. See latest wip-au=
th,
>> sha1 0c21a7875059bef80842756dfb003f47cc2d66a6.
>>
>> Thanks!
>> sage
>>
>> On Fri, 30 Jan 2015, Andreas Bluemle wrote:
>>
>>> Hi Sage,
>>>
>>> I tried to integrate wip-auth into my 0.91 build environment.
>>>
>>> I had not been able to start the cluster successfully: ceph-mon
>>> crashes with a segmentation fault in CryptoKey::encrypt()
>>> (see attachment).
>>>
>>> This happens when linking with libnss or libcryptopp (version 5.6.2=
).
>>>
>>> I created the patch to add wip-auth based on github
>>> pull request 3523 and was able to use this patch directly
>>> with 0.91 with only a minor adaptation for common/ceph_context.h:
>>> the 0.91 version of ceph_context.h did not know anything about
>>> the experimental "class CephContextObs".
>>>
>>> wip-auth commit ID is 1a0507a2940f6edcc2bf9533cfa6c210b0b41933.
>>>
>>> As my build environment is rpm, I had to modify the invocation
>>> of the configure script in the spec file instead of the do_autogen.=
sh
>>> script.
>>>
>>>
>>> Best Regards
>>>
>>> Andreas Bluemle
>>>
>>>
>>> On Tue, 27 Jan 2015 09:18:45 -0800 (PST)
>>> Sage Weil <sweil@redhat.com> wrote:
>>>
>>>> I spent some time focusing on just CryptoKey::encrypt(). I
>>>> benchmarked 100,000 encrypts of 128 bytes and got, at baseline,
>>>>
>>>> cryptopp: 100000 encoded in 0.655651
>>>> libnss : 100000 encoded in 1.288786
>>>>
>>>> Ouch! With a (fixed) version of my earlier patch that avoids
>>>> uselessly copying the input buffer:
>>>>
>>>> 100000 encoded in 1.231977
>>>>
>>>> With a patch that puts the key structures in CryptoKey instead of
>>>> recreating them each time:
>>>>
>>>> 100000 encoded in 0.396208 -- ~70% improvement over original
>>>>
>>>> This is pushed to wip-auth. There's also a patch that caches key
>>>> structs for crypopp.. it now takes
>>>>
>>>> 100000 encoded in 0.440758 -- ~33% improvement over original
>>>>
>>>> (Not that almost anybody will ever care; we use libnss by default =
for
>>>> both rpm and deb distros.)
>>>>
>>>> So, yay, nss is now a bit faster. What I'm not completely certain
>>>> about is whether the structures I've preserved are truly stateless
>>>> (and can be shared across threads, etc.). They encrypt/decrypt
>>>> methods are const so, if the libraries are const-correct, it shoul=
d
>>>> be fine... but perhaps someone familiar with nss and/or crypto++ c=
an
>>>> review this?
>>>>
>>>> This is pushed to the latest wip-auth branch:
>>>>
>>>> https://github.com/ceph/ceph/commits/wip-auth
>>>>
>>>> Andreas and Stephen, what effect does this have on your numbers?
>>>>
>>>> Thanks!
>>>> sage
>>>>
>>>>
>>>> On Mon, 26 Jan 2015, Blinick, Stephen L wrote:
>>>>
>>>>> Good to know, I was wondering why the spec file defaulted to
>>>>> lib-nss.. the dpkg-build for debian packages just uses whatever
>>>>> configuration you had built, and I believe that will use
>>>>> libcryptopp if the dependency is installed on the build machine
>>>>> (last I looked).
>>>>>
>>>>> I forgot to mention the numbers below were based on v.91.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Stephen
>>>>>
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
>>>>> Sent: Monday, January 26, 2015 10:24 AM To: Blinick, Stephen L
>>>>> Cc: andreas.bluemle@itxperts.de; ceph-devel@vger.kernel.org
>>>>> Subject: RE: wip-auth
>>>>>
>>>>> On Mon, 26 Jan 2015, Blinick, Stephen L wrote:
>>>>>> I noticed that the spec file for building RPM's defaults to
>>>>>> building with libnss, instead of libcrypto++. Since the
>>>>>> measurements I'd done so far were from those RPM's I rebuilt wit=
h
>>>>>> libcrypto++.. so FWIW here is the difference between those two o=
n
>>>>>> my system, memstore backend with a single OSD, and single
>>>>>> client.
>>>>>>
>>>>>> Dual socket Xeon E5 2620v3, 64GB Memory, RHEL7
>>>>>> Kernel: 3.10.0-123.13.2.el7
>>>>>>
>>>>>> 100% 4K Writes, 1xOSD w/ Rados Bench
>>>>>> libnss |
>>>>>> Cryptopp # QD IOPS Latency(ms) |
>>>>>> IOPS Latency(ms) IOPS Improvement % 16
>>>>>> 14432.57 1.11 | 18896.60 0.85
>>>>>> 30.93% 100% 4K Reads, 1xOSD w/ Rados
>>>>>> Bench libnss | Cryptopp # QD IOPS Latency(ms) | IOPS Latency(ms)
>>>>>> IOPS Improvement % 16 19532.53 0.82 | 25708.70 0.62 31.62%
>>>>>
>>>>> Yikes, 30%! I think this definitely worth some effort. We
>>>>> switched to libnss because it has the weird government
>>>>> certfiications that everyone wants and is more prevalent. crypto+=
+
>>>>> is also not packaged for Red Hat distros at all (presumably for
>>>>> that reason).
>>>>>
>>>>> I suspect that most of the overhead is in the encryption context
>>>>> setup and can be avoided with a bit of effort..
>>>>>
>>>>> sage
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Stephen
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
>>>>>> Sent: Thursday, January 22, 2015 4:56 PM
>>>>>> To: andreas.bluemle@itxperts.de
>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>> Subject: wip-auth
>>>>>>
>>>>>> Hi Andreas,
>>>>>>
>>>>>> I took a look at the wip-auth I mentioned in the security call
>>>>>> last week... and the patch didn't work at all. Sorry if you
>>>>>> wasted any time trying it.
>>>>>>
>>>>>> Anyway, I fixed it up so that it actually worked and made one
>>>>>> other optimization. It would be great to hear what latencies you
>>>>>> measure with the changes in place.
>>>>>>
>>>>>> Also, it might be worth trying --with-cryptopp (or --with-nss if
>>>>>> you built cryptopp by default) to see if there is a difference.
>>>>>> There is a ton of boilerplate setting up encryption contexts and
>>>>>> key structures and so on that I suspect could be cached (perhaps
>>>>>> stashed in the CryptoKey struct?) with a bit of effort. See
>>>>>>
>>>>>> https://github.com/ceph/ceph/blob/master/src/auth/Crypto.cc#L99-=
L213
>>>>>>
>>>>>> sage
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.or=
g
>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.htm=
l
>>>>>>
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>> -- To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>> --
>>> Andreas Bluemle mailto:Andreas.Bluemle@itxperts.de
>>> ITXperts GmbH http://www.itxperts.de
>>> Balanstrasse 73, Geb. 08 Phone: (+49) 89 89044917
>>> D-81541 Muenchen (Germany) Fax: (+49) 89 89044910
>>>
>>> Company details: http://www.itxperts.de/imprint.htm
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
