From: John Spray <jspray@redhat.com>
Subject: Re: Luminous 12.1.1 upgrade mgr woes
Date: Tue, 18 Jul 2017 12:32:44 +0100
Message-ID: <CALe9h7crTisnMZNqicOa3Tc=dDxvM-cKCxPmf5cpXfrwvR5Bpg@mail.gmail.com>
References: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35712 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdGRLdG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 07:33:06 -0400
Received: by mail-wr0-f171.google.com with SMTP id w4so24566794wrb.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 04:33:05 -0700 (PDT)
In-Reply-To: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 18, 2017 at 10:03 AM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> Hi,
>
> Just had a go at this - 12.1.1 from a freshly deployed Jewel (10.2.9) on
> Ubuntu 16.04, following
> http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken.
>
> So it all worked ok *except* for the the mgr deploy, this hang at the
> key/caps modification stage (see attached). Now I managed to work around it:
>
> - switch cephx to none in ceph.conf
>
> - restart mon
>
> - redeploy mgr

Hmm, I suspect the issue is with the bootstrap-mgr keyring.  I notice
that when trying a "mgr create" on an upgraded cluster, ceph-deploy is
prompting me to do a "gatherkeys", at which point it generates the
keyring.  However, the bootstrap-mgr identity that I have inside the
mon is weird, its key is AAAAAAAAAAAAAAAA.

Even after I've got the bootstrap-mgr keyring (whose AAA... key
matches the weird one that the mon has), I get EINVAL connecting, and
the mon is logging "error when trying to handle auth request, probably
malformed request".

So yeah, something's pretty broken here!

John


> - edit client.admin and add missing: caps mgr = "allow *"
>
> - switch to cephx again, restart mon, mgr
>
> - ...and continue, but it makes things a whole lot more messy than needed,
> would be good for this not to trip up upgraders on important systems (I'm
> just on a play setup, so no stress here)!
>
> regards
>
> Mark
>
>
