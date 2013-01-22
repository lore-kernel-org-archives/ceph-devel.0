From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [0.48.3] OSD memory leak when scrubbing
Date: Tue, 22 Jan 2013 22:32:32 +0100
Message-ID: <CAF6-1L40y-JvBr9J3Cx9p9nX=uEaz+pMrA2+g9rJDV-1AQxqtA@mail.gmail.com>
References: <CAF6-1L5Evp-vz1K4M9tu4vVLfbBzXfgL4+GHBGzGjZJ-KoPt3A@mail.gmail.com>
	<CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44404 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab3AVVcd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:32:33 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so1656713obc.33
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:32:32 -0800 (PST)
In-Reply-To: <CAOLwVUkLdECXqoj2rpOh0hm66FPv0tEe-Z8A1oOj9Geer3NJ+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

> I don't really want to try the mem profiler, I had quite a bad
> experience with it on a test cluster. While running the profiler some
> OSD crashed...
> The only way to fix this is to provide a heap dump. Could you provide one?

I just did:

ceph osd tell 0 heap start_profiler
ceph osd tell 0 heap dump
ceph osd tell 0 heap stop_profiler

and it produced osd.0.profile.0001.heap

Is it enough or do I actually have to leave it running ?

I had to stop the profiler because after doing the dump, the OSD
process was taking 100% of CPU ... stopping the profiler restored it
to normal.

Cheers,

    Sylvain
