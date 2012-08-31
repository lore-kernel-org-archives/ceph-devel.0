From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: RE: RBD performance - tuning hints
Date: Fri, 31 Aug 2012 12:58:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1208311225570.25096@Psilocybe.Update.UU.SE>
References: <503F91EF.7020807@inktank.com> <1ab6cbb8-de0c-4d24-953b-98eced2f4ae2@mailpro>
 <24E144B8C0207547AD09C467A8259F755760304F@lisa.maurer-it.com>
Reply-To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:36167 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab2HaK6D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 06:58:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id 78CC3300B2
	for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 12:58:00 +0200 (CEST)
In-Reply-To: <24E144B8C0207547AD09C467A8259F755760304F@lisa.maurer-it.com>
Content-ID: <Pine.LNX.4.64.1208311244381.25096@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 31 Aug 2012, Dietmar Maurer wrote:

>>> RBD waits for the data to be on disk on all replicas. It's pretty easy
>>> to relax this to in memory on all replicas, but there's no option for
>>> that right now.
>
> I thought that is dangerous, because you can loose data?

By putting the journal in a tmpfs then data written to the journal does 
not hit disk. If all replicas fail data will be lost.

For some use cases that might be ok. For example incremental backups or 
fast scratch space or volatile virtual machines etc.

Also see this previous discussion:

http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg06070.html

--jerker
