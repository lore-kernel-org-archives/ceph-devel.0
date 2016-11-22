From: Sage Weil <sweil@redhat.com>
Subject: crush multi-pick anomaly
Date: Tue, 22 Nov 2016 15:25:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611221521220.11236@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933632AbcKVPfE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 10:35:04 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4363B81226
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 15:25:12 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: aemerson@redhat.com, sjust@redhat.com
Cc: ceph-devel@vger.kernel.org

Hi Adam,

Sam had a suggestion about the CRUSH weight anomaly[1]. Instead of 
adjusting the weight for a given bucket based on an expected num_rep 
value, instead we could store a vector of weight values for every bucket 
in the tree for a range of num_reps (2..15, or whatever range is 
appropriate given the min_size/max_size values for the rules).  In general 
the tools will show the normal weight (which is a sum of the children) but 
we'd also keep the adjusted values for any given num_rep and use those for 
the actual choose.

What do you think?
sage



[1] See

	https://github.com/ceph/ceph/pull/10218
	http://tracker.ceph.com/issues/15653
