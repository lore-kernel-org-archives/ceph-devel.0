From: Sage Weil <sage@newdream.net>
Subject: Re: cephfs task: Extend file layout ceph_file_layout to specify a
 namespace id
Date: Wed, 27 May 2015 09:26:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505270923320.6462@cobra.newdream.net>
References: <55523B95.9010005@suse.de> <CAC6JEv8gp-GAiFaOt1BFGnPMmd5F0OGNBwnV=9bUHZ8xAhgRow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56167 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbbE0Q03 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 12:26:29 -0400
In-Reply-To: <CAC6JEv8gp-GAiFaOt1BFGnPMmd5F0OGNBwnV=9bUHZ8xAhgRow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, ceph-devel <ceph-devel@vger.kernel.org>, jashank42@gmail.com, nishtha3rai@gmail.com

On Tue, 12 May 2015, Gregory Farnum wrote:
> On Tue, May 12, 2015 at 10:42 AM, Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > Hi,
> >
> > The task mentioned in $SUBJECT is a part of the multi-tenancy cephfs
> > project. Has someone taken the task as yet? If not, I am interested in
> > working on the task.
> 
> We've got a few GSoC students who will be working on multi-tenancy
> issues and we'd expected this to be one of the things they do, but I
> don't think any work has started on it yet so if you wanted to claim
> that feature it should be all good.

Yep!

Ping any of us on IRC or over email if you have any questions.  We've 
talked a bit about this and one thing we've mostly settled on is that we 
want to allow namespaces that are strings, not just ints.  (RADOS allows 
this, and it'll make this more usable.. e.g., you could use a username or 
uuid as the namespace).  This will be more work because we need to move 
from struct ceph_file_layout to a file_layout_t that uses the modern 
versioning encode/decode infrastructure, and that transition will be a bit 
tricky.

Happy to do a video call or irc chat to discuss how to proceed when you 
have a chance!

sage
