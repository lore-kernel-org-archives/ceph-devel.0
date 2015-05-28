From: Gregory Farnum <greg@gregs42.com>
Subject: Re: rados bench throughput with no disk or network activity
Date: Thu, 28 May 2015 16:18:20 -0700
Message-ID: <CAC6JEv82uAz2kwZM9iRfkMSdtUx=AJ03ZBDW4v598sWE-7B53Q@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166995A9B@satlexdag04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36667 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbbE1XSW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 19:18:22 -0400
Received: by qkx62 with SMTP id 62so35516598qkx.3
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 16:18:22 -0700 (PDT)
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com. [209.85.192.49])
        by mx.google.com with ESMTPSA id 138sm1775578qhx.18.2015.05.28.16.18.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 16:18:21 -0700 (PDT)
Received: by qgez61 with SMTP id z61so23131702qge.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 16:18:21 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166995A9B@satlexdag04.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 28, 2015 at 4:09 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> I've noticed that
>    * with a single node cluster with 4 osds
>    * and running rados bench rand on that same node so no network traffic
>    * with a number of objects small enough so that everything is in the cache so no disk traffic
>
> we still peak out at about 1600 MB/sec.
>
> And the cpu is 40% idle. (and a good chunk of the cpu activity is the rados benchmark itself)
>
> What is likely causing the throttling here?

Well, rados bench itself is essentially single-threaded, so if it's
using 100% CPU that's probably the bottleneck you're hitting.

Otherwise, by default it will limit itself to 100MB of outstanding IO
(there's an objecter config value you can change for this; it's been
discussed recently) and that might not be enough given the latencies
of hopping packets across different CPUs, and the OSDs have a
slightly-embarrassing amount of CPU computation and thread hopping
they have to perform on every op (around half a millisecond's worth on
each read, I think?).
-Gerg
