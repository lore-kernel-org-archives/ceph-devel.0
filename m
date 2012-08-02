From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: TIER: combine SSDs and HDDs into a single block device
Date: Thu, 02 Aug 2012 12:02:44 -0500
Message-ID: <501AB2B4.2010406@inktank.com>
References: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54715 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab2HBRCr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 13:02:47 -0400
Received: by obbuo13 with SMTP id uo13so14086264obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 10:02:46 -0700 (PDT)
In-Reply-To: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 8/2/12 11:13 AM, Tommi Virtanen wrote:
> Sounds like bcache in writeback mode. Assumes all underlying block
> devices are RAIDed, or losing one will mean losing data; that is, for
> example RAID1(SSD+SSD) & RAID5(8*HDD).
>
> http://www.lessfs.com/wordpress/?p=776
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Neat!  I'll try to play with it once the test hardware all makes it in.

Alex is also trying to bug the XFS guys (and Sage bugged the BTRFS guys) 
about ways to put metadata on SSD while keeping data on spinning disk. 
It sounds like there is a hack for XFS that would let us keep inodes in 
the lower portion of a volume up to some configurable boundary and then 
we could use lvm to assign that portion of the volume to an SSD.  The 
BTRFS guys have a SOC project in the works to separate out metadata onto 
another disk.

I think these kinds of things could really help our small request 
performance.

Mark

