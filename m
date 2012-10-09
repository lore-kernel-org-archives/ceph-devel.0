From: John Axel Eriksson <john@insane.se>
Subject: Deleting files from radosgw-bucket doesn't free up space in ceph?
Date: Tue, 9 Oct 2012 18:31:41 +0200
Message-ID: <CAMmJxtK7iyONQ1EaKgSkRkTyf0Ou1Ja0HXCGFTa2146maC5d6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42796 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab2JIQbm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 12:31:42 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so6881898vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 09:31:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm worried that data deleted in radosgw wasn't actually deleted from
disk/cluster.

Here's the output using df:

/dev/xvdf      1000G  779G  185G  81% /var/lib/ceph/osd/ceph-0

Quite full that disk. Now for ceph -s I get

health HEALTH_OK
  <lines removed>
    pgmap v256604: 2304 pgs: 2304 active+clean; 1103 GB data, 1547 GB
used, 378 GB / 2000 GB avail
  <lines removed>

Still looks pretty full here.

And here's finally the output when checking the only bucket we have:

{ "bucket": "<bucket-name-removed>",
  "pool": ".rgw.buckets",
  "id": "4122.1",
  "marker": "4122.1",
  "owner": "<owner-removed>",
  "usage": { "rgw.main": { "size_kb": 247104513,
          "size_kb_actual": 247345748,
          "num_objects": 108889}}}

This translates to around 236GB which is FAR from the around 770GB
that df and ceph -s reports. The thing is - the only way we're storing
data in ceph is through radosgw and the only bucket we have is the one
shown above (yes a pretty simple deployment). How can the stats
be so very different? Was data not actually deleted from disk? The
deletion took place yesterday so the cluster has had some time to do
any
delayed deletion if that's how it's done.

Any ideas? Thanks!

John
