From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Bug #563 - osd: btrfs, warning at inode.c (
 btrfs_orphan_commit_root )
Date: Fri, 04 Feb 2011 15:38:12 +0100
Message-ID: <1296830292.2408.0.camel@wido-desktop>
References: <20110204084808.GA3814@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:59078 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab1BDOiM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Feb 2011 09:38:12 -0500
In-Reply-To: <20110204084808.GA3814@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

Hi,

On Fri, 2011-02-04 at 19:48 +1100, Chris Dunlop wrote:
> G'day,
> 
> http://tracker.newdream.net/issues/563
> 
> I see this bug was closed 5 days ago. Which commit[s] closed it? I'm
> getting it on ceph-client 9aae8fa + btrfs-work bacae12 when I do a
> mkcephfs on 3 x 2 GB OSDs, e.g.:

From what I've heard they are working on it upstream (btrfs). Not sure
what the state is though.

Wido

