From: Sage Weil <sweil@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 16:40:05 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606101638520.6221@cpach.fuggernut.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com> <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <20160610201543.GC29233@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37400 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbcFJUjj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 16:39:39 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB117552DB
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 20:39:38 +0000 (UTC)
In-Reply-To: <20160610201543.GC29233@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 10 Jun 2016, Adam C. Emerson wrote:
> don't. A lot of 'light weight' data classes in the MDS for example
> don't have a link back to anything but still need g_ceph_context to
> tell time or dout something. A lot of callbacks do that, too. other

FWIW the time thing is a bit of a red herring.  The only reason time takes 
cct is for the configuration clock skew.  That was added for debugging 
purposes but has never (to my knowledge) been used.  I'd be happy to rip 
it out.

There is an implicit dependency on the host tz in the render-to-string 
method, but that's handled by glibc.

sage
