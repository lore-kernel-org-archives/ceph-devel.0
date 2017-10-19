From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Wish list : automatic rebuild with hot swap osd ?
Date: Thu, 19 Oct 2017 15:08:23 +0200
Message-ID: <77422e82-aea3-abd6-75ce-d89d2b75945a@digiware.nl>
References: <06c8570a-415c-b830-3102-476a0d85cbdf@epfl.ch>
 <alpine.DEB.2.11.1710172118210.26702@piezo.us.to>
 <CAOtMX2hcnqQT8R_qAkRrDwdE=+S_+wX9FqSTnLcAVyMmuSraJw@mail.gmail.com>
 <alpine.DEB.2.11.1710181619440.24806@piezo.us.to>
 <CAC-Np1xHoNcH4cW7avPL2bv=2-hTZE6N1Q=KmuRwrX27rusPRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:61967 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752671AbdJSNIp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 09:08:45 -0400
In-Reply-To: <CAC-Np1xHoNcH4cW7avPL2bv=2-hTZE6N1Q=KmuRwrX27rusPRQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Sage Weil <sage@newdream.net>
Cc: alan somers <asomers@gmail.com>, Yoann Moulin <yoann.moulin@epfl.ch>, ceph-devel <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

On 19-10-2017 14:14, Alfredo Deza wrote:
> If these properties also mean device information (vendor, size,
> solid/rotational, etc...) it could help
> to better map/detect an OSD replacement since clusters tend to have a
> certain level of
> homogeneous hardware: if $brand, and $size, and $rotational etc...
> 
>>
>> - A daemon (e.g., ceph-osd-autoreplace) that runs on each machine or a
>> tool that is triggered by udev.  It would check for new, empty devices
>> appearing in the locations (as defined by the by-path string) previously
>> occupied by OSDs that are down.  If that happens, it can use 'ceph osd
>> safe-to-destroy' to verify whether it is safe to automatically rebuild
>> that OSD.  (If not, it might want to raise a health alert, since it's
>> possible the drive that was physically pulled should be preserved until
>> the cluster is sure it doesn't need it.)
> 
> systemd has some support for devices, so we might not even need a
> daemon, but more a unit that can
> depend on events already handled by systemd (would save us from udev).

FreeBSD does not have systemd. 8-)

I'm inclined to say luckily, but then that may be my personal bias.
I don't like "automagic" tools like Udev or systemd tinkering with my 
disks.

As Alan says, in ZFS one can designate hot-standby. But even there I 
prefer to be alerted and then manually intervene.

A hot-swap daemon that gets instructed to only use explicitly and fully 
enumerated disk might be something to trust. So something matching 
disk-serial number would be oke.

--WjW
