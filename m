From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Bug #630
Date: Thu, 24 Feb 2011 08:09:51 -0700
Message-ID: <1298560191.25491.260.camel@sale659.sandia.gov>
References: <AANLkTi=o9qXJr+SgPZmYtSZ0eZ6q5dyaZQd+eKmqbEVW@mail.gmail.com>
 <1298541518.2423.124.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:38201 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab1BXPKC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 10:10:02 -0500
In-Reply-To: <1298541518.2423.124.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Henry Chang <henry.cy.chang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2011-02-24 at 02:58 -0700, Wido den Hollander wrote:
> Hi,
> 
> On Thu, 2011-02-24 at 15:13 +0800, Henry Chang wrote:
> > Hi,
> > 
> > I want to confirm if the following problem is related to Bug #630.
> > 
> > Step 1. On client A, create a file of 10G by dd.
> > "ceph -w" shows the total data size increased by 10G.
> > 
> > Step 2. On client B, touch the file.
> > 
> > Step 3. On client A, remove the file.
> > "ceph -w" shows the total data size is NOT decreased.
> > 
> > Step 4. Umount ceph on client B.
> > "ceph -w" shows the total data size decreased by 10G.

FWIW, I think it might be.

On client B, try

  echo 2 > /proc/sys/vm/drop_caches

rather than umount, and see if the data size decreases.

--Jim

> 
> I tried your test, I'm seeing the same behaviour. I write a 1GB.bin and
> 4MB.bin and cloned the linux-2.6 tree, after removing them:
> 
> pg v7776: 12336 pgs: 12336 active+clean; 767 MB data, 2925 MB used, 544
> GB / 558 GB avail
> 
> But there is nothing left on the filesystem.
> 
> Looking closer I saw that the pool "data" still contained 16937 objects
> with a total size of 662876021 bytes.
> 
> The "metadata" pool still contains 957 objects, total size is 132289047
> bytes.
> 
> 132289047 + 662876021 = 758MB
> 
> That is almost the same as "ceph -s" is reporting.
> 
> I removed those files about 2 hours ago, after that there have been no
> I/O's on the filesystem.
> 
> My replication is on 3 btw.
> 
> Wido
> 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


