From: Haomai Wang <haomai@xsky.com>
Subject: Re: Re:Re:Re:Re: How does rbd-mirror preserve the order of WRITE
 operations that finished on the primary cluster
Date: Tue, 6 Jun 2017 11:13:48 +0800
Message-ID: <CACJqLyYVmvTuxz6rABvweFyM2++2TFf2q6n3-dzt6AfrpZyDKQ@mail.gmail.com>
References: <70c5c552.66e6.15c766dce68.Coremail.xxhdx1985126@163.com>
 <CA+aFP1B=M97rVtGcY=v79zg_2rS=+NNcO5FTT32yLCZtky7N7g@mail.gmail.com>
 <75e21ee8.f334.15c78f23929.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1706051616540.3646@piezo.novalocal>
 <428d3e79.3d2.15c7a56a64f.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1706052222060.3646@piezo.novalocal>
 <cdf481f.45b.15c7a741e28.Coremail.xxhdx1985126@163.com> <448ceff0.46ce.15c7b5c0b16.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0099.outbound.protection.outlook.com ([104.47.125.99]:26144
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751194AbdFFDN5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Jun 2017 23:13:57 -0400
Received: by mail-it0-f50.google.com with SMTP id m47so96266411iti.0
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jun 2017 20:13:54 -0700 (PDT)
In-Reply-To: <448ceff0.46ce.15c7b5c0b16.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: Sage Weil <sweil@redhat.com>, jdillama@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 6, 2017 at 11:04 AM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>
> I submitted an issue about three months ago: http://tracker.ceph.com/issu=
es/19252, in which I submitted part of my log.
>

what's your use case?
I noticed your first sentence "Recently, in our test, we found a
strange phenomenon: a READ req from client A that arrived later than a
WRITE req from client B is finished ealier than that WRITE req.".

Is it means the two requests from two client? if so, it's expected.

>
> At 2017-06-06 06:50:49, "xxhdx1985126" <xxhdx1985126@163.com> wrote:
>>
>>Thanks for your reply:-)
>>
>>The requeueing is protected by PG::lock, however, when the write request =
is add to the transaction queue, it's left for the journaling thread and fi=
lestore thread, to do the actual write, the OSD's worker thread just releas=
e the PG::lock and try to retrieve the next req in OSD's work queue, which =
gives the opportunity for later reqs to go before previous reqs. This did h=
appened in our experiment.
>>
>>However, since this experiment was done serveral month ago, I'll upload t=
he log if I can find it, or I'll try to reproduce it.
>>
>>At 2017-06-06 06:22:36, "Sage Weil" <sweil@redhat.com> wrote:
>>>On Tue, 6 Jun 2017, xxhdx1985126 wrote:
>>>> Thanks for your reply:-)
>>>>
>>>> The requeueing is protected by PG::lock, however, when the write reque=
st is
>>>> add to the transaction queue, it's left for the journaling thread and
>>>> filestore thread, to do the actual write, the OSD's worker thread just
>>>> release the PG::lock and try to retrieve the next req in OSD's work qu=
eue,
>>>> which gives the opportunity for later reqs to go before previous reqs.=
 This
>>>> did happened in our experiment.
>>>
>>>FileStore should also strictly order the requests via the OpSequencer.
>>>
>>>> However, since this experiment was done serveral month ago, I'll uploa=
d the
>>>> log if I can find it, or I'll try to reproduce it.
>>>
>>>Okay, thanks!
>>>
>>>sage
>>>
>>>
>>>>
>>>> At 2017-06-06 00:21:34, "Sage Weil" <sweil@redhat.com> wrote:
>>>> >On Mon, 5 Jun 2017, xxhdx1985126 wrote:
>>>> >>
>>>> >> Uh, sorry, I don't quite follow you. According to my understanding =
of
>>>> >> the source code of OSD and our experiment previously mentioned in
>>>> >> "https://www.mail-archive.com/ceph-users@lists.ceph.com/msg36178.ht=
ml",
>>>> >> there exists the following scenario where the actual finishing orde=
r of
>>>> >> the WRITEs that targets the same object is not the same as the orde=
r
>>>> >> they arrived at OSD, which, I think, could be a hint that the order=
 of
>>>> >> writes from a single client connection to a single OSD is not guran=
teed:
>>>> >
>>>> >If so, it is a bug that should be fixed in the OSD.  rbd-mirror relyi=
ng on
>>>> >OSD ordering to be correct is totally fine--lots of other stuff does =
too.
>>>> >
>>>> >>       Say three writes that targeting the same object A arrived at =
an
>>>> >> OSD in the order: "WRITE A.off 1", "WRITE A.off 2", "WRITE A.off 3"=
. The
>>>> >> first write, "WRITE A.off 1", acquires the objectcontext lock of ob=
ject
>>>> >> A, and is put into a transaction queue to go through the "journalin=
g +
>>>> >> file system write" procedure. Before it's finished, a thread of
>>>> >> OSD::osd_op_tp retrieved the second write and attempt to process it
>>>> >> during which it finds that the objectcontext lock of A is held by a
>>>> >> previous WRITE and put the second write into A's rwstate::waiters q=
ueue.
>>>> >> It's only when the first write is finished on all replica OSDs that=
 the
>>>> >> second write is put back into OSD::shardedop_wq to be processed aga=
in in
>>>> >> the future. If, after the second write is put into rwstate::waiters
>>>> >> queue and the first write is finished on all replica OSDs, in which=
 case
