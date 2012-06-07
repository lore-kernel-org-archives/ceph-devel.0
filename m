From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: Ceph and BackupPC
Date: Thu, 7 Jun 2012 10:02:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206070934110.358@Psilocybe.Update.UU.SE>
References: <c99406dc-0969-47de-a75a-72a8f42eae52@mail.linserv.se>
 <3941218.dafc4yYMCO@pc10>
Reply-To: ceph-devel <ceph-devel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:57145 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454Ab2FGICt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 04:02:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id AB91D3007E
	for <ceph-devel@vger.kernel.org>; Thu,  7 Jun 2012 10:02:47 +0200 (CEST)
In-Reply-To: <3941218.dafc4yYMCO@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 6 Jun 2012, Guido Winkelmann wrote:

> I'm asking because BackupPC is the only application I know of that actually
> makes heavy use of hardlinks.

I used to run "rsync --link-dest" to create snapshot-like directories with 
hard links but have been using real ZFS snapshots lately.

--jerker
