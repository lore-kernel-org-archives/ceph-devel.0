From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: rbd unmap deadlock
Date: Fri, 2 May 2014 18:40:07 +0200
Message-ID: <CABt9es8uqPXiL4+9aG_JqhHM9RfUU-jP37j1AsMVL+MLeCZ43Q@mail.gmail.com>
References: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
	<5363C338.1090506@ieee.org>
	<CABt9es85qWwoZNwq_-=7NANV8ZejTKbA6jRfE0nxdVhbZd+GMw@mail.gmail.com>
	<CALFYKtBwUhMv_Lw=WrP9NdhSYYTF3J2sxXGgfdjUTZ-kbJgMEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:64342 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbaEBQkI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 May 2014 12:40:08 -0400
Received: by mail-lb0-f176.google.com with SMTP id w7so3229058lbi.7
        for <ceph-devel@vger.kernel.org>; Fri, 02 May 2014 09:40:07 -0700 (PDT)
In-Reply-To: <CALFYKtBwUhMv_Lw=WrP9NdhSYYTF3J2sxXGgfdjUTZ-kbJgMEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 2, 2014 at 6:30 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> Can you succesfully map and then unmap a different image?  What's the
> general state of the cluster, i.e. the output of ceph -s?
>
> Thanks,
>
>                 Ilya

Yes, that was possible, however (as I mentioned) some additional
unmaps also deadlocked (and some succeeded).

Unfortunately I've rebooted the devel machine now (which fixed the
issue). The status of ceph looks pretty much the same as before
though:

    cluster e1206f49-cc79-436e-b69d-375e0374d7a9
     health HEALTH_WARN
     monmap e1: 1 mons at {localhost=192.168.0.215:6789/0}, election
epoch 1, quorum 0 localhost
     osdmap e550: 3 osds: 1 up, 1 in
      pgmap v153419: 892 pgs, 10 pools, 37194 MB data, 10703 objects
            49119 MB used, 299 GB / 349 GB avail
                 892 active+clean

2014-05-02 18:31:57.254360 mon.0 [INF] pgmap v153419: 892 pgs: 892
active+clean; 37194 MB data, 49119 MB used, 299 GB /
 349 GB avail

FYI: This machine runs both the ceph cluster and the clients.

Thank you for your time,
--
Hannes Landeholm
