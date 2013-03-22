From: Sage Weil <sage@inktank.com>
Subject: Re: crush changes via cli
Date: Fri, 22 Mar 2013 15:58:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303221554130.32540@cobra.newdream.net>
References: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net> <CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51309 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423504Ab3CVW6I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 18:58:08 -0400
In-Reply-To: <CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 22 Mar 2013, Gregory Farnum wrote:
> I suspect users are going to easily get in trouble without a more
> rigid separation between multi-linked and single-linked buckets. It's
> probably best if anybody who's gone to the trouble of setting up a DAG
> can't wipe it out without being very explicit ? so for instance "move"
> should only work against a bucket with a single parent.

Good idea; I'll add that.

> Rather than
> defaulting to all ancestors, removals should (for multiply-linked
> buckets) require users to either specify a set of ancestors or to pass
> in a "--all" flag.

'rm' only works on an empty bucket, so I'm not sure there is much danger 
is removing all links (and the bucket) in that case?

> Also, I suspect that "rm" actually deletes the bucket while "unlink"
> simply removes it from all parents (but leaves it in the tree); that
> distinction might need to be a little stronger (or is possibly not
> appropriate to leave in the CLI?).

That's right.  The "remove" versus "unlink" verbs make that pretty clear 
to me, at least...  Are you suggesting this be clarified in the docs, or 
that the command set change?  I think once we settle on the CLI, John can 
make a pass through the crush docs and make sure these commands are 
explained.

> You mention that one of the commands "does nothing" under some
> circumstances ? does that mean there's no error? If a command can't be
> logically completed it should complain to the user, not just fail
> silently.

It returns -ENOTEMPTY; sorry, poor choice of words.  :)

sage
