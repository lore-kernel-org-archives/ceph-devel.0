From: Sage Weil <sage@inktank.com>
Subject: Re: Tracking hadoop-common for file system shim versioning
Date: Fri, 26 Oct 2012 16:03:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210261601180.26041@cobra.newdream.net>
References: <CAPrxi584NjBoo1qA-2YpqMt9p+6g+SooeR0Y1fKetGN55Fchdg@mail.gmail.com> <CAPYLRziSw8WVK8=X557+M8ZJ+T9Dv2v1kyp_FXkQM=8XBmhwPA@mail.gmail.com> <F94C248B-486F-4565-B712-1FAE21912B65@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46133 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934218Ab2JZXDE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 19:03:04 -0400
In-Reply-To: <F94C248B-486F-4565-B712-1FAE21912B65@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <jbbuck@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 26 Oct 2012, Joe Buck wrote:
> Noah and I talked about this a bit and the idea was not to push our code 
> upstream, but rather to host a fork locally so that we could decide when 
> to rev the version(s) we build against rather than just pulling trunk 
> from Hadoop's repo. We'd still be building the one or two .jar files 
> that users would have to configure Hadoop to find, but we'd have a full 
> version of Hadoop in our repo for consistency and what not.

This sounds like the right approach.  

Which repo to fork?  https://github.com/apache/hadoop ?

sage


> 
> -Joe Buck
> 
> On Oct 26, 2012, at 3:42 PM, Gregory Farnum wrote:
> 
> > On Fri, Oct 26, 2012 at 3:29 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> >> Development of the Hadoop shim layer is best done in the Apache Hadoop
> >> Git repository, so we can track up-stream and build for all the
> >> different versions that exist. Is keeping a clone in Inktank Github
> >> something that is possible / desired?
> > 
> > Are we sure we want to maintain it in a fork of their repo? (I'm not
> > saying we don't, just curious.) QFS recently published support for
> > Hadoop and apparently they only need two JARs to support the things
> > that everybody is running now. Either way, see
> > http://mail-archives.apache.org/mod_mbox/hadoop-common-dev/201210.mbox/%3CCC946699.1C97B%25thilee@quantcast.com%3E
> > and https://issues.apache.org/jira/browse/HADOOP-8885 for the
> > discussion surrounding (not) sending that upstream and the
> > distribution strategy they ended up with.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
