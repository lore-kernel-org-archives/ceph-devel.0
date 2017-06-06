From: Haomai Wang <haomai@xsky.com>
Subject: Re: Re:Re: Re:Re:Re:Re: How does rbd-mirror preserve the order of
 WRITE operations that finished on the primary cluster
Date: Tue, 6 Jun 2017 15:49:07 +0800
Message-ID: <CACJqLyaKv3TvkFopog0mkGCyDqOaC-9ZcgPnPgYMvNRiW3DWCg@mail.gmail.com>
References: <70c5c552.66e6.15c766dce68.Coremail.xxhdx1985126@163.com>
 <CA+aFP1B=M97rVtGcY=v79zg_2rS=+NNcO5FTT32yLCZtky7N7g@mail.gmail.com>
 <75e21ee8.f334.15c78f23929.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1706051616540.3646@piezo.novalocal>
 <428d3e79.3d2.15c7a56a64f.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1706052222060.3646@piezo.novalocal>
 <cdf481f.45b.15c7a741e28.Coremail.xxhdx1985126@163.com> <448ceff0.46ce.15c7b5c0b16.Coremail.xxhdx1985126@163.com>
 <CACJqLyYVmvTuxz6rABvweFyM2++2TFf2q6n3-dzt6AfrpZyDKQ@mail.gmail.com>
 <344a1254.5a75.15c7b942fa4.Coremail.xxhdx1985126@163.com> <762fe21a.9068.15c7c58f41b.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0100.outbound.protection.outlook.com ([104.47.125.100]:43264
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751285AbdFFHtV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Jun 2017 03:49:21 -0400
Received: by mail-it0-f51.google.com with SMTP id m47so100991814iti.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 00:49:16 -0700 (PDT)
In-Reply-To: <762fe21a.9068.15c7c58f41b.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: Sage Weil <sweil@redhat.com>, jdillama@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 6, 2017 at 3:40 PM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>
> Uh, sorry, my fault. OSD does treat requests from different clients seper=
ately.
>
> By the way, I've a further question. Say, there is a write operation: WRI=
TE(objA.off=3D3, objB.off=3D4), if, due to some reason(primary cluster's OS=
D failure, for example), the "objB" part of the operation can not be replic=
ated to slave cluster, can the "objA" part and non-objB part of subsequent =
writes that involve objB still be replicated?

librados only support object-level transaction

>
> At 2017-06-06 12:05:28, "xxhdx1985126" <xxhdx1985126@163.com> wrote:
>>
>>Yes, it is from two clients, but it looks to me that OSD treats requests =
from different clients uniformly. So I think, in the scenario of rbd-mirror=
, requests from the same rbd-mirror instance can also get disordered.
>>
>>
>>At 2017-06-06 11:13:48, "Haomai Wang" <haomai@xsky.com> wrote:
>>>On Tue, Jun 6, 2017 at 11:04 AM, xxhdx1985126 <xxhdx1985126@163.com> wro=
te:
>>>>
>>>> I submitted an issue about three months ago: http://tracker.ceph.com/i=
ssues/19252, in which I submitted part of my log.
>>>>
>>>
>>>what's your use case?
>>>I noticed your first sentence "Recently, in our test, we found a
>>>strange phenomenon: a READ req from client A that arrived later than a
>>>WRITE req from client B is finished ealier than that WRITE req.".
>>>
>>>Is it means the two requests from two client? if so, it's expected.
>>>
>>>>
>>>> At 2017-06-06 06:50:49, "xxhdx1985126" <xxhdx1985126@163.com> wrote:
>>>>>
>>>>>Thanks for your reply:-)
>>>>>
>>>>>The requeueing is protected by PG::lock, however, when the write reque=
st is add to the transaction queue, it's left for the journaling thread and=
 filestore thread, to do the actual write, the OSD's worker thread just rel=
ease the PG::lock and try to retrieve the next req in OSD's work queue, whi=
ch gives the opportunity for later reqs to go before previous reqs. This di=
d happened in our experiment.
>>>>>
>>>>>However, since this experiment was done serveral month ago, I'll uploa=
d the log if I can find it, or I'll try to reproduce it.
>>>>>
>>>>>At 2017-06-06 06:22:36, "Sage Weil" <sweil@redhat.com> wrote:
>>>>>>On Tue, 6 Jun 2017, xxhdx1985126 wrote:
>>>>>>> Thanks for your reply:-)
>>>>>>>
>>>>>>> The requeueing is protected by PG::lock, however, when the write re=
quest is
>>>>>>> add to the transaction queue, it's left for the journaling thread a=
nd
>>>>>>> filestore thread, to do the actual write, the OSD's worker thread j=
ust
>>>>>>> release the PG::lock and try to retrieve the next req in OSD's work=
 queue,
