From: Guang Yang <guangyy@gmail.com>
Subject: Long peering - throttle at FileStore::queue_transactions
Date: Mon, 4 Jan 2016 15:32:19 -0800
Message-ID: <CAKtk8hdb1dTJ013Qed1D9Wu_wWNvTM9H0hjqg2PGVr9xBnt51g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35074 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbcADXcU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 18:32:20 -0500
Received: by mail-yk0-f173.google.com with SMTP id x67so264391020ykd.2
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jan 2016 15:32:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Cc: sjust@redhat.com

Hi Cephers,
Happy New Year! I got question regards to the long PG peering..

Over the last several days I have been looking into the *long peering*
problem when we start a OSD / OSD host, what I observed was that the
two peering working threads were throttled (stuck) when trying to
queue new transactions (writing pg log), thus the peering process are
dramatically slow down.

The first question came to me was, what were the transactions in the
queue? The major ones, as I saw, included:

- The osd_map and incremental osd_map, this happens if the OSD had
been down for a while (in a large cluster), or when the cluster got
upgrade, which made the osd_map epoch the down OSD had, was far behind
the latest osd_map epoch. During the OSD booting, it would need to
persist all those osd_maps and generate lots of filestore transactions
(linear with the epoch gap).
> As the PG was not involved in most of those epochs, could we only take and persist those osd_maps which matter to the PGs on the OSD?

- There are lots of deletion transactions, and as the PG booting, it
needs to merge the PG log from its peers, and for the deletion PG
entry, it would need to queue the deletion transaction immediately.
> Could we delay the queue of the transactions until all PGs on the host are peered?

Thanks,
Guang
