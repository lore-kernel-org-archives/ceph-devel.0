From: Haomai Wang <haomai@xsky.com>
Subject: Re: pg_stat_t is 500+ bytes
Date: Wed, 24 Aug 2016 12:02:58 +0800
Message-ID: <CACJqLybzJHWrVF-gOZy6nvUTb0weZJRtqt4rJBO_Nn1viBjDgw@mail.gmail.com>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to> <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0093.outbound.protection.outlook.com ([104.47.126.93]:62688
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751168AbcHXEDU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 00:03:20 -0400
Received: by mail-ua0-f169.google.com with SMTP id k90so8153693uak.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 21:03:03 -0700 (PDT)
In-Reply-To: <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 24, 2016 at 11:01 AM, Haomai Wang <haomai@xsky.com> wrote:
> On Wed, Aug 24, 2016 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
>> This is huge.  It takes the pg_info_t str from 306 bytes to 847 bytes, and
>> this _info omap key is rewritten on *every* IO.
>>
>> We could shrink this down significant with varint and/or delta encoding
>> since a huge portion of it is just a bunch of uint64_t counters.  This
>> will probably cost some CPU time, but OTOH it'll also shrink our metadata
>> down a fair bit too which will pay off later.
>>
>> Anybody want to tackle this?
>
> what about separating "object_stat_collection_t stats" from pg_stat_t?
> pg info should be unchanged for most of times, we could only update
> object related stats. This may help to reduce half bytes.

Or we only store increment values and keep the full in memory(may
reduce to 20-30bytes). In period time we store the full structure(only
hundreds of bytes)....

>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
