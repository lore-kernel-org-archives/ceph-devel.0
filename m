From: Sage Weil <sage@newdream.net>
Subject: Re: rocked crash in 12.1.0 release when ran
 fio+libfio_objectstore.so
Date: Wed, 12 Jul 2017 13:56:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707121356090.3424@piezo.novalocal>
References: <CAMwhyqW3vhQRrwRkoxGsbDp8NQZcqA3tVm9eO_E-pb1T3sFANA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1048243660-1499867802=:3424"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44407 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbdGLN4n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 09:56:43 -0400
In-Reply-To: <CAMwhyqW3vhQRrwRkoxGsbDp8NQZcqA3tVm9eO_E-pb1T3sFANA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?xcrB9Q==?= <liupan1111@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, 20702390@qq.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1048243660-1499867802=:3424
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 12 Jul 2017, 攀刘 wrote:
> Hi Cephers,
> 
> When I ran fio_libfio_objectstore.so, I met a crash below after ran 10 mins:
> 
> https://drive.google.com/open?id=0B1m1ON51YNOSTFRHRng3YksxRkk
> 
> I made three disk partitions：
> 1) db part, 50GB
> 2) wal part, 50GB
> 3) data part, others.
> 
> I used all default options of RocksDB.

I haven't seen this one.  Did you exhaust memory?  (Can you reproduce and 
see what the memory utilization looks like?)

sage

> 
> Could anybody have some opinion?
> 
> Thanks
> Pan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1048243660-1499867802=:3424--
