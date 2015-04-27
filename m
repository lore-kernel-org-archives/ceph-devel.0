From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Re: [ceph-users] strange benchmark problem : restarting osd daemon
 improve performance from 100k iops to 300k iops
Date: Sun, 26 Apr 2015 23:12:49 -0700
Message-ID: <CAKKTCLV9fVjprDFPs8YO+zrtox8g_1oOASWVxvY0RBwg8gFbRg@mail.gmail.com>
References: <1232683114.515741917.1429692005478.JavaMail.zimbra@oxygem.tv>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD806BE@SACMBXIP01.sdcorp.global.sandisk.com>
 <CAF-rypyB=CjjJQs_+3Q=ELCVwpg9nyWKdBu8gVyuDQa49=GHtw@mail.gmail.com>
 <1270073308.621430804.1429893511370.JavaMail.zimbra@oxygem.tv>
 <BEEF4E3E-92BD-4E41-8E17-5BF9476A3674@profihost.ag> <553A8527.3020503@redhat.com>
 <1416266012.633995646.1429937143054.JavaMail.zimbra@oxygem.tv>
 <94521284.683547748.1430110881936.JavaMail.zimbra@oxygem.tv> <1545533798.684536916.1430113581382.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34137 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbD0GNM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 02:13:12 -0400
Received: by oiav1 with SMTP id v1so5068449oia.1
        for <ceph-devel@vger.kernel.org>; Sun, 26 Apr 2015 23:13:11 -0700 (PDT)
In-Reply-To: <1545533798.684536916.1430113581382.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Milosz Tanski <milosz@adfin.com>

If I want to use librados API for performance testing, are there any
existing benchmark tools which directly accesses librados (not through
rbd or gateway)

Thanks in advance,
JV

On Sun, Apr 26, 2015 at 10:46 PM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
>>>I'll retest tcmalloc, because I was prety sure to have patched it co=
rrectly.
>
> Ok, I really think I have patched tcmalloc wrongly.
> I have repatched it, reinstalled it, and now I'm getting 195k iops wi=
th a single osd (10fio rbd jobs 4k randread).
>
> So better than jemalloc.
>
>
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: "Mark Nelson" <mnelson@redhat.com>
> Cc: "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Milosz Tanski" <milosz@adfin.com>
> Envoy=C3=A9: Lundi 27 Avril 2015 07:01:21
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd da=
emon improve performance from 100k iops to 300k iops
>
> Hi,
>
> also another big difference,
>
> I can reach now 180k iops with a single jemalloc osd (data in buffer)=
 vs 50k iops max with tcmalloc.
>
> I'll retest tcmalloc, because I was prety sure to have patched it cor=
rectly.
>
>
> ----- Mail original -----
> De: "aderumier" <aderumier@odiso.com>
> =C3=80: "Mark Nelson" <mnelson@redhat.com>
> Cc: "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Milosz Tanski" <milosz@adfin.com>
> Envoy=C3=A9: Samedi 25 Avril 2015 06:45:43
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd da=
emon improve performance from 100k iops to 300k iops
>
>>>We haven't done any kind of real testing on jemalloc, so use at your=
 own
>>>peril. Having said that, we've also been very interested in hearing
>>>community feedback from folks trying it out, so please feel free to =
give
>>>it a shot. :D
>
> Some feedback, I have runned bench all the night, no speed regression=
=2E
>
> And I have a speed increase with fio with more jobs. (with tcmalloc, =
it seem to be the reverse)
>
> with tcmalloc :
>
> 10 fio-rbd jobs =3D 300k iops
> 15 fio-rbd jobs =3D 290k iops
> 20 fio-rbd jobs =3D 270k iops
> 40 fio-rbd jobs =3D 250k iops
>
> (all with up and down values during the fio bench)
>
>
> with jemalloc:
>
> 10 fio-rbd jobs =3D 300k iops
> 15 fio-rbd jobs =3D 320k iops
> 20 fio-rbd jobs =3D 330k iops
> 40 fio-rbd jobs =3D 370k iops (can get more currently, only 1 client =
machine with 20cores 100%)
>
> (all with contant values during the fio bench)
>
> ----- Mail original -----
> De: "Mark Nelson" <mnelson@redhat.com>
> =C3=80: "Stefan Priebe" <s.priebe@profihost.ag>, "aderumier" <aderumi=
er@odiso.com>
> Cc: "ceph-users" <ceph-users@lists.ceph.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Somnath Roy" <Somnath.Roy@sandisk.com>, "Milosz Ta=
nski" <milosz@adfin.com>
> Envoy=C3=A9: Vendredi 24 Avril 2015 20:02:15
> Objet: Re: [ceph-users] strange benchmark problem : restarting osd da=
emon improve performance from 100k iops to 300k iops
>
> We haven't done any kind of real testing on jemalloc, so use at your =
own
> peril. Having said that, we've also been very interested in hearing
> community feedback from folks trying it out, so please feel free to g=
ive
> it a shot. :D
>
> Mark
>
> On 04/24/2015 12:36 PM, Stefan Priebe - Profihost AG wrote:
>> Is jemalloc recommanded in general? Does it also work for firefly?
>>
>> Stefan
>>
>> Excuse my typo sent from my mobile phone.
>>
>> Am 24.04.2015 um 18:38 schrieb Alexandre DERUMIER <aderumier@odiso.c=
om
>> <mailto:aderumier@odiso.com>>:
>>
>>> Hi,
>>>
>>> I have finished to rebuild ceph with jemalloc,
>>>
>>> all seem to working fine.
>>>
>>> I got a constant 300k iops for the moment, so no speed regression.
>>>
>>> I'll do more long benchmark next week.
>>>
>>> Regards,
>>>
>>> Alexandre
>>>
>>> ----- Mail original -----
>>> De: "Irek Fasikhov" <malmyzh@gmail.com <mailto:malmyzh@gmail.com>>
>>> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com
>>> <mailto:Somnath.Roy@sandisk.com>>
>>> Cc: "aderumier" <aderumier@odiso.com <mailto:aderumier@odiso.com>>,
>>> "Mark Nelson" <mnelson@redhat.com <mailto:mnelson@redhat.com>>,
>>> "ceph-users" <ceph-users@lists.ceph.com
>>> <mailto:ceph-users@lists.ceph.com>>, "ceph-devel"
>>> <ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kernel.org>>,
>>> "Milosz Tanski" <milosz@adfin.com <mailto:milosz@adfin.com>>
>>> Envoy=C3=A9: Vendredi 24 Avril 2015 13:37:52
>>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd
>>> daemon improve performance from 100k iops to 300k iops
>>>
>>> Hi,Alexandre!
>>> Do not try to change the parameter vm.min_free_kbytes?
>>>
>>> 2015-04-23 19:24 GMT+03:00 Somnath Roy < Somnath.Roy@sandisk.com
>>> <mailto:Somnath.Roy@sandisk.com> > :
>>>
>>>
>>> Alexandre,
>>> You can configure with --with-jemalloc or ./do_autogen -J to build
>>> ceph with jemalloc.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: ceph-users [mailto: ceph-users-bounces@lists.ceph.com
>>> <mailto:ceph-users-bounces@lists.ceph.com> ] On Behalf Of Alexandre
>>> DERUMIER
>>> Sent: Thursday, April 23, 2015 4:56 AM
>>> To: Mark Nelson
>>> Cc: ceph-users; ceph-devel; Milosz Tanski
>>> Subject: Re: [ceph-users] strange benchmark problem : restarting os=
d
>>> daemon improve performance from 100k iops to 300k iops
>>>
>>>>> If you have the means to compile the same version of ceph with
>>>>> jemalloc, I would be very interested to see how it does.
>>>
>>> Yes, sure. (I have around 3-4 weeks to do all the benchs)
>>>
>>> But I don't know how to do it ?
>>> I'm running the cluster on centos7.1, maybe it can be easy to patch
>>> the srpms to rebuild the package with jemalloc.
>>>
>>>
>>>
>>> ----- Mail original -----
>>> De: "Mark Nelson" < mnelson@redhat.com <mailto:mnelson@redhat.com> =
>
>>> =C3=80: "aderumier" < aderumier@odiso.com <mailto:aderumier@odiso.c=
om> >,
>>> "Srinivasula Maram" < Srinivasula.Maram@sandisk.com
>>> <mailto:Srinivasula.Maram@sandisk.com> >
>>> Cc: "ceph-users" < ceph-users@lists.ceph.com
>>> <mailto:ceph-users@lists.ceph.com> >, "ceph-devel" <
>>> ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kernel.org> >,
>>> "Milosz Tanski" < milosz@adfin.com <mailto:milosz@adfin.com> >
>>> Envoy=C3=A9: Jeudi 23 Avril 2015 13:33:00
>>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd
>>> daemon improve performance from 100k iops to 300k iops
>>>
>>> Thanks for the testing Alexandre!
>>>
>>> If you have the means to compile the same version of ceph with
>>> jemalloc, I would be very interested to see how it does.
>>>
>>> In some ways I'm glad it turned out not to be NUMA. I still suspect=
 we
