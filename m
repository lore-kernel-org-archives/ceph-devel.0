From: Sage Weil <sweil@redhat.com>
Subject: Re: 10.2.9 release needed to fix fs regression in 10.2.8
Date: Wed, 12 Jul 2017 19:58:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707121957360.3424@piezo.novalocal>
References: <a7d7b003-f348-6648-064a-1c91524c7b64@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbdGLT6O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Jul 2017 15:58:14 -0400
In-Reply-To: <a7d7b003-f348-6648-064a-1c91524c7b64@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "Durgin, Josh" <jdurgin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 12 Jul 2017, Nathan Cutler wrote:
> Hi leads,
> 
> Zheng and John confirmed today that there is an fs regression in 10.2.8 which
> requires a single PR to fix. Since the v10.2.8 tag has already been applied,
> RPM and DEB packages uploaded, and release notes prepared, the best option at
> this stage seems to be cutting a 10.2.9 release consisting of the current tip
> of the jewel branch plus https://github.com/ceph/ceph/pull/16282
> 
> Yuri is running an fs suite on that PR already.
> 
> In this respect, I have two questions for you:
> 
> 1. do you agree with the above, and

Can't speak to the nature of the regression itself, but

> 2. what further QE testing should we do on 10.2.9, other than the fs suite?

fs suite seems sufficient since there are no other Journaler users.

sage