>>>>>>> which gives the opportunity for later reqs to go before previous re=
qs. This
>>>>>>> did happened in our experiment.
>>>>>>
>>>>>>FileStore should also strictly order the requests via the OpSequencer=
.
>>>>>>
>>>>>>> However, since this experiment was done serveral month ago, I'll up=
load the
>>>>>>> log if I can find it, or I'll try to reproduce it.
>>>>>>
>>>>>>Okay, thanks!
>>>>>>
>>>>>>sage
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> At 2017-06-06 00:21:34, "Sage Weil" <sweil@redhat.com> wrote:
>>>>>>> >On Mon, 5 Jun 2017, xxhdx1985126 wrote:
>>>>>>> >>
>>>>>>> >> Uh, sorry, I don't quite follow you. According to my understandi=
ng of
>>>>>>> >> the source code of OSD and our experiment previously mentioned i=
n
>>>>>>> >> "https://www.mail-archive.com/ceph-users@lists.ceph.com/msg36178=
.html",
>>>>>>> >> there exists the following scenario where the actual finishing o=
rder of
>>>>>>> >> the WRITEs that targets the same object is not the same as the o=
rder
>>>>>>> >> they arrived at OSD, which, I think, could be a hint that the or=
der of
>>>>>>> >> writes from a single client connection to a single OSD is not gu=
ranteed:
>>>>>>> >
>>>>>>> >If so, it is a bug that should be fixed in the OSD.  rbd-mirror re=
lying on
>>>>>>> >OSD ordering to be correct is totally fine--lots of other stuff do=
es too.
>>>>>>> >
>>>>>>> >>       Say three writes that targeting the same object A arrived =
at an
>>>>>>> >> OSD in the order: "WRITE A.off 1", "WRITE A.off 2", "WRITE A.off=
 3". The
>>>>>>> >> first write, "WRITE A.off 1", acquires the objectcontext lock of=
 object
>>>>>>> >> A, and is put into a transaction queue to go through the "journa=
ling +
>>>>>>> >> file system write" procedure. Before it's finished, a thread of
>>>>>>> >> OSD::osd_op_tp retrieved the second write and attempt to process=
 it
>>>>>>> >> during which it finds that the objectcontext lock of A is held b=
y a
>>>>>>> >> previous WRITE and put the second write into A's rwstate::waiter=
s queue.
>>>>>>> >> It's only when the first write is finished on all replica OSDs t=
hat the
>>>>>>> >> second write is put back into OSD::shardedop_wq to be processed =
again in
>>>>>>> >> the future. If, after the second write is put into rwstate::wait=
ers
>>>>>>> >> queue and the first write is finished on all replica OSDs, in wh=
ich case
>>>>>>> >> the first write release the A's objectcontext lock, but before t=
he
>>>>>>> >> second write is put back into OSD::shardedop_wq, the third write=
 is
>>>>>>> >> retrieved by OSD's worker thread, it would get processed as no p=
revious
>>>>>>> >> operation is holding A's objectcontext lock, in which case, the =
actual
>>>>>>> >> finishing order of the three writes is "WRITE A.off 1", "WRITE A=
.off 3",
>>>>>>> >> "WRITE A.off 2", which is different from the order they arrived.
>>>>>>> >
>>>>>>> >This should not happen.  (If it happened in the past, it was a bug=
, but I
>>>>>>> >would expect it is fixed in the latest hammer point release, and i=
n jewel
>>>>>>> >and master.)  The requeing is done under the PG::lock so that requ=
eueing
>>>>>>> >preserves ordering.  A fair bit of code and a *lot* of testing goe=
s into
>>>>>>> >ensuring that this is true.  If you've seen this recently, then a
>>>>>>> >reproducer or log (and tracker ticket) would be welcome!  When we =
see any
>>>>>>> >ordering errors in QA we take them very seriously and fix them qui=
ckly.
>>>>>>> >
>>>>>>> >You might be interested in the osd_debug_op_order config option, w=
hich we
>>>>>>> >enable in qa, which asserts if it sees ops from a client arrive ou=
t of
>>>>>>> >order.  The ceph_test_rados workload generate that we use for much=
 of the
