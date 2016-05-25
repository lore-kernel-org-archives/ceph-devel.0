From: Sage Weil <sweil@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was:
 mon daemon makes authentication side effects on startup
Date: Wed, 25 May 2016 08:45:40 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605250843590.4873@cpach.fuggernut.com>
References: <5703A7FF.2090002@suse.com> <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com> <5704C76C.2050408@suse.com> <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com> <570666AB.8090408@suse.com> <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
 <57067F56.2000705@suse.com> <alpine.DEB.2.11.1604071143000.19675@cpach.fuggernut.com> <57081B3A.20601@suse.com> <570BAC52.4070404@suse.com> <alpine.DEB.2.11.1605120905220.23446@cpach.fuggernut.com> <573F0A9F.6000704@suse.com> <57457CC7.1080809@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46933 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480AbcEYMpW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 May 2016 08:45:22 -0400
In-Reply-To: <57457CC7.1080809@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, adeza@redhat.com, cjones303@bloomberg.net
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

On Wed, 25 May 2016, Owen Synge wrote:
> Great news ceph-deploy master now has the PR merged in so that
> ceph-deploy can now work without any magic involved with ceph-create-keys.
> 
> I will now make a patch to ceph proper to remove ceph-create-keys from
> the init scripts. Hopefully this will move things forward and we can get
> this patch merged relatively quickly.
> 
> Please let me know if I am doing anything wrong.

Great!

Alfredo, are there changes we need to ceph-ansible for this too?  Puppet?  
Chef?

(This is post-jewel, so it can wait a bit if necessary.)

sage
