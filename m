From: Sage Weil <sage@newdream.net>
Subject: Re: Questions for NVRAM+SATA SSDs with Bluestore
Date: Mon, 27 Jun 2016 12:31:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606271229510.2844@piezo.us.to>
References: <CAFNt83a4mnNhO722drHTB_FavwzFfHJpRfCbUg8En2WpRHZWdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1305960165-1467030688=:2844"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53001 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcF0Mb3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 08:31:29 -0400
In-Reply-To: <CAFNt83a4mnNhO722drHTB_FavwzFfHJpRfCbUg8En2WpRHZWdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: myoungwon oh <ohmyoungwon@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1305960165-1467030688=:2844
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 27 Jun 2016, myoungwon oh wrote:
> Hi, I have questions for bluestore (4K random write case).
> 
> So far, we have used NVRAM(PCIe) as journal and SSD (SATA) as data
> disk (filestore).
> Therefore, we got performance gain from NVRAM journal.
> However, current Bluestore design seems that data (4K aligned) is
> written to data disk first, then metadata is written to WAL rocksdb.
> This design can remove “double write” in objectstore, but in our case,
> NVRAM can not be utilized fully.
> 
>  So, my questions are that
> 
> 1. Can bluestore write WAL first as filestore?

You can do it indirectly with bluestore_min_alloc_size=65536, which will 
send anything smaller than this value through the wal path.  Please let 
us know what effect this has on our latency/performance!

> 2. If not, using bcache or flashcache for NVRAM on top of SSDs is right 
> answer?

This is also possible, but I expect we'd like to make this work out of the 
box if we can!

sage

--8323329-1305960165-1467030688=:2844--
