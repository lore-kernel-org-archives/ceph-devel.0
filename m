From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: on-the-wire encryption, addrs, and cephx
Date: Fri, 6 May 2016 12:11:05 -0400
Message-ID: <20160506161105.GA23534@ultraspiritum>
References: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com>
 <CAJ4mKGaU_oB6QLGxUF5irPM4T9FOoN0Q=wRNWBXH0TS0GFMEQg@mail.gmail.com>
 <alpine.DEB.2.11.1605060823190.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14805 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758697AbcEFQLH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 12:11:07 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC8C780088
	for <ceph-devel@vger.kernel.org>; Fri,  6 May 2016 16:11:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1605060823190.15518@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 06/05/2016, Sage Weil wrote:
[snip]
> and we'll also need to keep the v1 protocol support around for a
> long time (probably a couple years at least) for the benefit of old
> clients.  And there's no reason anybody *has* to switch to the new
> protocol unless they need the new features or improved security.
[snip]

I can understand not wanting to force people to take a performance
hit. However, it sounded, from your writeup, like even without
encryption the new auth mechanism would be an improvement on the old
one. Once we do get it working, tested, and performant, I'd suggest we
might want to force users' hand on the issue and announce that the old
mechanism will be removed in some upcoming version, rather than
waiting for users to rotate older clients out over time.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
