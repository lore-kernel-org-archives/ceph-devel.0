From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 19:56:33 +0100 (CET)
Message-ID: <8be796b6-f1c1-43ed-abe8-ec06b62c7e84@mailpro>
References: <CALFpzo4m_jQfmmwPPeX7hdv3YmcZ3Ozm8S4NtZTwi6KmJaY7MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38018 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759898Ab2JaS5E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 14:57:04 -0400
In-Reply-To: <CALFpzo4m_jQfmmwPPeX7hdv3YmcZ3Ozm8S4NtZTwi6KmJaY7MQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes, I think you are right, round trip with mon must cut by half the pe=
rformance.

I have just done test with 2 parallel fio bench, from 2 differents host=
,
I get 2 x 5000 iops

so it must be related to network latency.

I have also done tests with --numjob 1000, it doesn't help, same result=
s.


Do you have an idea how I can have more io from 1 host ?
Doing lacp with multiple links ?

I think that 10gigabit latency is almost same, i'm not sure it will imp=
rove iops too much
Maybe InfiniBand can help?

----- Mail original -----=20

De: "Marcus Sorensen" <shadowsor@gmail.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-devel@vger.kerne=
l.org>=20
Envoy=C3=A9: Mercredi 31 Octobre 2012 18:38:46=20
Objet: Re: slow fio random read benchmark, need help=20

Yes, I was going to say that the most I've ever seen out of gigabit is=20
about 15k iops, with parallel tests and NFS (or iSCSI). Multipathing=20
may not really parallelize the io for you. It can send an io down one=20
path, then move to the next path and send the next io without=20
necessarily waiting for the previous one to respond, but it only=20
shaves a slight amount from your latency under some scenarios as=20
opposed to sending down all paths simultaneously. I have seen it help=20
with high latency links.=20

I don't remember the Ceph design that well, but with distributed=20
storage systems you're going to pay a penalty. If you can do 10-15k=20
with one TCP round trip, you'll get half that with the round trip to=20
talk to the metadata server to find your blocks and then to fetch=20
them. Like I said, that might not be exactly what Ceph does, but=20
you're going to have more traffic than just a straight single attached=20
NFS or iscsi server.=20

On Wed, Oct 31, 2012 at 11:27 AM, Alexandre DERUMIER=20
<aderumier@odiso.com> wrote:=20
> Thanks Marcus,=20
>=20
> indeed gigabit ethernet.=20
>=20
> note that my iscsi results (40k)was with multipath, so multiple gigab=
it links.=20
>=20
> I have also done tests with a netapp array, with nfs, single link, I'=
m around 13000 iops=20
>=20
> I will do more tests with multiples vms, from differents hosts, and w=
ith --numjobs.=20
>=20
> I'll keep you in touch,=20
>=20
> Thanks for help,=20
>=20
> Regards,=20
>=20
> Alexandre=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Marcus Sorensen" <shadowsor@gmail.com>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-devel@vger.ker=
nel.org>=20
> Envoy=C3=A9: Mercredi 31 Octobre 2012 18:08:11=20
> Objet: Re: slow fio random read benchmark, need help=20
>=20
> 5000 is actually really good, if you ask me. Assuming everything is=20
> connected via gigabit. If you get 40k iops locally, you add the=20
> latency of tcp, as well as that of the ceph services and VM layer, an=
d=20
> that's what you get. On my network I get about a .1ms round trip on=20
> gigabit over the same switch, which by definition can only do 10,000=20
> iops. Then if you have storage on the other end capable of 40k iops,=20
> you add the latencies together (.1ms + .025ms) and you're at 8k iops.=
=20
> Then add the small latency of the application servicing the io (NFS,=20
> Ceph, etc), and the latency introduced by your VM layer, and 5k sound=
s=20
> about right.=20
>=20
> The good news is that you probably aren't taxing the storage, you can=
=20
> likely do many simultaneous tests from several VMs and get the same=20
> results.=20
>=20
> You can try adding --numjobs to your fio to parallelize the specific=20
> test you're doing, or launching a second VM and doing the same test a=
t=20
> the same time. This would be a good indicator if it's latency.=20
>=20
> On Wed, Oct 31, 2012 at 10:29 AM, Alexandre DERUMIER=20
> <aderumier@odiso.com> wrote:=20
>>>>Have you tried increasing the iodepth?=20
>> Yes, I have try with 100 and 200, same results.=20
>>=20
>> I have also try directly from the host, with /dev/rbd1, and I have s=
ame result.=20
>> I have also try with 3 differents hosts, with differents cpus models=
=2E=20
>>=20
>> (note: I can reach around 40.000 iops with same fio config on a zfs =
iscsi array)=20
>>=20
>> My test ceph cluster nodes cpus are old (xeon E5420), but they are a=
round 10% usage, so I think it's ok.=20
>>=20
>>=20
>> Do you have an idea if I can trace something ?=20
>>=20
>> Thanks,=20
>>=20
>> Alexandre=20
>>=20
>> ----- Mail original -----=20
>>=20
>> De: "Sage Weil" <sage@inktank.com>=20
>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
>> Envoy=C3=A9: Mercredi 31 Octobre 2012 16:57:05=20
>> Objet: Re: slow fio random read benchmark, need help=20
>>=20
>> On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:=20
>>> Hello,=20
>>>=20
>>> I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,ca=
che=3Dnone), randread, with 4K block size on a small size of 1G (so it =
can be handle by the buffer cache on ceph cluster)=20
>>>=20
>>>=20
>>> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000M -=
-iodepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dlibaio --di=
rect=3D1=20
>>>=20
>>>=20
>>> I can't get more than 5000 iops.=20
>>=20
>> Have you tried increasing the iodepth?=20
>>=20
>> sage=20
>>=20
>>>=20
>>>=20
>>> RBD cluster is :=20
>>> ---------------=20
>>> 3 nodes,with each node :=20
>>> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon=20
>>> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ=20
>>> rbd 0.53=20
>>>=20
>>> ceph.conf=20
>>>=20
>>> journal dio =3D false=20
>>> filestore fiemap =3D false=20
>>> filestore flusher =3D false=20
>>> osd op threads =3D 24=20
>>> osd disk threads =3D 24=20
>>> filestore op threads =3D 6=20
>>>=20
>>> kvm host is : 4 x 12 cores opteron=20
>>> ------------=20
>>>=20
>>>=20
>>> During the bench:=20
>>>=20
>>> on ceph nodes:=20
>>> - cpu is around 10% used=20
>>> - iostat show no disks activity on osds. (so I think that the 1G fi=
le is handle in the linux buffer)=20
>>>=20
>>>=20
>>> on kvm host:=20
>>>=20
>>> -cpu is around 20% used=20
>>>=20
>>>=20
>>> I really don't see where is the bottleneck....=20
>>>=20
>>> Any Ideas, hints ?=20
>>>=20
>>>=20
>>> Regards,=20
>>>=20
>>> Alexandre=20
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
>>> the body of a message to majordomo@vger.kernel.org=20
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>>=20
>>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
