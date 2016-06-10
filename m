From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 17:04:33 -0400
Message-ID: <20160610210433.GA16959@ultraspiritum.eng.arb.redhat.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
 <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
 <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbcFJVFH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Jun 2016 17:05:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 10/06/2016, Sage Weil wrote:
> I think the crux of the issue is the debug/logging code.  Almost all
> the other uses of cct are related to config options that are
> per-cluster.

That is correct. I thought we might pull some things like (like the
Crypto stuff) while we were at it but that was more "As long as I'm
here anyway I might as well see if there's anything more to do..."

> And with logging... it seems like even this is really a per-cluster
> (well, per entity) thing.  Sorting through a log file that combines
> output from two different objecters sounds horrific, and when we
> cram multiple OSDs into one process, we're going to want them to
> still feed into different log files.

This is a good point that I had not considered. Though, I'm not sure
if the un-separated case is that much better. I think part of the
savings we would want from multi-OSD work (at least in principle) is
to be able to have them share messengers and other overhead. In that
case giving each OSD its own fully fledged CephContext doesn't make
sense, I don't think.

Some form of sterring might work, perhaps making the log system smart
enough to shove things around based on subsystem or an entity
identifier or something.

> How bad is the cct plumbing patch?  I fear this might still be the
> best path forward...

It's not great? Really at all. I wrote it and I don't like it. I
could pull it up and smack it into shape and make sure it passes tests
if it were necessary.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