>>> will have to deal with it at some point, but perhaps not today. ;)
>>>
>>> Mark
>>>
>>> On 04/23/2015 05:58 AM, Alexandre DERUMIER wrote:
>>>> Maybe it's tcmalloc related
>>>> I thinked to have patched it correctly, but perf show a lot of
>>>> tcmalloc::ThreadCache::ReleaseToCentralCache
>>>>
>>>> before osd restart (100k)
>>>> ------------------
>>>> 11.66% ceph-osd libtcmalloc.so.4.1.2 [.]
>>>> tcmalloc::ThreadCache::ReleaseToCentralCache
>>>> 8.51% ceph-osd libtcmalloc.so.4.1.2 [.]
>>>> tcmalloc::CentralFreeList::FetchFromSpans
>>>> 3.04% ceph-osd libtcmalloc.so.4.1.2 [.]
>>>> tcmalloc::CentralFreeList::ReleaseToSpans
>>>> 2.04% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.63% swapper
>>>> [kernel.kallsyms] [k] intel_idle 1.35% ceph-osd libtcmalloc.so.4.1=
=2E2
>>>> [.] tcmalloc::CentralFreeList::ReleaseListToSpans
>>>> 1.33% ceph-osd libtcmalloc.so.4.1.2 [.] operator delete 1.07% ceph=
-osd
>>>> libstdc++.so.6.0.19 [.] std::basic_string<char,
>>>> std::char_traits<char>, std::allocator<char> >::basic_string 0.91%
>>>> ceph-osd libpthread-2.17.so [.] pthread_mutex_trylock 0.88% ceph-o=
sd
>>>> libc-2.17.so [.] __memcpy_ssse3_back 0.81% ceph-osd ceph-osd [.]
>>>> Mutex::Lock 0.79% ceph-osd [kernel.kallsyms] [k]
>>>> copy_user_enhanced_fast_string 0.74% ceph-osd libpthread-2.17.so [=
=2E]
>>>> pthread_mutex_unlock 0.67% ceph-osd [kernel.kallsyms] [k]
>>>> _raw_spin_lock 0.63% swapper [kernel.kallsyms] [k]
>>>> native_write_msr_safe 0.62% ceph-osd [kernel.kallsyms] [k]
>>>> avc_has_perm_noaudit 0.58% ceph-osd ceph-osd [.] operator< 0.57%
>>>> ceph-osd [kernel.kallsyms] [k] __schedule 0.57% ceph-osd
>>>> [kernel.kallsyms] [k] __d_lookup_rcu 0.54% swapper [kernel.kallsym=
s]
>>>> [k] __schedule
>>>>
>>>>
>>>> after osd restart (300k iops)
>>>> ------------------------------
>>>> 3.47% ceph-osd libtcmalloc.so.4.1.2 [.] operator new 1.92% ceph-os=
d
>>>> libtcmalloc.so.4.1.2 [.] operator delete 1.86% swapper
>>>> [kernel.kallsyms] [k] intel_idle 1.52% ceph-osd libstdc++.so.6.0.1=
9
>>>> [.] std::basic_string<char, std::char_traits<char>,
>>>> std::allocator<char> >::basic_string 1.34% ceph-osd
>>>> libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentralCa=
che
>>>> 1.24% ceph-osd libc-2.17.so [.] __memcpy_ssse3_back 1.23% ceph-osd
>>>> ceph-osd [.] Mutex::Lock 1.21% ceph-osd libpthread-2.17.so [.]
>>>> pthread_mutex_trylock 1.11% ceph-osd [kernel.kallsyms] [k]
>>>> copy_user_enhanced_fast_string 0.95% ceph-osd libpthread-2.17.so [=
=2E]
>>>> pthread_mutex_unlock 0.94% ceph-osd [kernel.kallsyms] [k]
>>>> _raw_spin_lock 0.78% ceph-osd [kernel.kallsyms] [k] __d_lookup_rcu
>>>> 0.70% ceph-osd [kernel.kallsyms] [k] tcp_sendmsg 0.70% ceph-osd
>>>> ceph-osd [.] Message::Message 0.68% ceph-osd [kernel.kallsyms] [k]
>>>> __schedule 0.66% ceph-osd [kernel.kallsyms] [k] idle_cpu 0.65%
>>>> ceph-osd libtcmalloc.so.4.1.2 [.]
>>>> tcmalloc::CentralFreeList::FetchFromSpans
>>>> 0.64% swapper [kernel.kallsyms] [k] native_write_msr_safe 0.61%
>>>> ceph-osd ceph-osd [.]
>>>> std::tr1::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release
>>>> 0.60% swapper [kernel.kallsyms] [k] __schedule 0.60% ceph-osd
>>>> libstdc++.so.6.0.19 [.] 0x00000000000bdd2b 0.57% ceph-osd ceph-osd=
 [.]
