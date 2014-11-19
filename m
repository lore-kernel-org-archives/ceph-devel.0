From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: client cpu usage : kbrd vs librbd perf report
Date: Wed, 19 Nov 2014 06:40:42 -0600
Message-ID: <546C8FCA.7070500@redhat.com>
References: <48f230d2-8905-42df-a4e5-610ae968581c@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:44349 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbaKSMko (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Nov 2014 07:40:44 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so345588iec.8
        for <ceph-devel@vger.kernel.org>; Wed, 19 Nov 2014 04:40:43 -0800 (PST)
In-Reply-To: <48f230d2-8905-42df-a4e5-610ae968581c@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Somnath Roy <somnath.roy@sandisk.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Mark Nelson <mark.nelson@inktank.com>

Please do!

Mark

On 11/19/2014 01:29 AM, Alexandre DERUMIER wrote:
> Hi,
>
> Can I make a tracker for this ?
>
> ----- Mail original -----
>
> De: "Haomai Wang" <haomaiwang@gmail.com>
> =C3=80: "Mark Nelson" <mark.nelson@inktank.com>
> Cc: "Sage Weil" <sage@newdream.net>, "Alexandre DERUMIER" <aderumier@=
odiso.com>, "Somnath Roy" <somnath.roy@sandisk.com>, "Ceph Devel" <ceph=
-devel@vger.kernel.org>
> Envoy=C3=A9: Jeudi 13 Novembre 2014 19:15:24
> Objet: Re: client cpu usage : kbrd vs librbd perf report
>
> Hmm, I think it's a good perf topic to discuss about buffer
> alloc/dealloc. For example, maybe frequency alloced object can use
> memory pool(each pool stores the same objects), but the most challeng=
e
> to this is also STL structures.
>
> On Fri, Nov 14, 2014 at 1:05 AM, Mark Nelson <mark.nelson@inktank.com=
> wrote:
>> On 11/13/2014 10:29 AM, Sage Weil wrote:
>>>
>>> On Thu, 13 Nov 2014, Alexandre DERUMIER wrote:
>>>>>>
>>>>>> I think we need to figure out why so much time is being spent
>>>>>> mallocing/freeing memory. Got to get those symbols resolved!
>>>>
>>>>
>>>> Ok, I don't known why, but if I remove all ceph -dbg packages, I'm=
 seeing
>>>> the rbd && rados symbols now...
>>>>
>>>> I have udpdate the files:
>>>>
>>>> http://odisoweb1.odiso.net/cephperf/perf-librbd/report.txt
>>>
>>>
>>> Ran it through c++filt:
>>>
>>> https://gist.github.com/88ba9409f5d201b957a1
>>>
>>> I'm a bit suprised by the some of the items near the top
>>> (bufferlist.clear() callers). I'm sure several of those can be
>>> streamlined to avoid temporary bufferlists. I don't see any super
>>> egregious users of the allocator, though.
>>>
>>> The memcpy callers might be a good place to start...
>>>
>>> sage
>>
>>
>> Wasn't josh looking into some of this a year ago? Did anything ever =
come of
>> that work?
>>
>>
>>>
>>>
>>>
>>>
>>>
>>>>
>>>>
>>>>
>>>>
>>>> ----- Mail original -----
>>>>
>>>> De: "Mark Nelson" <mark.nelson@inktank.com>
>>>> ?: "Alexandre DERUMIER" <aderumier@odiso.com>, "Ceph Devel"
>>>> <ceph-devel@vger.kernel.org>
>>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Sage Weil"
>>>> <sweil@redhat.com>, "Somnath Roy" <somnath.roy@sandisk.com>
>>>> Envoy?: Jeudi 13 Novembre 2014 15:20:40
>>>> Objet: Re: client cpu usage : kbrd vs librbd perf report
>>>>
>>>> On 11/13/2014 05:15 AM, Alexandre DERUMIER wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I have redone perf with dwarf
>>>>>
>>>>> perf record -g --call-graph dwarf -a -F 99 -- sleep 60
>>>>>
>>>>> I have put perf reports, ceph conf, fio config here:
>>>>>
>>>>> http://odisoweb1.odiso.net/cephperf/
>>>>>
>>>>> test setup
>>>>> -----------
>>>>> client cpu config : 8 x Intel(R) Xeon(R) CPU E5-2603 v2 @ 1.80GHz
>>>>> ceph cluster : 3 nodes (same cpu than client) with 2 osd each (in=
tel ssd
>>>>> s3500), test pool with replication x1
>>>>> rbd volume size : 10G (almost all reads are done in osd buffer ca=
che)
>>>>>
>>>>> benchmark with fio 4k randread, with 1 rbd volume. (also tested w=
ith 20
>>>>> rbd volumes, results are equals).
>>>>> debian wheezy - kernel 3.17 - and ceph packages from master on
>>>>> gitbuilder
>>>>>
>>>>> (BTW, I have installed librbd/rados dbg packages but I have missi=
ng
>>>>> symbols ?)
>>>>
>>>>
>>>> I think if you run perf report with verbose enabled it will tell y=
ou
>>>> which symbols are missing:
>>>>
>>>> perf report -v 2>&1 | less
>>>>
>>>> If you have them but it's not detecting them properly you can clea=
n out
>>>> the cache or even manually reassign the symbols but it's annoying.
>>>>
>>>>>
>>>>>
>>>>>
>>>>> Global results:
>>>>> ---------------
>>>>> librbd : 60000iops : 98% cpu
>>>>> krbd : 90000iops : 32% cpu
>>>>>
>>>>>
>>>>> So, librbd usage is 4,5x more than krbd for same ios throughput
>>>>>
>>>>> The difference seem to be quite huge, is it expected ?
>>>>
>>>>
>>>> This is kind of the wild west. With that many IOPS we are running =
into
>>>> new bottlenecks. :)
>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> librbd perf report:
>>>>> -------------------------
>>>>> top cpu usage
>>>>> --------------
>>>>> 25.71% fio libc-2.13.so
>>>>> 17.69% fio librados.so.2.0.0
>>>>> 12.38% fio librbd.so.1.0.0
>>>>> 27.99% fio [kernel.kallsyms]
>>>>> 4.19% fio libpthread-2.13.so
>>>>>
>>>>>
>>>>> libc-2.13.so (seem that malloc/free use a lot of cpu here)
>>>>> ------------
>>>>> 21.05%-- _int_malloc
>>>>> 14.36%-- free
>>>>> 13.66%-- malloc
>>>>> 9.89%-- __lll_unlock_wake_private
>>>>> 5.35%-- __clone
>>>>> 4.38%-- __poll
>>>>> 3.77%-- __memcpy_ssse3
>>>>> 1.64%-- vfprintf
>>>>> 1.02%-- arena_get2
>>>>>
>>>>
>>>> I think we need to figure out why so much time is being spent
>>>> mallocing/freeing memory. Got to get those symbols resolved!
>>>>
>>>>> fio [kernel.kallsyms] : seem to have a lot of futex functions her=
e
>>>>> -----------------------
>>>>> 5.27%-- _raw_spin_lock
>>>>> 3.88%-- futex_wake
>>>>> 2.88%-- __switch_to
>>>>> 2.74%-- system_call
>>>>> 2.70%-- __schedule
>>>>> 2.52%-- tcp_sendmsg
>>>>> 2.47%-- futex_wait_setup
>>>>> 2.28%-- _raw_spin_lock_irqsave
>>>>> 2.16%-- idle_cpu
>>>>> 1.66%-- enqueue_task_fair
>>>>> 1.57%-- native_write_msr_safe
>>>>> 1.49%-- hash_futex
>>>>> 1.46%-- futex_wait
>>>>> 1.40%-- reschedule_interrupt
>>>>> 1.37%-- try_to_wake_up
>>>>> 1.28%-- account_entity_enqueue
>>>>> 1.25%-- copy_user_enhanced_fast_string
>>>>> 1.25%-- futex_requeue
>>>>> 1.24%-- __fget
>>>>> 1.24%-- update_curr
>>>>> 1.20%-- tcp_write_xmit
>>>>> 1.14%-- wake_futex
>>>>> 1.08%-- scheduler_ipi
>>>>> 1.05%-- select_task_rq_fair
>>>>> 1.01%-- dequeue_task_fair
>>>>> 0.97%-- do_futex
>>>>> 0.97%-- futex_wait_queue_me
>>>>> 0.83%-- cpuacct_charge
>>>>> 0.82%-- tcp_transmit_skb
>>>>> ...
>>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Alexandre
>>>>>
>>>>>
>>>>>
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
