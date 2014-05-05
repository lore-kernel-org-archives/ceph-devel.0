From: Samuel Just <sam.just@inktank.com>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 11:23:50 -0700
Message-ID: <CA+4uBUYyA-WT2K1GJV9fuE+CYBAW+qXmQmXa3sQFs29cxO-z1w@mail.gmail.com>
References: <980181538.654650.1399300829103.JavaMail.zimbra@redhat.com>
	<355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
	<CABBk=J8=GgAPM7qWfs9=OZt6yHVERggiugPui31w4b=GPk8Oow@mail.gmail.com>
	<1793642728.775752.1399309685692.JavaMail.zimbra@redhat.com>
	<CA+4uBUaOWEwpet3dr1mzYQtr_Xju8a3aCgFAf4BCu22WGQ+aZg@mail.gmail.com>
	<1666953774.790843.1399311496408.JavaMail.zimbra@redhat.com>
	<CA+4uBUavv2d63qn0zY=yfS7KV4c45JH6Dr0PupKa+zTOh2GC1Q@mail.gmail.com>
	<324933830.809209.1399313264579.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:33996 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbaEESXu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 May 2014 14:23:50 -0400
Received: by mail-qa0-f44.google.com with SMTP id j7so1847423qaq.3
        for <ceph-devel@vger.kernel.org>; Mon, 05 May 2014 11:23:50 -0700 (PDT)
In-Reply-To: <324933830.809209.1399313264579.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Darcy <jdarcy@redhat.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, gluster-devel@gluster.org

We do essentially lock entire objects for many purposes.  This isn't
generally a problem (and greatly simplifies many bits of the
implementation) because all existing rados users employ some form of
chunking/striping.  That said, it's probably a good thing to punt on
for a prototype.
-Sam

On Mon, May 5, 2014 at 11:07 AM, Jeff Darcy <jdarcy@redhat.com> wrote:
>> It's very important, several kinds of blocking are done at object
>> granularity.  Off the top of my head, large objects would cause deep
>> scrub and recovery to stall requests for longer.  Elephant objects
>> would also be able to skew data distribution.
>
> There are some definite parallels here to discussions we've had in
> Gluster-land, which we might as well go through because people from
> either "parent" won't have heard the other.  The data distribution
> issue has turned out to be a practical non-issue for GlusterFS
> users.  Sure, if you have very few "elephant objects" on very few
> small-ish bricks (our equivalent of OSDs) then you can get skewed
> distribution.  On the other hand, that problem *very* quickly
> solves itself for even moderate object and brick counts, to the
> point that almost no users have found it useful to enable striping.
> Has your experience been different, or do you not know because
> striping is mandatory instead of optional?
>
> The "deep scrub and recovery" point brings up a whole different
> set of memories.  We used to have a problem in GlusterFS where
> self-heal would lock an entire file while it ran, so other access
> to that file would be blocked for a long time.  This would cause
> VMs to hang, for example.  In either 3.3 or 3.4 (can't remember)
> we added "granular self-heal" which would only lock the portion
> of the file that was currently under repair, in a sort of rolling
> fashion.  From your comment, it sounds like RADOS still locks the
> entire object.  Is that correct?  If so, I posit that it's
> something we wouldn't need to solve in a prototype.  If/when that
> starts turning into something real, then we'd have two options.
> One is to do striping as you suggest, which means solving all of
> the associated coordination problems.  Another would be to do
> something like what GlusterFS did, with locking at the sub-object
> level.  That does make repair less atomic, which some would
> consider a consistency problem, but we do have some evidence that
> it's a violation users don't seem to care about.
>
>
