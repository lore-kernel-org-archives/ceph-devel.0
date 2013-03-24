From: Gregory Farnum <greg@inktank.com>
Subject: Re: crush changes via cli
Date: Sun, 24 Mar 2013 16:20:00 -0700
Message-ID: <43BCE0F438AB4C22AEEEFEDCD165068B@inktank.com>
References: <alpine.DEB.2.00.1303221528240.18669@cobra.newdream.net>
 <CAPYLRzg2YUVBEL8oJ_N02w1dHwy7a9jpCAVkcRq8AhmyUMnuGw@mail.gmail.com>
 <alpine.DEB.2.00.1303221554130.32540@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54039 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab3CXXTm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Mar 2013 19:19:42 -0400
Received: by mail-pd0-f169.google.com with SMTP id 3so2273468pdj.14
        for <ceph-devel@vger.kernel.org>; Sun, 24 Mar 2013 16:19:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303221554130.32540@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Fri, Mar 22, 2013 at 3:58 PM, Sage Weil <sage@inktank.com (mailto:sage@inktank.com)> wrote:
> On Fri, 22 Mar 2013, Gregory Farnum wrote:
> > I suspect users are going to easily get in trouble without a more
> > rigid separation between multi-linked and single-linked buckets. It's
> > probably best if anybody who's gone to the trouble of setting up a DAG
> > can't wipe it out without being very explicit ? so for instance "move"
> > should only work against a bucket with a single parent.
> > 
> 
> 
> Good idea; I'll add that.
> 
> > Rather than
> > defaulting to all ancestors, removals should (for multiply-linked
> > buckets) require users to either specify a set of ancestors or to pass
> > in a "--all" flag.
> > 
> 
> 
> 'rm' only works on an empty bucket, so I'm not sure there is much danger
> is removing all links (and the bucket) in that case?
> 


Well, if "unlink" takes it out of the tree without requiring it to be empty then that would be one case.
 
> 
> > Also, I suspect that "rm" actually deletes the bucket while "unlink"
> > simply removes it from all parents (but leaves it in the tree); that
> > distinction might need to be a little stronger (or is possibly not
> > appropriate to leave in the CLI?).
> > 
> 
> 
> That's right. The "remove" versus "unlink" verbs make that pretty clear
> to me, at least... Are you suggesting this be clarified in the docs, or
> that the command set change? I think once we settle on the CLI, John can
> make a pass through the crush docs and make sure these commands are
> explained.
> 


That makes sense if you know the internal representation of the CRUSH map; less so if you're thinking of it in terms from related fields like, say, a filesystem. ;) I admit I don't have any better suggestions and strong docs might be just fine, but the distinction is one that's very visible to users *afterwards* but not beforehand. I'm imagining a lot of crush maps with 5 unlinked parallel trees in our future.
I guess mostly I'm just not sure what the use case is for keeping around unlinked buckets so I'd rather keep the set of CLI options simpler. It's not that hard to link a bucket into the tree where you want it and then remove the other links.
-Greg

