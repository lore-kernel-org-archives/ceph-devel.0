From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Unmountable btrfs filesystems
Date: Sat, 16 Jun 2012 14:12:03 -0500
Message-ID: <4FDCDA83.7070708@inktank.com>
References: <4FDCD484.50706@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65360 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702Ab2FPTMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jun 2012 15:12:06 -0400
Received: by yenl2 with SMTP id l2so2621115yen.19
        for <ceph-devel@vger.kernel.org>; Sat, 16 Jun 2012 12:12:06 -0700 (PDT)
In-Reply-To: <4FDCD484.50706@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 6/16/12 1:46 PM, Wido den Hollander wrote:
> Hi,
>
> On my dev cluster (10 nodes, 40 OSD's) I'm still trying to run Ceph on
> btrfs, but over the last couple of months I've lost multiple OSD's due
> to btrfs.
>
> On my nodes I've set kernel.panic=60 so that whenever a kernel panic
> occurs I get the node back within two minutes.
>
> Now, over the last time I've seen multiple nodes reboot (didn't see the
> strace), but afterwards the btrfs filesystems on that node were
> unmountable.
>
> "btrfs: open_ctree failed"
>
> I tried various kernels, the most recent 3.3.0 from kernel.ubuntu.com,
> but I'm still seeing this.
>
> Is anyone seeing the same or did everybody migrate away to ext4 or XFS?
>
> I still prefer btrfs due to the snapshotting, but loosing all these
> OSD's all the time is getting kind of frustrating.
>
> Any thoughts or comments?
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Hi Wido,

btrfsck might tell you what's wrong.  Sounds like there is a 
btrfs-restore command in the dangerdonteveruse branch you could try. 
Beyond that, I guess it just really comes down to tradeoffs.

Good luck! ;)

Mark
