From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: slow fio random read benchmark, need help
Date: Thu, 1 Nov 2012 06:41:50 +0100
Message-ID: <9F14794A-5732-4BC9-BB71-41136473382B@profihost.ag>
References: <9f76dbba-7559-4ba0-a207-370445df3e03@mailpro>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56345 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2KAFl4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 01:41:56 -0400
In-Reply-To: <9f76dbba-7559-4ba0-a207-370445df3e03@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 01.11.2012 um 06:11 schrieb Alexandre DERUMIER <aderumier@odiso.com>=
:

>>> Come to think of it that 15k iops I mentioned was on 10G ethernet w=
ith
>>> NFS. I have tried infiniband with ipoib and tcp, it's similar to 10=
G
>>> ethernet.
>=20
> I have see new arista 10GBe switch with latency around 1microsecond, =
that seem pretty good to do the job.

Pretty interesting. How can i measure switch / network latency.

Stefan

>=20
>=20
>=20
>>> You will need to get creative. What you're asking for really is to
>>> have local latencies with remote storage. Just off of the top of my
>>> head you may look into some way to do local caching on SSD for your
>>> RBD volume, like bcache or flashcache.
> I have already thinked about it. (But I would like to use qemu-rbd if=
 possible)
>=20
>=20
>>> At any rate, 5000 iops is not as good as a new SSD, but far better
>>> than a normal disk. Is there some specific application requirement,=
 or
>>> is it just that you are feeling like you want the full performance
>>> from the VM?
>=20
> I have some customers with some huge databases (too big to be handle =
in the bufer), require a lot of ios. (around 10K).
>=20
> I have redone tests with 4 guest in parallel, I get 4 x 5000iops, so =
it seem to scale ! (and cpu is very low on the ceph cluster).
>=20
>=20
> So I'll try some tricks, like raid over multiple rbd devices, maybe i=
t'll help.
>=20
> Thanks again for the help Marcus, I was not aware of these latencies =
problems.
>=20
> Regards,
>=20
> Alexandre
>=20
>=20
> ----- Mail original -----
>=20
> De: "Marcus Sorensen" <shadowsor@gmail.com>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-devel@vger.ker=
nel.org>
> Envoy=C3=A9: Mercredi 31 Octobre 2012 20:50:36
> Objet: Re: slow fio random read benchmark, need help
>=20
> Come to think of it that 15k iops I mentioned was on 10G ethernet wit=
h
> NFS. I have tried infiniband with ipoib and tcp, it's similar to 10G
> ethernet.
>=20
> You will need to get creative. What you're asking for really is to
> have local latencies with remote storage. Just off of the top of my
> head you may look into some way to do local caching on SSD for your
> RBD volume, like bcache or flashcache.
>=20
> Depending on your application, it may actually be a bonus that no
> single server (or handful of servers) can crush your storage's
> performance. if you only have one or two clients anyway then that may
> not be much consolation, but if you're going to have dozens or more
> then there's not much benefit to having one take all performance at
> the expense of everyone, except for perhaps in bursts.
>=20
> At any rate, 5000 iops is not as good as a new SSD, but far better
> than a normal disk. Is there some specific application requirement, o=
r
> is it just that you are feeling like you want the full performance
> from the VM?
>=20
> On Wed, Oct 31, 2012 at 12:56 PM, Alexandre DERUMIER
> <aderumier@odiso.com> wrote:
>> Yes, I think you are right, round trip with mon must cut by half the=
 performance.
>>=20
>> I have just done test with 2 parallel fio bench, from 2 differents h=
ost,=20
>> I get 2 x 5000 iops
>>=20
>> so it must be related to network latency.
>>=20
>> I have also done tests with --numjob 1000, it doesn't help, same res=
ults.
>>=20
>>=20
>> Do you have an idea how I can have more io from 1 host ?
>> Doing lacp with multiple links ?
>>=20
>> I think that 10gigabit latency is almost same, i'm not sure it will =
improve iops too much
>> Maybe InfiniBand can help?
>>=20
>> ----- Mail original -----
>>=20
>> De: "Marcus Sorensen" <shadowsor@gmail.com>
>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-devel@vger.ke=
rnel.org>
>> Envoy=C3=A9: Mercredi 31 Octobre 2012 18:38:46
>> Objet: Re: slow fio random read benchmark, need help
>>=20
>> Yes, I was going to say that the most I've ever seen out of gigabit =
is
>> about 15k iops, with parallel tests and NFS (or iSCSI). Multipathing
>> may not really parallelize the io for you. It can send an io down on=
e
>> path, then move to the next path and send the next io without
>> necessarily waiting for the previous one to respond, but it only
>> shaves a slight amount from your latency under some scenarios as
>> opposed to sending down all paths simultaneously. I have seen it hel=
p
>> with high latency links.
>>=20
>> I don't remember the Ceph design that well, but with distributed
>> storage systems you're going to pay a penalty. If you can do 10-15k
>> with one TCP round trip, you'll get half that with the round trip to
>> talk to the metadata server to find your blocks and then to fetch
>> them. Like I said, that might not be exactly what Ceph does, but
>> you're going to have more traffic than just a straight single attach=
ed
>> NFS or iscsi server.
>>=20
>> On Wed, Oct 31, 2012 at 11:27 AM, Alexandre DERUMIER
>> <aderumier@odiso.com> wrote:
>>> Thanks Marcus,
>>>=20
>>> indeed gigabit ethernet.
>>>=20
>>> note that my iscsi results (40k)was with multipath, so multiple gig=
abit links.
>>>=20
>>> I have also done tests with a netapp array, with nfs, single link, =
I'm around 13000 iops
>>>=20
>>> I will do more tests with multiples vms, from differents hosts, and=
 with --numjobs.
