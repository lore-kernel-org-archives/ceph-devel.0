From: Haomai Wang <haomai@xsky.com>
Subject: Re: pg_stat_t is 500+ bytes
Date: Wed, 24 Aug 2016 11:01:13 +0800
Message-ID: <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0092.outbound.protection.outlook.com ([104.47.93.92]:14800
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751032AbcHXDRc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 23:17:32 -0400
Received: by mail-ua0-f180.google.com with SMTP id k90so6457997uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 20:01:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 24, 2016 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
> This is huge.  It takes the pg_info_t str from 306 bytes to 847 bytes, and
> this _info omap key is rewritten on *every* IO.
>
> We could shrink this down significant with varint and/or delta encoding
> since a huge portion of it is just a bunch of uint64_t counters.  This
> will probably cost some CPU time, but OTOH it'll also shrink our metadata
> down a fair bit too which will pay off later.
>
> Anybody want to tackle this?

what about separating "object_stat_collection_t stats" from pg_stat_t?
pg info should be unchanged for most of times, we could only update
object related stats. This may help to reduce half bytes.

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