>>>> operator< 0.57% ceph-osd ceph-osd [.] crc32_iscsi_00 0.56% ceph-os=
d
>>>> libstdc++.so.6.0.19 [.] std::string::_Rep::_M_dispose 0.55% ceph-o=
sd
>>>> [kernel.kallsyms] [k] __switch_to 0.54% ceph-osd libc-2.17.so [.]
>>>> vfprintf 0.52% ceph-osd [kernel.kallsyms] [k] fget_light
>>>>
>>>> ----- Mail original -----
>>>> De: "aderumier" < aderumier@odiso.com <mailto:aderumier@odiso.com>=
 >
>>>> =C3=80: "Srinivasula Maram" < Srinivasula.Maram@sandisk.com
>>>> <mailto:Srinivasula.Maram@sandisk.com> >
>>>> Cc: "ceph-users" < ceph-users@lists.ceph.com
>>>> <mailto:ceph-users@lists.ceph.com> >, "ceph-devel"
>>>> < ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kernel.org> >=
,
>>>> "Milosz Tanski" < milosz@adfin.com <mailto:milosz@adfin.com> >
>>>> Envoy=C3=A9: Jeudi 23 Avril 2015 10:00:34
>>>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd
>>>> daemon improve performance from 100k iops to 300k iops
>>>>
>>>> Hi,
>>>> I'm hitting this bug again today.
>>>>
>>>> So don't seem to be numa related (I have try to flush linux buffer=
 to
>>>> be sure).
>>>>
>>>> and tcmalloc is patched (I don't known how to verify that it's ok)=
=2E
>>>>
>>>> I don't have restarted osd yet.
>>>>
>>>> Maybe some perf trace could be usefulll ?
>>>>
>>>>
>>>> ----- Mail original -----
>>>> De: "aderumier" < aderumier@odiso.com <mailto:aderumier@odiso.com>=
 >
