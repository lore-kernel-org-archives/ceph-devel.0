From: Greg Farnum <greg@inktank.com>
Subject: Re: RBD format changes and layering
Date: Fri, 25 May 2012 13:55:55 -0700
Message-ID: <63BD3F6B9DF74617B6B7DC74B3105FF4@inktank.com>
References: <4FBEBECD.6040403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37928 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933574Ab2EYUz7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 16:55:59 -0400
Received: by dady13 with SMTP id y13so1706419dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 13:55:59 -0700 (PDT)
In-Reply-To: <4FBEBECD.6040403@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thursday, May 24, 2012 at 4:05 PM, Josh Durgin wrote:

<snip> 
> 
> One thing that's not addressed in the earlier design is how to make
> images read-only. The simplest way would be to only support layering
> on top of snapshots, which are read-only by definition.
> 
> Another way would be to allow images to be set read-only or
> read-write, and disallow setting images with children read-write. Are
> there many use cases that would justify this second, more complicated
> way?

I'm pretty sure we want to require images to be based on snapshots. It's actually more flexible than read-write flags: service providers could provide several Ubuntu 12.04 installs with different packages available by simply snapshotting as they go through the install procedure. If they instead had to go to an endpoint and then mark the image read-only, they would need to duplicate all the shared data.

 
> Copy-up
> =======
> 
> Another feature we want to include with layering is the ability to
> copy all remaining data from the parent image to the child image, to
> break the dependency of the latter on the former. This does not change
> snapshots that were taken earlier though - they still rely on the
> parent image. Thus, the children of a parent image will need to
> include snapshots as well, and the reference to the parent image will
> be needed to interact with snapshots. Thus, we can't just remove the
> information pointing the parent. Instead, we can add a boolean
> has_parent field that is stored in the header and with each snapshot,
> since some snapshots may be taken when the parent was still used, and
> some after all the data has been copied to the child.

I understand why you're maintaining a reference to the parent image for old snapshots, but it makes me a little uneasy. This limitation means that you either need to delete snapshots or you need to maintain access to the parent image, which makes me a sad panda.
Have you looked into options for doing a full "local" copy of the needed parent data? I realize there are several tricky problems, but given some of the usage scenarios for layering (ie, migration) it would be an advantage.

My last question is about recursive layering. I know it's been discussed some, and *hopefully* it won't impact the actual on-disk layout of RBD images; do you have enough of a design sketched out to be sure? (One example: given the security concerns you've raised, I think layered images are going to need to list themselves as a child of each of their ancestors, rather than letting that information be absorbed by the intermediate image. Can the plan for storing parent pointers handle that?)
-Greg


