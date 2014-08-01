From: Sage Weil <sweil@redhat.com>
Subject: Re: call for comments -> "ceph-disk" making OSD directories on typos
 and is inconsistent (useability).
Date: Fri, 1 Aug 2014 08:10:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408010808020.18917@cobra.newdream.net>
References: <53DB539C.8090306@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41966 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbaHAPLA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 11:11:00 -0400
In-Reply-To: <53DB539C.8090306@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 1 Aug 2014, Owen Synge wrote:
> Dear all,
> 
> By default "ceph-disk" will do the following:
> 
> # ceph-disk -vvvv prepare  --fs-type xfs --cluster ceph -- /dev/sdk
> DEBUG:ceph-disk:Preparing osd data dir /dev/sdk
> 
> No block device "/dev/sdk" exists so "ceph-disk" decides a block device
> is not wanted and makes a directory for an OSD.
> 
> I think as policy "ceph-disk" should not assume by default, that a non
> existent target is correct, make a directory for the "disk" type OSD to
> reside in, and set it up as a "disk" type OSD.
> 
> Hence I proposed this patch:
> 
> https://github.com/ceph/ceph/pull/2160

In a vacuum, this seems like the cleanest approach...
 
> As a second best option I would be happier with an explicit "don?t fail
> if target is not present and just make a directory at the target". But
> then you get on to the question of deeper directory structures being
> handled:
> 
> The current behavior with deeper directory structures is currently
> inconsistent as this output shows:
> 
> # ceph-disk prepare --fs-type xfs --cluster ceph -- /mnt/vdu/vdu
> Traceback (most recent call last):
>   File "/usr/sbin/ceph-disk", line 2605, in <module>
>     main()
>   File "/usr/sbin/ceph-disk", line 2583, in main
>     args.func(args)
>   File "/usr/sbin/ceph-disk", line 1311, in main_prepare
>     os.mkdir(args.data)
> OSError: [Errno 2] No such file or directory: '/mnt/vdu/vdu'
> 
> I think as a third best option would be to only make directories the
> "--data-dir" parameter is used, but still suffers the deeper directory
> structures question.
> 
> I am still unsure if I like the idea of creating directories for deeper
> directory structures, as again the potential for typos leading to vastly
> different directory paths with a single misplaced character, and for
> consistency would rather "ceph-disk" just failed if the target is not
> available.
> 
> Although I propose failing fast and clearly with a clear error message
> when a target does not exist, removing the assumption that all non
> existent targets are valid and "disk" based OSD's and to try and make an
> "appropriate" directory, I do see 2 issues with this change:
> 
> (A) This is a change to the current default behavior so effecting
> deployment frameworks.
> (B) This would effect "ceph-deploy" which under some circumstances uses
> this behavior.
> 
> I propose the following patch to mitigate side effect (B).
> 
> https://github.com/ceph/ceph-deploy/pull/224

Is the problem that ceph-deploy will let you specify a directory /foo/bar 
and create bar for you?

Given that I don't think the directory use case is a common as the 
device one, perhaps simply requiring that that directory already exist 
(user can do mkdir -p $dir) will get us to the cleanest point.  I think 
one of the more common use cases for this is when the user has their own 
mount they want to set up, in which case it'll be an existing 
directory (mount point).

The other main use case that comes to mind is the 'quickly deploy in a 
bunch of dirs for testing', and in that case we can simply add mkdir to 
the instructions...?

sage

> 
> I see no way to resolve issue (A) in general if my proposal for change
> is selected.
> 
> I have discussed this issue with "alfredodeza" on IRC both privately and
> later on the "ceph-devel" IRC channel and he is "really divided here"
> hence we decided I would bring this up for discussion on this mailing list.
> 
> Best regards
> 
> Owen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
