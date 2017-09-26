From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: inconsistent pg will not repair
Date: Tue, 26 Sep 2017 10:55:07 -0700
Message-ID: <CAJ4mKGbx1pEWd0b+99t0tmjLanjSUe9OmChWoTgthAkqyVurGA@mail.gmail.com>
References: <CAGbvivJWLXaGzZjAFLpqBFP9N7QHkYt8uZyo9z3qpSnrHz8YZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:51383 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936853AbdIZRzI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 13:55:08 -0400
Received: by mail-io0-f171.google.com with SMTP id l15so13517506iol.8
        for <ceph-devel@vger.kernel.org>; Tue, 26 Sep 2017 10:55:08 -0700 (PDT)
In-Reply-To: <CAGbvivJWLXaGzZjAFLpqBFP9N7QHkYt8uZyo9z3qpSnrHz8YZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

[ Re-send due to HTML email part]

IIRC, this is because the object info and the actual object disagree
about what the checksum should be. I don't know the best way to fix it
off-hand but it's been discussed on the list (try searching for email
threads involving David Zafman).
-Greg

On Tue, Sep 26, 2017 at 7:03 AM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> I have an inconsistent PG that I cannot seem to get to repair cleanly.
> I can find the 3 objects in question and they all have the same size
> and md5sum, but yet whenever I repair it, it is reported as an error
> "failed to pick suitable auth object".
>
> Any suggestions for fixing or workaround this issue to resolve the
> inconsistency?
>
> Ceph 10.2.9
> Ubuntu 16.04.2
>
>
> 2017-09-26 09:54:03.123938 7fd31048e700 -1 log_channel(cluster) log
> [ERR] : 1.5b8 shard 7: soid 1:1daab06b:::100004d6662.00000000:head
> data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
> 1:1daab06b:::100004d6662.00000000:head(204442'221517
> client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
> 203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
> 2017-09-26 09:54:03.123944 7fd31048e700  0 log_channel(cluster) do_log
> log to syslog
> 2017-09-26 09:54:03.123999 7fd31048e700 -1 log_channel(cluster) log
> [ERR] : 1.5b8 shard 26: soid 1:1daab06b:::100004d6662.00000000:head
> data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
> 1:1daab06b:::100004d6662.00000000:head(204442'221517
> client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
> 203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
> 2017-09-26 09:54:03.124005 7fd31048e700  0 log_channel(cluster) do_log
> log to syslog
> 2017-09-26 09:54:03.124013 7fd31048e700 -1 log_channel(cluster) log
> [ERR] : 1.5b8 shard 44: soid 1:1daab06b:::100004d6662.00000000:head
> data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
> 1:1daab06b:::100004d6662.00000000:head(204442'221517
> client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
> 203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
> 2017-09-26 09:54:03.124015 7fd31048e700  0 log_channel(cluster) do_log
> log to syslog
> 2017-09-26 09:54:03.124022 7fd31048e700 -1 log_channel(cluster) log
> [ERR] : 1.5b8 soid 1:1daab06b:::100004d6662.00000000:head: failed to
> pick suitable auth object
> 2017-09-26 09:54:03.124023 7fd31048e700  0 log_channel(cluster) do_log
> log to syslog
> 2017-09-26 09:56:14.461015 7fd31048e700 -1 log_channel(cluster) log
> [ERR] : 1.5b8 deep-scrub 3 errors
> 2017-09-26 09:56:14.461021 7fd31048e700  0 log_channel(cluster) do_log
> log to syslog
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
