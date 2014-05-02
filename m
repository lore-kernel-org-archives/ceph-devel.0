From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: rbd unmap deadlock
Date: Fri, 2 May 2014 20:52:23 +0400
Message-ID: <CALFYKtCPUf1gJCHife3xqqcsh4CZ2scQ+P2htDpN9VmecD38fw@mail.gmail.com>
References: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
	<5363C338.1090506@ieee.org>
	<CABt9es85qWwoZNwq_-=7NANV8ZejTKbA6jRfE0nxdVhbZd+GMw@mail.gmail.com>
	<CALFYKtBwUhMv_Lw=WrP9NdhSYYTF3J2sxXGgfdjUTZ-kbJgMEw@mail.gmail.com>
	<CABt9es8uqPXiL4+9aG_JqhHM9RfUU-jP37j1AsMVL+MLeCZ43Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:57624 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbaEBQwX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 May 2014 12:52:23 -0400
Received: by mail-qc0-f171.google.com with SMTP id c9so5044257qcz.16
        for <ceph-devel@vger.kernel.org>; Fri, 02 May 2014 09:52:23 -0700 (PDT)
In-Reply-To: <CABt9es8uqPXiL4+9aG_JqhHM9RfUU-jP37j1AsMVL+MLeCZ43Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Landeholm <hannes@jumpstarter.io>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 2, 2014 at 8:40 PM, Hannes Landeholm <hannes@jumpstarter.io> wrote:
> FYI: This machine runs both the ceph cluster and the clients.

I'll file a ticket.  I think I saw something similar sometime ago, at
least the stacktrace looks familiar, and that was a dev box running
both servers and kernel client too.

Thanks,

                Ilya
