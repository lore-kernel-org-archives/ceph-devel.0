From: Sage Weil <sage@newdream.net>
Subject: Re: question about backfill on erasure pool
Date: Tue, 13 Dec 2016 12:48:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612131247350.32565@piezo.novalocal>
References: <CABAwU-b6m6xfLXvLwfR4DXMxW4kwzyvVYpKPm_NzRxzDWoROVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56742 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbcLMMsJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 07:48:09 -0500
In-Reply-To: <CABAwU-b6m6xfLXvLwfR4DXMxW4kwzyvVYpKPm_NzRxzDWoROVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 13 Dec 2016, huang jun wrote:
> hi,all
> i have a question about pg backfill on erasure pool.
> pg0 in erasure pool, which k:m=2:1,
> at first, pg0 on osd [1,2,3], after osd.4 added,
> the pg0 is now distribute to osd [1,2,4],
> for replicated pool, it will do backfill from primary(osd.1) to osd.4,
> for erasure code pool, the primary osd.1 needs to read the data chunks
> from osd.1 and osd.2,
> then decode and push the parity chunk to osd.4,
> in the above case, the osd.3 is up and contain the parity chunk,
> why dont let osd.3 push the parity chunk to osd.4?

I don't think there is any reason why we couldn't... it just hasn't been 
implemented.  Sam?

sage
