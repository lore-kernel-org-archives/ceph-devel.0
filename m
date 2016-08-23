From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: should we remove autotools from master?
Date: Tue, 23 Aug 2016 09:11:13 -0600
Message-ID: <CALqRxCxhLu+bph8hX3NgovaRm60RhoX95r4A=cx8d_kCLZg4ow@mail.gmail.com>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33953 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbcHWPLP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 11:11:15 -0400
Received: by mail-ua0-f169.google.com with SMTP id k90so249698782uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 08:11:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Avner Ben Hanoch <avnerb@mellanox.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 23, 2016 at 7:58 AM, Sage Weil <sweil@redhat.com> wrote:
> Should we remove the autotools stuff from master?
>
> Yes:
> - It won't be maintained
> - It sucks
> - It confuses people and they use it by mistake
> - We'll find any build scripts etc that haven't been converted sooner
> rather than later
>
> No:
> - Other architectures might rely on it
> - It's possible some build scripts haven't been convert yet

yes, bring the pain forward so Kraken is stable :)

- Ken
