From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 16:43:02 -0400
Message-ID: <20160610204302.GA7952@ultraspiritum.eng.arb.redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <BLUPR0201MB152410CE52AA744E1631F6AFE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932376AbcFJUng (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 16:43:36 -0400
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB152410CE52AA744E1631F6AFE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 10/06/2016, Allen Samuels wrote:
> Have you considered threadlocal storage for this? I suspect it's a
> *much* easier way to go. Very little source code will need modification.

I thought about it briefly, but I don't think it would work for tools
that spawn two RadosClients each pointing to a different cluster. While
each would launch threads of its own, they'd both share the application
threads for outgoing operations (at least until they hit the messenger). So I
think we'd still need to tease apart the class somewhat to make thread local
storage work.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
