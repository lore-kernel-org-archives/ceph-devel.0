From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Supplying ID to ceph-disk when creating OSD
Date: Wed, 15 Feb 2017 09:16:58 -0800
Message-ID: <CAJ4mKGZPfWg+WCfYdaobuRj0BgqSatQ11UNTFhvxqNiG2Fh-vw@mail.gmail.com>
References: <1907009558.10080.1487177956475@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35340 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBORRA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 12:17:00 -0500
Received: by mail-ot0-f173.google.com with SMTP id 19so10111794oti.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 09:17:00 -0800 (PST)
In-Reply-To: <1907009558.10080.1487177956475@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 15, 2017 at 8:59 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Currently we can supply a OSD UUID to 'ceph-disk prepare', but we can't provide a OSD ID.
>
> With BlueStore coming I think the use-case for this is becoming very valid:
>
> 1. Stop OSD
> 2. Zap disk
> 3. Re-create OSD with same ID and UUID (with BlueStore)
> 4. Start OSD
>
> This allows for a in-place update of the OSD without modifying the CRUSHMap. For the cluster's point of view the OSD goes down and comes back up empty.
>
> There were some drawbacks around this and some dangers, so before I start working on a PR for this, any gotcaches which might be a problem?

Yes. Unfortunately they are subtle and I don't remember them. :p

I'd recommend going back and finding the historical discussions about
this to be sure. I *think* there were two main issues which prompted
us to remove that:
1) people creating very large IDs, needlessly exploding OSDMap size
because it's all array-based,
2) issues reusing the ID of lost OSDs versus PGs recognizing that the
OSD didn't have the data they wanted.

1 is still a bit of a problem, though if anybody has a good UX way of
handling it that's the real issue. 2 has hopefully been fixed over the
course of various refactors and improvements, but it's not something
I'd count on without checking very carefully.
-Greg

>
> The idea is that users have a very simple way to re-format a OSD in-place while keeping the same CRUSH location, ID and UUID.
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
