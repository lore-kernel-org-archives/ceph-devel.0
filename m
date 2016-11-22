From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: uint32_t BlueStore::Extent::logical_offset?
Date: Tue, 22 Nov 2016 12:06:03 -0500
Message-ID: <CAJ4mKGZ8=fikstiyfN_K23n=rBqRx8h-Umri7UOwhM6mfhNe-Q@mail.gmail.com>
References: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38203 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbcKVROk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 12:14:40 -0500
Received: by mail-it0-f51.google.com with SMTP id j191so17257312ita.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 09:14:39 -0800 (PST)
In-Reply-To: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 22, 2016 at 11:58 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Hi Sage,
>
>
> I'm wondering why BlueStore::Extent::logical_offset is 32-bit wide.
>
> IMHO it's to be uint64_t unless we limit onode size to 4Gb.
>
> Looks like we have implicit truncate when doing set_lextent/new Extent at
> the moment and hence some issues with large onodes are possible.

onodes represent a single RADOS object within BlueStore, don't they?
So 4GB is much more than we need; the rest of the system on top is
going to fail well before you reach that size.
-Greg

>
> Thanks,
> Igor
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
