From: Sage Weil <sage@newdream.net>
Subject: Re: conditionalize build on branch using jenkins
Date: Wed, 6 Dec 2017 15:40:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712061540020.5536@piezo.novalocal>
References: <CAJE9aOM-h17ErsTjqX-0RFKBqnZ4Lvkh4G5ajSGoUFaBaOf4LA@mail.gmail.com> <CAC-Np1xCdkWY-4fwHq33t2KoajJthfDe35_nU+vBshBK-Ly75Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:41506 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbdLFPkb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Dec 2017 10:40:31 -0500
In-Reply-To: <CAC-Np1xCdkWY-4fwHq33t2KoajJthfDe35_nU+vBshBK-Ly75Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 6 Dec 2017, Alfredo Deza wrote:
> > 1. a naming convention for branches targeting jewel/luminous, like
> > wip-fix-a-bug-luminous.
> 
> A naming convention sounds OK to me. I would prefer to have luminous
> at the beginning. If using 'wip-' is a must, then something like:
> 
>     wip-luminous-fix-a-bug
> 
> Otherwise:
> 
>     luminous-fix-a-bug

+1.  No need for the wip- part.

sage
