From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: testing ceph
Date: Thu, 31 Oct 2013 10:55:56 +0000
Message-ID: <5272373C.4020906@inktank.com>
References: <DUB116-W8372DACD4F54B9145260E4E00B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:57358 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab3JaKz6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Oct 2013 06:55:58 -0400
Received: by mail-we0-f178.google.com with SMTP id q59so2546207wes.9
        for <ceph-devel@vger.kernel.org>; Thu, 31 Oct 2013 03:55:57 -0700 (PDT)
In-Reply-To: <DUB116-W8372DACD4F54B9145260E4E00B0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: charles L <charlesboy009@hotmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/31/2013 04:54 AM, charles L wrote:
> Hi,
> Pls is this a good setup for a production environment test of ceph? My focus is on the SSD ... should it be partitioned(sdf1,2 ,3,4) and shared by the four OSDs on a host? or is this a better configuration for the SSD to be just one partition(sdf1) while all osd uses that one partition?
> my setup:
> - 6 Servers with one 250gb boot disk for OS(sda),
> four-2Tb Disks each for the OSDs i.e Total disks = 6x4 = 24 disks (sdb -sde)
> and one-60GB SSD for Osd Journal(sdf).
> -RAM = 32GB on each server with 2 GB network link.
> hostname for servers: Server1 -Server6

Charles,

What you are describing on the ceph.conf below is definitely not a good 
idea.  If you really want to use just one SSD and share it across 
multiple OSDs, then you have two possible approaches:

- partition that disk and assign a *different* partition to each OSD; or
- keep only one partition, format it with some filesystem, and assign a 
*different* journal file within that fs to each OSD.

What you are describing has you using the same partition for all OSDs. 
This will likely create issues due to multiple OSDs writing and reading 
from a single journal.  TBH I'm not familiar enough with the journal 
mechanism to know whether the OSDs will detect that situation.

   -Joao

>
> [osd.0]
>   host = server1
> devs = /dev/sdb
> osd journal = /dev/sdf1
> [osd.1]
> host = server1
> devs = /dev/sdc
> osd journal = /dev/sdf2
>
> [osd.3]
> host = server1
> devs = /dev/sdd
> osd journal = /dev/sdf2
>
> [osd.4]
> host = server1
> devs = /dev/sde
> osd journal = /dev/sdf2
> [osd.5]
> host = server2
> devs = /dev/sdb
> osd journal = /dev/sdf2
> ...
> [osd.23]
> host = server6
> devs = /dev/sde
> osd journal = /dev/sdf2
>
> Thanks. 		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
