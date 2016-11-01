From: Sage Weil <sweil@redhat.com>
Subject: kraken
Date: Tue, 1 Nov 2016 13:20:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1169078AbcKANVA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 1 Nov 2016 09:21:00 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A33363F725
        for <ceph-devel@vger.kernel.org>; Tue,  1 Nov 2016 13:20:59 +0000 (UTC)
Received: from ovpn-112-71.phx2.redhat.com (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uA1DKvlf005388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Tue, 1 Nov 2016 09:20:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey everyone,

I think we're about ready for a kraken feature freeze.  The main item we 
were waiting for was the EC overwrites and Sam has a working branch for 
review this week.  There are still a few odds and ends that I have on my 
list to get in (like the new CRUSH tunable), but it's a short list.

How does next Monday (11/7) sound for an initial freeze?

sage

