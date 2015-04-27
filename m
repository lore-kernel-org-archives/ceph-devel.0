From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Hitting tcmalloc bug even with patch applied
Date: Mon, 27 Apr 2015 16:02:10 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD820B6@SACMBXIP01.sdcorp.global.sandisk.com>
References: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv>
 <837264898.702990831.1430140908848.JavaMail.zimbra@oxygem.tv>
 <553E4D51.9010103@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0073.outbound.protection.outlook.com ([157.56.111.73]:6828
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752473AbbD0QCl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 12:02:41 -0400
In-Reply-To: <553E4D51.9010103@adfin.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

I doubt the tcmalloc trace will go away permanently with the env variab=
le set. Depending on your workload it may come back. Giving more memory=
 as a thread cache will definitely help.
BTW, in case of any confusion, the patch was to make the env variable i=
n effect (and alleviate the traces) not to resolve the traces.

Thanks & Regards
Somnath

-----Original Message-----
=46rom: Milosz Tanski [mailto:milosz@adfin.com]
Sent: Monday, April 27, 2015 7:53 AM
To: Alexandre DERUMIER; ceph-devel; Somnath Roy
Subject: Re: Hitting tcmalloc bug even with patch applied



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
> =C0: "ceph-devel" <ceph-devel@vger.kernel.org>, "Somnath Roy"
> <somnath.roy@sandisk.com>
> Envoy=E9: Lundi 27 Avril 2015 14:06:22
> Objet: Hitting tcmalloc bug even with patch applied
>
> Hi,
>
> I'm hitting the tcmalloc even with patch apply.
> It's mainly occur when I try to bench fio with a lot jobs (20 - 40
> jobs)
>
> Does It need to tuned something in osd environnement variable ?
>
>
> I double check it with
>
> #g++ -o gperftest gperftest.c -ltcmalloc # export
> TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES=3D67108864
> # ./gperftest
> Tcmalloc OK! Internal and Env cache size are same:67108864
>
>
> perf top
> -------
> 10.04% libtcmalloc.so.4.1.2 [.]
> tcmalloc::ThreadCache::ReleaseToCentralCache
> 8.19% libtcmalloc.so.4.1.2 [.]
> tcmalloc::CentralFreeList::FetchFromSpans
> 3.89% libtcmalloc.so.4.1.2 [.]
> tcmalloc::CentralFreeList::ReleaseToSpans
> 2.04% libtcmalloc.so.4.1.2 [.]
> tcmalloc::CentralFreeList::ReleaseListToSpans
> 1.79% libtcmalloc.so.4.1.2 [.] operator new 1.25% ceph-osd [.]
> ConfFile::load_from_buffer 1.21% libtcmalloc.so.4.1.2 [.] operator
> delete 1.14% [kernel] [k] _raw_spin_lock 1.08% libstdc++.so.6.0.19 [.=
]
> std::basic_string<char, std::char_traits<char>, std::allocator<char>
> >::basic_string 1.04% [kernel] [k] __schedule 1.00% libpthread-2.17.s=
o
> [.] pthread_mutex_trylock 0.90% [kernel] [k] native_write_msr_safe
> 0.89% [kernel] [k] __switch_to 0.79% [kernel] [k]
> _raw_spin_lock_irqsave 0.73% [kernel] [k]
> copy_user_enhanced_fast_string
>
>
>
> Regards,
>
> Alexandre


________________________________

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
