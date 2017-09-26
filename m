From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: inconsistent pg will not repair
Date: Tue, 26 Sep 2017 15:40:18 -0400
Message-ID: <CAGbvivLkt1u8wnkw=edhMj9dBvRM_p+F-Xs7RY8bf0Em4dkZ0Q@mail.gmail.com>
References: <CAGbvivJWLXaGzZjAFLpqBFP9N7QHkYt8uZyo9z3qpSnrHz8YZQ@mail.gmail.com>
 <CAJ4mKGbx1pEWd0b+99t0tmjLanjSUe9OmChWoTgthAkqyVurGA@mail.gmail.com> <61c697d9-2c0e-d694-3bfb-df8b2338606c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:48939 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934038AbdIZTkV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 15:40:21 -0400
Received: by mail-lf0-f50.google.com with SMTP id q132so5598658lfe.5
        for <ceph-devel@vger.kernel.org>; Tue, 26 Sep 2017 12:40:20 -0700 (PDT)
In-Reply-To: <61c697d9-2c0e-d694-3bfb-df8b2338606c@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Thank you!  That worked, finally cleared that one out.

On Tue, Sep 26, 2017 at 3:16 PM, David Zafman <dzafman@redhat.com> wrote:
>
> The following is based on the discussion in:
> http://tracker.ceph.com/issues/21388
>
> ------
>
> There is a particular scenario which if identified can be repaired manually.
> In this case the automatic repair rejects all copies because none match the
> selected_object_info thus setting data_digest_mismatch_oi on all shards.
>
> Doing the following should produce list-inconsistent-obj information:
>
> $ ceph pg deep-scrub 1.0
> (Wait for scrub to finish)
> $ rados list-inconsistent-obj 1.0 --format=json-pretty
>
> Requirements:
>
> data_digest_mismatch_oi is set on all shards make it unrepairable
> union_shard_errors has only data_digest_mismatch_oi listed, no other issues
> involved
> Object "errors" is empty { "inconsistent": [ { ..."errors": []....} ] }
> which means the data_digest value is the same on all shards (0x2d4a11c2 in
> the example below)
> No down OSDs which might have different/correct data
>
> To fix use rados get/put followed by a deep-scrub to clear the
> "inconsistent" pg state.  Use -b option with a value smaller than the file
> size so that the read doesn't compare the digest and return EIO.
>
> rados -p pool -b 10240 get mytestobject tempfile
> rados -p pool put mytestobject tempfile
> ceph pg deep-scrub 1.0
>
>
> Here is an example list-inconsistent-obj output of what this scenario looks
> like:
>
> {
>   "inconsistents": [
>     {
>       "shards": [
>         {
>           "data_digest": "0x2d4a11c2",
>           "omap_digest": "0xf5fba2c6",
>           "size": 143456,
>           "errors": [
>             "data_digest_mismatch_oi"
>           ],
>           "osd": 0,
>           "primary": true
>         },
>         {
>           "data_digest": "0x2d4a11c2",
>           "omap_digest": "0xf5fba2c6",
>           "size": 143456,
>           "errors": [
>             "data_digest_mismatch_oi"
>           ],
>           "osd": 1,
>           "primary": false
>         },
>         {
>           "data_digest": "0x2d4a11c2",
>           "omap_digest": "0xf5fba2c6",
>           "size": 143456,
>           "errors": [
>             "data_digest_mismatch_oi"
>           ],
>           "osd": 2,
>           "primary": false
>         }
>       ],
>       "selected_object_info": "3:ce3f1d6a::: mytestobject:head(47'54
> osd.0.0:53 dirty|omap|data_digest|omap_digest s 143456 uv 3 dd 2ddbf8f5 od
> f5fba2c6 alloc_hint [0 0 0])",
>       "union_shard_errors": [
>         "data_digest_mismatch_oi"
>       ],
>       "errors": [
>       ],
>       "object": {
>         "version": 3,
>         "snap": "head",
>         "locator": "",
>         "nspace": "",
>         "name": "mytestobject"
>       }
>     }
>   ],
>   "epoch": 103443
> }
>
>
> David
>
>
> On 9/26/17 10:55 AM, Gregory Farnum wrote:
>
> [ Re-send due to HTML email part]
>
> IIRC, this is because the object info and the actual object disagree
> about what the checksum should be. I don't know the best way to fix it
> off-hand but it's been discussed on the list (try searching for email
> threads involving David Zafman).
> -Greg
>
> On Tue, Sep 26, 2017 at 7:03 AM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
