From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: request improve online mds help
Date: Thu, 14 Sep 2017 14:27:52 -0700
Message-ID: <CA+2bHPYVANBVjceQiS4Y=08qHCqxxdbXj_mJFg2tpgAU_kpaGQ@mail.gmail.com>
References: <CAKRxpuu9Wn9eS4hBQ4BwSHc_TMY6G9hWH7mCYROvsEhgs16sDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:54271 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdINV2Y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 17:28:24 -0400
Received: by mail-it0-f45.google.com with SMTP id 85so1680100ith.2
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 14:28:23 -0700 (PDT)
In-Reply-To: <CAKRxpuu9Wn9eS4hBQ4BwSHc_TMY6G9hWH7mCYROvsEhgs16sDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 14, 2017 at 1:31 PM, Two Spirit <twospirit6905@gmail.com> wrote:
> $ ceph mds ?
>
> mds rmfailed <who> {<confirm>}
> mds repaired <rank>
>
> I thought the <who> was the id since the next line said <rank>, so I
> concluded <who> != <rank>
>
> It is my understanding that this is more correct:
>
> mds rmfailed <rank> {<confirm>}
> mds repaired <rank>

Thanks for pointing that out. Here's the tracker ticket:
http://tracker.ceph.com/issues/21393

-- 
Patrick Donnelly
