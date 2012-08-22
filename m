From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph performance improvement
Date: Wed, 22 Aug 2012 09:29:12 -0700
Message-ID: <CADvuQRFk8ARM-ex1tjr-uf1jzrfxOXeTnQrvkVh222NJZ5Zw7w@mail.gmail.com>
References: <50349E62.90405@ledeuns.net> <CADvuQRHQmK991u8NO3YH5qifTz-bj87YUfh2xmGRLrMVNZFGQw@mail.gmail.com>
 <5035077D.8090707@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41418 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab2HVQ3e convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 12:29:34 -0400
Received: by qaas11 with SMTP id s11so4628169qaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 09:29:33 -0700 (PDT)
In-Reply-To: <5035077D.8090707@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 22, 2012 at 9:23 AM, Denis Fondras <ceph@ledeuns.net> wrote=
:
>> Are you sure your osd data and journal are on the disks you think? T=
he
>> /home paths look suspicious -- especially for journal, which often
>> should be a block device.
> I am :)
=2E..
> -rw-r--r-- 1 root root 1048576000 ao=C3=BBt  22 17:22 /home/osd.0.jou=
rnal

Your journal is a file on a btrfs partition. That is probably a bad
idea for performance. I'd recommend partitioning the drive and using
partitions as journals directly.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
