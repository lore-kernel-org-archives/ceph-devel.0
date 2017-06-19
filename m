From: Sage Weil <sweil@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Mon, 19 Jun 2017 19:26:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706191924150.32269@piezo.novalocal>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com> <CADRKj5RCQf8wv+Y3VsL=e_gB9URYzK0SkzGRVfTFQwcJn-OL4g@mail.gmail.com> <alpine.DEB.2.11.1706141943490.32269@piezo.novalocal>
 <CA+aFP1B0ngk-Wkfy0KXnkyRP2XZJqvce1qhdBfpL+5PcjmGNoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdFST00 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Jun 2017 15:26:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCDA54E4CA
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 19:26:25 +0000 (UTC)
In-Reply-To: <CA+aFP1B0ngk-Wkfy0KXnkyRP2XZJqvce1qhdBfpL+5PcjmGNoQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I wrote up a quick proposal at

	http://pad.ceph.com/p/service-map

Basic idea:

 - generic ServiceMap of service -> daemon -> metadata and status
 - managed/persisted by mon
 - librados interface to register as service X name Y (e.g., 'rgw.foo')
 - librados will send regular beacon to mon to keep entry alive
 - various mon commands to dump all or part of the service map

sage
