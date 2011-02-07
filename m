From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: RE: Bug #563 - osd: btrfs, warning at inode.c (
 btrfs_orphan_commit_root )
Date: Mon, 7 Feb 2011 11:27:42 +0100
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D6717B3D841@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
References: <20110204084808.GA3814@onthe.net.au>
 <Pine.LNX.4.64.1102040920460.26364@cobra.newdream.net>
 <20110207062455.GC25062@onthe.net.au> <20110207073828.GA16034@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail3.alcatel.fr ([64.208.49.56]:45392 "EHLO smail3.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab1BGK6B convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 05:58:01 -0500
In-Reply-To: <20110207073828.GA16034@onthe.net.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


[  282.347591] ------------[ cut here ]------------
[  282.352289] WARNING: at fs/btrfs/inode.c:2161 btrfs_orphan_commit_root+0x7f/0x9b()
[  282.360045] Hardware name: X7SBi-LN4
[  282.363710] Pid: 2297, comm: kworker/0:2 Not tainted 2.6.38-rc3+ #23
[  282.370170] Call Trace:
[  282.372725]  [<ffffffff8103baa9>] ? warn_slowpath_common+0x73/0x87
[  282.379002]  [<ffffffff81260508>] ? btrfs_orphan_commit_root+0x7f/0x9b
[  282.385633]  [<ffffffff81257e0c>] ? commit_fs_roots+0x8d/0xf4
[  282.391487]  [<ffffffff81258acc>] ? btrfs_commit_transaction+0x349/0x61c
[  282.398293]  [<ffffffff81053d3b>] ? autoremove_wake_function+0x0/0x2a
[  282.404842]  [<ffffffff81258d9f>] ? do_async_commit+0x0/0x1b
[  282.410602]  [<ffffffff81258db1>] ? do_async_commit+0x12/0x1b
[  282.416468]  [<ffffffff8104f025>] ? process_one_work+0x1cc/0x2e9
[  282.422605]  [<ffffffff81050dbd>] ? worker_thread+0x123/0x234
[  282.428459]  [<ffffffff81050c9a>] ? worker_thread+0x0/0x234
[  282.434152]  [<ffffffff81050c9a>] ? worker_thread+0x0/0x234
[  282.439848]  [<ffffffff81053915>] ? kthread+0x7a/0x82
[  282.445001]  [<ffffffff810036d4>] ? kernel_thread_helper+0x4/0x10
[  282.451199]  [<ffffffff8105389b>] ? kthread+0x0/0x82
[  282.456263]  [<ffffffff810036d0>] ? kernel_thread_helper+0x0/0x10
[  282.462456] ---[ end trace 466f4ef3f2383e7f ]--- 

With

commit 0eb30e7f58a0a2794211f39ff5b87aae97d784ec
Merge: 410fd12 aba63cd
Author: root <root@bolt.(none)>
Date:   Mon Feb 7 10:04:00 2011 +0100

    Merge branch 'master' of http://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-work into HEAD

commit 410fd12a9067d97ffaac5a950a3d42273f0091db
Merge: 8dbdea8 9c01177
Author: root <root@bolt.(none)>
Date:   Mon Feb 7 09:42:26 2011 +0100

    Merge branch 'unstable' of http://ceph.newdream.net/git/ceph-client into HEAD


And 

ceph version 0.25~rc (commit:06fe1320efe7285f2bc76bcf81c19671f44a70df)


- Jan


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org 
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Chris Dunlop
> Sent: maandag 7 februari 2011 8:38
> To: Sage Weil
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Bug #563 - osd: btrfs, warning at inode.c ( 
> btrfs_orphan_commit_root )
> 
> On Mon, Feb 07, 2011 at 05:24:55PM +1100, Chris Dunlop wrote:
> > On Fri, Feb 04, 2011 at 09:22:53AM -0800, Sage Weil wrote:
> >> On Fri, 4 Feb 2011, Chris Dunlop wrote:
> >>> 
> >>> http://tracker.newdream.net/issues/563
> >>> 
> >>> I see this bug was closed 5 days ago. Which commit[s] 
> closed it? I'm
> >>> getting it on ceph-client 9aae8fa + btrfs-work bacae12 when I do a
> >>> mkcephfs on 3 x 2 GB OSDs, e.g.:
> >> 
> >> I closed it because it seems to be a btrfs issue that's 
> not specific to 
> >> Ceph.  Have you tried Josef's latest tree?  See
> >> 
> >> 
> http://git.kernel.org/?p=linux/kernel/git/josef/btrfs-work.git
;a=summary
> > 
> > Yup, this warning came up using:
> > 
> > ceph-client 9aae8faf
> > + Josef's btrfs-work bacae123
> 
> Sorry, just found I've been booting wrong kernel. I've been
> seeing the warning *without* Josef's btrfs-work.  Will re-test
> tomorrow.
> --
> To unsubscribe from this list: send the line "unsubscribe 
> ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 