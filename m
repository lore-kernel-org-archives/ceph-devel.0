From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: Cache pool bug?
Date: Tue, 28 Oct 2014 12:28:33 +0800
Message-ID: <CANE=7sWu2aXfAYRXNTqkUvGkxmkyYjmeJbt=j-8SaUNwbu4Rvw@mail.gmail.com>
References: <CANE=7sUW0e-vp8LROZFA+5BGNoENA4MLthsnPUKb1ks=hnoyEA@mail.gmail.com>
	<BLU169-W9B3F7EAC2250B1425B560DA9E0@phx.gbl>
	<06E7D85B3BA36C4DB207FEDE871C5348950BD2@SHSMSX101.ccr.corp.intel.com>
	<alpine.DEB.2.00.1410270902320.13498@cobra.newdream.net>
	<CANE=7sVJLeCBkSzNM9cC0k0YOCgapBdMVeYP=GqncTKtup5eKw@mail.gmail.com>
	<06E7D85B3BA36C4DB207FEDE871C5348950D90@SHSMSX101.ccr.corp.intel.com>
	<alpine.DEB.2.00.1410272100310.7897@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:60567 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaJ1E2e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 00:28:34 -0400
Received: by mail-oi0-f46.google.com with SMTP id g201so2583424oib.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 21:28:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410272100310.7897@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think if it changed to be  *atime = p->first, Below logic should
also be modified.

ReplicatedPG::agent_maybe_evict

    if (atime < 0 && obc->obs.oi.mtime != utime_t()) {
      if (obc->obs.oi.local_mtime != utime_t()) {
        atime = ceph_clock_now(NULL).sec() - obc->obs.oi.local_mtime;
      } else {
        atime = ceph_clock_now(NULL).sec() - obc->obs.oi.mtime;
      }
    }


including
ReplicatedPG::agent_estimate_atime_temp
  if (temp)
    *temp = 0;
  if (hit_set->contains(oid)) {
    *atime = 0;
    if (temp)
      ++(*temp);
    else
      return;
  }

2014-10-28 12:02 GMT+08:00 Sage Weil <sage@newdream.net>:
> Yep.  The pull request looks is correct too, but needs to be squashed into
> a single commit with a Signed-off-by: line and description.
>
> Zhiqiang, I think the reversed logic you just fixed in agent_maybe_evict()
> was partly because this function is filling in atime (which sounds like a
> timestamp) with an *age* (now - p->first).  I think we should change
>
>>       if (*atime < 0)
>>       *atime = now - p->first;
>
> to be
>
>  *atime = p->first
>
> and/or adjust the caller accordingly...?
>
> sage
