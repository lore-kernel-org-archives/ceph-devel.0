From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph performance improvement / journal on block-dev
Date: Wed, 22 Aug 2012 16:19:32 -0700
Message-ID: <CADvuQRHq-BV3uhUmLkcSH0Ebh1BDTJwnG5z_xt15uV5heZWCDQ@mail.gmail.com>
References: <50349E62.90405@ledeuns.net> <CADvuQRHQmK991u8NO3YH5qifTz-bj87YUfh2xmGRLrMVNZFGQw@mail.gmail.com>
 <5035077D.8090707@ledeuns.net> <CADvuQRFk8ARM-ex1tjr-uf1jzrfxOXeTnQrvkVh222NJZ5Zw7w@mail.gmail.com>
 <20120822191234.GA21826@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40359 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2HVXTz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 19:19:55 -0400
Received: by vcbfk26 with SMTP id fk26so178336vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 16:19:54 -0700 (PDT)
In-Reply-To: <20120822191234.GA21826@oder.kd-bie.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>
Cc: Denis Fondras <ceph@ledeuns.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 22, 2012 at 12:12 PM, Dieter Kasper (KD)
<d.kasper@kabelmail.de> wrote:
>> Your journal is a file on a btrfs partition. That is probably a bad
>> idea for performance. I'd recommend partitioning the drive and using
>> partitions as journals directly.
> can you please teach me how to use the right parameter(s) to realize 'journal on block-dev' ?

Replacing the example paths, use "sudo parted /dev/sdg" or "gksu
gparted /dev/sdg", create partitions, set osd journal to point to a
block device for a partition.

[osd.42]
osd journal = /dev/sdg4

> It looks like something is not OK during 'mkcephfs -a -c /etc/ceph/ceph.conf --mkbtrfs'
> (see below)

Try running it with -x for any chance of extracting debuggable
information from the monster.

> Scanning for Btrfs filesystems
>  HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
> 2012-08-22 21:04:01.519073 7fb475e8b780 -1 journal check: ondisk fsid 8b18c558-8b40-4b07-aa66-61fecb4dd89d doesn't match expected ee0b8bf1-dd4a-459e-a218-3f590f9a8c16, invalid (someone else's?) journal

Based on that, my best guess would be that you're seeing a journal
from an old run -- perhaps you need to explicitly clear out the block
device contents..

Frankly, you should not use btrfs devs. Any convenience you may gain
is more than doubly offset by pains exactly like these.
