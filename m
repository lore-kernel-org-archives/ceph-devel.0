From: Laurent Barbe <laurent@ksperis.com>
Subject: Re: krbd + format=2 ?
Date: Thu, 04 Jul 2013 16:45:09 +0200
Message-ID: <51D58A75.8060705@ksperis.com>
References: <20130603092428.GB28293@onthe.net.au> <51B2103C.7040402@inktank.com> <20130608024852.GA31065@onthe.net.au> <20130612045949.GA13654@onthe.net.au> <51B94302.1010104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab3GDOpk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jul 2013 10:45:40 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so687983bkb.19
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jul 2013 07:45:38 -0700 (PDT)
In-Reply-To: <51B94302.1010104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Chris Dunlop <chris@onthe.net.au>, Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

Hello,

Since I upgrade kernel 3.10-rc6 to 3.10 final, it seems that the format=
=20
of block device has changed and I can't mount them anymore.
I'm using rbd format 2 / xfs.

Are you aware of this incompatibility?


SGI XFS with ACLs, security attributes, realtime, large block/inode ug=20
enabled
XFS (rbd1): bad magic number
ffff880037241000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .
ffff880037241010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .
ffff880037241020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .
ffff880037241030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .
XFS (rbd1): Internal error xfs_sb_read_verify at line 730 of file t.c.=20
Caller 0xffffffffa0522d95

CPU: 0 PID: 182 Comm: kworker/0:1H Not tainted 3.10.0-ccmbg1 #1
Hardware name: Dell Computer Corporation PowerEdge 860/0XM089, BIOS
Workqueue: xfslogd xfs_buf_iodone_work [xfs]
  ffffffff81362b9c 0000000000000071 ffffffffa0524c61 ffffffffa0522d95
  00000000000002da 0000000000000000 0000000000000016 ffff88007cbdde00
  ffff88003704c800 ffff88007fc1a500 ffffffffa0566222 ffffffffa0522d95
Call Trace:
  [<ffffffff81362b9c>] ? dump_stack+0xd/0x17
  [<ffffffffa0524c61>] ? xfs_corruption_error+0x54/0x6f [xfs]
  [<ffffffffa0522d95>] ? xfs_buf_iodone_work+0x3c/0x6a [xfs]
  [<ffffffffa0566222>] ? xfs_sb_read_verify+0xa4/0xbf [xfs]
  [<ffffffffa0522d95>] ? xfs_buf_iodone_work+0x3c/0x6a [xfs]
  [<ffffffffa0522d95>] ? xfs_buf_iodone_work+0x3c/0x6a [xfs]
  [<ffffffff81046588>] ? process_one_work+0x191/0x28f
  [<ffffffff813650f4>] ? __schedule+0x516/0x51b
  [<ffffffff81046a35>] ? worker_thread+0x121/0x1e7
  [<ffffffff81046914>] ? rescuer_thread+0x269/0x269
  [<ffffffff8104aedd>] ? kthread+0x81/0x89
  [<ffffffff8104ae5c>] ? __kthread_parkme+0x5d/0x5d
  [<ffffffff8136adec>] ? ret_from_fork+0x7c/0xb0
  [<ffffffff8104ae5c>] ? __kthread_parkme+0x5d/0x5d
XFS (rbd1): Corruption detected. Unmount and run xfs_repair
XFS (rbd1): SB validate failed with error 22.

Thanks,

Laurent Barbe


Le 13/06/2013 05:56, Josh Durgin a =E9crit :
> On 06/11/2013 09:59 PM, Chris Dunlop wrote:
>> On Sat, Jun 08, 2013 at 12:48:52PM +1000, Chris Dunlop wrote:
>>> On Fri, Jun 07, 2013 at 11:54:20AM -0500, Alex Elder wrote:
>>>> On 06/03/2013 04:24 AM, Chris Dunlop wrote:
>>>>> I pulled the for-linus branch (@ 3abef3b) on top of 3.10.0-rc4, a=
nd
>>>>> it's
>>>>> letting me map a format=3D2 image (created under bobtail), howeve=
r
>>>>> reading
>>>>> from the block device returns zeros rather than the data. The sam=
e
>>>>> image
>>>>> correctly shows data (NTFS filesystem) when mounted into kvm usin=
g
>>>>> librbd.
>>>>
>>>> Have you tried using a format 2 image that you created using
>>>> the Linux rbd environment?  It would be good to know whether
>>>> that works for you.
>>>
>>> Sorry, how to you mean "created using the Linux rbd environment"?
>>> The one I was trying was created using:
>>>
>>> rbd create --format 2 xxx --size nnnnn
>>>
>>> ...then populated using qemu/librbd.
>>
>> Looks like the kernel rbd and librbd aren't compatible, as at
>> 3.10.0-rc4+ceph-client/for-linus@3abef3b vs librbd1 0.56.6-1~bpo70+1=
=2E
>
> Thanks for the detailed report Chris. The kernel client was using the
> wrong object names for format 2 (zero-padding them with a different
> length than librbd). I just posted a patch fixing this.
>
> Josh
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
