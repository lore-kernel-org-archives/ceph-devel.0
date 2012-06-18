From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Unmountable btrfs filesystems
Date: Mon, 18 Jun 2012 11:30:42 +0200
Message-ID: <4FDEF542.3040704@widodh.nl>
References: <4FDCD484.50706@widodh.nl> <4FDDE1DE.5030709@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58777 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab2FRJao (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 05:30:44 -0400
In-Reply-To: <4FDDE1DE.5030709@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On 06/17/2012 03:55 PM, Martin Mailand wrote:
> Hi Wido,
> until recently there were still a few bugs in btrfs which could be hit
> quite easily with ceph. The last big one was fixed here
> http://www.spinics.net/lists/ceph-devel/msg06270.html
>
> I am running a ceph cluster with btrfs on a 3.5-rc2 without a problem,
> even under heavy test load.
>

I'll give that one a try, thanks!

I've also let the btrfs tools like fsck loose on those filesystems, but 
they were beyond any repair. Al kinds of errors on the filesystems.

Nothing wrong with the disk below them, but the filesystems were just 
completely broken, no way of repairing.

Wido

> Hope that's helped.
>
> -martin
>
>
> Am 16.06.2012 20:46, schrieb Wido den Hollander:
>> I tried various kernels, the most recent 3.3.0 from kernel.ubuntu.com,
>> but I'm still seeing this.
>>
>> Is anyone seeing the same or did everybody migrate away to ext4 or XFS?
>>
>> I still prefer btrfs due to the snapshotting, but loosing all these
>> OSD's all the time is getting kind of frustrating.
>>
>> Any thoughts or comments?

