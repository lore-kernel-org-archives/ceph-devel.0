From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] ceph-volume: migration and disk partition support
Date: Tue, 10 Oct 2017 08:25:51 -0400
Message-ID: <CAC-Np1w5Gt+qB_+iGciPC2rcrUFNLSgwuQOvTyt17miEDGnM=w@mail.gmail.com>
References: <CAC-Np1xUasg0C34HEuCFims18zPyRZ17p9-mp3xYCUETAYnn_A@mail.gmail.com>
 <20171010072831.GB20633@shell.dmz.bit.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:49778 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdJJMZx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 08:25:53 -0400
Received: by mail-oi0-f48.google.com with SMTP id w197so40196293oif.6
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 05:25:52 -0700 (PDT)
In-Reply-To: <20171010072831.GB20633@shell.dmz.bit.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kooman <stefan@bit.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Tue, Oct 10, 2017 at 3:28 AM, Stefan Kooman <stefan@bit.nl> wrote:
> Hi,
>
> Quoting Alfredo Deza (adeza@redhat.com):
>> Hi,
>>
>> Now that ceph-volume is part of the Luminous release, we've been able
>> to provide filestore support for LVM-based OSDs. We are making use of
>> LVM's powerful mechanisms to store metadata which allows the process
>> to no longer rely on UDEV and GPT labels (unlike ceph-disk).
>>
>> Bluestore support should be the next step for `ceph-volume lvm`, and
>> while that is planned we are thinking of ways to improve the current
>> caveats (like OSDs not coming up) for clusters that have deployed OSDs
>> with ceph-disk.
>
> I'm a bit confused after reading this. Just to make things clear. Would
> bluestore be put on top of a LVM volume (in an ideal world)? Has
> bluestore in Ceph luminious support for LVM? I.e. is there code in
> bluestore to support LVM? Or is it _just_ support of `ceph-volume lvm`
> for bluestore?

There is currently no support in `ceph-volume lvm` for bluestore yet.
It is being worked on today and should be ready soon (hopefully in the
next Luminous release).

And yes, in the case of  `ceph-volume lvm` it means that bluestore
would be "on top" of LVM volumes.

>
>> --- New clusters ---
>> The `ceph-volume lvm` deployment is straightforward (currently
>> supported in ceph-ansible), but there isn't support for plain disks
>> (with partitions) currently, like there is with ceph-disk.
>>
>> Is there a pressing interest in supporting plain disks with
>> partitions? Or only supporting LVM-based OSDs fine?
>
> We're still in a green field situation. Users with an installed base
> will have to comment on this. If the assumption that bluestore would be
> put on top of LVM is true, it would make things simpler (in our own Ceph
> ansible playbook).

There is already support in ceph-ansible too, which will mean that
when bluestore support is added, it will be added in ceph-ansible at
the same time.
>
> Gr. Stefan
>
> --
> | BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
> | GPG: 0xD14839C6                   +31 318 648 688 / info@bit.nl
