From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: radosgw: shadow objects
Date: Thu, 29 Sep 2011 23:17:01 -0700
Message-ID: <CAC-hyiHE3zn-DJKV+989ZKZyu1WCL1=KiP39qTJ7MtM4R9QViQ@mail.gmail.com>
References: <CANExM-MPCAj9pzZUSciMrSxg+r=VJ9J9GUH88U-MvzDsyZJp7A@mail.gmail.com>
	<CAC-hyiHzFympqYkYgNvs+1UJ78588QCgMZje7P-340hirNEteA@mail.gmail.com>
	<CANExM-P2ZPSW4g2D59=0W4NSqdSZmF4Mt9H=GafbZvs5GTa+og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64001 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab1I3GRC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Sep 2011 02:17:02 -0400
Received: by bkbzt4 with SMTP id zt4so1389072bkb.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2011 23:17:01 -0700 (PDT)
In-Reply-To: <CANExM-P2ZPSW4g2D59=0W4NSqdSZmF4Mt9H=GafbZvs5GTa+og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 29, 2011 at 8:17 PM, Henry C Chang <henry.cy.chang@gmail.com> wrote:
> I see the reason now, but is the "period" configurable?

There is no such automatic period. You'll need to set up a cron job or
something similar to get radosgw-admin to clean up all the craft.

> Another question is: it seems the shadow object is to prevent racing
> between concurrent r/w. Why do we need to keep those objects so long?
>

There is no way to actually know whether there are concurrent
operations on an object. There can be a slow read going on an object
while we write into it and we don't want that read to break.

Yehuda
