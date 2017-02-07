From: Elita Lobo <loboelita@gmail.com>
Subject: Re: Fwd: Disable Load balancing in ceph during repair
Date: Tue, 7 Feb 2017 20:53:38 +0530
Message-ID: <CAA8xDw1DVm4og0wD4LSkyR936d5C5hrKDQ1o5HRE_TDSUm6nDg@mail.gmail.com>
References: <CAA8xDw1g2-__B5riz9KXLJvGMtvP_Ykg9_rs_CrhAsFcwf-ymw@mail.gmail.com>
 <CAA8xDw3W8ujm3XZ=MxzPkDkx0OGmPRyLq5rZ+srQtDd-MHRvFQ@mail.gmail.com> <alpine.DEB.2.11.1702071451470.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33153 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdBGPXj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 10:23:39 -0500
Received: by mail-ua0-f169.google.com with SMTP id i68so86874015uad.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2017 07:23:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702071451470.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, ceph-community@ceph.com

Hello Sage,

Thanks for your fast response. I guess I did not explain the problem
properly. We created a pool with 512 PGs and 25 osds. We bring one osd
down and out. The purpose of our experiment is to test a single
erasure case . However due to load balancing, we observe that in some
PGs  osds other than the one that was brought down are shuffled and a
few are even replaced with new osds. Due to this , the recovery
operation considers this as >1 erasure case for some PGs which is
undesired (Since only 1 osd was brought down in a cluster and each PG
should be affected by at max 1 erasure).  Is there a way we can
prevent this from happening?


Thanking you,
Yours sincerely,
Elita Lobo



On Tue, Feb 7, 2017 at 8:22 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 7 Feb 2017, Elita Lobo wrote:
>> Hi,
>>
>> Is there a way to disable load balancing in ceph (in multiple pg case)
>> whenever an osd goes down?
>> Or can we atleast add a delay before load balancing happens?
>>
>>
>> I am trying to compute the no of erasures in each pg by using the
>> command "ceph pg dump" before and after an osd goes down. The
>> positions of some of the osds get changed due to load balancing.
>> Hence I am unable to get the correct no of erasures due to load
>> balancing happening.
>>
>> Would be grateful if any of the ceph developers could help me figure
>> out a way to find the no of erasures in each pg.
>
> The simplest thing to do is simply
>
>  ceph osd set noout
>
> which will prevent the rebalancing indefinitely.  You can also adjust the
> 'mon osd down out interval' setting on the mon (default 10m IIRC) to be
> something longer.
>
> sage
