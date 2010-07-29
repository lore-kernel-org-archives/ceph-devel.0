From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: Roadmap to production
Date: Thu, 29 Jul 2010 05:45:53 +0000 (UTC)
Message-ID: <i2r4ih$nki$1@dough.gmane.org>
References: <i29ckr$lab$1@dough.gmane.org>
	<Pine.LNX.4.64.1007271024060.28672@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50528 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab0G2FqF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jul 2010 01:46:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OeLwQ-0000Dm-Ku
	for ceph-devel@vger.kernel.org; Thu, 29 Jul 2010 07:46:02 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 07:46:02 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 07:46:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Wed, 28 Jul 2010 11:25:40 -0700 schrieb Sage Weil:

> On Thu, 22 Jul 2010, Thomas Mueller wrote:
>> reading http://ceph.newdream.net/roadmap/ leaves me with some
>> questions. :)
>> 
>> * is there some roadmap when CEPH will be official announced
>> "production ready"
> 
> These are good questions.  :)
> 
> I've made the Ceph site link directly into the redmine roadmap, where
> we'll be maintaining a detailed set of issues (features, bugs) for each
> upcoming release along with a target release date.  The roadmap now
> includes a v1.0, which will be something we at least will cautiously
> deploy in production.  I would like to get there (or close to it) by the
> end of the year.
> 
> I prefer to avoid "production ready" as that is a bit of a subjective
> term.  Different people have different stability requirements and
> expectations.  That said, I would like v1.0 to be something I am
> comfortable encouraging people to use in real (but non-critical)
> deployments.
> 

answering here the question from another thread because IMHO it fits 
better:

> > what leads me to my other question: when will ceph be considered 
> > "stable"? 
> Soon?    I'd be interested in hearing what you (or anyone else) expect 
> from a "stable" v1.0 release.

as storage is a fundamental service there are for sure other "stable" 
demands than for a newsreader/mailclient/whateveruncriticalapp. 

I'll give it a try to describe my idea of stable:

- stable means promised features (http://ceph.newdream.net/about/) work 
reliable
- no workarounds needed to use these features
- (at least) in a series of stable releases (aka "1.x") i can upgrade 
without downtime
- in a series of stable releases a can do a rolling upgrade
- in a stable series there no design changes introduced



- Thomas

