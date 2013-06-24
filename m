From: "Holger Hoffstaette" <holger.hoffstaette@googlemail.com>
Subject: Re: ceph-mon vs leveldb status
Date: Mon, 24 Jun 2013 20:57:29 +0200
Message-ID: <pan.2013.06.24.18.57.29.146860@googlemail.com>
References: <alpine.DEB.2.00.1306191304230.7089@cobra.newdream.net> <pan.2013.06.24.10.51.37.437785@googlemail.com> <alpine.DEB.2.00.1306240955180.29802@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48462 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab3FXS5k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Jun 2013 14:57:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UrBxL-0002A2-D7
	for ceph-devel@vger.kernel.org; Mon, 24 Jun 2013 20:57:39 +0200
Received: from p548760b8.dip0.t-ipconnect.de ([84.135.96.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 20:57:39 +0200
Received: from holger.hoffstaette by p548760b8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 20:57:39 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Mon, 24 Jun 2013 09:56:40 -0700, Sage Weil wrote:

> On Mon, 24 Jun 2013, Holger Hoffstaette wrote:
>> On Wed, 19 Jun 2013 13:09:42 -0700, Sage Weil wrote:
>> 
>> [snip]
>> 
>> > Meanwhile, the next development release will be changing the way all
>> > the pg metadata in the monitor is stored to be much more efficient and
>> > to take advantage of leveldb's capabilities; this will be present in
>> > 0.66 (dumpling - 1).
>> 
>> Have you considered using one of the recently annoucned LevelDB forks?
>> The HyperDex folks recently published their HyperLevelDB fork (still
>> compatible though) and it has significantly improved behaviour, less
>> performance variance etc.
>> See http://hyperdex.org/performance/leveldb/ or github.
> 
> The two issues are packaging and QA.  Ideally we (or someone) would build
> packages that provide libleveldb so that users can drop in whichever
> leveldb variant they want on their machines.  The other issue here,

As much as I understand, I think for something as critical as a metadata
store for ceph this way lies madness, and that you will sooner or later be
forced to fork/bundle/QA yourself anyway..maybe that's just me being old.
Trust me when I say that as a Gentoo user & developer I am painfully
familiar with all the issues around bundling/unbundling/upstreaming etc.,
not the least because of the absurd HN discussion last week, which was
about LevelDB as well.

As much as I hope this gets rolled back upstream I'm pessimistic
simply based on Google's track record of properly managing their open
source projects.

That being said, the HyperLevelDB fork is actively maintained and upstream
patches, as well as test cases, are merged. It also explicitly has a
different soname, precisely to avoid the confusion that could come from an
improved fork with the same name.

> though, is that these are new variants that haven't seen as much usage, so
> we have no idea how stable they are with Ceph workloads.

After looking at the LevelDB bugtracker I don't think things can really
get much worse.. :/

The real reason I posted this was that I've been lurking here and noticed
a lot of postings about timeouts, performance drops etc. The thing is that
HyperLevelDB should give back breathing room for the case where a system
is over ~80% utilization (the part of the hockey curve where things go
north in terms of latency). Improving bandwith, reducing contention and
thus latency & pause times etc. can have an incredibly stabilizing effect
on a system. Very often a lot of weird and hard to diagnose queueing
effects (convoying, unintentional synchronisation leading to stalls etc.)
can be traced to this. I'm not saying this is the case..just that it can
never hurt to have more predictable performance characteristics in the
metadata store for a distributed filesystem.

Also, who doesn't enjoy more efficient software? Think of the little ARM
cores.. :)

cheers
Holger


