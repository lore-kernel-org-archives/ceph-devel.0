From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 13:22:22 -0700
Message-ID: <5091887E.3020605@inktank.com>
References: <8be796b6-f1c1-43ed-abe8-ec06b62c7e84@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60236 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760652Ab2JaUWf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 16:22:35 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1213965pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 13:22:34 -0700 (PDT)
In-Reply-To: <8be796b6-f1c1-43ed-abe8-ec06b62c7e84@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 10/31/2012 11:56 AM, Alexandre DERUMIER wrote:
> Yes, I think you are right, round trip with mon must cut by half the =
performance.

I just want to note that the monitors aren't in the data path.
The client knows how to reach the osds and which osds to talk to based
on the osdmap. This is updated asynchronously from the client's
perspective.

> I have just done test with 2 parallel fio bench, from 2 differents ho=
st,
> I get 2 x 5000 iops

It'd be interesting to try smaller rbd objects (rbd create --order 12
=2E..) to rule out contention in the OSD for particular objects.

Josh

> so it must be related to network latency.
>
> I have also done tests with --numjob 1000, it doesn't help, same resu=
lts.
>
>
> Do you have an idea how I can have more io from 1 host ?
> Doing lacp with multiple links ?
>
> I think that 10gigabit latency is almost same, i'm not sure it will i=
mprove iops too much
> Maybe InfiniBand can help?
>
> ----- Mail original -----
>
> De: "Marcus Sorensen" <shadowsor@gmail.com>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-devel@vger.ker=
nel.org>
> Envoy=C3=A9: Mercredi 31 Octobre 2012 18:38:46
> Objet: Re: slow fio random read benchmark, need help
>
> Yes, I was going to say that the most I've ever seen out of gigabit i=
s
> about 15k iops, with parallel tests and NFS (or iSCSI). Multipathing
> may not really parallelize the io for you. It can send an io down one
> path, then move to the next path and send the next io without
> necessarily waiting for the previous one to respond, but it only
> shaves a slight amount from your latency under some scenarios as
> opposed to sending down all paths simultaneously. I have seen it help
> with high latency links.
>
> I don't remember the Ceph design that well, but with distributed
> storage systems you're going to pay a penalty. If you can do 10-15k
> with one TCP round trip, you'll get half that with the round trip to
> talk to the metadata server to find your blocks and then to fetch
> them. Like I said, that might not be exactly what Ceph does, but
> you're going to have more traffic than just a straight single attache=
d
> NFS or iscsi server.
>
> On Wed, Oct 31, 2012 at 11:27 AM, Alexandre DERUMIER
> <aderumier@odiso.com> wrote:
>> Thanks Marcus,
>>
>> indeed gigabit ethernet.
>>
>> note that my iscsi results (40k)was with multipath, so multiple giga=
bit links.
>>
>> I have also done tests with a netapp array, with nfs, single link, I=
'm around 13000 iops
>>
>> I will do more tests with multiples vms, from differents hosts, and =
with --numjobs.
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
>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>> Cc: "Sage Weil" <sage@inktank.com>, "ceph-devel" <ceph-devel@vger.ke=
rnel.org>
>> Envoy=C3=A9: Mercredi 31 Octobre 2012 18:08:11
>> Objet: Re: slow fio random read benchmark, need help
>>
>> 5000 is actually really good, if you ask me. Assuming everything is
>> connected via gigabit. If you get 40k iops locally, you add the
>> latency of tcp, as well as that of the ceph services and VM layer, a=
nd
>> that's what you get. On my network I get about a .1ms round trip on
>> gigabit over the same switch, which by definition can only do 10,000
>> iops. Then if you have storage on the other end capable of 40k iops,
>> you add the latencies together (.1ms + .025ms) and you're at 8k iops=
=2E
>> Then add the small latency of the application servicing the io (NFS,
>> Ceph, etc), and the latency introduced by your VM layer, and 5k soun=
ds
>> about right.
>>
>> The good news is that you probably aren't taxing the storage, you ca=
n
>> likely do many simultaneous tests from several VMs and get the same
>> results.
>>
>> You can try adding --numjobs to your fio to parallelize the specific
>> test you're doing, or launching a second VM and doing the same test =
at
>> the same time. This would be a good indicator if it's latency.
>>
>> On Wed, Oct 31, 2012 at 10:29 AM, Alexandre DERUMIER
>> <aderumier@odiso.com> wrote:
>>>>> Have you tried increasing the iodepth?
>>> Yes, I have try with 100 and 200, same results.
>>>
>>> I have also try directly from the host, with /dev/rbd1, and I have =
same result.
>>> I have also try with 3 differents hosts, with differents cpus model=
s.
>>>
>>> (note: I can reach around 40.000 iops with same fio config on a zfs=
 iscsi array)
>>>
>>> My test ceph cluster nodes cpus are old (xeon E5420), but they are =
around 10% usage, so I think it's ok.
>>>
>>>
>>> Do you have an idea if I can trace something ?
>>>
>>> Thanks,
>>>
>>> Alexandre
>>>
>>> ----- Mail original -----
>>>
>>> De: "Sage Weil" <sage@inktank.com>
>>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>>> Envoy=C3=A9: Mercredi 31 Octobre 2012 16:57:05
>>> Objet: Re: slow fio random read benchmark, need help
>>>
>>> On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:
>>>> Hello,
>>>>
>>>> I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,c=
ache=3Dnone), randread, with 4K block size on a small size of 1G (so it=
 can be handle by the buffer cache on ceph cluster)
>>>>
>>>>
>>>> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000M =
--iodepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dlibaio --d=
irect=3D1
>>>>
>>>>
>>>> I can't get more than 5000 iops.
>>>
>>> Have you tried increasing the iodepth?
>>>
>>> sage
>>>
>>>>
>>>>
>>>> RBD cluster is :
>>>> ---------------
>>>> 3 nodes,with each node :
>>>> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon
>>>> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ
>>>> rbd 0.53
>>>>
>>>> ceph.conf
>>>>
>>>> journal dio =3D false
>>>> filestore fiemap =3D false
>>>> filestore flusher =3D false
>>>> osd op threads =3D 24
>>>> osd disk threads =3D 24
>>>> filestore op threads =3D 6
>>>>
>>>> kvm host is : 4 x 12 cores opteron
>>>> ------------
>>>>
>>>>
>>>> During the bench:
>>>>
>>>> on ceph nodes:
>>>> - cpu is around 10% used
>>>> - iostat show no disks activity on osds. (so I think that the 1G f=
ile is handle in the linux buffer)
>>>>
>>>>
>>>> on kvm host:
>>>>
>>>> -cpu is around 20% used
>>>>
>>>>
>>>> I really don't see where is the bottleneck....
>>>>
>>>> Any Ideas, hints ?
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Alexandre


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
