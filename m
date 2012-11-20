From: Gregory Farnum <greg@inktank.com>
Subject: Re: Can't start ceph mon
Date: Tue, 20 Nov 2012 10:26:06 -0800
Message-ID: <CAPYLRzg_X2ipWLQeOkLE=hJ-_r9W-eS4=SWdQO525R58PpJxtg@mail.gmail.com>
References: <50ABC929.3000107@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44265 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab2KTS0G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 13:26:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so9049728iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 10:26:06 -0800 (PST)
In-Reply-To: <50ABC929.3000107@bob-the-boat.me.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 20, 2012 at 10:17 AM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
>>Do you have other monitors in working order? The easiest way to handle
>>it if that's the case is just to remove this monitor from the cluster
>>and add it back in as a new monitor with a fresh store. If not we can
>>look into reconstructing it.
>>-Greg
>
>
>>Also, if you still have it, could you zip up your monitor data
>>directory and put it somewhere accessible to us? (I can provide you a
>>drop point if necessary.) We'd like to look at the file layouts a bit
>>since we thought we were properly handling ENOSPC-style issues.
>>-Greg
>
> Greg,
>
> Thanks. I was running only one monitor, so I will need to try to reconstruct things.
>
> If you tell me exactly what to pack up and where to send it, I'll be only too pleased to receive your help...
>
> David

The monitor has a data directory somewhere on your filesystem. It's
configurable but by default is at /var/lib/ceph/mon/. If you can send
me the contents of that we ought to be able to 1) figure out how this
actually happened, and 2) turn it into something that works properly.
:)
Any logs you have (default: /var/log/ceph/mon*) would also be helpful.
-Greg
