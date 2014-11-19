From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: client cpu usage : kbrd vs librbd perf report
Date: Wed, 19 Nov 2014 08:29:20 +0100 (CET)
Message-ID: <48f230d2-8905-42df-a4e5-610ae968581c@mailpro>
References: <CACJqLybr_X8g8W3xAq5QAiGeXdXR=3NAX-gyajnj_Z2ggV-zhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:54501 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbaKSH33 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Nov 2014 02:29:29 -0500
In-Reply-To: <CACJqLybr_X8g8W3xAq5QAiGeXdXR=3NAX-gyajnj_Z2ggV-zhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Somnath Roy <somnath.roy@sandisk.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Mark Nelson <mark.nelson@inktank.com>

Hi,

Can I make a tracker for this ?

----- Mail original -----=20

De: "Haomai Wang" <haomaiwang@gmail.com>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Sage Weil" <sage@newdream.net>, "Alexandre DERUMIER" <aderumier@od=
iso.com>, "Somnath Roy" <somnath.roy@sandisk.com>, "Ceph Devel" <ceph-d=
evel@vger.kernel.org>=20
Envoy=C3=A9: Jeudi 13 Novembre 2014 19:15:24=20
Objet: Re: client cpu usage : kbrd vs librbd perf report=20

Hmm, I think it's a good perf topic to discuss about buffer=20
alloc/dealloc. For example, maybe frequency alloced object can use=20
memory pool(each pool stores the same objects), but the most challenge=20
to this is also STL structures.=20

On Fri, Nov 14, 2014 at 1:05 AM, Mark Nelson <mark.nelson@inktank.com> =
wrote:=20
> On 11/13/2014 10:29 AM, Sage Weil wrote:=20
>>=20
>> On Thu, 13 Nov 2014, Alexandre DERUMIER wrote:=20
>>>>>=20
>>>>> I think we need to figure out why so much time is being spent=20
>>>>> mallocing/freeing memory. Got to get those symbols resolved!=20
>>>=20
>>>=20
>>> Ok, I don't known why, but if I remove all ceph -dbg packages, I'm =
seeing=20
>>> the rbd && rados symbols now...=20
>>>=20
>>> I have udpdate the files:=20
>>>=20
>>> http://odisoweb1.odiso.net/cephperf/perf-librbd/report.txt=20
>>=20
>>=20
>> Ran it through c++filt:=20
>>=20
>> https://gist.github.com/88ba9409f5d201b957a1=20
>>=20
>> I'm a bit suprised by the some of the items near the top=20
>> (bufferlist.clear() callers). I'm sure several of those can be=20
>> streamlined to avoid temporary bufferlists. I don't see any super=20
>> egregious users of the allocator, though.=20
>>=20
>> The memcpy callers might be a good place to start...=20
>>=20
>> sage=20
>=20
>=20
> Wasn't josh looking into some of this a year ago? Did anything ever c=
ome of=20
> that work?=20
>=20
>=20
>>=20
>>=20
>>=20
>>=20
>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>>=20
>>> De: "Mark Nelson" <mark.nelson@inktank.com>=20
>>> ?: "Alexandre DERUMIER" <aderumier@odiso.com>, "Ceph Devel"=20
>>> <ceph-devel@vger.kernel.org>=20
>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Sage Weil"=20
>>> <sweil@redhat.com>, "Somnath Roy" <somnath.roy@sandisk.com>=20
>>> Envoy?: Jeudi 13 Novembre 2014 15:20:40=20
>>> Objet: Re: client cpu usage : kbrd vs librbd perf report=20
>>>=20
>>> On 11/13/2014 05:15 AM, Alexandre DERUMIER wrote:=20
>>>>=20
>>>> Hi,=20
>>>>=20
>>>> I have redone perf with dwarf=20
>>>>=20
>>>> perf record -g --call-graph dwarf -a -F 99 -- sleep 60=20
>>>>=20
>>>> I have put perf reports, ceph conf, fio config here:=20
>>>>=20
>>>> http://odisoweb1.odiso.net/cephperf/=20
>>>>=20
>>>> test setup=20
>>>> -----------=20
>>>> client cpu config : 8 x Intel(R) Xeon(R) CPU E5-2603 v2 @ 1.80GHz=20
>>>> ceph cluster : 3 nodes (same cpu than client) with 2 osd each (int=
el ssd=20
>>>> s3500), test pool with replication x1=20
>>>> rbd volume size : 10G (almost all reads are done in osd buffer cac=
he)=20
>>>>=20
>>>> benchmark with fio 4k randread, with 1 rbd volume. (also tested wi=
th 20=20
>>>> rbd volumes, results are equals).=20
>>>> debian wheezy - kernel 3.17 - and ceph packages from master on=20
>>>> gitbuilder=20
>>>>=20
>>>> (BTW, I have installed librbd/rados dbg packages but I have missin=
g=20
>>>> symbols ?)=20
>>>=20
>>>=20
>>> I think if you run perf report with verbose enabled it will tell yo=
u=20
>>> which symbols are missing:=20
>>>=20
>>> perf report -v 2>&1 | less=20
>>>=20
>>> If you have them but it's not detecting them properly you can clean=
 out=20