>>>> =C3=80: "Srinivasula Maram" < Srinivasula.Maram@sandisk.com
>>>> <mailto:Srinivasula.Maram@sandisk.com> >
>>>> Cc: "ceph-users" < ceph-users@lists.ceph.com
>>>> <mailto:ceph-users@lists.ceph.com> >, "ceph-devel"
>>>> < ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kernel.org> >=
,
>>>> "Milosz Tanski" < milosz@adfin.com <mailto:milosz@adfin.com> >
>>>> Envoy=C3=A9: Mercredi 22 Avril 2015 18:30:26
>>>> Objet: Re: [ceph-users] strange benchmark problem : restarting osd
>>>> daemon improve performance from 100k iops to 300k iops
>>>>
>>>> Hi,
>>>>
>>>>>> I feel it is due to tcmalloc issue
>>>>
>>>> Indeed, I had patched one of my node, but not the other.
>>>> So maybe I have hit this bug. (but I can't confirm, I don't have
>>>> traces).
>>>>
>>>> But numa interleaving seem to help in my case (maybe not from
>>>> 100->300k, but 250k->300k).
>>>>
>>>> I need to do more long tests to confirm that.
>>>>
>>>>
>>>> ----- Mail original -----
>>>> De: "Srinivasula Maram" < Srinivasula.Maram@sandisk.com
>>>> <mailto:Srinivasula.Maram@sandisk.com> >
>>>> =C3=80: "Mark Nelson" < mnelson@redhat.com <mailto:mnelson@redhat.=
com> >,
>>>> "aderumier"
>>>> < aderumier@odiso.com <mailto:aderumier@odiso.com> >, "Milosz Tans=
ki"
>>>> < milosz@adfin.com <mailto:milosz@adfin.com> >
>>>> Cc: "ceph-devel" < ceph-devel@vger.kernel.org
>>>> <mailto:ceph-devel@vger.kernel.org> >, "ceph-users"
>>>> < ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com> >
>>>> Envoy=C3=A9: Mercredi 22 Avril 2015 16:34:33
>>>> Objet: RE: [ceph-users] strange benchmark problem : restarting osd
>>>> daemon improve performance from 100k iops to 300k iops
>>>>
>>>> I feel it is due to tcmalloc issue
>>>>
>>>> I have seen similar issue in my setup after 20 days.
>>>>
>>>> Thanks,
>>>> Srinivas
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: ceph-users [mailto: ceph-users-bounces@lists.ceph.com
>>>> <mailto:ceph-users-bounces@lists.ceph.com> ] On Behalf
>>>> Of Mark Nelson
>>>> Sent: Wednesday, April 22, 2015 7:31 PM
>>>> To: Alexandre DERUMIER; Milosz Tanski
>>>> Cc: ceph-devel; ceph-users
>>>> Subject: Re: [ceph-users] strange benchmark problem : restarting o=
sd
>>>> daemon improve performance from 100k iops to 300k iops
>>>>
>>>> Hi Alexandre,
>>>>
>>>> We should discuss this at the perf meeting today. We knew NUMA nod=
e
>>>> affinity issues were going to crop up sooner or later (and indeed
>>>> already have in some cases), but this is pretty major. It's probab=
ly
>>>> time to really dig in and figure out how to deal with this.
>>>>
>>>> Note: this is one of the reasons I like small nodes with single
>>>> sockets and fewer OSDs.
>>>>
>>>> Mark
>>>>
>>>> On 04/22/2015 08:56 AM, Alexandre DERUMIER wrote:
>>>>> Hi,
>>>>>
>>>>> I have done a lot of test today, and it seem indeed numa related.
>>>>>
>>>>> My numastat was
>>>>>
>>>>> # numastat
>>>>> node0 node1
>>>>> numa_hit 99075422 153976877
>>>>> numa_miss 167490965 1493663
>>>>> numa_foreign 1493663 167491417
>>>>> interleave_hit 157745 167015
>>>>> local_node 99049179 153830554
>>>>> other_node 167517697 1639986
>>>>>
>>>>> So, a lot of miss.
>>>>>
>>>>> In this case , I can reproduce ios going from 85k to 300k iops, u=
p
>>>>> and down.
>>>>>
>>>>> now setting
>>>>> echo 0 > /proc/sys/kernel/numa_balancing
>>>>>
>>>>> and starting osd daemons with
>>>>>
>>>>> numactl --interleave=3Dall /usr/bin/ceph-osd
>>>>>
>>>>>
>>>>> I have a constant 300k iops !
>>>>>
>>>>>
>>>>> I wonder if it could be improve by binding osd daemons to specifi=
c
>>>>> numa node.
>>>>> I have 2 numanode of 10 cores with 6 osd, but I think it also
>>>>> require ceph.conf osd threads tunning.
>>>>>
>>>>>
>>>>>
>>>>> ----- Mail original -----
>>>>> De: "Milosz Tanski" < milosz@adfin.com <mailto:milosz@adfin.com> =
>
>>>>> =C3=80: "aderumier" < aderumier@odiso.com <mailto:aderumier@odiso=
=2Ecom> >
>>>>> Cc: "ceph-devel" < ceph-devel@vger.kernel.org
>>>>> <mailto:ceph-devel@vger.kernel.org> >, "ceph-users"
>>>>> < ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com> >
>>>>> Envoy=C3=A9: Mercredi 22 Avril 2015 12:54:23
>>>>> Objet: Re: [ceph-users] strange benchmark problem : restarting os=
d
>>>>> daemon improve performance from 100k iops to 300k iops
>>>>>
>>>>>
>>>>>
>>>>> On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER <
>>>>> aderumier@odiso.com <mailto:aderumier@odiso.com> > wrote:
>>>>>
>>>>>
>>>>> I wonder if it could be numa related,
>>>>>
>>>>> I'm using centos 7.1,
>>>>> and auto numa balacning is enabled
>>>>>
>>>>> cat /proc/sys/kernel/numa_balancing =3D 1
>>>>>
>>>>> Maybe osd daemon access to buffer on wrong numa node.
>>>>>
>>>>> I'll try to reproduce the problem
>>>>>
>>>>>
>>>>>
>>>>> Can you force the degenerate case using numactl? To either affirm=
 or
>>>>> deny your suspicion.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> ----- Mail original -----
>>>>> De: "aderumier" < aderumier@odiso.com <mailto:aderumier@odiso.com=
> >
>>>>> =C3=80: "ceph-devel" < ceph-devel@vger.kernel.org
>>>>> <mailto:ceph-devel@vger.kernel.org> >, "ceph-users" <
>>>>> ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com> >
>>>>> Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05
>>>>> Objet: [ceph-users] strange benchmark problem : restarting osd da=
emon
>>>>> improve performance from 100k iops to 300k iops
>>>>>
>>>>> Hi,
>>>>>
>>>>> I was doing some benchmarks,
>>>>> I have found an strange behaviour.
>>>>>
>>>>> Using fio with rbd engine, I was able to reach around 100k iops.
>>>>> (osd datas in linux buffer, iostat show 0% disk access)
>>>>>
>>>>> then after restarting all osd daemons,
>>>>>
>>>>> the same fio benchmark show now around 300k iops.
>>>>> (osd datas in linux buffer, iostat show 0% disk access)
>>>>>
>>>>>
>>>>> any ideas?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> before restarting osd
>>>>> ---------------------
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4=
K,
>>>>> ioengine=3Drbd, iodepth=3D32 ...
>>>>> fio-2.2.7-10-g51e9
>>>>> Starting 10 processes
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> ^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6=
K/0/0
>>>>> iops] [eta 14m:45s]
>>>>> fio: terminating on signal 2
>>>>>
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D170=
75: Wed Apr
>>>>> 22 10:00:04 2015 read : io=3D11558MB, bw=3D451487KB/s, iops=3D112=
871, runt=3D
>>>>> 26215msec slat (usec): min=3D5, max=3D3685, avg=3D16.89, stdev=3D=
17.38 clat
>>>>> (usec): min=3D5, max=3D62584, avg=3D2695.80, stdev=3D5351.23 lat =
(usec):
>>>>> min=3D109, max=3D62598, avg=3D2712.68, stdev=3D5350.42 clat perce=
ntiles
>>>>> (usec):
>>>>> | 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.00th=3D[=
 247],
>>>>> | 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00th=3D[ 446], 60.00th=3D=
[ 660],
>>>>> | 70.00th=3D[ 1176], 80.00th=3D[ 3152], 90.00th=3D[ 9024], 95.00t=
h=3D[14656],
>>>>> | 99.00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95t=
h=3D[41728],
>>>>> | 99.99th=3D[47360]
>>>>> bw (KB /s): min=3D23928, max=3D154416, per=3D10.07%, avg=3D45462.=
82,
>>>>> stdev=3D28809.95 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%,=
 100=3D0.01%,
