From: Sage Weil <sage@newdream.net>
Subject: Re: latency compare between 2t NVME SSD P3500 and bluestore
Date: Wed, 12 Jul 2017 12:02:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707121158300.3424@piezo.novalocal>
References: <CAMwhyqVYiWuAVg_+HJ7xjsNs=BNkH-g5BtHGTDDP4j-5sSGXLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-956442208-1499860936=:3424"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42319 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756250AbdGLMCR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 08:02:17 -0400
In-Reply-To: <CAMwhyqVYiWuAVg_+HJ7xjsNs=BNkH-g5BtHGTDDP4j-5sSGXLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?xcrB9Q==?= <liupan1111@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-956442208-1499860936=:3424
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 12 Jul 2017, 攀刘 wrote:
> Hi Cephers,
> 
> I did some experiment today to compare the latency between one
> P3500(2T nvme SSD) and bluestore(fio + libfio_objectstore.so):
> 
> For iodepth = 1, the random write latency of bluestore is 276.91us,
> compare with 14.71 of SSD, big overhead.
> 
> I also test iodepth = 16, Still, there is a big overhead.(143 us -> 642 us)
> 
> What is your opinion?

There is a lot of work that bluestore is doing over the raw device as it 
is implementing all of the metadata tracking, checksumming, allocation, 
and so on.  There's definitely lots of room for improvement, but I'm 
not sure you can expect to see latencies in the 10s of us.  That said, it 
would be interesting to see an updated flamegraph to see where the time is 
being spent and where we can slim this down.  On a new nvme it's possible 
we can do away with some of the complexity of, say, the allocator, since 
the FTL is performing a lot of the same work anyway.

sage
--8323329-956442208-1499860936=:3424--
