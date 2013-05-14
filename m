From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: QCOW2 to RBD format 2 in one step
Date: Tue, 14 May 2013 13:10:09 -0700
Message-ID: <51929A21.4010908@inktank.com>
References: <a7a591d3-713b-43dc-a427-2d0b0c8e42a7@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:62501 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENULZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 16:11:25 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so507150dan.25
        for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 13:11:24 -0700 (PDT)
In-Reply-To: <a7a591d3-713b-43dc-a427-2d0b0c8e42a7@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: leen@consolejunkie.net, ceph-devel@vger.kernel.org

On 05/14/2013 07:36 AM, Alexandre DERUMIER wrote:
> Hi,
>
> we do it with proxmox,
>
> we create the target rbd volume at format v2 with "rbd .." commands,
>
> then, we use qemu-img convert to copy from qcow2 to rbd.
>
> We have patched qemu-img to be able to write to an existing volume.
> (By default qemu-img convert try to create the volume)
> https://git.proxmox.com/?p=3Dpve-qemu-kvm.git;a=3Dcommit;h=3Dc0cf085d=
a9b6b1d21791dd88c34f7ad7f0b83359

It'd be nice to get that option into upstream qemu.


> If you want to test, you can try the coming proxmox 3.0 release here:
> http://forum.proxmox.com/threads/13733-Proxmox-VE-3-0-RC1-released!?p=
=3D73897#post73897
>
> support vm cloning full clone, from any storage (raw,qcow2,lvm,rbd,sh=
eepdog,iscsi) to any storage.
> Linked clones are also implemented for rbd :)

Good to know!

Josh

> Hope It can help.
>
> ----- Mail original -----
>
> De: "Leen Besselink" <leen@consolejunkie.net>
> =C3=80: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mardi 14 Mai 2013 14:15:21
> Objet: Re: QCOW2 to RBD format 2 in one step
>
> On Tue, May 14, 2013 at 01:52:28PM +0200, Wido den Hollander wrote:
>> On 05/14/2013 12:34 PM, Leen Besselink wrote:
>>> On Tue, May 14, 2013 at 12:16:32PM +0200, Wido den Hollander wrote:
>>>> Hi,
>>>>
>>
>> Hi Leen,
>>
>>>
>>> Hi Wido,
>>>
>>>> While working on the CloudStack code for 4.2 I'm running into some
>>>> problems with QCOW2 and RBD format 2.
>>>>
>>>> A quick cap of the problem:
>>>>
>>>> CloudStack stores all the templates on "Secondary Storage" as QCOW=
2 files.
>>>>
>>>> When a VM is deployed, this image will be copied (once) from
>>>> Secondary Storage to Primary Storage, this is done by qemu-img whi=
ch
>>>> does the conversion.
>>>>
>>>> When the image is on Primary Storage it will be copied to the
>>>> destination volume and the Instance/VM is started.
>>>>
>>>> In that last step I want to use layering, but the problem is that =
my
>>>> image is RBD format 1 due to the qemu-img copy.
>>>>
>>>> I can skip the qemu-img copy, but I have to find a way to go from
>>>> QCOW2 to RBD format 2 in preferably one step. There is a issue abo=
ut
>>>> this in the tracker [0], but that won't be finished on time.
>>>>
>>>> Another idea would be to do QCOW2 -> RAW -> RBD format 2, but that
>>>> extra step will take a lot of time. It would also require some
>>>> temporary storage on the hypervisor.
>>>>
>>>> I also thought of creating the RBD image prior to converting to it=
,
>>>> but that fails, since qemu-img won't let you convert to a already
>>>> existing image.
>>>>
>>>> Any brights ideas? Maybe even doing the QCOW2 -> RAW format in
>>>> memory? In Java?
>>>>
>>>
>>> I'm no expert, but would it be possible to change qemu-img to suppo=
rt writing RAW to standard out ?
>>>
>>
>> No, qemu-img can't write to stdout. Due to various formats it suppor=
ts.
>>
>
> I meant extending qemu-img to support that, it would probably be less
> work than the work needed for the issue below. But the longer I think
> about it. It would only be able to do that for RAW. And RAW isn't ver=
y
> efficient anyway.
>
>>> So you can run qemu-img convert and pipe that drectly to the rbd im=
port command ?
>>>
>>
>> If qemu-img would support writing to stdout there is the problem
>> that I'm not using the rbd tool, but Java bindings for librbd and
>> librados. I'm trying to avoid executing from Java.
>>
>>> rbd import already supports standard in I believe.
>>>
>>> Then you don't need any temporary storage.
>>>
>>> Maybe something more efficient than RAW is possible as well ?
>>>
>>>> The goal is to go from QCOW2 to RBD format 2 in one step.
>>>>
>>>> [0]: http://tracker.ceph.com/issues/4897
>>>>
>>>> --
>>>> Wido den Hollander
>>>> 42on B.V.
>>>>
>>>> Phone: +31 (0)20 700 9902
>>>> Skype: contact42on
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
