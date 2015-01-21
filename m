From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] Rbd: add listwatchers command
Date: Wed, 21 Jan 2015 08:58:11 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501210856200.3895@cobra.newdream.net>
References: <cover.1421849230.git.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42356 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291AbbAUQ61 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Jan 2015 11:58:27 -0500
In-Reply-To: <cover.1421849230.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

On Wed, 21 Jan 2015, Li Wang wrote:
> Currently, RBD does not provide an easy way to 
> consult who opened a specied image, this complicates
> the cloud maintenance, sometimes the administrator 
> found that a RBD image could not be deleted with 
> an error 'image has watchers', but no further 
> information available. The RADOS has a command to 
> show the watchers of an object, but the commands 
> at RADOS level are not supposed to be exposed to a 
> cloud administrator, and it is not clear for a 
> non-expert administrator to how to associate an 
> opened RBD with a corresponding watched object. 
> This motivates us to add an RBD command to list the 
> information of the clients who opened a RBD image to 
> facilitate the cloud maintenance.

Perhaps this should just be rolled into the existing 'rbd info' command.  
More people will see it and there's no additional cost over what info is 
already doing...

sage





> 
> The patches are at:
> https://github.com/ceph/ceph/pull/3435
> 
> Yunchuan Wen (3):
>   rbd: add listwatchers command to list the watchers of an image
>   test: add rbd listwatchers to src/test/cli/rbd/help.t
>   man: add rbd listwatchers to doc/man/8/rbd.rst
> 
>  doc/man/8/rbd.rst       |  3 +++
>  src/rbd.cc              | 63 +++++++++++++++++++++++++++++++++++++++++++++++--
>  src/test/cli/rbd/help.t |  1 +
>  3 files changed, 65 insertions(+), 2 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
