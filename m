From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [pve-devel] less cores more iops / speed
Date: Mon, 12 Nov 2012 10:50:15 -0800
Message-ID: <50A144E7.2010003@inktank.com>
References: <9c1ce666-795e-4611-8f2c-af1d85270533@mailpro> <50A116DC.2020509@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:61067 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2KLSuS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 13:50:18 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2854758dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 10:50:18 -0800 (PST)
In-Reply-To: <50A116DC.2020509@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, pve-devel@pve.proxmox.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/12/2012 07:33 AM, Stefan Priebe - Profihost AG wrote:
> Adding this to ceph.conf on kvm host adds another 2000 iops (20.000
> iop/s with one VM). I'm sure most of them are useless on a client kvm=
 /
> rbd host but i don't know which one makes sense ;-)
>
> [global]
>          debug ms =3D 0/0
>          debug rbd =3D 0/0
>          debug lockdep =3D 0/0
>          debug context =3D 0/0
>          debug crush =3D 0/0
>          debug buffer =3D 0/0
>          debug timer =3D 0/0
>          debug journaler =3D 0/0
>          debug osd =3D 0/0
>          debug optracker =3D 0/0
>          debug objclass =3D 0/0
>          debug filestore =3D 0/0
>          debug journal =3D 0/0
>          debug ms =3D 0/0
>          debug monc =3D 0/0
>          debug tp =3D 0/0
>          debug auth =3D 0/0
>          debug finisher =3D 0/0
>          debug heartbeatmap =3D 0/0
>          debug perfcounter =3D 0/0
>          debug asok =3D 0/0
>          debug throttle =3D 0/0
>
> [client]

=46or the client side you'd these settings to disable all debug logging=
:

[client]
debug lockdep =3D 0/0
debug context =3D 0/0
debug crush =3D 0/0
debug buffer =3D 0/0
debug timer =3D 0/0
debug filer =3D 0/0
debug objecter =3D 0/0
debug rados =3D 0/0
debug rbd =3D 0/0
debug objectcacher =3D 0/0
debug client =3D 0/0
debug ms =3D 0/0
debug monc =3D 0/0
debug tp =3D 0/0
debug auth =3D 0/0
debug finisher =3D 0/0
debug perfcounter =3D 0/0
debug asok =3D 0/0
debug throttle =3D 0/0

Josh

