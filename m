From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: /sys/block and /dev and partitions
Date: Tue, 18 Aug 2015 12:53:43 +0300
Message-ID: <CAOi1vP8Mab1M10Gr+L-eWw=tH2hd6A8DK+jm9sxKqCQ3kfG5PQ@mail.gmail.com>
References: <55CF1F99.5050807@dachary.org>
	<alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>
	<55CF5C4B.2010406@dachary.org>
	<CAOi1vP-0Kz6x=nEO=9yijNfS1QzN9hEa0GMQR94Ggv-KCrM=cw@mail.gmail.com>
	<55CFA778.6030703@dachary.org>
	<CAOi1vP--kcWVtWoFCWqgmuB+A0vUX8E3pxoFbVQbTQuLn6hW2Q@mail.gmail.com>
	<55CFB8CE.10508@dachary.org>
	<55D25642.6090001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35539 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbHRJxp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Aug 2015 05:53:45 -0400
Received: by lbcbn3 with SMTP id bn3so98923946lbc.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2015 02:53:43 -0700 (PDT)
In-Reply-To: <55D25642.6090001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 18, 2015 at 12:46 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ilya,
>
> For regular devices such as /dev/vdb2 or /dev/sda3, do you think it is safe to use /sys/dev/block/M:m/partition to figure out the partition number ? Or could it vary depending on the disk driver or the partition table layout ? Or the kernel version ?

Yes, I think it is.  "partition" was added specifically for finding out
partition numbers after extended devt scheme was merged, because it
made it impossible to use arithmetic on minor numbers.  That happened
around 2.6.27 - 2.6.28, so it's a more recent one compared to others,
but I don't think you care about anything pre 2.6.32.

(You could choose not to rely on "partition" and access() "start" for
figuring out if the thing is a partition - it's been around forever,
but then, the only way to figure out the partition index would be to
parse the name, which you want to avoid.)

Thanks,

                Ilya
