From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 13:46:17 -0700
Message-ID: <CAFMfnwowPY+Kzeh3m1U2zQ5ys7iumqy5RJuaAefTCsySbBEq8g@mail.gmail.com>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36022 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbdGKUqT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 16:46:19 -0400
Received: by mail-yw0-f182.google.com with SMTP id a12so1649738ywh.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 13:46:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

With civetweb, radosgw needs a thread per connection, so recently I've
been using haproxy on each node running radosgw, with the backend
being only the local radosgw process. Combined with the haproxy
configuration setting "option http-server-close", haproxy will hold
open the connection to the client, but close the connection between it
and civetweb/rgw after the request finishes. Putting a pile of radosgw
nodes behind haproxy is fine and all, but doesn't scale cluster
ingress/egress beyond the pipe size of the haproxy node.

It might be a bigger win to look into doing something with IPVS / LVS,
which can do direct server return (scaling egress). Perhaps some sort
of service that pokes the service map and uses it to run commands with
ipvsadm and ensures a heartbeat service is setup via
keepalived/corosync.

To scale ingress *and* egress, we'd need to wire the service map
feature into a bgp/osfp speaker like bird/quagga in order to
inject/remove equal cost multipath routes to $virtual_ip/32 and/or
$virtual_ip6/128 with the upstream router(s).

On Tue, Jul 11, 2017 at 8:03 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi all,
>
> Luminous features a new 'service map' that lets rgw's (and rgw nfs
> gateways and iscsi gateways and rbd mirror daemons and ...) advertise
> themselves to the cluster along with some metadata (like the addresses
> they are binding to and the services the provide).
>
> It should be pretty straightforward to build a service that
> auto-configures haproxy based on this information so that you can deploy
> an rgw front-end that dynamically reconfigures itself when additional
> rgw's are deployed or removed.  haproxy has a facility to adjust its
> backend configuration at runtime[1].
>
> Anybody interested in tackling this?  Setting up the load balancer in
> front of rgw is one of the more annoying pieces of getting ceph up and
> running in production and until now has been mostly treated as out of
> scope.  It would be awesome if there was an autoconfigured service that
> did it out of the box (and had all the right haproxy options set).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Kyle Bader
