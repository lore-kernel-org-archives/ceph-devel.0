From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: creation of ./.snap/test creates something in ./subdir/.snap/
Date: Mon, 21 Jun 2010 09:30:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1006210908450.25950@Psilocybe.Update.UU.SE>
References: <hvhrh3$n0a$1@dough.gmane.org> <Pine.LNX.4.64.1006190833230.17737@cobra.newdream.net>
 <hvipog$r1f$1@dough.gmane.org>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:42489 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab0FUHg4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jun 2010 03:36:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id D48D230079
	for <ceph-devel@vger.kernel.org>; Mon, 21 Jun 2010 09:30:34 +0200 (CEST)
In-Reply-To: <hvipog$r1f$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi all,

It would be sweet to get shadow copy for Samba to work with Ceph 
snapshots. This blog entry (for ZFS) might be a good start if anyone is 
interested in experimenting and documenting (for Ceph)!

http://www.edplese.com/blog/2009/12/02/samba-shadow_copy2-enhancements/

One difference seem to be that Samba is expecting the snapshots to be per 
volume and not per directory, but I havn't had time to look into it 
further.

--jerker


On Sat, 19 Jun 2010, Thomas Mueller wrote:

> thanks for the explanation! i've created
>
> http://ceph.newdream.net/wiki/Snapshots
>
> for future  reference.

