From: Sage Weil <sweil@redhat.com>
Subject: pg_stat_t is 500+ bytes
Date: Tue, 23 Aug 2016 18:13:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbcHWSNv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 14:13:51 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD4939D0D3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 18:13:50 +0000 (UTC)
Received: from ovpn-112-89.phx2.redhat.com (ovpn-112-89.phx2.redhat.com [10.3.112.89])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7NIDnW1012784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 14:13:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is huge.  It takes the pg_info_t str from 306 bytes to 847 bytes, and 
this _info omap key is rewritten on *every* IO.

We could shrink this down significant with varint and/or delta encoding 
since a huge portion of it is just a bunch of uint64_t counters.  This 
will probably cost some CPU time, but OTOH it'll also shrink our metadata 
down a fair bit too which will pay off later.

Anybody want to tackle this?
sage
