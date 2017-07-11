From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 21:01:25 +0100
Message-ID: <CALe9h7dx-u=PeM=UWNGdkiYy9OZ+5b5yeUhroNNJtxxk4uh9UQ@mail.gmail.com>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal> <1718355157.3684.1499801810149@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35300 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdGKUBr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 16:01:47 -0400
Received: by mail-wr0-f172.google.com with SMTP id k67so3778761wrc.2
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 13:01:46 -0700 (PDT)
In-Reply-To: <1718355157.3684.1499801810149@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Tue, Jul 11, 2017 at 8:36 PM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 11 juli 2017 om 17:03 schreef Sage Weil <sweil@redhat.com>:
>>
>>
>> Hi all,
>>
>> Luminous features a new 'service map' that lets rgw's (and rgw nfs
>> gateways and iscsi gateways and rbd mirror daemons and ...) advertise
>> themselves to the cluster along with some metadata (like the addresses
>> they are binding to and the services the provide).
>>
>> It should be pretty straightforward to build a service that
>> auto-configures haproxy based on this information so that you can deploy
>> an rgw front-end that dynamically reconfigures itself when additional
>> rgw's are deployed or removed.  haproxy has a facility to adjust its
>> backend configuration at runtime[1].
>>
>> Anybody interested in tackling this?  Setting up the load balancer in
>> front of rgw is one of the more annoying pieces of getting ceph up and
>> running in production and until now has been mostly treated as out of
>> scope.  It would be awesome if there was an autoconfigured service that
>> did it out of the box (and had all the right haproxy options set).
>>
>
> Are there easy Python bindings for this? I mean querying the service map.

This could be a good use-case for extending the new `restful` module,
to expose a read-only endpoint for reading the servicemap entries for
a particular type of service.

John

>
> I'm personally a fan of running Varnish (with Hitch for SSL) in front of RGW. Some people might also prefer Traefik [0] since that also supports dynamic configs.
>
> Wido
>
> [0]: https://traefik.io/
>
>> sage
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