>>>>> 250=3D20.79% lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.03%=
 lat (msec) :
>>>>> 2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.60%, 50=3D2.37% lat (mse=
c) : 100=3D0.01%
>>>>> cpu : usr=3D15.90%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D8=
710 IO depths :
>>>>> 1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6%, >=
=3D64=3D0.0% submit :
>>>>> 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, =
>=3D64=3D0.0%
>>>>> complete : 0=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 6=
4=3D0.0%,
>>>>>> =3D64=3D0.0% issued : total=3Dr=3D2958935/w=3D0/d=3D0, short=3Dr=
=3D0/w=3D0/d=3D0,
>>>>> drop=3Dr=3D0/w=3D0/d=3D0 latency : target=3D0, window=3D0, percen=
tile=3D100.00%,
>>>>> depth=3D32
>>>>>
>>>>> Run status group 0 (all jobs):
>>>>> READ: io=3D11558MB, aggrb=3D451487KB/s, minb=3D451487KB/s, maxb=3D=
451487KB/s,
>>>>> mint=3D26215msec, maxt=3D26215msec
>>>>>
>>>>> Disk stats (read/write):
>>>>> sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=3D3, util=3D=
0.01%
>>>>> [root@ceph1-3 fiorbd]# ./fio fiorbd
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4=
K,
>>>>> ioengine=3Drbd, iodepth=3D32
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> AFTER RESTARTING OSDS
>>>>> ----------------------
>>>>> [root@ceph1-3 fiorbd]# ./fio fiorbd
>>>>> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4=
K,
>>>>> ioengine=3Drbd, iodepth=3D32 ...
>>>>> fio-2.2.7-10-g51e9
>>>>> Starting 10 processes
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> rbd engine: RBD version: 0.1.9
>>>>> ^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/=
0/0
>>>>> iops] [eta 01h:09m:27s]
>>>>> fio: terminating on signal 2
>>>>>
>>>>> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D182=
52: Wed Apr
>>>>> 22 10:02:28 2015 read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D26=
5218,
>>>>> runt=3D 7389msec slat (usec): min=3D5, max=3D3406, avg=3D26.59, s=
tdev=3D40.35
>>>>> clat
>>>>> (usec): min=3D8, max=3D684328, avg=3D930.43, stdev=3D6419.12 lat =
(usec):
>>>>> min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28 clat perce=
ntiles
>>>>> (usec):
>>>>> | 1.00th=3D[ 243], 5.00th=3D[ 314], 10.00th=3D[ 366], 20.00th=3D[=
 450],
>>>>> | 30.00th=3D[ 524], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D=
[ 796],
>>>>> | 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=
=3D[ 1720],
>>>>> | 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920], 99.95t=
h=3D[ 9792],
>>>>> | 99.99th=3D[436224]
>>>>> bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076=
=2E46,
>>>>> stdev=3D28263.82 lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%,=
 100=3D0.01%,
>>>>> 250=3D1.23% lat (usec) : 500=3D25.64%, 750=3D29.15%, 1000=3D18.84=
% lat (msec)
>>>>> : 2=3D22.19%, 4=3D2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01% lat (=
msec) :
>>>>> 250=3D0.01%, 500=3D0.02%, 750=3D0.01% cpu : usr=3D44.06%, sys=3D1=
1.26%,
>>>>> ctx=3D642620, majf=3D0, minf=3D6832 IO depths : 1=3D0.1%, 2=3D0.5=
%, 4=3D2.0%,
>>>>> 8=3D11.5%, 16=3D77.8%, 32=3D8.1%, >=3D64=3D0.0% submit : 0=3D0.0%=
, 4=3D100.0%,
>>>>> 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, >=3D64=3D0.0% complete=
 : 0=3D0.0%,
