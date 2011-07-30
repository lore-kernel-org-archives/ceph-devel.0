From: Christian Brunner <chb@muc.de>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 16:37:43 +0200
Message-ID: <CAO47_-_EC4s1HF1pOGNzPRitYGyigOd1hfgz1qDPy6dqwGMMQA@mail.gmail.com>
References: <4E33D101.1050504@ufm.su>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38193 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1G3Ohq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2011 10:37:46 -0400
Received: by vws1 with SMTP id 1so3569301vws.19
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2011 07:37:45 -0700 (PDT)
In-Reply-To: <4E33D101.1050504@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

This is also reproducable with a RHEL6.1 kernel (2.6.32-131.6.1.el6.x86=
_64). :(

Regards,
Christian

2011/7/30 Fyodor Ustinov <ufm@ufm.su>:
> fail. Epic fail.
>
> Absolutely reproducible.
>
> I have ceph cluster with this configuration:
>
> 8 physical servers
> 14 osd servers.
> Each osd server have personal fs.
> 48T total size of ceph cluster.
> 17T used.
>
> Now, step by step:
>
> 1. Stop ceph server osd0
> /etc/init.d/ceph stop
>
> 2. Make fresh fs for osd
> umount /osd.0
> mkfs.ext4 /dev/sdc1
> tune2fs -o journal_data_writeback /dev/sdc1
> mount -a
> # string from /etc/fstab:
> # /dev/sdc1 /osd.0 =A0 =A0 =A0 =A0 =A0ext4
> =A0user_xattr,rw,noexec,nodev,noatime,nodiratime,data=3Dwriteback,bar=
rier=3D0
> =A0 =A00 =A0 =A0 =A0 2
> ceph mon getmap -o /tmp/monmap
> cosd --mkfs -i 0 --monmap /tmp/monmap
>
> 3. Start ceph server osd0
> /etc/init.d/ceph start
>
> Now, make a big cup of coffee and begin to wait.
>
> After completion of rebalancing do:
> /etc/init.d/ceph stop
> umount /osd.0
> fsck.ext4 -fy /dev/sdc1
>
> and see many-many messages like:
>
> Inode 238551053, i_blocks is 24, should be 32. =A0Fix? yes
>
> Inode 238551054, i_blocks is 40, should be 32. =A0Fix? yes
>
> Inode 238551066, i_blocks is 24, should be 32. =A0Fix? yes
>
> Inode 238944257, i_blocks is 8, should be 16. =A0Fix? yes
>
> Inode 239206414, i_blocks is 8, should be 16. =A0Fix? yes
>
> Inode 239206416, i_blocks is 40, should be 32. =A0Fix? yes
>
> Inode 239206431, i_blocks is 8, should be 16. =A0Fix? yes
>
> Inode 239206441, i_blocks is 24, should be 32. =A0Fix? yes
>
> Voila.
>
> P.S. No any message in syslog. No any message in console.
>
> WBR,
> =A0 =A0Fyodor.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
