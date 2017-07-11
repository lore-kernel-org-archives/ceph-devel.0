From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: [ceph-users] autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 18:55:22 -0400
Message-ID: <CAKOnar=1eHKp5f=kSCRxi3qH-j7uFMoqirajW2ZONJNofKgiog@mail.gmail.com>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
 <alpine.DEB.2.11.1707111507220.3424@piezo.novalocal> <CACJqLyY0fhZJtDZ3ZS3OL=K6TcK_S2fPAE1uUGHPmnbuxDHmvw@mail.gmail.com>
 <alpine.DEB.2.11.1707111537290.3424@piezo.novalocal> <CABZ+qqk=kvoTdVebgJrxQ1kdVogY2g9aiSVZKXYzPqGaRAQ+5A@mail.gmail.com>
 <alpine.DEB.2.11.1707111614080.3424@piezo.novalocal> <robbat2-20170711T181007-461462320Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35940 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753647AbdGKWzX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 18:55:23 -0400
Received: by mail-pf0-f181.google.com with SMTP id q86so3035425pfl.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 15:55:23 -0700 (PDT)
In-Reply-To: <robbat2-20170711T181007-461462320Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Robin,

On Tue, Jul 11, 2017 at 2:53 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> (Trim lots of good related content).
>
> The upcoming HAProxy 1.8 has landed further patches for improving hot
> restarts/reloads of HAProxy, which previously lead to a brief gap period
> when new connections were not serviced. Lots of other approaches had
> been seen, including delaying TCP SYN momentarily [1]. It also notably
> fixes how you needed a separate wrapper for using haproxy w/ systemd.
>
> In the DreamHost RGW usage, I've been building additional functionality
> into HAProxy via Lua, but I'm not convinced it's the best place for some
> of it:
> - rate-limiting by access key (with explicitly whitelisted & blacklisted
>   keys), over multiple frontends [2]
> - Planned: different rates for different operations/customer classes.
> - Planned: issue redirects for buckets being moved (because getting
>   federated metadata between existing clusters is painful) [3].
>   This differs from the CERN backend-selection-by-bucket, because the
>   bucket is going to be moving regions!

This is really cool.

>
> RGW doesn't seem like the right place for some of this functionality
> either, because storing rate data in multiple places means lots of
> cross-talk.

I'm pretty skeptical about this, though.  RGW isn't becoming a load
balancer, but also needs to make scheduling decisions.  Probably
should know what the load balancer knows when it is present?

>
> [1] https://engineeringblog.yelp.com/2015/04/true-zero-downtime-haproxy-reloads.html
> [2] http://blog.armbruster-it.de/2015/08/neo4j-and-haproxy-some-best-practices-and-tricks/
> [3] http://docs.aws.amazon.com/AmazonS3/latest/dev/Redirects.html
>
>> > I don't know if the bucket mapping concept is generally applicable.
>> > Maybe this haproxy-agent should focus on configuring a single backend
>> > populated with the radosgw's, and leave more complex configurations up
>> > to their admins?
>> Yeah.  (The dynamic remapping is interesting, though!  That could
>> potentially be controlled by rgw as well to automatically isolate busy
>> buckets or objects.)
> Yes, this would fit well to populate a single HAProxy backend w/ the
> available RGWs, and then that can be wrapped with whatever frontend
> configuration (esp. SSL) that the admin wants.
>
>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
>


Matt
