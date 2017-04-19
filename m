From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Ceph-deploy for FreeBSD
Date: Wed, 19 Apr 2017 13:47:06 -0700
Message-ID: <CAJ4mKGZmMv+ZcuBEkvaqajW7ntK26TDEbT77DM+nDFsPxsyDOw@mail.gmail.com>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl> <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:32976 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937671AbdDSUrI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Apr 2017 16:47:08 -0400
Received: by mail-io0-f181.google.com with SMTP id k87so36893076ioi.0
        for <ceph-devel@vger.kernel.org>; Wed, 19 Apr 2017 13:47:08 -0700 (PDT)
In-Reply-To: <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Joao Eduardo Luis <joao@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 14, 2017 at 1:44 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Having solved the first few step in ceph-deploy, I can now get to the
> point where it actually wants to start the first monitor.
> Like:
>     /usr/local/bin/ceph-deploy mon create-initial
>
> And if I look at the other platform booting the inital monitor is
> started thru the init|systemd|upstart....
>
> However under FreeBSD bsdrc I require atleast in ceph.conf
> [mon]
>     host = cephtest
>
> This is not the case on the other platforms?
>
> And how would I otherwise get this into the ceph.conf?

I think you're running into some annoying deployment sharp edges here.
The monitor "host" config value has gone in and out of being necessary
at various times — the whole monitor boot sequence is pretty finicky
so I've added Joao to the thread. It's possible that the way things
are default-configured in FreeBSD that's necessary to work around some
other default configs?
-Greg
