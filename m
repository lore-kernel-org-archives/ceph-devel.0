From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Thu, 29 Jun 2017 15:33:30 -0400
Message-ID: <CA+aFP1A8KfoYMBR163YQKbqJLSWyBuXab3Z1qcqJ8FDdkWgppA@mail.gmail.com>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com> <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f181.google.com ([209.85.213.181]:35472 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdF2Tdb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 15:33:31 -0400
Received: by mail-yb0-f181.google.com with SMTP id b81so32020737yba.2
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 12:33:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mohamad Gebai <mgebai@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jun 29, 2017 at 3:25 PM, Sage Weil <sage@newdream.net> wrote:
> IIRC Igor hit this by doing 4KB random writes via the fio ObjectStore
> driver.  I suspect we'd see a similar with the OSD and 4KB writes, but
> never confirmed.

There was also a recent ticket for the librbd client-side cache using
up exactly 2x the amount RAM as expected under 4K workloads. I haven't
looked into it yet, but I can see how "raw_combined" could potentially
cause this ballooning that I haven't seen before (I used to expect it
on <4K workloads under hammer).

-- 
Jason
