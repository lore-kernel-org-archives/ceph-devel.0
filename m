From: Sage Weil <sage@inktank.com>
Subject: Re: Mon backing store
Date: Thu, 5 Jun 2014 11:26:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406051126100.11281@cobra.newdream.net>
References: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com> <CABBk=J9dfAXHcYPYzcu0ipAnzretOMWE3wHhtXVa1oYSzvF1zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36840 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaFES0d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 14:26:33 -0400
In-Reply-To: <CABBk=J9dfAXHcYPYzcu0ipAnzretOMWE3wHhtXVa1oYSzvF1zA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 5 Jun 2014, Yehuda Sadeh wrote:
> On Thu, Jun 5, 2014 at 10:42 AM, Samuel Just <sam.just@inktank.com> wrote:
> > I am starting to wonder whether using leveldb for the mon is actually
> > introducing an excessive amount unnecessary complexity and
> > non-determinism.  Given that the monitor workload is read mostly,
> > except for failure conditions when it becomes write latency sensitive,
> > might we do better with a strict b-tree style backing db such as
> > berkely db even at the cost of some performance?  It seems like
> > something like that might provide more reliable latency properties.
> >
> > Thoughts?
> 
> Whichever route we're taking it'd be nice if it would have been 
> abstracted more cleanly, and make it pluggable.

The first several patches in the wip-rocksdb branch do this.

sage
