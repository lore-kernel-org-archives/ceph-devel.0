From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: scrub test assert
Date: Thu, 7 Jan 2016 12:07:38 -0800
Message-ID: <CAJ4mKGahSM5kb-5vJttHuoY7pBQFkv9+EQr=V8Dg+sX+kOM6pg@mail.gmail.com>
References: <D2B36D43.A56C%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37013 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbcAGUHj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 15:07:39 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so141155520wmf.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jan 2016 12:07:39 -0800 (PST)
In-Reply-To: <D2B36D43.A56C%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 7, 2016 at 1:17 AM, Evgeniy Firsov
<Evgeniy.Firsov@sandisk.com> wrote:
> Hi, Devs,
>
> We hit an assert while doing scrub test.
> Can you, please, verify if the test case is valid?
>
> The test:
> 1. Start Jewel cluster. 2 nodes, 8 osds each.
> 2. Start fio, pure write workload.
> 3. Delete data of random pg: rm -rf /var/lib/ceph/osd/ceph-7/2.185_head/*
> 4. Stop workload
> 5. Do a scrub on that pg. Cluster active and clean after that.
> 6. Restart the node with that pg.
> 7. The OSD with that pg fails to recover and asserts with:
>      osd/PGLog.cc: 382: FAILED assert(objiter->second->version >
> last_divergent_update)

The OSD is passing scrub tests because of the file descriptor cache
(so it still has its own fds open for the deleted files that it
references), but then on restart everything gets wiped away and it
discovers its data store is inconsistent. I believe your team has run
into this before when designing data loss tests. :)
-Greg
