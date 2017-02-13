From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: crush multipick anomaly
Date: Mon, 13 Feb 2017 13:19:45 -0800
Message-ID: <CAJ4mKGZER6SJyjM-=iOZwyKxHBXHc4qMvRSdnO2mTVH_HvZYFQ@mail.gmail.com>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org> <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal>
 <3486c5b8-1d50-5762-c84a-8d1fcecaa775@dachary.org> <alpine.DEB.2.11.1702131913070.7782@piezo.novalocal>
 <365bb618-3718-cd8b-1383-d6f5d51a20cb@dachary.org> <49b7e4ae-dae7-ed51-b5b3-96da5cf37129@dachary.org>
 <alpine.DEB.2.11.1702132111140.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33699 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdBMVTr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 16:19:47 -0500
Received: by mail-oi0-f48.google.com with SMTP id w204so58644300oiw.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 13:19:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702132111140.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 13, 2017 at 1:15 PM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 13 Feb 2017, Loic Dachary wrote:
>> I get the expected behavior for replica 1 (which is what
>> CRUSH.straw2_reweight does). The movement between buckets observered
>> below is for replica 2.
>
> Oh, right, now I remember.  The movement for the second replica is
> unavoidable (as far as I can see).  For the second replica, sometimes we
> end up picking a dup (the same thing we got for the first
> replica) and trying again; any change in the behavior of the first choice
> may mean that we have more or less "second tries."  Although any given try
> will behave as we like (only moving to or from the reweighted item),
> adding new tries will pick uniformly.  In your example below, I think all
> of the second replicas that moved to osds 0-9 were objects that originally
> picked a dup for the second try and, once 10 was added, did not--because
> the first replica was now on the new osd 10.

Just to be clear, that's within a bucket, right?
Because obviously changing bucket weights in the CRUSH hierarchy will
move new data to them, not all of which ends up on the new disk.
-Greg
