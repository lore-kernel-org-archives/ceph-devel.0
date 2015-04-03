From: huang jun <hjwsm1989@gmail.com>
Subject: how to recovery lost objects
Date: Sat, 4 Apr 2015 07:25:39 +0800
Message-ID: <CABAwU-YkJVV6qnixUC2t2yzKQezJgM-Jk7hTFC24LFiFN77ZHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33885 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbDCXZl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Apr 2015 19:25:41 -0400
Received: by lboc7 with SMTP id c7so86276429lbo.1
        for <ceph-devel@vger.kernel.org>; Fri, 03 Apr 2015 16:25:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,ceph

Last week, we  add 48 OSDs to our exist cluster, the special thing is during
the  backfill and recovery procedure,  some osds going to 100% full(we
have set osd_full_ratio to 0.99).
In each full OSD, we find one PG  that the PG's acting and up set
didn't include this OSD anymore, then move the PG data to stale disk,
and then restart the full OSDs, the backfill and recovery finally fininshed. And
"ceph -s" shows all PG state is "active+clean". So we didn't copy the backuped
data back.

But now  we have a problem, we queried a file, find that one object of the file
is lost, but the PG status is ok

root@node1:~# ceph osd  map data 10000024b56.00000001
osdmap e64986 pool 'data' (0) object '10000024b56.00000001' -> pg
0.6b96f1d3 (0.11d3) -> up ([85,22], p85) acting ([85,22], p85)

root@node1:/var/lib/ceph/osd/ceph-85/current/0.11d3_head# find ./
-name 10000024b56*

root@node5:/var/lib/ceph/osd/ceph-22/current/0.11d3_head#  find ./
-name 10000024b56*
root@node5:/var/lib/ceph/osd/ceph-22/current/0.11d3_head# ls -R *|grep
10000024b56

As you can see, there are no object 10000024b56.00000001 found both in
osd.85 and osd.82.

we check all backuped PG data, but with no luck.

Does the object to PG refection changes after add OSDs? i think only
the PG to OSD reflection changes.

how to recovery lost objects?

Any tips or hints are welcome.
-- 
thanks
huangjun
