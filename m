From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 18:44:55 -0400
Message-ID: <20160610224454.GA17244@ultraspiritum.eng.arb.redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <BLUPR0201MB152410CE52AA744E1631F6AFE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <20160610204302.GA7952@ultraspiritum.eng.arb.redhat.com>
 <BLUPR0201MB152467C60C23D726D93C10BAE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47622 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbcFJWp3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 18:45:29 -0400
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB152467C60C23D726D93C10BAE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 10/06/2016, Allen Samuels wrote:
> Not sure why you'd want to RadosClient instances to share outgoing threads etc. Seems like a bad idea to me.

No, I meant that when I, as an application, say to write an object, everything
happens in my (the application's) down through objecter until we hit the
messenger. So it's not that I /want/ them to share threds, it's just that they
do on the outgoing operation path. (And having them not do so would involve a
bunch of overhead.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
