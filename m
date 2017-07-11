From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [ceph-users] autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 18:04:34 +0200
Message-ID: <CABZ+qqk=kvoTdVebgJrxQ1kdVogY2g9aiSVZKXYzPqGaRAQ+5A@mail.gmail.com>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
 <alpine.DEB.2.11.1707111507220.3424@piezo.novalocal> <CACJqLyY0fhZJtDZ3ZS3OL=K6TcK_S2fPAE1uUGHPmnbuxDHmvw@mail.gmail.com>
 <alpine.DEB.2.11.1707111537290.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35992 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbdGKQFR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 12:05:17 -0400
Received: by mail-oi0-f52.google.com with SMTP id x187so3852981oig.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 09:05:17 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id b188sm489139oia.17.2017.07.11.09.05.15
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 09:05:15 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id x187so3852320oig.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 09:05:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707111537290.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Tue, Jul 11, 2017 at 5:40 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 11 Jul 2017, Haomai Wang wrote:
>> On Tue, Jul 11, 2017 at 11:11 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 11 Jul 2017, Sage Weil wrote:
>> >> Hi all,
>> >>
>> >> Luminous features a new 'service map' that lets rgw's (and rgw nfs
>> >> gateways and iscsi gateways and rbd mirror daemons and ...) advertise
>> >> themselves to the cluster along with some metadata (like the addresses
>> >> they are binding to and the services the provide).
>> >>
>> >> It should be pretty straightforward to build a service that
>> >> auto-configures haproxy based on this information so that you can deploy
>> >> an rgw front-end that dynamically reconfigures itself when additional
>> >> rgw's are deployed or removed.  haproxy has a facility to adjust its
>> >> backend configuration at runtime[1].
>> >>
>> >> Anybody interested in tackling this?  Setting up the load balancer in
>> >> front of rgw is one of the more annoying pieces of getting ceph up and
>> >> running in production and until now has been mostly treated as out of
>> >> scope.  It would be awesome if there was an autoconfigured service that
>> >> did it out of the box (and had all the right haproxy options set).
>> >
>> > [1] https://stackoverflow.com/questions/42678269/haproxy-dynamic-configuration
>>
>> it looks we do more compared to before. do we need to care the
>> lifecycle of haproxy?  we need to manage haproxy in ceph command?
>
> I don't think so, although not having done this much I'm not the
> expert.
>
> My suggestion would be a new package like radosgw-haproxy-agent that
> depends on haproxy and includes a script and some systemd units etc so
> that with minimal configuration (i.e., set up ceph.conf auth key or
> something) it will wake up periodically and refresh the running haproxy's
> config.

So IIUC you want to periodically discover the set of radosgw backends
to fill haproxy.cfg, then reload the haproxy daemons. That would be
useful to (a) keep the set of radosgw hosts up to date and (b) to
provide a high quality haproxy configuration OOTB.

The stackoverflow link you sent is about another interesting use-case
of haproxy -- mapping different urls to different backends. Indeed we
used this in the past to migrate between ceph clusters, bucket by
bucket. And we still use it today to redirect a few very busy buckets
to an isolated set of radosgw's. I can share our config if that helps
explain how this works [2]. And maybe that config can already start a
debate about which are the best settings for an haproxy frontend (I
won't claim ours is generally correct -- happy to hear about how it
could be improved).

I don't know if the bucket mapping concept is generally applicable.
Maybe this haproxy-agent should focus on configuring a single backend
populated with the radosgw's, and leave more complex configurations up
to their admins?

(BTW, we generate this haproxy.cfg dynamically via puppet, which fills
a template by discovering the radosgw hosts in our PuppetDB).

Cheers, Dan

[2] https://gist.github.com/dvanders/857ffcf7249849cffc8d784c55b1a4d5

> We could add a 'ceph-deploy haproxy create ...' command to deploy it,
> along with something similar in ceph-ansible...
>
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