>>>=20
>>> I'll keep you in touch,
>>>=20
>>> Thanks for help,
>>>=20
>>> Regards,
>>>=20
>>> Alexandre
>>>=20
>>>=20
>>> ----- Mail original -----
>>>=20
>>> De: "Marcus Sorensen" <shadowsor@gmail.com>
>>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>>> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>
>>> Envoy=C3=A9: Mercredi 31 Octobre 2012 18:08:11
>>> Objet: Re: slow fio random read benchmark, need help
>>>=20
>>> 5000 is actually really good, if you ask me. Assuming everything is
>>> connected via gigabit. If you get 40k iops locally, you add the
>>> latency of tcp, as well as that of the ceph services and VM layer, =
and
>>> that's what you get. On my network I get about a .1ms round trip on
>>> gigabit over the same switch, which by definition can only do 10,00=
0
>>> iops. Then if you have storage on the other end capable of 40k iops=
,
>>> you add the latencies together (.1ms + .025ms) and you're at 8k iop=
s.
>>> Then add the small latency of the application servicing the io (NFS=
,
>>> Ceph, etc), and the latency introduced by your VM layer, and 5k sou=
nds
>>> about right.
>>>=20
>>> The good news is that you probably aren't taxing the storage, you c=
an
>>> likely do many simultaneous tests from several VMs and get the same
>>> results.
>>>=20
>>> You can try adding --numjobs to your fio to parallelize the specifi=
c
>>> test you're doing, or launching a second VM and doing the same test=
 at
>>> the same time. This would be a good indicator if it's latency.
>>>=20
>>> On Wed, Oct 31, 2012 at 10:29 AM, Alexandre DERUMIER
>>> <aderumier@odiso.com> wrote:
>>>>>> Have you tried increasing the iodepth?
>>>> Yes, I have try with 100 and 200, same results.
>>>>=20
>>>> I have also try directly from the host, with /dev/rbd1, and I have=
 same result.
>>>> I have also try with 3 differents hosts, with differents cpus mode=
ls.
>>>>=20
>>>> (note: I can reach around 40.000 iops with same fio config on a zf=
s iscsi array)
>>>>=20
>>>> My test ceph cluster nodes cpus are old (xeon E5420), but they are=
 around 10% usage, so I think it's ok.
>>>>=20
>>>>=20
>>>> Do you have an idea if I can trace something ?
>>>>=20
>>>> Thanks,
>>>>=20
>>>> Alexandre
>>>>=20
>>>> ----- Mail original -----
>>>>=20
>>>> De: "Sage Weil" <sage@inktank.com>
>>>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>>>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>>>> Envoy=C3=A9: Mercredi 31 Octobre 2012 16:57:05
>>>> Objet: Re: slow fio random read benchmark, need help
>>>>=20
>>>> On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:
>>>>> Hello,
>>>>>=20
>>>>> I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,=
cache=3Dnone), randread, with 4K block size on a small size of 1G (so i=
t can be handle by the buffer cache on ceph cluster)
>>>>>=20
>>>>>=20
>>>>> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000M=
 --iodepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dlibaio --=
direct=3D1
>>>>>=20
>>>>>=20
>>>>> I can't get more than 5000 iops.
>>>>=20
>>>> Have you tried increasing the iodepth?
>>>>=20
>>>> sage
>>>>=20
>>>>>=20
>>>>>=20
>>>>> RBD cluster is :
>>>>> ---------------
>>>>> 3 nodes,with each node :
>>>>> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon
>>>>> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ
>>>>> rbd 0.53
>>>>>=20
>>>>> ceph.conf
>>>>>=20
>>>>> journal dio =3D false
>>>>> filestore fiemap =3D false
>>>>> filestore flusher =3D false
>>>>> osd op threads =3D 24
>>>>> osd disk threads =3D 24
>>>>> filestore op threads =3D 6
>>>>>=20
>>>>> kvm host is : 4 x 12 cores opteron
>>>>> ------------
>>>>>=20
>>>>>=20
>>>>> During the bench:
>>>>>=20
>>>>> on ceph nodes:
>>>>> - cpu is around 10% used
>>>>> - iostat show no disks activity on osds. (so I think that the 1G =
file is handle in the linux buffer)
>>>>>=20
>>>>>=20
>>>>> on kvm host:
>>>>>=20
>>>>> -cpu is around 20% used
>>>>>=20
>>>>>=20
>>>>> I really don't see where is the bottleneck....
>>>>>=20
>>>>> Any Ideas, hints ?
>>>>>=20
>>>>>=20
>>>>> Regards,
>>>>>=20
>>>>> Alexandre
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>=20
>>>>>=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
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
