From: Sage Weil <sage@newdream.net>
Subject: RE: Adding compression support for bluestore.
Date: Wed, 16 Mar 2016 15:15:29 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603161512580.14377@cpach.fuggernut.com>
References: <56C1FCF3.4030505@mirantis.com> <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com> <56C3BAA3.3070804@mirantis.com> <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com> <56CDF40C.9060405@mirantis.com> <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com> <56D08E30.20308@mirantis.com> <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com> <BLUPR0201MB1890A352BFE71C1D74634ED2E88A0@BLUPR0201MB1890.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39716 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934332AbcCPTPr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 15:15:47 -0400
In-Reply-To: <BLUPR0201MB1890A352BFE71C1D74634ED2E88A0@BLUPR0201MB1890.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 16 Mar 2016, Allen Samuels wrote:
> > A potential issue with using WAL for compressed block overwrites is
> > significant WAL data volume increase. IIUC currently WAL record can have up
> > to 2*bluestore_min_alloc_size (i.e. 128K) client data per single write request
> > - overlapped head and tail.
> > In case of compressed blocks this will be up to
> > 2*bluestore_max_compressed_block ( i.e. 8Mb ) as you can't simply
> > overwrite fully overlapped extents - one should operate compression blocks
> > now...
> > 
> > Seems attractive otherwise...
> 
> This is one of the fundamental tradeoffs with compression. When your compression block size exceeds the minimum I/O size you either have to consume time (RMW + uncompress/recompress) or you have to consume space (overlapping extents). Sage's current code essentially starts out by consuming space and then assumes in the background that he'll consume time to recover the space.
> Of course if you set the compression block size equal to or smaller than the minimum I/O size you can avoid these problems -- but you create others (including poor compression, needing to track very small chunks of space, etc.) and nobody seriously believes that this is a viable alternative. 

My inclination would be to set min_alloc_size to something smallish (if 
not 64KB, then 32KB perhaps) and the compression_block to something 
also reasonable (256KB or 512KB at most).  That means you lose some of 
the savings (on average, 1/2 of min_alloc_size) which is more significant 
if compression_block is not >> min_alloc_size, but it avoids the expensive 
r/m/w cases and big read + decompress for a small read request...

sage