>>> the cache or even manually reassign the symbols but it's annoying.=20
>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> Global results:=20
>>>> ---------------=20
>>>> librbd : 60000iops : 98% cpu=20
>>>> krbd : 90000iops : 32% cpu=20
>>>>=20
>>>>=20
>>>> So, librbd usage is 4,5x more than krbd for same ios throughput=20
>>>>=20
>>>> The difference seem to be quite huge, is it expected ?=20
>>>=20
>>>=20
>>> This is kind of the wild west. With that many IOPS we are running i=
nto=20
>>> new bottlenecks. :)=20
>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> librbd perf report:=20
>>>> -------------------------=20
>>>> top cpu usage=20
>>>> --------------=20
>>>> 25.71% fio libc-2.13.so=20
>>>> 17.69% fio librados.so.2.0.0=20
>>>> 12.38% fio librbd.so.1.0.0=20
>>>> 27.99% fio [kernel.kallsyms]=20
>>>> 4.19% fio libpthread-2.13.so=20
>>>>=20
>>>>=20
>>>> libc-2.13.so (seem that malloc/free use a lot of cpu here)=20
>>>> ------------=20
>>>> 21.05%-- _int_malloc=20
>>>> 14.36%-- free=20
>>>> 13.66%-- malloc=20
>>>> 9.89%-- __lll_unlock_wake_private=20
>>>> 5.35%-- __clone=20
>>>> 4.38%-- __poll=20
>>>> 3.77%-- __memcpy_ssse3=20
>>>> 1.64%-- vfprintf=20
>>>> 1.02%-- arena_get2=20
>>>>=20
>>>=20
>>> I think we need to figure out why so much time is being spent=20
>>> mallocing/freeing memory. Got to get those symbols resolved!=20
>>>=20
>>>> fio [kernel.kallsyms] : seem to have a lot of futex functions here=
=20
>>>> -----------------------=20
>>>> 5.27%-- _raw_spin_lock=20
>>>> 3.88%-- futex_wake=20
>>>> 2.88%-- __switch_to=20
>>>> 2.74%-- system_call=20
>>>> 2.70%-- __schedule=20
>>>> 2.52%-- tcp_sendmsg=20
>>>> 2.47%-- futex_wait_setup=20
>>>> 2.28%-- _raw_spin_lock_irqsave=20
>>>> 2.16%-- idle_cpu=20
>>>> 1.66%-- enqueue_task_fair=20
>>>> 1.57%-- native_write_msr_safe=20
>>>> 1.49%-- hash_futex=20
>>>> 1.46%-- futex_wait=20
>>>> 1.40%-- reschedule_interrupt=20
>>>> 1.37%-- try_to_wake_up=20
>>>> 1.28%-- account_entity_enqueue=20
>>>> 1.25%-- copy_user_enhanced_fast_string=20
>>>> 1.25%-- futex_requeue=20
>>>> 1.24%-- __fget=20
>>>> 1.24%-- update_curr=20
>>>> 1.20%-- tcp_write_xmit=20
>>>> 1.14%-- wake_futex=20
>>>> 1.08%-- scheduler_ipi=20
>>>> 1.05%-- select_task_rq_fair=20
>>>> 1.01%-- dequeue_task_fair=20
>>>> 0.97%-- do_futex=20
>>>> 0.97%-- futex_wait_queue_me=20
>>>> 0.83%-- cpuacct_charge=20
>>>> 0.82%-- tcp_transmit_skb=20
>>>> ...=20
>>>>=20
>>>>=20
>>>> Regards,=20
>>>>=20
>>>> Alexandre=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
>>> the body of a message to majordomo@vger.kernel.org=20
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>>=20
>>>=20
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20
Best Regards,=20

Wheat=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
