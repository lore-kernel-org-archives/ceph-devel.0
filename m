From: Ben Rowland <ben.rowland@gmail.com>
Subject: Geo-replication with RADOS GW
Date: Mon, 28 Jan 2013 17:54:21 +0000
Message-ID: <CAEU8emnv5z9JmkqTG4+ddNV6wRLQfeSQyPShznyg=xFzqTYwpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:50329 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629Ab3A1RyW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 12:54:22 -0500
Received: by mail-ee0-f45.google.com with SMTP id b57so1484993eek.32
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 09:54:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm considering using Ceph to create a cluster across several data
centres, with the strict requirement that writes should go to both
DCs.  This seems possible by specifying rules in the CRUSH map, with
an understood latency hit resulting from purely synchronous writes.

The part I'm unsure about is how the RADOS GW fits into this picture.
For high availability (and to improve best-case latency on reads),
we'd want to run a gateway in each data centre.  However, the first
paragraph of the following post suggests this is not possible:

http://article.gmane.org/gmane.comp.file-systems.ceph.devel/12238

Is there a hard restriction on how many radosgw instances can run
across the cluster, or is the point of the above post more about a
performance hit?  It seems to me it should be possible to run more
than one radosgw, particularly if each instance communicates with a
local OSD which can proxy reads/writes to the primary (which may or
may not be DC-local).

Thanks for any clarifications,

Ben
