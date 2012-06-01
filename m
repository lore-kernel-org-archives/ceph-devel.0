From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: How will Ceph cope with a failed Journal device?
Date: Fri, 1 Jun 2012 13:35:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206011326020.358@Psilocybe.Update.UU.SE>
References: <2465580.E9977TXsHv@pc10> <CADxhoDTe5mO5-pAzBoZYesCw8MV4TUUzBCYMmmwPfKU4otTrNg@mail.gmail.com>
 <CADvuQREBg4GfouqSVTmBXaTRTfoDSuvZdhMK7MdperStT4Utqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:42535 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2FALfc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 07:35:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id 5AEC23006F
	for <ceph-devel@vger.kernel.org>; Fri,  1 Jun 2012 13:35:30 +0200 (CEST)
In-Reply-To: <CADvuQREBg4GfouqSVTmBXaTRTfoDSuvZdhMK7MdperStT4Utqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, 18 May 2012, Tommi Virtanen wrote:

> Losing a journal with btrfs: creating a new journal should let the osd
> recover the missing parts from replicas (and your data is safe mostly
> because of Ceph replication, recovery is just faster).

Cool! No more SSDs (that might fail over being written to continuously 
after a couple of months depending in size, prize, write cycles etc) just 
add a lot of RAM, keep the journals on tmpfs and make sure to run Ceph on 
Btrfs? While keeping the replicas separated so not all fail at once.

The contents of the storage node will not be corrupt or something (just a 
bit old) when losing the journal?

--jerker
