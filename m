From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Bug #630
Date: Thu, 24 Feb 2011 10:58:38 +0100
Message-ID: <1298541518.2423.124.camel@wido-laptop.pcextreme.nl>
References: <AANLkTi=o9qXJr+SgPZmYtSZ0eZ6q5dyaZQd+eKmqbEVW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:45095 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab1BXJ6z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 04:58:55 -0500
In-Reply-To: <AANLkTi=o9qXJr+SgPZmYtSZ0eZ6q5dyaZQd+eKmqbEVW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Thu, 2011-02-24 at 15:13 +0800, Henry Chang wrote:
> Hi,
> 
> I want to confirm if the following problem is related to Bug #630.
> 
> Step 1. On client A, create a file of 10G by dd.
> "ceph -w" shows the total data size increased by 10G.
> 
> Step 2. On client B, touch the file.
> 
> Step 3. On client A, remove the file.
> "ceph -w" shows the total data size is NOT decreased.
> 
> Step 4. Umount ceph on client B.
> "ceph -w" shows the total data size decreased by 10G.

I tried your test, I'm seeing the same behaviour. I write a 1GB.bin and
4MB.bin and cloned the linux-2.6 tree, after removing them:

pg v7776: 12336 pgs: 12336 active+clean; 767 MB data, 2925 MB used, 544
GB / 558 GB avail

But there is nothing left on the filesystem.

Looking closer I saw that the pool "data" still contained 16937 objects
with a total size of 662876021 bytes.

The "metadata" pool still contains 957 objects, total size is 132289047
bytes.

132289047 + 662876021 = 758MB

That is almost the same as "ceph -s" is reporting.

I removed those files about 2 hours ago, after that there have been no
I/O's on the filesystem.

My replication is on 3 btw.

Wido

> 

