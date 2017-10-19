From: Alan Somers <asomers@freebsd.org>
Subject: Re: Wish list : automatic rebuild with hot swap osd ?
Date: Thu, 19 Oct 2017 08:53:06 -0600
Message-ID: <CAOtMX2gKjiibodHKiyBVDJ4Z5n7ECkK2tBBhmN9gyo5dJsyf_Q@mail.gmail.com>
References: <06c8570a-415c-b830-3102-476a0d85cbdf@epfl.ch> <alpine.DEB.2.11.1710172118210.26702@piezo.us.to>
 <CAOtMX2hcnqQT8R_qAkRrDwdE=+S_+wX9FqSTnLcAVyMmuSraJw@mail.gmail.com>
 <alpine.DEB.2.11.1710181619440.24806@piezo.us.to> <CAC-Np1xHoNcH4cW7avPL2bv=2-hTZE6N1Q=KmuRwrX27rusPRQ@mail.gmail.com>
 <77422e82-aea3-abd6-75ce-d89d2b75945a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:49697 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbdJSOxI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 10:53:08 -0400
Received: by mail-lf0-f43.google.com with SMTP id w21so9943022lfc.6
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 07:53:07 -0700 (PDT)
In-Reply-To: <77422e82-aea3-abd6-75ce-d89d2b75945a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Alfredo Deza <adeza@redhat.com>, Sage Weil <sage@newdream.net>, Yoann Moulin <yoann.moulin@epfl.ch>, ceph-devel <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

On Thu, Oct 19, 2017 at 7:08 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 19-10-2017 14:14, Alfredo Deza wrote:
>>
>> If these properties also mean device information (vendor, size,
>> solid/rotational, etc...) it could help
>> to better map/detect an OSD replacement since clusters tend to have a
>> certain level of
>> homogeneous hardware: if $brand, and $size, and $rotational etc...
>>
>>>
>>> - A daemon (e.g., ceph-osd-autoreplace) that runs on each machine or a
>>> tool that is triggered by udev.  It would check for new, empty devices
>>> appearing in the locations (as defined by the by-path string) previously
>>> occupied by OSDs that are down.  If that happens, it can use 'ceph osd
>>> safe-to-destroy' to verify whether it is safe to automatically rebuild
>>> that OSD.  (If not, it might want to raise a health alert, since it's
>>> possible the drive that was physically pulled should be preserved until
>>> the cluster is sure it doesn't need it.)
>>
>>
>> systemd has some support for devices, so we might not even need a
>> daemon, but more a unit that can
>> depend on events already handled by systemd (would save us from udev).
>
>
> FreeBSD does not have systemd. 8-)
>
> I'm inclined to say luckily, but then that may be my personal bias.
> I don't like "automagic" tools like Udev or systemd tinkering with my disks.
>
> As Alan says, in ZFS one can designate hot-standby. But even there I prefer
> to be alerted and then manually intervene.

Actually, I was talking about autoreplace by physical path.  Hot
spares are something else.  The physical path of a drive is distinct
from its device path.  The physical path is determined by information
from a SES[1] expander, which can actually tell you which physical
slots contain which logical drives.

>
> A hot-swap daemon that gets instructed to only use explicitly and fully
> enumerated disk might be something to trust. So something matching
> disk-serial number would be oke.

Matching disk serial number isn't always safe in a VM.  VMs can
generate duplicate serial numbers.  Better to match against a GPT
label or something that identifies a drive as belonging to Ceph.
That, unfortunately, requires some intervention from the
administrator.  The nice thing about a user space daemon is that its
behavior can easily be controlled by the sysadmin.  So for example, a
sysadmin could opt into a rule that says "Ceph can take over all SCSI
disks" or "Ceph can take over all disks without an existing partition
table or known filesystem".

-Alan

[1] https://en.wikipedia.org/wiki/SCSI_Enclosure_Services
