From: Haomai Wang <haomai@xsky.com>
Subject: Re: msg/async question
Date: Tue, 13 Jun 2017 10:26:04 +0800
Message-ID: <CACJqLyYC34ep3C5HMnTWd_4eTo2FNc+fnv2DOteM9+DbZ4r-7w@mail.gmail.com>
References: <alpine.DEB.2.11.1706121845530.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0128.outbound.protection.outlook.com ([104.47.125.128]:61488
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753157AbdFMC0M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Jun 2017 22:26:12 -0400
Received: by mail-it0-f51.google.com with SMTP id m62so33320260itc.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 19:26:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706121845530.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

https://github.com/ceph/ceph/pull/15645

On Tue, Jun 13, 2017 at 2:46 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi Haomai,
>
> Ticket http://tracker.ceph.com/issues/20230 is about a busy loop in
> AsyncConnection::handle_connect_msg(). Can you take a look?  I don't
> understand what that block of code is trying to do.
>
> Thanks!
> sage
>
