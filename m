From: Sage Weil <sage@inktank.com>
Subject: jerasure crash
Date: Mon, 31 Mar 2014 17:38:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403311735120.22715@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47508 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaDAAiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Mar 2014 20:38:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: loic.dachary@inktank.com
Cc: ceph-devel@vger.kernel.org

Hey Loic,

A new failure came up in QA over the weekend that looks like a problem 
inside jerasure:

	http://tracker.ceph.com/issues/7914

I think this is the first time this particular failure has come up.  Sam 
suggests taking a hard look at the recent jerasure/gf-complete submodule 
changes.  And/or we need to run one of the failing tests in a loop to get 
a sense of frequency and then bisect.  Can you spearhead this one?

sage

