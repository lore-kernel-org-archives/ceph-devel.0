From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Bug #563 - osd: btrfs, warning at inode.c (
 btrfs_orphan_commit_root )
Date: Mon, 7 Feb 2011 18:38:28 +1100
Message-ID: <20110207073828.GA16034@onthe.net.au>
References: <20110204084808.GA3814@onthe.net.au>
 <Pine.LNX.4.64.1102040920460.26364@cobra.newdream.net>
 <20110207062455.GC25062@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:55835 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab1BGHi2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 02:38:28 -0500
Content-Disposition: inline
In-Reply-To: <20110207062455.GC25062@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Feb 07, 2011 at 05:24:55PM +1100, Chris Dunlop wrote:
> On Fri, Feb 04, 2011 at 09:22:53AM -0800, Sage Weil wrote:
>> On Fri, 4 Feb 2011, Chris Dunlop wrote:
>>> 
>>> http://tracker.newdream.net/issues/563
>>> 
>>> I see this bug was closed 5 days ago. Which commit[s] closed it? I'm
>>> getting it on ceph-client 9aae8fa + btrfs-work bacae12 when I do a
>>> mkcephfs on 3 x 2 GB OSDs, e.g.:
>> 
>> I closed it because it seems to be a btrfs issue that's not specific to 
>> Ceph.  Have you tried Josef's latest tree?  See
>> 
>> http://git.kernel.org/?p=linux/kernel/git/josef/btrfs-work.git;a=summary
> 
> Yup, this warning came up using:
> 
> ceph-client 9aae8faf
> + Josef's btrfs-work bacae123

Sorry, just found I've been booting wrong kernel. I've been
seeing the warning *without* Josef's btrfs-work.  Will re-test
tomorrow.
