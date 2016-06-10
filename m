From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 15:58:38 -0400
Message-ID: <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbcFJT7L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 15:59:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FCDC8F4F2
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 19:59:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 10/06/2016, Gregory Farnum wrote:
> Maybe I'm misunderstanding the scope of what you're proposing, but I
> don't think this is a good reason to go through this work right now.
> Lots of things that seem process-specific turn out to be essentially
> cluster properties, despite being configurable on both ends, and will
> need to be referenced from all over the stack. And in general if we'r=
e
> addressing multiple Ceph clusters within a utility we want a full
> RadosClient etc for each cluster, so the split doesn't do us much goo=
d
> on its own, does it? (If we don't want separate admin sockets for eac=
h
> one, we'd need to extend all of those interfaces to support two
> entries for the same type of thing, etc)

=46inding out exactly which things are process specific is one reason
I'm soliciting for feedback. AdminSocket doesn't have to be
included. Really, I think we'd get a lot of benefit if we made JUST
some debug options and dout support process specific and refactored it
that way. Other things could move later on if people wanted them to
but wouldn't have to.


> If this is your actual goal, I think the unappealing work of replacin=
g
> g_ceph_context with a CephContext *cct is the way to go =E2=80=94 we'=
d need to
> do this much to support multiple ClusterContexts within a process
> anyway. Once we have a motivating use case for splitting stuff up, we
> can address that. But if we try and do a generic solution it'll be
> much more difficult, and probably will miss some key points we don't
> run into until trying to make use of it.
>=20
> Am I missing something?
> -Greg

I have been working on the unappealing work of replacing
g_ceph_context with CephContext* cct. It's not just unappealing work,
it ends up wiht a result ugly enough I don't think I'd want to merge
it if someone presented it to me. It's very invasive in that it
changes a whole lot of everything. The split would ALSO change a whole
lot of everything, but likely less. You would at least be able to
avoid changing the constructors of a while bunch of unrelated things
just to pass a variable in that only some member several classes in
cares about so it can log a message.


--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
