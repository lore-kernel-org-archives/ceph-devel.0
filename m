From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: Re: Wish list : automatic rebuild with hot swap osd ?
Date: Fri, 20 Oct 2017 18:58:01 +0200
Message-ID: <49f687b5-e779-d751-af8e-129518354428@epfl.ch>
References: <06c8570a-415c-b830-3102-476a0d85cbdf@epfl.ch>
 <alpine.DEB.2.11.1710172118210.26702@piezo.us.to>
 <CAOtMX2hcnqQT8R_qAkRrDwdE=+S_+wX9FqSTnLcAVyMmuSraJw@mail.gmail.com>
 <alpine.DEB.2.11.1710181619440.24806@piezo.us.to>
 <CAC-Np1xHoNcH4cW7avPL2bv=2-hTZE6N1Q=KmuRwrX27rusPRQ@mail.gmail.com>
 <77422e82-aea3-abd6-75ce-d89d2b75945a@digiware.nl>
 <CAOtMX2gKjiibodHKiyBVDJ4Z5n7ECkK2tBBhmN9gyo5dJsyf_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:52873 "EHLO smtp4.epfl.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbdJTQ6E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Oct 2017 12:58:04 -0400
In-Reply-To: <CAOtMX2gKjiibodHKiyBVDJ4Z5n7ECkK2tBBhmN9gyo5dJsyf_Q@mail.gmail.com>
Content-Language: fr-CH
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Somers <asomers@freebsd.org>, Willem Jan Withagen <wjw@digiware.nl>
Cc: Alfredo Deza <adeza@redhat.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

Hello,

>>> If these properties also mean device information (vendor, size,
>>> solid/rotational, etc...) it could help
>>> to better map/detect an OSD replacement since clusters tend to have a
>>> certain level of
>>> homogeneous hardware: if $brand, and $size, and $rotational etc...
>>>
>>>>
>>>> - A daemon (e.g., ceph-osd-autoreplace) that runs on each machine or a
>>>> tool that is triggered by udev.  It would check for new, empty devices
>>>> appearing in the locations (as defined by the by-path string) previously
>>>> occupied by OSDs that are down.  If that happens, it can use 'ceph osd
>>>> safe-to-destroy' to verify whether it is safe to automatically rebuild
>>>> that OSD.  (If not, it might want to raise a health alert, since it's
>>>> possible the drive that was physically pulled should be preserved until
>>>> the cluster is sure it doesn't need it.)
>>>
>>>
>>> systemd has some support for devices, so we might not even need a
>>> daemon, but more a unit that can
>>> depend on events already handled by systemd (would save us from udev).
>>
>>
>> FreeBSD does not have systemd. 8-)
>>
>> I'm inclined to say luckily, but then that may be my personal bias.
>> I don't like "automagic" tools like Udev or systemd tinkering with my disks.
>>
>> As Alan says, in ZFS one can designate hot-standby. But even there I prefer
>> to be alerted and then manually intervene.
> 
> Actually, I was talking about autoreplace by physical path.  Hot
> spares are something else.  The physical path of a drive is distinct
> from its device path.  The physical path is determined by information
> from a SES[1] expander, which can actually tell you which physical
> slots contain which logical drives.
> 
>>
>> A hot-swap daemon that gets instructed to only use explicitly and fully
>> enumerated disk might be something to trust. So something matching
>> disk-serial number would be oke.
> 
> Matching disk serial number isn't always safe in a VM.  VMs can
> generate duplicate serial numbers.  Better to match against a GPT
> label or something that identifies a drive as belonging to Ceph.
> That, unfortunately, requires some intervention from the
> administrator.  The nice thing about a user space daemon is that its
> behavior can easily be controlled by the sysadmin.  So for example, a
> sysadmin could opt into a rule that says "Ceph can take over all SCSI
> disks" or "Ceph can take over all disks without an existing partition
> table or known filesystem".

I like the idea of mutiple level of "take over".

To begin, we can imagine something like :

there is a daemon which check if a new disk device is added to an OSD server, a quick analyses of the disk tell if there is a partition table,
which one it is, if there is partitions, if there is zero or garbage (like encrypted data) etc... then  make a resume of the new device to a mon
or mgr or a new daemon

if an OSD is marked as down/out, give the possibility to replace the osd mark as down by a single command (same place in the crush map same weight

  ceph osd <id> replaceby <new disk ref>

if no OSD mark as down, offers the ability to add a new OSD at the right place in the crush map if possible (maybe calculate the place of the
new disk can be difficult)

  ceph osd add <new disk ref> [crush map placement]

of just ignore the disk

  ceph osd ignore <new disk ref>

then give the ability of the cluster in some condition to do choose what to do without human interaction.

does this make sense ?


-- 
Yoann Moulin
EPFL IC-IT
