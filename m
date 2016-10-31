From: Zhiqiang Wang <wonzhq@gmail.com>
Subject: Partial replicas read/write
Date: Mon, 31 Oct 2016 17:50:36 +0800
Message-ID: <CA+cZ7shWJ7DLfJrEy-nZiq7=J3r=dzCd0ukEUpv6RLHDoVSYZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35189 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764215AbcJaJuh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Oct 2016 05:50:37 -0400
Received: by mail-oi0-f46.google.com with SMTP id i127so218697773oia.2
        for <ceph-devel@vger.kernel.org>; Mon, 31 Oct 2016 02:50:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@redhat.com, sjust@redhat.com

Currently if an object is missing on either primary or replicas during
recovery, and there are IO requests on this object, the IO requests
are blocked, and the recovery of the whole object is kicked off, which
includes a 4M object and some attrs/omaps reads/writes. These IO
requests are not resumed until the object is recovered on all OSDs of
the acting set. When there are many objects in this kind of scenario,
especially at the beginning of the recovery, the client IO is
significantly impacted during this period of time. This is not
acceptable for many enterprise workloads. We've seen many cases of
this issue even if we've lowered the parameters which control the
recovery traffic.

To fix this issue, I plan to implement a feature which I call it
'partial replicas read/write' for the replicated pool. The basic idea
is that for an op which accesses a degraded object, it's not blocked
until the object is recovered. Instead, the data of the object is only
read from or written to those OSDs of the acting set on which the
object is not missing. But for pglog, they are written to all OSDs of
the acting set regardless of their missing status. This is to comply
with the current peering design.

To be more specific, there are two cases.

## Case 1. Object is degraded but available on primary
This case is kind of straightforward, but we need to carefully update
the missing set, missing_loc, etc. Read op is not blocked even in the
current code in this case, so let's forget it. For write, the
objectstore transaction, pglog/pgstat are built on primary. For those
acting set OSDs which are missing this object, only the pglog/pgstat
is shipped to them. For the others, the prepared objectstore
transaction is shipped as well, which is the same as what we do now.

## Case 2. Object is missing on the primary
IO on this object can't be handled on the primary in this case, they
are proxied to one of the acting set OSDs who is not missing this
object. Again, we divide it into read and write.
### Read
Primary proxies the degraded read to one of the replicas who is not
missing this object. The replica OSD does the read and returns to the
primary. And then primary replies to the client.
### Write
Primary proxies the degraded write to one of the replicas who is not
missing this object, together with some infos, such as the acting set,
missing status, etc. This replica OSD handles the op and builds the
transaction/pglog/pgstat. As in case 1, it ships the new pglog/pgstat
to all the acting set OSDs, but only ships the object data to the OSDs
who are not missing the object. After applied and committed pglog
and/or object data, they replied to the replica OSD. The replica OSD
then replies back to the primary, finally back to the client.
Two notes for this case:
1) Carefully update the missing set, missing_loc as in case 1
2) When there are partial replica writes inflight, the later writes on
this PG should wait after the primary has received the new pglog of
the inflight partial replica write. Though this may induce some wait
time, it should be OK since it's much lightweight.

For some complex scenarios, we can fall back to the original way for
simplicity, such as the snapshot read, hybrid read/write/cache ops,
etc.

Does this make sense? Comments are appreciated!
