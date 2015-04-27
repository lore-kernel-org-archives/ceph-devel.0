From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Hitting tcmalloc bug even with patch applied
Date: Mon, 27 Apr 2015 09:57:44 -0500
Message-ID: <553E4E68.8080801@redhat.com>
References: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv> <837264898.702990831.1430140908848.JavaMail.zimbra@oxygem.tv> <553E4D51.9010103@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964882AbbD0O5s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Apr 2015 10:57:48 -0400
In-Reply-To: <553E4D51.9010103@adfin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Somnath Roy <somnath.roy@sandisk.com>

Looks like the default is 16MB:

http://gperftools.googlecode.com/svn/trunk/doc/tcmalloc.html

On 04/27/2015 09:53 AM, Milosz Tanski wrote:
>
>
> On 4/27/15 9:21 AM, Alexandre DERUMIER wrote:
>> Seem that starting osd with:
>>
>> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=3D128M /usr/bin/ceph-osd
>>
>> fix it.
>>
>> I don't known if it's the right way ?
>
> Do you know what the default is if you don't specify it?
>>
>>
>>
>> ----- Mail original -----
>> De: "aderumier" <aderumier@odiso.com>
>> =C0: "ceph-devel" <ceph-devel@vger.kernel.org>, "Somnath Roy" <somna=
th.roy@sandisk.com>
>> Envoy=E9: Lundi 27 Avril 2015 14:06:22
>> Objet: Hitting tcmalloc bug even with patch applied
>>
>> Hi,
>>
>> I'm hitting the tcmalloc even with patch apply.
>> It's mainly occur when I try to bench fio with a lot jobs (20 - 40 j=
obs)
>>
>> Does It need to tuned something in osd environnement variable ?
>>
>>
>> I double check it with
>>
>> #g++ -o gperftest gperftest.c -ltcmalloc
>> # export TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=3D67108864
>> # ./gperftest
>> Tcmalloc OK! Internal and Env cache size are same:67108864
>>
>>
>> perf top
>> -------
>> 10.04% libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCent=
ralCache
>> 8.19% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::FetchFromS=
pans
>> 3.89% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseToS=
pans
>> 2.04% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseLis=
tToSpans
>> 1.79% libtcmalloc.so.4.1.2 [.] operator new
>> 1.25% ceph-osd [.] ConfFile::load_from_buffer
>> 1.21% libtcmalloc.so.4.1.2 [.] operator delete
>> 1.14% [kernel] [k] _raw_spin_lock
>> 1.08% libstdc++.so.6.0.19 [.] std::basic_string<char, std::char_trai=
ts<char>, std::allocator<char> >::basic_string
>> 1.04% [kernel] [k] __schedule
>> 1.00% libpthread-2.17.so [.] pthread_mutex_trylock
>> 0.90% [kernel] [k] native_write_msr_safe
>> 0.89% [kernel] [k] __switch_to
>> 0.79% [kernel] [k] _raw_spin_lock_irqsave
>> 0.73% [kernel] [k] copy_user_enhanced_fast_string
>>
>>
>>
>> Regards,
>>
>> Alexandre
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
