From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: slow fio random read benchmark, need help
Date: Thu, 1 Nov 2012 09:46:49 -0600
Message-ID: <CALFpzo7dMm2EUGh2-Tzx33+PFh=BqB342wE2mh_4dgmWAggsQA@mail.gmail.com>
References: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com>
	<0cc4e4a7-5f71-4579-8265-f97dc5cba341@mailpro>
	<24E144B8C0207547AD09C467A8259F7557707A07@lisa.maurer-it.com>
	<CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50708 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933080Ab2KAPwO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 11:52:14 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2685559oag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 08:52:14 -0700 (PDT)
In-Reply-To: <CAPYLRzi3i8C-uRyRKMgCxSag6ReANg+X5keSA43XGqbusrrRLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dietmar Maurer <dietmar@proxmox.com>, Josh Durgin <josh.durgin@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

In this case he's doing a direct random read, so the ios queue one at
a time on his various multipath channels. Be may have defined a depth
that sends a bunch at once, but they still get split up, he could run
a blktrace to verify. If they could merge he could maybe send
multiples, or perhaps he could change his multipathing io grouping or
RR io numbers but I don't suspect it would help.

Just to take this further, if I do his benchmark locally, I see that
it does a good job of keeping the queue full, but the ios are still
4k. They can't be merged, and they're sync (read), so they're issued
one at a time.

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00 6378.00    0.00 25512.00     0.00
8.00    45.49    5.87    5.87    0.00   0.16 100.00

If I do a blktrace ( I know you're not interested in pages of output,
but here are a few IOs), I see that the 4k IO (seen as sector number +
8 512b sectors) is issued (make_request =3D Q), then a new request
descriptor is allocated (G), then the block device queue is
plugged(P), then the request descriptor is inserted into the queue(I),
then the queue is unplugged so it can be proccessed, then the block
device driver kicks in and pops a single request off the queue, and
tells the disk controller to raise an interrupt whenever that is
completed.

So even though FIO is doing a good job of keeping the queue size high
as seen in iostat, the IOs are not merged and are issued to the device
driver in single file.
In this case, the point between D and whenever the interrupt is raised
and we see a "C" is subject to the latency of whatever is between our
driver and the actual data. You can see at the bottom that each one cam=
e
back in about 4-5 ms (4th column is timestamp).

  8,0    0    78905     1.932584450 10413  Q   R 34215048 + 8 [fio]
  8,0    0    78906     1.932586964 10413  G   R 34215048 + 8 [fio]
  8,0    0    78907     1.932589199 10413  P   N [fio]
  8,0    0    78908     1.932591713 10413  I   R 34215048 + 8 [fio]
  8,0    0    78909     1.932593948 10413  U   N [fio] 1
  8,0    0    78910     1.932596183 10413  D   R 34215048 + 8 [fio]

  8,0    0    78911     1.932659879 10413  Q   R 36222288 + 8 [fio]
  8,0    0    78912     1.932662393 10413  G   R 36222288 + 8 [fio]
  8,0    0    78913     1.932664907 10413  P   N [fio]
  8,0    0    78914     1.932667421 10413  I   R 36222288 + 8 [fio]
  8,0    0    78915     1.932669656 10413  U   N [fio] 1
  8,0    0    78916     1.932671891 10413  D   R 36222288 + 8 [fio]

  8,0    0    78918     1.932822469 10413  Q   R 2857800 + 8 [fio]
  8,0    0    78919     1.932827218 10413  G   R 2857800 + 8 [fio]
  8,0    0    78920     1.932829732 10413  P   N [fio]
  8,0    0    78921     1.932832247 10413  I   R 2857800 + 8 [fio]
  8,0    0    78922     1.932834482 10413  U   N [fio] 1
  8,0    0    78923     1.932836717 10413  D   R 2857800 + 8 [fio]

  8,0    0    78924     1.932902926 10413  Q   R 58687488 + 8 [fio]
  8,0    0    78925     1.932905440 10413  G   R 58687488 + 8 [fio]
  8,0    0    78926     1.932907675 10413  P   N [fio]
  8,0    0    78927     1.932910469 10413  I   R 58687488 + 8 [fio]
  8,0    0    78928     1.932912704 10413  U   N [fio] 1
  8,0    0    78929     1.932914939 10413  D   R 58687488 + 8 [fio]

  8,0    0    78930     1.932953212 10413  Q   R 31928168 + 8 [fio]
  8,0    0    78931     1.932956005 10413  G   R 31928168 + 8 [fio]
  8,0    0    78932     1.932958240 10413  P   N [fio]
  8,0    0    78933     1.932960755 10413  I   R 31928168 + 8 [fio]
  8,0    0    78934     1.932962990 10413  U   N [fio] 1
  8,0    0    78935     1.932965225 10413  D   R 31928168 + 8 [fio]

  8,0    0    79101     1.936660108     0  C   R 34215048 + 8 [0]

  8,0    0    79147     1.937862217     0  C   R 36222288 + 8 [0]

  8,0    0    79149     1.937944909     0  C   R 58687488 + 8 [0]

  8,0    0    79105     1.936713466     0  C   R 31928168 + 8 [0]


