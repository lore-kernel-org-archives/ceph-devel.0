From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: rbd unmap deadlock
Date: Fri, 2 May 2014 20:30:49 +0400
Message-ID: <CALFYKtBwUhMv_Lw=WrP9NdhSYYTF3J2sxXGgfdjUTZ-kbJgMEw@mail.gmail.com>
References: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
	<5363C338.1090506@ieee.org>
	<CABt9es85qWwoZNwq_-=7NANV8ZejTKbA6jRfE0nxdVhbZd+GMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:64551 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbaEBQau (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 May 2014 12:30:50 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so4579470qap.9
        for <ceph-devel@vger.kernel.org>; Fri, 02 May 2014 09:30:49 -0700 (PDT)
In-Reply-To: <CABt9es85qWwoZNwq_-=7NANV8ZejTKbA6jRfE0nxdVhbZd+GMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Landeholm <hannes@jumpstarter.io>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

Can you succesfully map and then unmap a different image?  What's the
general state of the cluster, i.e. the output of ceph -s?

Thanks,

                Ilya
