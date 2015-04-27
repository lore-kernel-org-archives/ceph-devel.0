From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Hitting tcmalloc bug even with patch applied
Date: Mon, 27 Apr 2015 12:00:20 -0400
Message-ID: <553E5D14.5060900@adfin.com>
References: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv> <837264898.702990831.1430140908848.JavaMail.zimbra@oxygem.tv> <553E4D51.9010103@adfin.com> <553E4E68.8080801@redhat.com> <616080493.708389966.1430148334591.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35273 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbbD0QAf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 12:00:35 -0400
Received: by igbyr2 with SMTP id yr2so66744941igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 09:00:34 -0700 (PDT)
In-Reply-To: <616080493.708389966.1430148334591.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Somnath Roy <somnath.roy@sandisk.com>



On 4/27/15 11:25 AM, Alexandre DERUMIER wrote:
>>> Looks like the default is 16MB:=20
>>> http://gperftools.googlecode.com/svn/trunk/doc/tcmalloc.html=20
>=20
> I don't known if setting it to 128MB have performance impact (cpu, me=
mory garbage collection ?)
> I'll try to test different values between 16->128MB.

It looks like the mongodb people have run into a similar issue in a par=
ticular (degenerate) case. Here's the ticket link for reference: https:=
//jira.mongodb.org/browse/SERVER-16551

>=20
>=20
>=20
>=20
> ----- Mail original -----
> De: "Mark Nelson" <mnelson@redhat.com>
> =C3=80: "Milosz Tanski" <milosz@adfin.com>, "aderumier" <aderumier@od=
iso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Somnath Roy" <som=
nath.roy@sandisk.com>
> Envoy=C3=A9: Lundi 27 Avril 2015 16:57:44
> Objet: Re: Hitting tcmalloc bug even with patch applied
>=20
> Looks like the default is 16MB:=20
>=20
> http://gperftools.googlecode.com/svn/trunk/doc/tcmalloc.html=20
>=20
> On 04/27/2015 09:53 AM, Milosz Tanski wrote:=20
>>
>>
>> On 4/27/15 9:21 AM, Alexandre DERUMIER wrote:=20
>>> Seem that starting osd with:=20
>>>
>>> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=3D128M /usr/bin/ceph-osd=20
>>>
>>> fix it.=20
>>>
>>> I don't known if it's the right way ?=20
>>
>> Do you know what the default is if you don't specify it?=20
>>>
>>>
>>>
>>> ----- Mail original -----=20
>>> De: "aderumier" <aderumier@odiso.com>=20
>>> =C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>, "Somnath Roy" <s=
omnath.roy@sandisk.com>=20
>>> Envoy=C3=A9: Lundi 27 Avril 2015 14:06:22=20
>>> Objet: Hitting tcmalloc bug even with patch applied=20
>>>
>>> Hi,=20
>>>
>>> I'm hitting the tcmalloc even with patch apply.=20
>>> It's mainly occur when I try to bench fio with a lot jobs (20 - 40 =
jobs)=20
>>>
>>> Does It need to tuned something in osd environnement variable ?=20
>>>
>>>
>>> I double check it with=20
>>>
>>> #g++ -o gperftest gperftest.c -ltcmalloc=20
>>> # export TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=3D67108864=20
>>> # ./gperftest=20
>>> Tcmalloc OK! Internal and Env cache size are same:67108864=20
>>>
>>>
>>> perf top=20
>>> -------=20
>>> 10.04% libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCen=
tralCache=20
>>> 8.19% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::FetchFrom=
Spans=20
>>> 3.89% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseTo=
Spans=20
>>> 2.04% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseLi=
stToSpans=20
>>> 1.79% libtcmalloc.so.4.1.2 [.] operator new=20
>>> 1.25% ceph-osd [.] ConfFile::load_from_buffer=20
>>> 1.21% libtcmalloc.so.4.1.2 [.] operator delete=20
>>> 1.14% [kernel] [k] _raw_spin_lock=20
>>> 1.08% libstdc++.so.6.0.19 [.] std::basic_string<char, std::char_tra=
its<char>, std::allocator<char> >::basic_string=20
>>> 1.04% [kernel] [k] __schedule=20
>>> 1.00% libpthread-2.17.so [.] pthread_mutex_trylock=20
>>> 0.90% [kernel] [k] native_write_msr_safe=20
>>> 0.89% [kernel] [k] __switch_to=20
>>> 0.79% [kernel] [k] _raw_spin_lock_irqsave=20
>>> 0.73% [kernel] [k] copy_user_enhanced_fast_string=20
>>>
>>>
>>>
>>> Regards,=20
>>>
>>> Alexandre=20
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