On Thu, Nov 1, 2012 at 4:40 AM, Gregory Farnum <greg@inktank.com> wrote=
:
> I'm not sure that latency addition is quite correct. Most use cases
> cases do multiple IOs at the same time, and good benchmarks tend to
> reflect that.
>
> I suspect the IO limitations here are a result of QEMU's storage
> handling (or possibly our client layer) more than anything else =97 J=
osh
> can talk about that more than I can, though!
> -Greg
>
> On Thu, Nov 1, 2012 at 8:38 AM, Dietmar Maurer <dietmar@proxmox.com> =
wrote:
>> I do not really understand that network latency argument.
>>
>> If one can get 40K iops with iSCSI, why can't I get the same with ra=
dos/ceph?
>>
>> Note: network latency is the same in both cases
>>
>> What do I miss?
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Alexandre DERUMIER
>>> Sent: Mittwoch, 31. Oktober 2012 18:27
>>> To: Marcus Sorensen
>>> Cc: Sage Weil; ceph-devel
>>> Subject: Re: slow fio random read benchmark, need help
>>>
>>> Thanks Marcus,
>>>
>>> indeed gigabit ethernet.
>>>
>>> note that my iscsi results  (40k)was with multipath, so multiple gi=
gabit links.
>>>
>>> I have also done tests with a netapp array, with nfs, single link, =
I'm around
>>> 13000 iops
>>>
>>> I will do more tests with multiples vms, from differents hosts, and=
 with --
>>> numjobs.
>>>
>>> I'll keep you in touch,
>>>
>>> Thanks for help,
>>>
>>> Regards,
>>>
>>> Alexandre
>>>
>>>
>>> ----- Mail original -----
>>>
>>> De: "Marcus Sorensen" <shadowsor@gmail.com>
>>> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
>>> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-
>>> devel@vger.kernel.org>
>>> Envoy=E9: Mercredi 31 Octobre 2012 18:08:11
>>> Objet: Re: slow fio random read benchmark, need help
>>>
>>> 5000 is actually really good, if you ask me. Assuming everything is=
 connected
>>> via gigabit. If you get 40k iops locally, you add the latency of tc=
p, as well as
>>> that of the ceph services and VM layer, and that's what you get. On=
 my
>>> network I get about a .1ms round trip on gigabit over the same swit=
ch, which
>>> by definition can only do 10,000 iops. Then if you have storage on =
the other
>>> end capable of 40k iops, you add the latencies together (.1ms + .02=
5ms) and
>>> you're at 8k iops.
>>> Then add the small latency of the application servicing the io (NFS=
, Ceph, etc),
>>> and the latency introduced by your VM layer, and 5k sounds about ri=
ght.
>>>
>>> The good news is that you probably aren't taxing the storage, you c=
an likely
>>> do many simultaneous tests from several VMs and get the same result=
s.
>>>
>>> You can try adding --numjobs to your fio to parallelize the specifi=
c test you're
>>> doing, or launching a second VM and doing the same test at the same=
 time.
>>> This would be a good indicator if it's latency.
>>>
>>> On Wed, Oct 31, 2012 at 10:29 AM, Alexandre DERUMIER
>>> <aderumier@odiso.com> wrote:
>>> >>>Have you tried increasing the iodepth?
>>> > Yes, I have try with 100 and 200, same results.
>>> >
>>> > I have also try directly from the host, with /dev/rbd1, and I hav=
e same
>>> result.
>>> > I have also try with 3 differents hosts, with differents cpus mod=
els.
>>> >
>>> > (note: I can reach around 40.000 iops with same fio config on a z=
fs
>>> > iscsi array)
>>> >
>>> > My test ceph cluster nodes cpus are old (xeon E5420), but they ar=
e around
>>> 10% usage, so I think it's ok.
>>> >
>>> >
>>> > Do you have an idea if I can trace something ?
>>> >
>>> > Thanks,
>>> >
>>> > Alexandre
>>> >
>>> > ----- Mail original -----
>>> >
>>> > De: "Sage Weil" <sage@inktank.com>
>>> > =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
>>> > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>>> > Envoy=E9: Mercredi 31 Octobre 2012 16:57:05
>>> > Objet: Re: slow fio random read benchmark, need help
>>> >
>>> > On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:
>>> >> Hello,
>>> >>
>>> >> I'm doing some tests with fio from a qemu 1.2 guest (virtio
>>> >> disk,cache=3Dnone), randread, with 4K block size on a small size=
 of 1G
>>> >> (so it can be handle by the buffer cache on ceph cluster)
>>> >>
>>> >>
>>> >> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000=
M
>>> >> --iodepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dlib=
aio
>>> >> --direct=3D1
>>> >>
>>> >>
>>> >> I can't get more than 5000 iops.
>>> >
>>> > Have you tried increasing the iodepth?
>>> >
>>> > sage
>>> >
>>> >>
>>> >>
>>> >> RBD cluster is :
>>> >> ---------------
>>> >> 3 nodes,with each node :
>>> >> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon
>>> >> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ rbd 0.53
>>> >>
>>> >> ceph.conf
>>> >>
>>> >> journal dio =3D false
>>> >> filestore fiemap =3D false
>>> >> filestore flusher =3D false
>>> >> osd op threads =3D 24
>>> >> osd disk threads =3D 24
>>> >> filestore op threads =3D 6
>>> >>
>>> >> kvm host is : 4 x 12 cores opteron
>>> >> ------------
>>> >>
>>> >>
>>> >> During the bench:
>>> >>
>>> >> on ceph nodes:
>>> >> - cpu is around 10% used
>>> >> - iostat show no disks activity on osds. (so I think that the 1G=
 file
>>> >> is handle in the linux buffer)
>>> >>
>>> >>
>>> >> on kvm host:
>>> >>
>>> >> -cpu is around 20% used
>>> >>
>>> >>
>>> >> I really don't see where is the bottleneck....
>>> >>
>>> >> Any Ideas, hints ?
>>> >>
>>> >>
>>> >> Regards,
>>> >>
>>> >> Alexandre
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>> >> in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>> >> info at http://vger.kernel.org/majordomo-info.html
>>> >>
>>> >>
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>>> > in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>> > info at http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in the
>>> body of a message to majordomo@vger.kernel.org More majordomo info =
at
>>> http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
