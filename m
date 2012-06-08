From: Tommi Virtanen <tv@inktank.com>
Subject: Re: mount: 10.0.6.10:/: can't read superblock
Date: Fri, 8 Jun 2012 09:20:39 -0700
Message-ID: <CADvuQREEAKq3AJHe3=1y59VJS36FFVY3dXPcvOLFaYecmjb9xg@mail.gmail.com>
References: <d5061f6f-3671-4eb1-9718-fb78752459f1@mail.linserv.se> <bca9b4eb-f8b0-4366-874a-1c7fcad64835@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56114 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761314Ab2FHQU7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 12:20:59 -0400
Received: by pbbrp8 with SMTP id rp8so2741077pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 09:20:59 -0700 (PDT)
In-Reply-To: <bca9b4eb-f8b0-4366-874a-1c7fcad64835@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jun 5, 2012 at 9:37 PM, Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> 0> 2012-06-06 05:38:37.200297 7f2d5ea08700 -1 mds/AnchorServer.cc: In function 'virtual void AnchorServer::handle_query(MMDSTableRequest*)' thread 7f2d5ea08700 time 2012-06-06 05:38:37.198981
> mds/AnchorServer.cc: 249: FAILED assert(anchor_map.count(curino) == 1)
>
> ceph version 0.46 (commit:cb7f1c9c7520848b0899b26440ac34a8acea58d1)
> 1: (AnchorServer::handle_query(MMDSTableRequest*)+0x175) [0x6bdc95]
> 2: (MDS::handle_deferrable_message(Message*)+0xd84) [0x4b0474]
> 3: (MDS::_dispatch(Message*)+0xaf8) [0x4c50b8]
...
> root@ceph1:~# ceph -v
> ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
> root@ceph1:~# ssh ceph2 ceph -v
> ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
> root@ceph1:~# ssh ceph3 ceph -v
> ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
> root@ceph1:~# ssh ceph4 ceph -v
> ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
>
> is the 0.46 above reporting when the error occurred or am I running the wrong binaries
> i use the debian packages ?

That sounds weird. The ways I can see that being possible are

1. you had daemons still running from when you had 0.46 debs
installed, and the package upgrade didn't restart them -- ceph.git
uses "dh_installinit --no-start", so this might actually have
happened?

2. at some point, you checked out the 0.46 source and ran make
install, and the binaries from that are installed at a path that takes
precedence over the 0.47.2 ones in /usr/sbin

But having mixed versions in your cluster might explain the crashes.
