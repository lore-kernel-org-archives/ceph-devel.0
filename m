From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: ceph nagios plugins
Date: Tue, 1 Aug 2017 10:12:01 -0600
Message-ID: <CALqRxCw2EWH4cHuogSgYSFrqZa0F-nfdgbgG_R1PUbkJekcheg@mail.gmail.com>
References: <alpine.DEB.2.11.1708011414210.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36789 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdHAQMD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Aug 2017 12:12:03 -0400
Received: by mail-ua0-f175.google.com with SMTP id k43so9153651uaf.3
        for <ceph-devel@vger.kernel.org>; Tue, 01 Aug 2017 09:12:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708011414210.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: valery.tschopp@switch.ch, ceph-devel <ceph-devel@vger.kernel.org>

Hi Valery,

We discussed this a bit more in #ceph-devel today. Would you be ok
with moving the Git repo into the https://github.com/ceph org? Then
we'd preserve Git history, make it easier to package and distribute,
etc.

- Ken


On Tue, Aug 1, 2017 at 8:30 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi Valery,
>
> We're thinking about bringing the nagios plugins into the ceph tree to
> make them easier to find for users (e.g., making ceph-nagios-plugins
> available in the upstream ceph.com repos).  It looks like these are the
> most complete (and most commonly used) plugins out there.
>
> Would you object to pulling
>
>         https://github.com/valerytschopp/ceph-nagios-plugins
>
> into ceph.git (into, say, contrib/nagios)?
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