>>>>>>> >rados qa suite also fails if it sees out of order operations.
>>>>>>> >
>>>>>>> >sage
>>>>>>> >
>>>>>>> >>
>>>>>>> >> In https://www.mail-archive.com/ceph-users@lists.ceph.com/msg361=
78.html,
>>>>>>> we showed our experiment result which is exactly as the above scena=
rio shows
>>>>>>> .
>>>>>>> >>
>>>>>>> >> However, the ceph's version on which we did the experiment and t=
he souce
>>>>>>> code of which we read was Hammer, 0.94.5. I don't know whether the =
scenario
>>>>>>> above may still exists in later versions.
>>>>>>> >>
>>>>>>> >> Am I right about this? Or am I missing anything? Please help me,=
 I'm real
>>>>>>> ly confused right now. Thank you.
>>>>>>> >>
>>>>>>> >> At 2017-06-05 20:00:06, "Jason Dillaman" <jdillama@redhat.com> w=
rote:
>>>>>>> >> >The order of writes from a single client connection to a single=
 OSD is
>>>>>>> >> >guaranteed. The rbd-mirror journal replay process handles one e=
vent at
>>>>>>> >> >a time and does not start processing the next event until the I=
O has
>>>>>>> >> >been started in-flight with librados. Therefore, even though th=
e
>>>>>>> >> >replay process allows 50 - 100 IO requests to be in-flight, tho=
se IOs
>>>>>>> >> >are actually well-ordered in terms of updates to a single objec=
t.
>>>>>>> >> >
>>>>>>> >> >Of course, such an IO request from the client application / VM =
would
>>>>>>> >> >be incorrect behavior if they didn't wait for the completion ca=
llback
>>>>>>> >> >before issuing the second update.
>>>>>>> >> >
>>>>>>> >> >On Mon, Jun 5, 2017 at 12:05 AM, xxhdx1985126 <xxhdx1985126@163=
.com> wro
>>>>>>> te:
>>>>>>> >> >> Hi, everyone.
>>>>>>> >> >>
>>>>>>> >> >>
>>>>>>> >> >> Recently, I've been reading the source code of rbd-mirror. I =
wonder ho
>>>>>>> w rbd-mirror preserves the order of WRITE operations that finished =
on the pr
>>>>>>> imary cluster. As far as I can understand the code, rbd-mirror fetc=
hes I/O o
>>>>>>> perations from the journal on the primary cluster, and replay them =
on the sl
>>>>>>> ave cluster without checking whether there's already any I/O operat=
ions targ
>>>>>>> eting the same object that has been issued to the slave cluster and=
 not yet
>>>>>>> finished. Since concurrent operations may finish in a different ord=
er than t
>>>>>>> hat in which they arrived at the OSD, the order that the WRITE oper=
ations fi
>>>>>>> nish on the slave cluster may be different than that on the primay =
cluster.
>>>>>>> For example: on the primary cluster, there are two WRITE operation =
targeting
>>>>>>>  the same object A which are, in the order they finish on the prima=
ry cluste
>>>>>>> r, "WRITE A.off data1" and "WRITE A.off data2"; while when they are=
 replayed
>>>>>>>  on the slave cluster, the order may be "WRITE A.off data2" and "WR=
ITE A.off
>>>>>>>  data1", wh
>>>>>>> > ich means that the result of the two operations on the primary cl=
uster is
>>>>>>> A.off=3Ddata2 while, on the slave cluster, the result is A.off=3Dda=
ta1.
>>>>>>> >> >>
>>>>>>> >> >>
>>>>>>> >> >> Is this possible?
>>>>>>> >> >>
>>>>>>> >> >>
>>>>>>> >> >>
>>>>>>> >> >
>>>>>>> >> >
>>>>>>> >> >
>>>>>>> >> >--
>>>>>>> >> >Jason
>>>>>>> >> N=E5=AB=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y???=E6=B0=8Ab=E7=9E=82???=
=E5=8D=83v=E8=B1=9D???=E8=97=93{.n???=E5=A3=8F=E6=B8=AE=E6=A6=8Fz=E9=B3=90=
=E5=A6=A0ay???=E8=95=A0=E8=B7=88???j???f=EF=BC=82=E7=A9=90=E6=AE=9D=E9=84=
=97
>>>>>>> ???=E7=95=90=E3=82=A2???=E2=92=8E???:+v=E5=A2=BE=E5=A6=9B=E9=91=9A=
=E8=B1=B0=E7=A8=9B???=E7=8F=A3=E8=B5=99zZ+=E5=87=92=E6=AE=A0=E5=A8=B8???"=
=E6=BF=9F!=E7=A7=88
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>
>>>>
>>>>
>>>>
>>
>>
>>
>>
