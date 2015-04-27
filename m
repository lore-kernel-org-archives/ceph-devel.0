From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Hitting tcmalloc bug even with patch applied
Date: Mon, 27 Apr 2015 10:53:05 -0400
Message-ID: <553E4D51.9010103@adfin.com>
References: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv> <837264898.702990831.1430140908848.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35804 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbbD0OxV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 10:53:21 -0400
Received: by igbyr2 with SMTP id yr2so64754398igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 07:53:20 -0700 (PDT)
In-Reply-To: <837264898.702990831.1430140908848.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Somnath Roy <somnath.roy@sandisk.com>



On 4/27/15 9:21 AM, Alexandre DERUMIER wrote:
> Seem that starting osd with:
>
> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=3D128M /usr/bin/ceph-osd
>
> fix it.
>
> I don't known if it's the right way ?

Do you know what the default is if you don't specify it?
>
>
>
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C0: "ceph-devel" <ceph-devel@vger.kernel.org>, "Somnath Roy" <somnat=
h.roy@sandisk.com>
> Envoy=E9: Lundi 27 Avril 2015 14:06:22
> Objet: Hitting tcmalloc bug even with patch applied
>
> Hi,=20
>
> I'm hitting the tcmalloc even with patch apply.=20
> It's mainly occur when I try to bench fio with a lot jobs (20 - 40 jo=
bs)=20
>
> Does It need to tuned something in osd environnement variable ?=20
>
>
> I double check it with=20
>
> #g++ -o gperftest gperftest.c -ltcmalloc=20
> # export TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=3D67108864=20
> # ./gperftest=20
> Tcmalloc OK! Internal and Env cache size are same:67108864=20
>
>
> perf top=20
> -------=20
> 10.04% libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentr=
alCache=20
> 8.19% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::FetchFromSp=
ans=20
> 3.89% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseToSp=
ans=20
> 2.04% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseList=
ToSpans=20
> 1.79% libtcmalloc.so.4.1.2 [.] operator new=20
> 1.25% ceph-osd [.] ConfFile::load_from_buffer=20
> 1.21% libtcmalloc.so.4.1.2 [.] operator delete=20
> 1.14% [kernel] [k] _raw_spin_lock=20
> 1.08% libstdc++.so.6.0.19 [.] std::basic_string<char, std::char_trait=
s<char>, std::allocator<char> >::basic_string=20
> 1.04% [kernel] [k] __schedule=20
> 1.00% libpthread-2.17.so [.] pthread_mutex_trylock=20
> 0.90% [kernel] [k] native_write_msr_safe=20
> 0.89% [kernel] [k] __switch_to=20
> 0.79% [kernel] [k] _raw_spin_lock_irqsave=20
> 0.73% [kernel] [k] copy_user_enhanced_fast_string=20
>
>
>
> Regards,=20
>
> Alexandre=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
