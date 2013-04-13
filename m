From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: ceph radosgw cannot work
Date: Sat, 13 Apr 2013 09:37:54 -0700
Message-ID: <CAC-hyiFe-TgkHYNbXvvZc-7N9Vs7DJVj1yEArSvDBxgoyGvRKg@mail.gmail.com>
References: <loom.20130413T170940-905@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:53547 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825Ab3DMQhz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Apr 2013 12:37:55 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so3239172iag.22
        for <ceph-devel@vger.kernel.org>; Sat, 13 Apr 2013 09:37:55 -0700 (PDT)
In-Reply-To: <loom.20130413T170940-905@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: proguest <proguest1942@hotmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Apr 13, 2013 at 8:20 AM, proguest <proguest1942@hotmail.com> wrote:
>
> hi, I'm working with ceph for a while.
> I just follow by the ceph.com step by step,
> but it still not work with restful.
> There're a few problem with it.
>
> here is my ceph.conf
> [client.radosgw.gateway]
>         host = node71
>         keyring = /etc/ceph/keyring.radosgw.gateway
>         rgw socket path = /tmp/radosgw.sock
>         log file = /var/log/ceph/radosgw.log
> and all other conf are all the same with website
>
> http://ceph.com/docs/master/radosgw/config/
>
> by the way , what's the fqdn mean? I just set it the same with
> hostname(node71)
>
> first I use the cmd
> #radosgw
> it reply
> radosgw: must specify 'rgw socket path' to run as a daemon
> but the rgw socket path is already have and set


try:

# radosgw -n client.radosgw.gateway

>
> second I don't understand how to get in ceph radosgw with swift
> i use the cmd
> swift -A http://node71 -U richard -K
> 8ni1ubMgQ\/Jxgnh9z\/QurcZ9v2EUpGoSWEk9wIT9 post test
>
> it just client to apache server

swift -A http://node71/auth ...

>
> then i tried to use
>
> swift -A http://node76:6789/auth -U richard -K
> 8ni1ubMgQ\/Jxgnh9z\/QurcZ9v2EUpGoSWEk9wIT9 post test
>
> node76 is my mon node

Nope, wouldn't work. You need to point it at your web server.

>
> and it can not reach by this cmd
>
> how can I let my radosgw works?
> i really need to fix this problem as soon as possible.
>
> please help me to solve the problems.
> thx
>

Yehuda
