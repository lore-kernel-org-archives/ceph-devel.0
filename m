From: Sage Weil <sweil@redhat.com>
Subject: Re: size of testing lab
Date: Wed, 13 Sep 2017 18:49:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709131845040.24068@piezo.novalocal>
References: <CAKRxpuvxULyT-QynJJ7fO7k8D-+gRH_F+rdqyM-QMW10jydGOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbdIMStw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Sep 2017 14:49:52 -0400
In-Reply-To: <CAKRxpuvxULyT-QynJJ7fO7k8D-+gRH_F+rdqyM-QMW10jydGOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 13 Sep 2017, Two Spirit wrote:
> Can you tell me how many chassis are in the lab you setup that you 
> believe will adequately test Ceph?

The sepia lab has a few hundred machines in it... see

	http://pulpito.ceph.com/nodes/

(ignoring 'down' and 'vps' entries).

Whether that is enough depends on what you are testing and what your goals 
of testing are.  We use the lab for validating changes to the code, and 
the hardware is sized/tuned for our tests.  Most users want to test on the 
hardware they'll go into production with, and are primarily interested in 
performance and robustness (handling of failures and so on).  What scale 
is needed for that testing depends on what scale you're likely to 
deploy...


sage

