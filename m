From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph-fuse remount issues
Date: Mon, 23 Feb 2015 00:14:18 -0500 (EST)
Message-ID: <133474621.9173173.1424668458008.JavaMail.zimbra@redhat.com>
References: <54E66259.9040501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:51177 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbBWFOS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Feb 2015 00:14:18 -0500
In-Reply-To: <54E66259.9040501@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: ceph-devel@vger.kernel.org, zyan@redhat.com, sage@redhat.com

----- Original Message -----
> From: "John Spray" <john.spray@redhat.com>
> To: ceph-devel@vger.kernel.org, zyan@redhat.com, "Gregory Farnum" <gfarnum@redhat.com>
> Sent: Thursday, February 19, 2015 2:23:21 PM
> Subject: ceph-fuse remount issues
> 
> 
> Background: a while ago, we found (#10277) that existing cache
> expiration mechanism wasn't working with latest kernels.  We used to
> invalidate the top level dentries, which caused fuse to invalidate
> everything, but an implementation detail in fuse caused it to start
> ignoring our repeated invalidate calls, so this doesn't work any more.
> To persuade fuse to dirty its entire metadata cache, Zheng added in a
> system() call to "mount -o remount" after we expire things from our
> client side cache.
> 
> However, this was a bit of a hack and has created problems:
>   * You can't call mount -o remount unless you're root, so we are less
> flexible than we used to be (#10542)
>   * While the remount is happening, unmounts sporadically fail and the
> fuse process can become unresponsive to SIGKILL (#10916)
> 
> The first issue was maybe an acceptable compromise, but the second issue
> is just painful, and it seems like we might not have seen the last of
> the knock on effects -- upstream maintainers certainly aren't expecting
> filesystems to remount themselves quite so frequently.

Yeah. I looked at this briefly and switching to a conditional behavior based on kernel version shouldn't be too difficult; the actual change in behavior is a very short patch: https://github.com/ceph/ceph/commit/0827bb79ea5127e6763f6e904dfa1a3266046ffb

I'm going to try and integrate that in with my branch to warn on remount issues in the morning: https://github.com/ceph/ceph/pull/3681 (better version of that sitting on my computer now too)

> We probably have an opportunity to get something upstream in fuse to
> support a direct call to trigger the invalidation we want, if we can
> work out what that should look like.  Thoughts?

Yes please. I don't really have the kernel VFS or FUSE interface experience here to offer up much off the top of my head, but I think this is something that FUSE ought to allow us to do. LSF/MM is coming up and Sage will be there, which is probably a good time to raise issues with people in the hallway or appropriate sessions.
-Greg
