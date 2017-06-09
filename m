From: Erik McCormick <emccormick@cirrusseven.com>
Subject: Re: [ceph-users] removing cluster name support
Date: Fri, 9 Jun 2017 12:19:10 -0400
Message-ID: <CAHUi5cOM8zrnZ80RMqJhEwowE6XmM3dnAKJmxNf8E82fM7Nfbg@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal> <alpine.DEB.2.11.1706091602210.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35301 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdFIQTM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jun 2017 12:19:12 -0400
Received: by mail-qt0-f169.google.com with SMTP id w1so81165504qtg.2
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jun 2017 09:19:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706091602210.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Fri, Jun 9, 2017 at 12:07 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 8 Jun 2017, Sage Weil wrote:
>> Questions:
>>
>>  - Does anybody on the list use a non-default cluster name?
>>  - If so, do you have a reason not to switch back to 'ceph'?
>
> It sounds like the answer is "yes," but not for daemons. Several users use
> it on the client side to connect to multiple clusters from the same host.
>

I thought some folks said they were running with non-default naming
for daemons, but if not, then count me as one who does. This was
mainly a relic of the past, where I thought I would be running
multiple clusters on one host. Before long I decided it would be a bad
idea, but by then the cluster was already in heavy use and I couldn't
undo it.

I will say that I am not opposed to renaming back to ceph, but it
would be great to have a documented process for accomplishing this
prior to deprecation. Even going so far as to remove --cluster from
deployment tools will leave me unable to add OSDs if I want to upgrade
when Luminous is released.

> Nobody is colocating multiple daemons from different clusters on the same
> host.  Some have in the past but stopped.  If they choose to in the
> future, they can customize the systemd units themselves.
>
> The rbd-mirror daemon has a similar requirement to talk to multiple
> clusters as a client.
>
> This makes me conclude our current path is fine:
>
>  - leave existing --cluster infrastructure in place in the ceph code, but
>  - remove support for deploying daemons with custom cluster names from the
> deployment tools.
>
> This neatly avoids the systemd limitations for all but the most
> adventuresome admins and avoid the more common case of an admin falling
> into the "oh, I can name my cluster? cool! [...] oh, i have to add
> --cluster rover to every command? ick!" trap.
>

Yeah, that was me in 2012. Oops.

-Erik

> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