>>>>> 4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%, >=3D64=3D0.=
0% issued :
>>>>> total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=3D=
r=3D0/w=3D0/d=3D0 latency :
>>>>> target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>>>>>
>>>>> Run status group 0 (all jobs):
>>>>> READ: io=3D7655.7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s,
>>>>> maxb=3D1036.8MB/s, mint=3D7389msec, maxt=3D7389msec
>>>>>
>>>>> Disk stats (read/write):
>>>>> sdg: ios=3D0/21, merge=3D0/10, ticks=3D0/2, in_queue=3D2, util=3D=
0.03%
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> CEPH LOG
>>>>> --------
>>>>>
>>>>> before restarting osd
>>>>> ----------------------
>>>>>
>>>>> 2015-04-22 09:53:17.568095 mon.0 10.7.0.152:6789/0 2144 : cluster
>>>>> [INF] pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 298 MB/s rd, 76465 op/s
>>>>> 2015-04-22 09:53:18.574524 mon.0 10.7.0.152:6789/0 2145 : cluster
>>>>> [INF] pgmap v11331: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 333 MB/s rd, 85355 op/s
>>>>> 2015-04-22 09:53:19.579351 mon.0 10.7.0.152:6789/0 2146 : cluster
>>>>> [INF] pgmap v11332: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 343 MB/s rd, 87932 op/s
>>>>> 2015-04-22 09:53:20.591586 mon.0 10.7.0.152:6789/0 2147 : cluster
>>>>> [INF] pgmap v11333: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 328 MB/s rd, 84151 op/s
>>>>> 2015-04-22 09:53:21.600650 mon.0 10.7.0.152:6789/0 2148 : cluster
>>>>> [INF] pgmap v11334: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 237 MB/s rd, 60855 op/s
>>>>> 2015-04-22 09:53:22.607966 mon.0 10.7.0.152:6789/0 2149 : cluster
>>>>> [INF] pgmap v11335: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 144 MB/s rd, 36935 op/s
>>>>> 2015-04-22 09:53:23.617780 mon.0 10.7.0.152:6789/0 2150 : cluster
>>>>> [INF] pgmap v11336: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 321 MB/s rd, 82334 op/s
>>>>> 2015-04-22 09:53:24.622341 mon.0 10.7.0.152:6789/0 2151 : cluster
>>>>> [INF] pgmap v11337: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 368 MB/s rd, 94211 op/s
>>>>> 2015-04-22 09:53:25.628432 mon.0 10.7.0.152:6789/0 2152 : cluster
>>>>> [INF] pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 244 MB/s rd, 62644 op/s
>>>>> 2015-04-22 09:53:26.632855 mon.0 10.7.0.152:6789/0 2153 : cluster
>>>>> [INF] pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 175 MB/s rd, 44997 op/s
>>>>> 2015-04-22 09:53:27.636573 mon.0 10.7.0.152:6789/0 2154 : cluster
>>>>> [INF] pgmap v11340: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 122 MB/s rd, 31259 op/s
>>>>> 2015-04-22 09:53:28.645784 mon.0 10.7.0.152:6789/0 2155 : cluster
>>>>> [INF] pgmap v11341: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 229 MB/s rd, 58674 op/s
>>>>> 2015-04-22 09:53:29.657128 mon.0 10.7.0.152:6789/0 2156 : cluster
>>>>> [INF] pgmap v11342: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 271 MB/s rd, 69501 op/s
>>>>> 2015-04-22 09:53:30.662796 mon.0 10.7.0.152:6789/0 2157 : cluster
>>>>> [INF] pgmap v11343: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 211 MB/s rd, 54020 op/s
>>>>> 2015-04-22 09:53:31.666421 mon.0 10.7.0.152:6789/0 2158 : cluster
>>>>> [INF] pgmap v11344: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 164 MB/s rd, 42001 op/s
>>>>> 2015-04-22 09:53:32.670842 mon.0 10.7.0.152:6789/0 2159 : cluster
>>>>> [INF] pgmap v11345: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 134 MB/s rd, 34380 op/s
>>>>> 2015-04-22 09:53:33.681357 mon.0 10.7.0.152:6789/0 2160 : cluster
>>>>> [INF] pgmap v11346: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 293 MB/s rd, 75213 op/s
>>>>> 2015-04-22 09:53:34.692177 mon.0 10.7.0.152:6789/0 2161 : cluster
>>>>> [INF] pgmap v11347: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 337 MB/s rd, 86353 op/s
>>>>> 2015-04-22 09:53:35.697401 mon.0 10.7.0.152:6789/0 2162 : cluster
>>>>> [INF] pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 229 MB/s rd, 58839 op/s
>>>>> 2015-04-22 09:53:36.699309 mon.0 10.7.0.152:6789/0 2163 : cluster
>>>>> [INF] pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 390 GB data, 391 GB used, 904 =
GB /
>>>>> 1295 GB avail; 152 MB/s rd, 39117 op/s
>>>>>
>>>>>
>>>>> restarting osd
>>>>> ---------------
>>>>>
>>>>> 2015-04-22 10:00:09.766906 mon.0 10.7.0.152:6789/0 2255 : cluster
>>>>> [INF] osd.0 marked itself down
>>>>> 2015-04-22 10:00:09.790212 mon.0 10.7.0.152:6789/0 2256 : cluster
>>>>> [INF] osdmap e849: 9 osds: 8 up, 9 in
>>>>> 2015-04-22 10:00:09.793050 mon.0 10.7.0.152:6789/0 2257 : cluster
>>>>> [INF] pgmap v11439: 964 pgs: 2 active+undersized+degraded, 8
>>>>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped=
,
>>>>> stale+active+794
>>>>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail; 5=
16
>>>>> kB/s rd, 130 op/s
>>>>> 2015-04-22 10:00:10.795966 mon.0 10.7.0.152:6789/0 2258 : cluster
>>>>> [INF] osdmap e850: 9 osds: 8 up, 9 in
>>>>> 2015-04-22 10:00:10.796675 mon.0 10.7.0.152:6789/0 2259 : cluster
>>>>> [INF] pgmap v11440: 964 pgs: 2 active+undersized+degraded, 8
>>>>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped=
,
>>>>> stale+active+794
>>>>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:11.798257 mon.0 10.7.0.152:6789/0 2260 : cluster
>>>>> [INF] pgmap v11441: 964 pgs: 2 active+undersized+degraded, 8
>>>>> stale+active+remapped, 106 stale+active+clean, 54 active+remapped=
,
>>>>> stale+active+794
>>>>> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:12.339696 mon.0 10.7.0.152:6789/0 2262 : cluster
>>>>> [INF] osd.1 marked itself down
>>>>> 2015-04-22 10:00:12.800168 mon.0 10.7.0.152:6789/0 2263 : cluster
>>>>> [INF] osdmap e851: 9 osds: 7 up, 9 in
>>>>> 2015-04-22 10:00:12.806498 mon.0 10.7.0.152:6789/0 2264 : cluster
>>>>> [INF] pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13
>>>>> stale+active+remapped, 216 stale+active+clean, 49 active+remapped=
,
>>>>> stale+active+684
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:13.804186 mon.0 10.7.0.152:6789/0 2265 : cluster
>>>>> [INF] osdmap e852: 9 osds: 7 up, 9 in
>>>>> 2015-04-22 10:00:13.805216 mon.0 10.7.0.152:6789/0 2266 : cluster
>>>>> [INF] pgmap v11444: 964 pgs: 1 active+undersized+degraded, 13
>>>>> stale+active+remapped, 216 stale+active+clean, 49 active+remapped=
,
>>>>> stale+active+684
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:14.781785 mon.0 10.7.0.152:6789/0 2268 : cluster
>>>>> [INF] osd.2 marked itself down
>>>>> 2015-04-22 10:00:14.810571 mon.0 10.7.0.152:6789/0 2269 : cluster
>>>>> [INF] osdmap e853: 9 osds: 6 up, 9 in
>>>>> 2015-04-22 10:00:14.813871 mon.0 10.7.0.152:6789/0 2270 : cluster
>>>>> [INF] pgmap v11445: 964 pgs: 1 active+undersized+degraded, 22
>>>>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped=
,
>>>>> stale+active+600
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:15.810333 mon.0 10.7.0.152:6789/0 2271 : cluster
>>>>> [INF] osdmap e854: 9 osds: 6 up, 9 in
>>>>> 2015-04-22 10:00:15.811425 mon.0 10.7.0.152:6789/0 2272 : cluster
>>>>> [INF] pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22
>>>>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped=
,
>>>>> stale+active+600
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:16.395105 mon.0 10.7.0.152:6789/0 2273 : cluster
>>>>> [INF] HEALTH_WARN; 2 pgs degraded; 323 pgs stale; 2 pgs stuck
>>>>> degraded; 64 pgs stuck unclean; 2 pgs stuck undersized; 2 pgs
>>>>> undersized; 3/9 in osds are down; clock skew detected on mon.ceph=
1-2
>>>>> 2015-04-22 10:00:16.814432 mon.0 10.7.0.152:6789/0 2274 : cluster
>>>>> [INF] osd.1 10.7.0.152:6800/14848 boot
>>>>> 2015-04-22 10:00:16.814938 mon.0 10.7.0.152:6789/0 2275 : cluster
>>>>> [INF] osdmap e855: 9 osds: 7 up, 9 in
>>>>> 2015-04-22 10:00:16.815942 mon.0 10.7.0.152:6789/0 2276 : cluster
>>>>> [INF] pgmap v11447: 964 pgs: 1 active+undersized+degraded, 22
>>>>> stale+active+remapped, 300 stale+active+clean, 40 active+remapped=
,
>>>>> stale+active+600
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:17.222281 mon.0 10.7.0.152:6789/0 2278 : cluster
>>>>> [INF] osd.3 marked itself down
>>>>> 2015-04-22 10:00:17.819371 mon.0 10.7.0.152:6789/0 2279 : cluster
>>>>> [INF] osdmap e856: 9 osds: 6 up, 9 in
>>>>> 2015-04-22 10:00:17.822041 mon.0 10.7.0.152:6789/0 2280 : cluster
>>>>> [INF] pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25
>>>>> stale+active+remapped, 394 stale+active+clean, 37 active+remapped=
,
>>>>> stale+active+506
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:18.551068 mon.0 10.7.0.152:6789/0 2282 : cluster
>>>>> [INF] osd.6 marked itself down
>>>>> 2015-04-22 10:00:18.819387 mon.0 10.7.0.152:6789/0 2283 : cluster
>>>>> [INF] osd.2 10.7.0.152:6812/15410 boot
>>>>> 2015-04-22 10:00:18.821134 mon.0 10.7.0.152:6789/0 2284 : cluster
>>>>> [INF] osdmap e857: 9 osds: 6 up, 9 in
>>>>> 2015-04-22 10:00:18.824440 mon.0 10.7.0.152:6789/0 2285 : cluster
>>>>> [INF] pgmap v11449: 964 pgs: 1 active+undersized+degraded, 30
>>>>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped=
,
>>>>> stale+active+398
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:19.820947 mon.0 10.7.0.152:6789/0 2287 : cluster
>>>>> [INF] osdmap e858: 9 osds: 6 up, 9 in
>>>>> 2015-04-22 10:00:19.821853 mon.0 10.7.0.152:6789/0 2288 : cluster
>>>>> [INF] pgmap v11450: 964 pgs: 1 active+undersized+degraded, 30
>>>>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped=
,
>>>>> stale+active+398
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:20.828047 mon.0 10.7.0.152:6789/0 2290 : cluster
>>>>> [INF] osd.3 10.7.0.152:6816/15971 boot
>>>>> 2015-04-22 10:00:20.828431 mon.0 10.7.0.152:6789/0 2291 : cluster
>>>>> [INF] osdmap e859: 9 osds: 7 up, 9 in
>>>>> 2015-04-22 10:00:20.829126 mon.0 10.7.0.152:6789/0 2292 : cluster
>>>>> [INF] pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30
>>>>> stale+active+remapped, 502 stale+active+clean, 32 active+remapped=
,
>>>>> stale+active+398
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:20.991343 mon.0 10.7.0.152:6789/0 2294 : cluster
>>>>> [INF] osd.7 marked itself down
>>>>> 2015-04-22 10:00:21.830389 mon.0 10.7.0.152:6789/0 2295 : cluster
>>>>> [INF] osd.0 10.7.0.152:6804/14481 boot
>>>>> 2015-04-22 10:00:21.832518 mon.0 10.7.0.152:6789/0 2296 : cluster
>>>>> [INF] osdmap e860: 9 osds: 7 up, 9 in
>>>>> 2015-04-22 10:00:21.836129 mon.0 10.7.0.152:6789/0 2297 : cluster
>>>>> [INF] pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35
>>>>> stale+active+remapped, 608 stale+active+clean, 27 active+remapped=
,
>>>>> stale+active+292
>>>>> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 42=
0 GB
>>>>> used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:22.830456 mon.0 10.7.0.152:6789/0 2298 : cluster
>>>>> [INF] osd.6 10.7.0.153:6808/21955 boot
>>>>> 2015-04-22 10:00:22.832171 mon.0 10.7.0.152:6789/0 2299 : cluster
>>>>> [INF] osdmap e861: 9 osds: 8 up, 9 in
>>>>> 2015-04-22 10:00:22.836272 mon.0 10.7.0.152:6789/0 2300 : cluster
>>>>> [INF] pgmap v11453: 964 pgs: 3 active+undersized+degraded, 27
>>>>> stale+active+remapped, 498 stale+active+clean, 2 peering, 28
>>>>> active+remapped, 402 active+clean, 4 remapped+peering; 419 GB dat=
a,
>>>>> 420 GB used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:23.420309 mon.0 10.7.0.152:6789/0 2302 : cluster
>>>>> [INF] osd.8 marked itself down
>>>>> 2015-04-22 10:00:23.833708 mon.0 10.7.0.152:6789/0 2303 : cluster
>>>>> [INF] osdmap e862: 9 osds: 7 up, 9 in
>>>>> 2015-04-22 10:00:23.836459 mon.0 10.7.0.152:6789/0 2304 : cluster
>>>>> [INF] pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44
>>>>> stale+active+remapped, 587 stale+active+clean, 2 peering, 11
>>>>> active+remapped, 313 active+clean, 4 remapped+peering; 419 GB dat=
a,
>>>>> 420 GB used, 874 GB / 1295 GB avail
>>>>> 2015-04-22 10:00:24.832905 mon.0 10.7.0.152:6789/0 2305 : cluster
>>>>> [INF] osd.7 10.7.0.153:6804/22536 boot
>>>>> 2015-04-22 10:00:24.834381 mon.0 10.7.0.152:6789/0 2306 : cluster
>>>>> [INF] osdmap e863: 9 osds: 8 up, 9 in
>>>>> 2015-04-22 10:00:24.836977 mon.0 10.7.0.152:6789/0 2307 : cluster
>>>>> [INF] pgmap v11455: 964 pgs: 3 active+undersized+degraded, 31
>>>>> stale+active+remapped, 503 stale+active+clean, 4
>>>>> active+undersized+degraded+remapped, 5 peering, 13 active+remappe=
d,
>>>>> 397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 8=
74
>>>>> GB / 1295 GB avail
>>>>> 2015-04-22 10:00:25.834459 mon.0 10.7.0.152:6789/0 2309 : cluster
>>>>> [INF] osdmap e864: 9 osds: 8 up, 9 in
>>>>> 2015-04-22 10:00:25.835727 mon.0 10.7.0.152:6789/0 2310 : cluster
>>>>> [INF] pgmap v11456: 964 pgs: 3 active+undersized+degraded, 31
>>>>> stale+active+remapped, 503 stale+active+clean, 4
>>>>> active+undersized+degraded+remapped, 5 peering, 13 active
>>>>>
>>>>>
>>>>> AFTER OSD RESTART
>>>>> ------------------
>>>>>
>>>>>
>>>>> 2015-04-22 10:09:27.609052 mon.0 10.7.0.152:6789/0 2339 : cluster
>>>>> [INF] pgmap v11478: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 786 MB/s rd, 196 kop/s
>>>>> 2015-04-22 10:09:28.618082 mon.0 10.7.0.152:6789/0 2340 : cluster
>>>>> [INF] pgmap v11479: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 1578 MB/s rd, 394 kop/s
>>>>> 2015-04-22 10:09:30.629067 mon.0 10.7.0.152:6789/0 2341 : cluster
>>>>> [INF] pgmap v11480: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 932 MB/s rd, 233 kop/s
>>>>> 2015-04-22 10:09:32.645890 mon.0 10.7.0.152:6789/0 2342 : cluster
>>>>> [INF] pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 627 MB/s rd, 156 kop/s
>>>>> 2015-04-22 10:09:33.652634 mon.0 10.7.0.152:6789/0 2343 : cluster
>>>>> [INF] pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 1034 MB/s rd, 258 kop/s
>>>>> 2015-04-22 10:09:35.655657 mon.0 10.7.0.152:6789/0 2344 : cluster
>>>>> [INF] pgmap v11483: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 529 MB/s rd, 132 kop/s
>>>>> 2015-04-22 10:09:37.674332 mon.0 10.7.0.152:6789/0 2345 : cluster
>>>>> [INF] pgmap v11484: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 770 MB/s rd, 192 kop/s
>>>>> 2015-04-22 10:09:38.679445 mon.0 10.7.0.152:6789/0 2346 : cluster
>>>>> [INF] pgmap v11485: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 1358 MB/s rd, 339 kop/s
>>>>> 2015-04-22 10:09:40.690037 mon.0 10.7.0.152:6789/0 2347 : cluster
>>>>> [INF] pgmap v11486: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 649 MB/s rd, 162 kop/s
>>>>> 2015-04-22 10:09:42.707164 mon.0 10.7.0.152:6789/0 2348 : cluster
>>>>> [INF] pgmap v11487: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 580 MB/s rd, 145 kop/s
>>>>> 2015-04-22 10:09:43.713736 mon.0 10.7.0.152:6789/0 2349 : cluster
>>>>> [INF] pgmap v11488: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 962 MB/s rd, 240 kop/s
>>>>> 2015-04-22 10:09:45.718658 mon.0 10.7.0.152:6789/0 2350 : cluster
>>>>> [INF] pgmap v11489: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 506 MB/s rd, 126 kop/s
>>>>> 2015-04-22 10:09:47.737358 mon.0 10.7.0.152:6789/0 2351 : cluster
>>>>> [INF] pgmap v11490: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 774 MB/s rd, 193 kop/s
>>>>> 2015-04-22 10:09:48.743338 mon.0 10.7.0.152:6789/0 2352 : cluster
>>>>> [INF] pgmap v11491: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 1363 MB/s rd, 340 kop/s
>>>>> 2015-04-22 10:09:50.746685 mon.0 10.7.0.152:6789/0 2353 : cluster
>>>>> [INF] pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 662 MB/s rd, 165 kop/s
>>>>> 2015-04-22 10:09:52.762461 mon.0 10.7.0.152:6789/0 2354 : cluster
>>>>> [INF] pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 593 MB/s rd, 148 kop/s
>>>>> 2015-04-22 10:09:53.767729 mon.0 10.7.0.152:6789/0 2355 : cluster
>>>>> [INF] pgmap v11494: 964 pgs: 2 active+undersized+degraded, 62
>>>>> active+remapped, 900 active+clean; 419 GB data, 421 GB used, 874 =
GB /
>>>>> 1295 GB avail; 938 MB/s rd, 234 kop/s
>>>>>
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>> ________________________________
>>>>
>>>> PLEASE NOTE: The information contained in this electronic mail
>>>> message is intended only for the use of the designated recipient(s=
)
>>>> named above. If the reader of this message is not the intended
>>>> recipient, you are hereby notified that you have received this
>>>> message in error and that any review, dissemination, distribution,=
 or
>>>> copying of this message is strictly prohibited. If you have receiv=
ed
>>>> this communication in error, please notify the sender by telephone=
 or
>>>> e-mail (as shown above) immediately and destroy any and all copies=
 of
>>>> this message in your possession (whether hard copies or
>>>> electronically stored copies).
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com <mailto:ceph-users@lists.ceph.com>
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
>>>
>>>
>>>
>>>
>>> --
>>> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=
=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=
=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
>>> =D0=9C=D0=BE=D0=B1.: +79229045757
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> <mailto:majordomo@vger.kernel.org>
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Jvrao
---
=46irst they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