>          debug ms =3D 0/0
>          debug rbd =3D 0/0
>          debug lockdep =3D 0/0
>          debug context =3D 0/0
>          debug crush =3D 0/0
>          debug buffer =3D 0/0
>          debug timer =3D 0/0
>          debug journaler =3D 0/0
>          debug osd =3D 0/0
>          debug optracker =3D 0/0
>          debug objclass =3D 0/0
>          debug filestore =3D 0/0
>          debug journal =3D 0/0
>          debug ms =3D 0/0
>          debug monc =3D 0/0
>          debug tp =3D 0/0
>          debug auth =3D 0/0
>          debug finisher =3D 0/0
>          debug heartbeatmap =3D 0/0
>          debug perfcounter =3D 0/0
>          debug asok =3D 0/0
>          debug throttle =3D 0/0
>
> Stefan
>
> Am 12.11.2012 15:35, schrieb Alexandre DERUMIER:
>> Another idea,
>>
>> do you have tried to put
>>>>>>   debug lockdep =3D 0/0
>>>>>>   debug context =3D 0/0
>>>>>>   debug crush =3D 0/0
>>>>>>   debug buffer =3D 0/0
>>>>>>   debug timer =3D 0/0
>>>>>>   debug journaler =3D 0/0
>>>>>>   debug osd =3D 0/0
>>>>>>   debug optracker =3D 0/0
>>>>>>   debug objclass =3D 0/0
>>>>>>   debug filestore =3D 0/0
>>>>>>   debug journal =3D 0/0
>>>>>>   debug ms =3D 0/0
>>>>>>   debug monc =3D 0/0
>>>>>>   debug tp =3D 0/0
>>>>>>   debug auth =3D 0/0
>>>>>>   debug finisher =3D 0/0
>>>>>>   debug heartbeatmap =3D 0/0
>>>>>>   debug perfcounter =3D 0/0
>>>>>>   debug asok =3D 0/0
>>>>>>   debug throttle =3D 0/0
>>
>> in a ceph.conf on your kvm host ?
>>
>>
>> ----- Mail original -----
>>
>> De: "Alexandre DERUMIER" <aderumier@odiso.com>
>> =C3=80: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>> Cc: pve-devel@pve.proxmox.com
>> Envoy=C3=A9: Lundi 12 Novembre 2012 15:26:36
>> Objet: Re: [pve-devel] less cores more iops / speed
>>
>> Maybe some tracing on kvm process could give us clues to find where
>> the cpu is used ?
>>
>> Also another idea, can you try with "auth supported=3Dnone" ? maybe =
they
>> are some overhead with ceph authenfication ?
>>
>>
>>
>>
>> ----- Mail original -----
>>
>> De: "Alexandre DERUMIER" <aderumier@odiso.com>
>> =C3=80: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>> Cc: pve-devel@pve.proxmox.com
>> Envoy=C3=A9: Lundi 12 Novembre 2012 15:20:07
>> Objet: Re: [pve-devel] less cores more iops / speed
>>
>> Ok thanks.
>>
>> Seem to use a lot of cpu vs nfs,iscsi ...
>>
>> I hope that ceph dev will work on this soon !
>>
>>
>> ----- Mail original -----
>>
>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>> Cc: "eric" <eric@netwalk.com>, pve-devel@pve.proxmox.com
>> Envoy=C3=A9: Lundi 12 Novembre 2012 15:05:08
>> Objet: Re: [pve-devel] less cores more iops / speed
>>
>> Am 12.11.2012 13:49, schrieb Alexandre DERUMIER:
>>>>> One VM on one Host: 18.000 IOP/s
>>>>> Two VM on one Host: 2x11.000 IOP/s
>>>>> Three VM on one Host: 3x7.000 IOP/s
>>>
>>> And host cpu is 100% ?
>>
>> No. For three VMs yes. For one and two no. I think librbd / rbd
>> implementation in kvm is the bottleneck here.
>>
>> Stefan
>>
>>> ----- Mail original -----
>>>
>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>>> Cc: "eric" <eric@netwalk.com>, pve-devel@pve.proxmox.com
>>> Envoy=C3=A9: Lundi 12 Novembre 2012 12:58:35
>>> Objet: Re: [pve-devel] less cores more iops / speed
>>>
>>> Am 12.11.2012 08:51, schrieb Alexandre DERUMIER:
>>>>>> Right now RBD in KVM is limited by CPU speed.
>>>>
>>>> Good to known, so it's seem lack of threading, or maybe somes lock=
s.
>>>> (so faster cpu give more iops).
>>>>
>>>> If you lauch parallel fio on same host on different guest, do you
>>>> get more total iops ? (for me it's scale)
>>>
>>> One VM on one Host: 18.000 IOP/s
>>> Two VM on one Host: 2x11.000 IOP/s
>>> Three VM on one Host: 3x7.000 IOP/s
>>>
>>>> if you launch 2 parallel fio, on same guest (on differents disk), =
do
>>>> you get more iops ? (for me, it doesn't scale, so raid0 in guest
>>>> doesn't help).
>>> No it doesn't scale.
>>>
>>> Stefan
>>>
>>>> ----- Mail original -----
>>>>
>>>> De: "Stefan Priebe" <s.priebe@profihost.ag>
>>>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>>>> Cc: "eric" <eric@netwalk.com>, pve-devel@pve.proxmox.com
>>>> Envoy=C3=A9: Dimanche 11 Novembre 2012 13:07:36
>>>> Objet: Re: [pve-devel] less cores more iops / speed
>>>>
>>>> Am 11.11.2012 12:12, schrieb Alexandre DERUMIER:
>>>>> If I remember good, stefan can achieve 100.000 iops with iscsi wi=
th
>>>>> same kvm host.
>>>>
>>>> Correct but this was always with scsi-generic and I/O multipathing=
 on
>>>> host. rbd does not support scsi-generic ;-(
>>>>
>>>>> I have checked ceph mailing, stefan seem to have resolved his
>>>>> problem with dual core with bios update !
>>>> Correct. So speed on Dual Xeon is now 14.000 IOP/s and 18.000 IOP/=
s on
>>>> Single Xeon. But the difference is an issue of the CPU Speed. 3,6G=
hz
>>>> Single Xeon vs. 2.5Ghz Dual Xeon.
>>>>
>>>> Right now RBD in KVM is limited by CPU speed.
>>>>
>>>> Greets,
>>>> Stefan
>>>>
>> _______________________________________________
>> pve-devel mailing list
>> pve-devel@pve.proxmox.com
>> http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel
>> _______________________________________________
>> pve-devel mailing list
>> pve-devel@pve.proxmox.com
>> http://pve.proxmox.com/cgi-bin/mailman/listinfo/pve-devel
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
