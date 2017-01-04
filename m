From: Sage Weil <sweil@redhat.com>
Subject: Re: Kraken branch rebases ...
Date: Wed, 4 Jan 2017 15:33:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701041532330.10511@piezo.novalocal>
References: <CA+aFP1CRKhY81g6KaPtVdvEOv65On1CD+MuWCnsaXXzdtQYoaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757498AbdADPdI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 4 Jan 2017 10:33:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41FC88FCF0
        for <ceph-devel@vger.kernel.org>; Wed,  4 Jan 2017 15:33:09 +0000 (UTC)
In-Reply-To: <CA+aFP1CRKhY81g6KaPtVdvEOv65On1CD+MuWCnsaXXzdtQYoaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 3 Jan 2017, Jason Dillaman wrote:
> Sage,
> 
> I know you are out this week, but I am trying to gauge whether or not
> we foresee any additional rebases of the master branch into the kraken
> branch or if everything should be cherry-picked from now on.  It would
> be great if we RBD folks knew we could safely start merging in new
> features w/o fear of them leaking into the kraken branch.

It's all cherry-picks from here on out!  Merge away...

sage
