From: Alfredo Deza <adeza@redhat.com>
Subject: Re: ceph-deploy disk partition alignment
Date: Tue, 23 Feb 2016 07:12:08 -0500
Message-ID: <CAC-Np1xPNBur=vbBMrcEkBwsi1_b9AKxaK0-n2ABahLFFatBUg@mail.gmail.com>
References: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37117 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcBWMMK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Feb 2016 07:12:10 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so207046441wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 Feb 2016 04:12:09 -0800 (PST)
In-Reply-To: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 22, 2016 at 1:27 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi,
> I am seeing ceph-deploy is creating data partition from sector 1 ignoring what sgdisk is recommending (256 in my disk). Basically, it should be aligned with physical sector size (reported in /sys/block/<device>/queue/physical_block_size). In my case it is 16K physical and 4K logical...256 is perfectly fine as sgdisk/fdisk internally decides.
> Disk performance will be severely impacted because of partitioning this way from ceph-deploy , any reason why we are doing like this ?

I don't think ceph-deploy is particularly opinionated on this. Have
you tried using ceph-disk directly to see if the behavior persists?

For OSDs/disks ceph-deploy mostly proxies to a remote node with ceph-disk.
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
