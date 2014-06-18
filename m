From: Gregory Farnum <greg@inktank.com>
Subject: MDS suggestions for upcoming CDS
Date: Wed, 18 Jun 2014 01:55:49 -0400
Message-ID: <CAPYLRzhn45AC7dWXCmkTEod0fvritKt2tiYDRAHd3THuFU-oqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35433 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbaFRFzu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jun 2014 01:55:50 -0400
Received: by mail-qg0-f54.google.com with SMTP id q107so308928qgd.41
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jun 2014 22:55:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Zheng Yan <ukernel@gmail.com>

Hey all,
It's a bit of a broken record, but we are again trying to kickstart
CephFS development going forward. To that end, I've created one
blueprint for the next CDS on CephFS "Forward Scrub"
(https://wiki.ceph.com/Planning/Blueprints/Submissions/CephFS%3A_Forward_Scrub)
based off discussions on the mailing last early last year (it still
seems to apply). Other blueprints I'm mulling over:
*) beginning to gather requirements and discuss possible
implementations of multiple FSes within a single RADOS cluster
*) changes we may want to make to backtraces (having clients write
them, optionally storing authoritative copies in the metadata pool, or
anything else of interest)
*) implementing file locking in the userspace client
*) an expansion on MDS dupability
(https://wiki.ceph.com/Planning/Sideboard/mds%3A_dumpability) which
also includes options to "kick" blocked parts of the tree
*) better methods for synchronizing CephFS clocks (for purposes of
mtime/atime/et al) across a cluster.

And I'm missing some other ideas I had earlier today. If you'd like to
see one of these, or some other blueprint, on the agenda for CephFS
discussion please let me know!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
