From: Sage Weil <sweil@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Wed, 21 Jun 2017 19:53:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706211948570.32269@piezo.novalocal>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com> <CADRKj5RCQf8wv+Y3VsL=e_gB9URYzK0SkzGRVfTFQwcJn-OL4g@mail.gmail.com> <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal> <CA+aFP1B0ngk-Wkfy0KXnkyRP2XZJqvce1qhdBfpL+5PcjmGNoQ@mail.gmail.com>
 <alpine.DEB.2.11.1706191924150.32269@piezo.novalocal> <CAJ4mKGZCQP0FXh5NWA8429mFmZq3=oqFX=eJMRCPoapmEVJULg@mail.gmail.com> <alpine.DEB.2.11.1706202045410.32269@piezo.novalocal> <CAJ4mKGY8mGwi=F3mu-q_zB19L6VBDHeGEkyHGtY3oDafV2gQLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54973 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdFUTxr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Jun 2017 15:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 370B380F97
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 19:53:47 +0000 (UTC)
In-Reply-To: <CAJ4mKGY8mGwi=F3mu-q_zB19L6VBDHeGEkyHGtY3oDafV2gQLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I've updated the pad at

	http://pad.ceph.com/p/service-map

- commands mediated by mgr
- (some) state persisted in config-key
- a few use-cases outline explicitly

sage
