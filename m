From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: No/wrong revdns for redmine tracker SMTP
Date: Thu, 2 Feb 2017 09:34:15 -0800
Message-ID: <CAJ4mKGYanEzVzg8kP1NUMmfAvevaw9=qEKEfQ0yWV17FnF69Fg@mail.gmail.com>
References: <cd43ea70-2b4f-e043-d6e2-6e9d0a86865b@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35750 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdBBReR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 12:34:17 -0500
Received: by mail-ot0-f173.google.com with SMTP id 65so17277262otq.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2017 09:34:16 -0800 (PST)
In-Reply-To: <cd43ea70-2b4f-e043-d6e2-6e9d0a86865b@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, sepia@ceph.com

This probably goes to the sepia list since it's infrastructure.
Shifting it there.

On Thu, Feb 2, 2017 at 2:51 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> Hello,
>
> We're not receiving emails from Ceph's Redmine, because SMTP server that
> sends them doesn't have proper revdns. Excerpt from our mail server log:
>
> [******] NOQUEUE: reject: RCPT from unknown[158.69.68.89]: 450 4.7.1 Client
> host rejected: cannot find your reverse hostname, [158.69.68.89];
> from=<redmine@tracker.ceph.com> to=<piotr.dalek@corp.ovh.com> proto=ESMTP
> helo=<tracker.localdomain>
>
> Also, domain sepecified in "helo" is incorrect.
> Who should I notifty of this? It's not the first time I'm seeing this.
>
> --
> Piotr Dałek
> piotr.dalek@corp.ovh.com
> https://www.ovh.com/us/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
