From: "Cook, Nigel" <nigel.cook@intel.com>
Subject: Re: rados read ordering
Date: Wed, 10 Dec 2014 00:37:51 +0000
Message-ID: <88C3E003BB3649489ED4ECA6C80410476BCEF6@ORSMSX102.amr.corp.intel.com>
References: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>,<CABBk=J9iA=iwAqOBrQ3zDpUvEDH2JA17+WJLRU2gLz_fFdF55w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63033 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbaLJAhx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Dec 2014 19:37:53 -0500
In-Reply-To: <CABBk=J9iA=iwAqOBrQ3zDpUvEDH2JA17+WJLRU2gLz_fFdF55w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>, "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, Jason Dillaman <dillaman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Folks

I'm wondering if this is related to the question I posed a few days ago..

 Can CEPH support 2 clients simultaneously accessing a single volume - for example a database cluster - and honor read and write order of blocks across the multiple clients?

Can you comment?

Regards,
Nigel Cook +1 720 319 7508

Sent from a mobile device.
Please excuse both my brevity and sp3lling

On Dec 8, 2014 10:12 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
On Mon, Dec 8, 2014 at 9:03 AM, Sage Weil <sweil@redhat.com> wrote:
> The current RADOS behavior is that reads (on any given object) are always
> processed in the order they are submitted by the client.  This causes a
> few headaches for the cache tiering that it would be nice to avoid.  It
> also occurs to me that there are likely cases where we could go a lot
> faster by not strictly ordering things.  For example, a stat can respond
> more quickly than a large read, and some reads may hit cache while others
> go to disk.  This doesn't happen currently because of the (lame) way we do
> reads synchronously, but hope that can change too.
>
> I propose we drop this semantic.  If a client wants reads to have a strict
> ordering, they can set the existing RWORDERED flag (which also orders them
> with respect to writes).  That's not the most general thing ever, but I'm
> not sure we care about callers who want reads ordered with respect to each
> other but not writes.
>
> The real question is whether there are any users that want/need this
> currently.  I can't think of any offhand.  In several places we submit
> multiple *writes* and expect them to be strictly ordered (e.g., we
> set a completion on teh last write only).  I don't think we do this
> anywhere for reads though...
>
> Josh, Yehuda, Jason--can you think of any in RBD or RGW that would depend
> on this?
>

None that I can think of. For objects data, we already stripe it
across multiple objects, and the underlying assumption is that we're
going to get responses out of order so we make sure we commit
in-order. Guards are used on the head object, and the read is
synchronous there anyway. I can't think of any other place where we'd
have an issue.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
