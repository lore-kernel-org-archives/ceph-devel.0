From: John Spray <jspray@redhat.com>
Subject: Re: ceph-mgr setup magic
Date: Thu, 29 Jun 2017 10:43:44 +0100
Message-ID: <CALe9h7c2E3hS5dyvA8xf8pNpJDQ1g4p-X7T4EPasqNqNY8aLYA@mail.gmail.com>
References: <alpine.DEB.2.11.1706281857110.8533@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33215 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdF2JoG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 05:44:06 -0400
Received: by mail-wr0-f173.google.com with SMTP id r103so186683941wrb.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jun 2017 02:44:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706281857110.8533@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Tim Serong <tserong@suse.com>

On Wed, Jun 28, 2017 at 8:04 PM, Sage Weil <sage@newdream.net> wrote:
> There is some goofy behavior with the systemd unit files that tries to
> make a new ceph-mgr daemon automagically appear next to the mons during a
> cluster upgrade:
>
> - The ceph-mon@.service triggers ceph-mgr@ to start
> - The ceph-mgr@.service tries to create a ceph-mgr key using whatever
> mon key it can find
>
> This was intended to ease the upgrade path by auto-creating ceph-mgr
> daemons along the way.
>
> Do we really want this?  I was reminded this behavior is here because of
> #19994, which points out that this isn't implemented for upstart (still
> used by trusty 14.04).

I was thinking of it as a temporary thing for Kraken, because mgr
didn't really do anything so it seemed unreasonable to make people
jump through manual hoops at the time, and the tools support wasn't
there.

For luminous I'm kind of ambivalent about whether to remove it in the
name of cleanliness or leave it in in the name of convenience.

John

> The jewel -> luminous upgrade process is currently documented here
>
>         http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken
>
> and basically has a step that says 'verify mgr daemons are running and, if
> not, create some'.  Is that sufficient?
>
> sage
