From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: teuthology-suite --rerun puzzle (take 2)
Date: Tue, 22 Nov 2016 14:30:52 -0500
Message-ID: <CA+2bHPb1JxoV9g_TPr85w-BKfx2UBuJ9ZX5EtxBvY1d+ncbvzw@mail.gmail.com>
References: <CA+2bHPZwXDfWrjJ=i-QsAOWaZWVX+JFwmuvbkjh2mVgYQcWShA@mail.gmail.com>
 <ce65792a-3b57-3fc2-f38d-59b693bbaca3@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35252 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbcKVTkn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 14:40:43 -0500
Received: by mail-io0-f172.google.com with SMTP id a124so5580062ioe.2
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 11:40:42 -0800 (PST)
In-Reply-To: <ce65792a-3b57-3fc2-f38d-59b693bbaca3@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 22, 2016 at 11:55 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Patrick,
>
> I'm getting consistent re-run using the following method (not --rerun):
>
> paddles=paddles.front.sepia.ceph.com
> run=loic-2016-11-10_10:23:37-rbd-jewel-backports---basic-smithi
> eval filter=$(curl --silent http://$paddles/runs/$run/ | jq '.jobs[] | select(.status == "dead" or .status == "fail") | .description' | while read description ; do echo -n $description, ; done | sed -e 's/,$//')
> teuthology-suite --priority 1000 --suite rbd --filter="$filter"  ...

Thanks Loic! This worked perfectly.

-- 
Patrick Donnelly
