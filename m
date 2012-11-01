From: Gregory Farnum <greg@inktank.com>
Subject: Re: slow fio random read benchmark, need help
Date: Thu, 1 Nov 2012 11:40:18 +0100
Message-ID: <CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
References: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com>
	<0cc4e4a7-5f71-4579-8265-f97dc5cba341@mailpro>
	<24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58701 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2KAKkU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 06:40:20 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3367059iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 03:40:19 -0700 (PDT)
In-Reply-To: <24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

I'm not sure that latency addition is quite correct. Most use cases
cases do multiple IOs at the same time, and good benchmarks tend to
reflect that.

I suspect the IO limitations here are a result of QEMU's storage
handling (or possibly our client layer) more than anything else =97=A0J=
osh
can talk about that more than I can, though!
-Greg

On Thu, Nov 1, 2012 at 8:38 AM, Dietmar Maurer <dietmar@proxmox.com> wr=
ote:
> I do not really understand that network latency argument.
>
> If one can get 40K iops with iSCSI, why can't I get the same with rad=
os/ceph?
>
> Note: network latency is the same in both cases
>
> What do I miss?
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Alexandre DERUMIER
>> Sent: Mittwoch, 31. Oktober 2012 18:27
>> To: Marcus Sorensen
>> Cc: Sage Weil; ceph-devel
>> Subject: Re: slow fio random read benchmark, need help
>>
>> Thanks Marcus,
>>
>> indeed gigabit ethernet.
>>
>> note that my iscsi results  (40k)was with multipath, so multiple gig=
abit links.
>>
>> I have also done tests with a netapp array, with nfs, single link, I=
'm around
>> 13000 iops
>>
>> I will do more tests with multiples vms, from differents hosts, and =
with --
>> numjobs.
>>
>> I'll keep you in touch,
>>
>> Thanks for help,
>>
>> Regards,
>>
>> Alexandre
>>
>>
>> ----- Mail original -----
>>
>> De: "Marcus Sorensen" <shadowsor@gmail.com>
>> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
>> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-
>> devel@vger.kernel.org>
>> Envoy=E9: Mercredi 31 Octobre 2012 18:08:11
>> Objet: Re: slow fio random read benchmark, need help
>>
>> 5000 is actually really good, if you ask me. Assuming everything is =
connected
>> via gigabit. If you get 40k iops locally, you add the latency of tcp=
, as well as
>> that of the ceph services and VM layer, and that's what you get. On =
my
>> network I get about a .1ms round trip on gigabit over the same switc=
h, which
>> by definition can only do 10,000 iops. Then if you have storage on t=
he other
>> end capable of 40k iops, you add the latencies together (.1ms + .025=
ms) and
>> you're at 8k iops.
>> Then add the small latency of the application servicing the io (NFS,=
 Ceph, etc),
>> and the latency introduced by your VM layer, and 5k sounds about rig=
ht.
>>
>> The good news is that you probably aren't taxing the storage, you ca=
n likely
>> do many simultaneous tests from several VMs and get the same results=
=2E
>>
>> You can try adding --numjobs to your fio to parallelize the specific=
 test you're
>> doing, or launching a second VM and doing the same test at the same =
time.
>> This would be a good indicator if it's latency.
>>
>> On Wed, Oct 31, 2012 at 10:29 AM, Alexandre DERUMIER
>> <aderumier@odiso.com> wrote:
>> >>>Have you tried increasing the iodepth?
>> > Yes, I have try with 100 and 200, same results.
>> >
>> > I have also try directly from the host, with /dev/rbd1, and I have=
 same
>> result.
>> > I have also try with 3 differents hosts, with differents cpus mode=
ls.
>> >
>> > (note: I can reach around 40.000 iops with same fio config on a zf=
s
>> > iscsi array)
>> >
>> > My test ceph cluster nodes cpus are old (xeon E5420), but they are=
 around
>> 10% usage, so I think it's ok.
>> >
>> >
>> > Do you have an idea if I can trace something ?
>> >
>> > Thanks,
>> >
>> > Alexandre
>> >
>> > ----- Mail original -----
>> >
>> > De: "Sage Weil" <sage@inktank.com>
>> > =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
>> > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> > Envoy=E9: Mercredi 31 Octobre 2012 16:57:05
>> > Objet: Re: slow fio random read benchmark, need help
>> >
>> > On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:
>> >> Hello,
>> >>
>> >> I'm doing some tests with fio from a qemu 1.2 guest (virtio
>> >> disk,cache=3Dnone), randread, with 4K block size on a small size =
of 1G
>> >> (so it can be handle by the buffer cache on ceph cluster)
>> >>
>> >>
>> >> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000M
>> >> --iodepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dliba=
io
>> >> --direct=3D1
>> >>
>> >>
>> >> I can't get more than 5000 iops.
>> >
>> > Have you tried increasing the iodepth?
>> >
>> > sage
>> >
>> >>
>> >>
>> >> RBD cluster is :
>> >> ---------------
>> >> 3 nodes,with each node :
>> >> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon
>> >> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ rbd 0.53
>> >>
>> >> ceph.conf
>> >>
>> >> journal dio =3D false
>> >> filestore fiemap =3D false
>> >> filestore flusher =3D false
>> >> osd op threads =3D 24
>> >> osd disk threads =3D 24
>> >> filestore op threads =3D 6
>> >>
>> >> kvm host is : 4 x 12 cores opteron
>> >> ------------
>> >>
>> >>
>> >> During the bench:
>> >>
>> >> on ceph nodes:
>> >> - cpu is around 10% used
>> >> - iostat show no disks activity on osds. (so I think that the 1G =
file
>> >> is handle in the linux buffer)
>> >>
>> >>
>> >> on kvm host:
>> >>
>> >> -cpu is around 20% used
>> >>
>> >>
>> >> I really don't see where is the bottleneck....
>> >>
>> >> Any Ideas, hints ?
>> >>
>> >>
>> >> Regards,
>> >>
>> >> Alexandre
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>> >> in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> >> info at http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>> > in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> > info at http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
