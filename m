From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: use UUID mount btrfs failed
Date: Wed, 12 Oct 2011 10:28:18 +0200
Message-ID: <j73j32$6fs$1@dough.gmane.org>
References: <CABAwU-Z=VJ4DkVANPyw6ogMyLz1CoGxAWcTGEay0QUOodL+Yiw@mail.gmail.com>	<CAFtEh-dwema2fWTbX_EHsPuPhK56kDiMqe5xEuev86nPCtHZRA@mail.gmail.com> <CABAwU-bS7gZscTkDUDTzBetSZ_v1GgQtcr0rH3VTa8Xj3ETTpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59716 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab1JLI2f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Oct 2011 04:28:35 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1RDuAw-00029L-Ui
	for ceph-devel@vger.kernel.org; Wed, 12 Oct 2011 10:28:30 +0200
Received: from 62.12.178.22 ([62.12.178.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2011 10:28:30 +0200
Received: from thomas by 62.12.178.22 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2011 10:28:30 +0200
In-Reply-To: <CABAwU-bS7gZscTkDUDTzBetSZ_v1GgQtcr0rH3VTa8Xj3ETTpA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 12.10.2011 10:22, huang jun wrote:
> 2011/10/12 Damien Churchill<damoxc@gmail.com>:
>> On 12 October 2011 02:22, huang jun<hjwsm1989@gmail.com>  wrote:
>>> I use the UUID option to mount the btrfs disk,but i can not success.
>>> first, the disk is /dev/sdd1
>>> then, i pull out the disk
>>> and after mintues, pushed it again,at this time, it changes to /dev/sde1
>>> at this time, if we use /etc/init.d/ceph restart, it will failed, for
>>> the current mount option is likely "/dev/sd** "
>>> but the UUID didn't change.
>>> why i can not mount it successfuly?
>>> BTW, does ceph provides methods to resolve the condition like that?
>>>
>>> the starce file attached.
>>>
>>> thanks!
>>>
>>
>> Hi,
>>
>> I switched to use the symlinks created by udev in /dev/disk/by-id/
>> which contains the hard-disks serial number which will be completely
>> static, even if a new btrfs filesystem is created. This ensures that
>> the same partition on the same disk is always used.
>>
>> Regards,
>> Damien
>>
> can you mount successfully by using the /dev/disk/by-id/  instead of  /dev/sd**?
> and how to get the hard-disk serial number? I have tried "udevadm info
> -a -p $(udevadm info -q path -n $btrfs_devs)", but failed to get it.
> or you should  test the condition like that, pull out the disk first
> and then push it in after few minutes.
>
> thanks!

for example with smartctl from the smartmontools you can get the s/n.

smartctl -i /dev/sd*

- Thomas

