From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: PG stuck stale
Date: Thu, 2 Aug 2012 11:27:56 +0200
Message-ID: <CAF6-1L7anuS_gwSsbdJt8BJLmUrSTwb2xpikHsPhD-wzD8YwjQ@mail.gmail.com>
References: <CAF6-1L5R9DaP778-Wdcpni6C6KpYMd0t3zF9t91CLd5oqAW7ZA@mail.gmail.com>
	<50197493.1040805@inktank.com>
	<5019783E.4010705@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42194 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab2HBJ15 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 05:27:57 -0400
Received: by vbbff1 with SMTP id ff1so7901591vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 02:27:57 -0700 (PDT)
In-Reply-To: <5019783E.4010705@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> I didn't notice before, but since you only have 1 copy of the data,
> no other osds will tell the new osd.0 that it should have those pgs.
> That's why they're stale. You can force osd.0 to notice the pgs it needs
> by running:
>
> ceph pg force_create_pg <pgid>
>
> for each pg that's mapped to osd.0 in 'ceph pg dump'.
>
> Once those are all created, and recovery has noticed that those pgs are
> all out of date, the mark_unfound_lost command should work.

Thanks, it worked.

It didn't go through the "unfound" step though. For the pg that were
empty it was good directly and for the pg that had object in them, it
went to unclean/inactive for a few minutes and then they were back as
just empty pg ... and the cluster was HEALTHY again.

Radosgw however doesn't seem to handle the situation too well because
the bucket that had data in this pg still appears in a 'list' but you
can't delete or list and stat it ...

Cheers,

    Sylvain
