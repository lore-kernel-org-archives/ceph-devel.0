From: Damien Churchill <damoxc@gmail.com>
Subject: Re: use UUID mount btrfs failed
Date: Wed, 12 Oct 2011 09:02:06 +0100
Message-ID: <CAFtEh-dwema2fWTbX_EHsPuPhK56kDiMqe5xEuev86nPCtHZRA@mail.gmail.com>
References: <CABAwU-Z=VJ4DkVANPyw6ogMyLz1CoGxAWcTGEay0QUOodL+Yiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41654 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1JLICH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 04:02:07 -0400
Received: by qyk7 with SMTP id 7so444004qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2011 01:02:06 -0700 (PDT)
In-Reply-To: <CABAwU-Z=VJ4DkVANPyw6ogMyLz1CoGxAWcTGEay0QUOodL+Yiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12 October 2011 02:22, huang jun <hjwsm1989@gmail.com> wrote:
> I use the UUID option to mount the btrfs disk,but i can not success.
> first, the disk is /dev/sdd1
> then, i pull out the disk
> and after mintues, pushed it again,at this time, it changes to /dev/sde1
> at this time, if we use /etc/init.d/ceph restart, it will failed, for
> the current mount option is likely "/dev/sd** "
> but the UUID didn't change.
> why i can not mount it successfuly?
> BTW, does ceph provides methods to resolve the condition like that?
>
> the starce file attached.
>
> thanks!
>

Hi,

I switched to use the symlinks created by udev in /dev/disk/by-id/
which contains the hard-disks serial number which will be completely
static, even if a new btrfs filesystem is created. This ensures that
the same partition on the same disk is always used.

Regards,
Damien
