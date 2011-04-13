From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: It's not a bug of ceph, but
Date: Wed, 13 Apr 2011 22:32:28 +0300
Message-ID: <4DA5FA4C.7030205@ufm.su>
References: <4DA58180.7090701@ufm.su>	<BANLkTim_rn4uzJSBp+oNVst7nYyVrU3Q=g@mail.gmail.com> <Pine.LNX.4.64.1104130922120.13408@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:35214 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757720Ab1DMTcd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2011 15:32:33 -0400
In-Reply-To: <Pine.LNX.4.64.1104130922120.13408@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Henry Chang <henry.cy.chang@gmail.com>, ceph-devel@vger.kernel.org

On 04/13/2011 07:22 PM, Sage Weil wrote:
> On Wed, 13 Apr 2011, Henry Chang wrote:
>> Hi,
>>
>> 2011/4/13 Fyodor Ustinov<ufm@ufm.su>:
>>> Hi!
>>>
>>> may be anyone seen this trouble?
>> I have seen this when running OSD with ext3 and never seen it after
>> switching to ext4.
> Yeah.  We've seen it on ext3 prior to 2.6.34 or so... ext3 on newer
> kernels (or ext4) seem to be okay.
>
> sage
On this kernel (2.6.38-8-server ubuntu 11.04) i have trouble with ext4 also.

I mount fresh ceph partition on client, test by bonnie++, unmount, stop 
ceph cluster, umount osd ext4 partition and forced fsck this partition.

Mount string on OSD:

/dev/md127 /mfs auto rw,noatime,nodiratime,async,noexec,nodev,user_xattr 0 0

No any messages in kernel log. But:

root@stc1:/home/ufm# umount /mfs
root@stc1:/home/ufm# fsck /dev/md127
fsck from util-linux-ng 2.17.2
e2fsck 1.41.14 (22-Dec-2010)
/dev/md127: clean, 29779/59834368 files, 3887821/239314496 blocks

root@stc1:/home/ufm# fsck -f /dev/md127
fsck from util-linux-ng 2.17.2
e2fsck 1.41.14 (22-Dec-2010)
Pass 1: Checking inodes, blocks, and sizes
Inode 4456487, i_blocks is 8200, should be 8208.  Fix<y>? yes

Inode 4456499, i_blocks is 8208, should be 8200.  Fix<y>? yes

Inode 4456549, i_blocks is 24, should be 16.  Fix<y>? yes

Inode 4456579, i_blocks is 24, should be 16.  Fix<y>? yes

Inode 4456580, i_blocks is 8, should be 16.  Fix<y>? yes

Inode 4456591, i_blocks is 8, should be 16.  Fix<y>? yes

Inode 4456601, i_blocks is 24, should be 16.  Fix<y>? /dev/md127: e2fsck 
canceled.

/dev/md127: ***** FILE SYSTEM WAS MODIFIED *****

May be md. I test now without md.

WBR,
    Fyodor.

