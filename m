From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 11:08:11 -0600
Message-ID: <CALFpzo70gX3RiZSO7+Szij9nRnLKruRvLiihFcmFugWPF9pGtA@mail.gmail.com>
References: <alpine.DEB.2.00.1210310856420.10356@cobra.newdream.net>
	<97eeb8be-85a7-4309-b02c-e5d4f5b0f151@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38627 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab2JaRIM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 13:08:12 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1105182wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 10:08:11 -0700 (PDT)
In-Reply-To: <97eeb8be-85a7-4309-b02c-e5d4f5b0f151@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

5000 is actually really good, if you ask me. Assuming everything is
connected via gigabit. If you get 40k iops locally, you add the
latency of tcp, as well as that of the ceph services and VM layer, and
that's what you get. On my network I get about a .1ms round trip on
gigabit over the same switch, which by definition can only do 10,000
iops. Then if you have storage on the other end capable of 40k iops,
you add the latencies together (.1ms + .025ms) and you're at 8k iops.
Then add the small latency of the application servicing the io (NFS,
Ceph, etc), and the latency introduced by your VM layer, and 5k sounds
about right.

The good news is that you probably aren't taxing the storage, you can
likely do many simultaneous tests from several VMs and get the same
results.

You can try adding --numjobs to your fio to parallelize the specific
test you're doing, or launching a second VM and doing the same test at
the same time. This would be a good indicator if it's latency.

On Wed, Oct 31, 2012 at 10:29 AM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
>>>Have you tried increasing the iodepth?
> Yes, I have try with 100 and 200, same results.
>
> I have also try directly from the host, with /dev/rbd1, and I have sa=
me result.
> I have also try with 3 differents hosts, with differents cpus models.
>
> (note: I can reach around 40.000 iops with same fio config on a zfs i=
scsi array)
>
> My test ceph cluster nodes cpus are old (xeon E5420), but they are ar=
ound 10% usage, so I think it's ok.
>
>
> Do you have an idea if I can trace something ?
>
> Thanks,
>
> Alexandre
>
> ----- Mail original -----
>
> De: "Sage Weil" <sage@inktank.com>
> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Envoy=E9: Mercredi 31 Octobre 2012 16:57:05
> Objet: Re: slow fio random read benchmark, need help
>
> On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:
>> Hello,
>>
>> I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,cac=
he=3Dnone), randread, with 4K block size on a small size of 1G (so it c=
an be handle by the buffer cache on ceph cluster)
>>
>>
>> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000M --=
iodepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dlibaio --dir=
ect=3D1
>>
>>
>> I can't get more than 5000 iops.
>
> Have you tried increasing the iodepth?
>
> sage
>
>>
>>
>> RBD cluster is :
>> ---------------
>> 3 nodes,with each node :
>> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon
>> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ
>> rbd 0.53
>>
>> ceph.conf
>>
>> journal dio =3D false
>> filestore fiemap =3D false
>> filestore flusher =3D false
>> osd op threads =3D 24
>> osd disk threads =3D 24
>> filestore op threads =3D 6
>>
>> kvm host is : 4 x 12 cores opteron
>> ------------
>>
>>
>> During the bench:
>>
>> on ceph nodes:
>> - cpu is around 10% used
>> - iostat show no disks activity on osds. (so I think that the 1G fil=
e is handle in the linux buffer)
>>
>>
>> on kvm host:
>>
>> -cpu is around 20% used
>>
>>
>> I really don't see where is the bottleneck....
>>
>> Any Ideas, hints ?
>>
>>
>> Regards,
>>
>> Alexandre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
