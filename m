From: Sage Weil <sweil@redhat.com>
Subject: Re: Kraken cephfs test results
Date: Fri, 13 Jan 2017 14:53:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701131453120.1911@piezo.novalocal>
References: <CALe9h7d5D=XQ_pRwZEEjY83TRY0ZzUkZX_DZ_D6mzp1L6xN_Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbdAMOxn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 13 Jan 2017 09:53:43 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19747C056791
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2017 14:53:41 +0000 (UTC)
In-Reply-To: <CALe9h7d5D=XQ_pRwZEEjY83TRY0ZzUkZX_DZ_D6mzp1L6xN_Qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks, John!

Sam, Jason, Matt, where are we at with the other subsystems?

Thanks!
sage


On Tue, 10 Jan 2017, John Spray wrote:

> Sage,
> 
> Here are the notes on the failures on the latest cephfs tests on
> kraken.  The tldr is that there's nothing blocking in here, but I'm
> writing it out in full so that we can refer to this list to make sure
> everything's backported to get the runs green.
> 
> Cheers,
> John
> 
> samba:
> * command failed with status 223 is PID file issue (pending backport)
> http://tracker.ceph.com/issues/18309
> * other samba failures are missing xenial packages.
> 
> fs:
> * test_session_reject failure is an issue with the injection path the
> test uses (PR open) https://github.com/ceph/ceph/pull/12757
> * test_evict_client failure is the pidfile issue (pending backport)
> http://tracker.ceph.com/issues/18309
> * snaptest-snap-rm-cmp.sh failure is new issue (apparently
> intermittent), PR open https://github.com/ceph/ceph/pull/12859
> 
> kcephfs:
> * failures in TestClientRecovery, probably just issues with the newly
> deployed kclient versions of the python tests (PR open)
> http://tracker.ceph.com/issues/18396
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
