From: Alexey Sheplyakov <asheplyakov@mirantis.com>
Subject: Re: 10.2.4 Jewel released -- IMPORTANT
Date: Fri, 9 Dec 2016 10:15:31 +0400
Message-ID: <CAC7t81ah1By3DktohaCinV5g9XYGb7cUO6nfa8aqu6b7xrxDWg@mail.gmail.com>
References: <877f7c3p6k.fsf@suse.com> <alpine.DEB.2.11.1612072305350.26733@piezo.novalocal>
 <CAC7t81a4Ctd8z7x55k+qzYHE+T5M8Y-3PyFe3t3BtZgNK54FmQ@mail.gmail.com> <CAJ4mKGbLAuVxqsfR-KAFmVthikBiMLPu1UAn+HfpYsqNbY0etg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34760 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752070AbcLIGPc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2016 01:15:32 -0500
Received: by mail-yw0-f171.google.com with SMTP id t125so7058816ywc.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Dec 2016 22:15:32 -0800 (PST)
In-Reply-To: <CAJ4mKGbLAuVxqsfR-KAFmVthikBiMLPu1UAn+HfpYsqNbY0etg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Abhishek L <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

> Hmm, I'd assume in the case of a checksum error you'd expect the data
> to show up again pretty quickly.

"pretty quickly" compared to what?

> In any case I've updated https://github.com/ceph/ceph/pull/12374 to
> deal with that more gracefully by setting a configurable number of
> retry attempts on EAGAIN.

I don't think these retries make sense: CPU will complete those 2 (or even 200)
loops much faster than the missing data could possibly arrive. It's simpler
(and more efficient) to wait for the data with select/[e]poll

Best regards,
       Alexey