>>>> >> the first write release the A's objectcontext lock, but before the
>>>> >> second write is put back into OSD::shardedop_wq, the third write is
>>>> >> retrieved by OSD's worker thread, it would get processed as no prev=
ious
>>>> >> operation is holding A's objectcontext lock, in which case, the act=
ual
>>>> >> finishing order of the three writes is "WRITE A.off 1", "WRITE A.of=
f 3",
>>>> >> "WRITE A.off 2", which is different from the order they arrived.
>>>> >
>>>> >This should not happen.  (If it happened in the past, it was a bug, b=
ut I
>>>> >would expect it is fixed in the latest hammer point release, and in j=
ewel
>>>> >and master.)  The requeing is done under the PG::lock so that requeue=
ing
>>>> >preserves ordering.  A fair bit of code and a *lot* of testing goes i=
nto
>>>> >ensuring that this is true.  If you've seen this recently, then a
>>>> >reproducer or log (and tracker ticket) would be welcome!  When we see=
 any
>>>> >ordering errors in QA we take them very seriously and fix them quickl=
y.
>>>> >
>>>> >You might be interested in the osd_debug_op_order config option, whic=
h we
>>>> >enable in qa, which asserts if it sees ops from a client arrive out o=
f
>>>> >order.  The ceph_test_rados workload generate that we use for much of=
 the
>>>> >rados qa suite also fails if it sees out of order operations.
>>>> >
>>>> >sage
>>>> >
>>>> >>
>>>> >> In https://www.mail-archive.com/ceph-users@lists.ceph.com/msg36178.=
html,
>>>> we showed our experiment result which is exactly as the above scenario=
 shows
>>>> .
>>>> >>
>>>> >> However, the ceph's version on which we did the experiment and the =
souce
>>>> code of which we read was Hammer, 0.94.5. I don't know whether the sce=
nario
>>>> above may still exists in later versions.
>>>> >>
>>>> >> Am I right about this? Or am I missing anything? Please help me, I'=
m real
>>>> ly confused right now. Thank you.
>>>> >>
>>>> >> At 2017-06-05 20:00:06, "Jason Dillaman" <jdillama@redhat.com> wrot=
e:
>>>> >> >The order of writes from a single client connection to a single OS=
D is
>>>> >> >guaranteed. The rbd-mirror journal replay process handles one even=
t at
>>>> >> >a time and does not start processing the next event until the IO h=
as
>>>> >> >been started in-flight with librados. Therefore, even though the
>>>> >> >replay process allows 50 - 100 IO requests to be in-flight, those =
IOs
>>>> >> >are actually well-ordered in terms of updates to a single object.
>>>> >> >
>>>> >> >Of course, such an IO request from the client application / VM wou=
ld
>>>> >> >be incorrect behavior if they didn't wait for the completion callb=
ack
>>>> >> >before issuing the second update.
>>>> >> >
>>>> >> >On Mon, Jun 5, 2017 at 12:05 AM, xxhdx1985126 <xxhdx1985126@163.co=
m> wro
>>>> te:
>>>> >> >> Hi, everyone.
>>>> >> >>
>>>> >> >>
>>>> >> >> Recently, I've been reading the source code of rbd-mirror. I won=
der ho
>>>> w rbd-mirror preserves the order of WRITE operations that finished on =
the pr
>>>> imary cluster. As far as I can understand the code, rbd-mirror fetches=
 I/O o
>>>> perations from the journal on the primary cluster, and replay them on =
the sl
>>>> ave cluster without checking whether there's already any I/O operation=
s targ
>>>> eting the same object that has been issued to the slave cluster and no=
t yet
>>>> finished. Since concurrent operations may finish in a different order =
than t
>>>> hat in which they arrived at the OSD, the order that the WRITE operati=
ons fi
>>>> nish on the slave cluster may be different than that on the primay clu=
ster.
>>>> For example: on the primary cluster, there are two WRITE operation tar=
geting
>>>>  the same object A which are, in the order they finish on the primary =
cluste
>>>> r, "WRITE A.off data1" and "WRITE A.off data2"; while when they are re=
played
>>>>  on the slave cluster, the order may be "WRITE A.off data2" and "WRITE=
 A.off
>>>>  data1", wh
>>>> > ich means that the result of the two operations on the primary clust=
er is
>>>> A.off=3Ddata2 while, on the slave cluster, the result is A.off=3Ddata1=
.
>>>> >> >>
>>>> >> >>
>>>> >> >> Is this possible?
>>>> >> >>
>>>> >> >>
>>>> >> >>
>>>> >> >
>>>> >> >
>>>> >> >
>>>> >> >--
>>>> >> >Jason
>>>> >> N=E5=AB=A5=E5=8F=89=E9=9D=A3=E7=AC=A1y???=E6=B0=8Ab=E7=9E=82???=E5=
=8D=83v=E8=B1=9D???=E8=97=93{.n???=E5=A3=8F=E6=B8=AE=E6=A6=8Fz=E9=B3=90=E5=
=A6=A0ay???=E8=95=A0=E8=B7=88???j???f=EF=BC=82=E7=A9=90=E6=AE=9D=E9=84=97
>>>> ???=E7=95=90=E3=82=A2???=E2=92=8E???:+v=E5=A2=BE=E5=A6=9B=E9=91=9A=E8=
=B1=B0=E7=A8=9B???=E7=8F=A3=E8=B5=99zZ+=E5=87=92=E6=AE=A0=E5=A8=B8???"=E6=
=BF=9F!=E7=A7=88
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>
>
>
>
