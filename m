From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: [ceph-users] qemu non-shared storage migration of nova instances?
Date: Thu, 20 Mar 2014 00:19:25 +1100
Message-ID: <CA+z5DswQosv1W+AVDfEwD6zm2Q6BOH204X6_Gj20k-sDMCAxng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:61337 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933877AbaCSNTr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 09:19:47 -0400
Received: by mail-la0-f46.google.com with SMTP id hr17so5873092lab.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 06:19:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Sebastian,

That's the case, at least with Libvirt 1.1.1 and Qemu 1.0 & 1.5 and
live block-migration, yes. I know the storage migration code has moved
a lot in Qemu, but I'm not sure if this basic issue has been addressed
or if we simply need to somehow tell Qemu to use a different
(de-coupled) storage and VM migration method.

Appreciate any insights on this!

Cheers,

On 20 March 2014 00:05, Sebastien Han <sebastien.han@enovance.com> wrot=
e:
> Hi Blair,
>
> Hum so the problem is:
>
> While block-migrating a VM with local ephemeral storage (VM disk is a=
 file under /var/lib/nova/instances/) the RBD volume attached to the in=
stance gets copied also?
>
> Am I correct?
>
> =E2=80=93=E2=80=93=E2=80=93=E2=80=93
> S=C3=A9bastien Han
> Cloud Engineer
>
> "Always give 100%. Unless you're giving blood.=E2=80=9D
>
> Phone: +33 (0)1 49 70 99 72
> Mail: sebastien.han@enovance.com
> Address : 11 bis, rue Roqu=C3=A9pine - 75008 Paris
> Web : www.enovance.com - Twitter : @enovance
>
> On 19 Mar 2014, at 13:57, Blair Bethwaite <blair.bethwaite@gmail.com>=
 wrote:
>
>> Hi Sebastian,
>>
>> As you seem to favor this configuration too, and are very knowledgea=
ble in these areas, I wonder if you have found an answer to my question=
 about block-migration with attached volumes?
>>
>> Best regards,
>> ~Blair
>>
>>
>> On 18 March 2014 09:08, Blair Bethwaite <blair.bethwaite@gmail.com> =
wrote:
>> Message: 20
>> Date: Mon, 17 Mar 2014 16:05:17 +0100
>> From: Sebastien Han <sebastien.han@enovance.com>
>> To: "Don Talton (dotalton)" <dotalton@cisco.com>
>> Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
>> Subject: Re: [ceph-users] qemu non-shared storage migration of nova
>>         instances?
>> Message-ID: <86ED699A-DE8B-4864-860F-E324A6F11CC5@enovance.com>
>> Content-Type: text/plain; charset=3D"windows-1252"
>>
>> Hi,
>>
>> I use the following live migration flags: VIR_MIGRATE_UNDEFINE_SOURC=
E,VIR_MIGRATE_PEER2PEER,VIR_MIGRATE_LIVE,VIR_MIGRATE_PERSIST_DEST
>> It deletes the libvirt.xml and re-creates it on the other side.
>>
>> We use this setup (local direct-attached ephemeral storage and Ceph =
for persistent volumes) in a production OpenStack cloud. The biggest pr=
oblem (which I think is still present with newer Qemu&Libvirt, though w=
e are on 1.0 and 1.1.1 respectively at the moment) with this is that li=
ve-block-migrations copy all block device contents from source to desti=
nation... i.e., even volumes get transferred in a ridiculous sequence o=
f "source hypervisor reads blocks from storage cluster -> source hyperv=
isor streams blocks to destination hypervisor -> destination hypervisor=
 writes blocks back to the storage cluster".
>>
>> Is that something others have run into and found workarounds for?
>>
>> --
>> Cheers,
>> ~Blairo
>>
>>
>>
>> --
>> Cheers,
>> ~Blairo
>



--=20
Cheers,
~Blairo
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
