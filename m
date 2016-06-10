From: Sage Weil <sweil@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 16:53:13 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606101651280.6221@cpach.fuggernut.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com> <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <20160610201543.GC29233@ultraspiritum.eng.arb.redhat.com> <alpine.DEB.2.11.1606101638520.6221@cpach.fuggernut.com> <20160610204549.GB7952@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbcFJUwq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 16:52:46 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20B36461C1
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 20:52:46 +0000 (UTC)
In-Reply-To: <20160610204549.GB7952@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 10 Jun 2016, Adam C. Emerson wrote:
> On 10/06/2016, Sage Weil wrote:
> > FWIW the time thing is a bit of a red herring.  The only reason time takes 
> > cct is for the configuration clock skew.  That was added for debugging 
> > purposes but has never (to my knowledge) been used.  I'd be happy to rip 
> > it out.
> 
> I wasn't aware of that. I'd asked once if the clock skew debug option
> was really important (back with the original time patch) and was told
> it was. The person I was talking to might have thought I was talking
> about monitor clock skew or something.

Ah, there is *one* teuthology test that sets this:

$ git grep clock\ offset | cat
suites/rados/multimon/tasks/mon_clock_with_skews.yaml:        clock offset: 10

I'd be quite happy to drop this test, or kludge around it some other way 
(e.g., put a mon on a different host and change the system time), if it 
saves us as much code churn as I suspect it will...

sage
