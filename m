From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: ceph-fuse remount issues
Date: Mon, 16 Mar 2015 14:28:32 +0800
Message-ID: <CAAM7YAmgh1vwKCbK-m0khtAd=NC4hDv7iSOZnxfh2=ZU92pCBg@mail.gmail.com>
References: <54E66259.9040501@redhat.com>
	<C2032CA0-61E4-430E-938F-C40D51BF8DDA@redhat.com>
	<alpine.DEB.2.00.1503152222480.28155@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:36123 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbCPG2d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 02:28:33 -0400
Received: by lamx15 with SMTP id x15so31332790lam.3
        for <ceph-devel@vger.kernel.org>; Sun, 15 Mar 2015 23:28:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503152222480.28155@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>, John Spray <john.spray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>

On Mon, Mar 16, 2015 at 1:28 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi Zheng,
>
> On Thu, 26 Feb 2015, ?? wrote:
>> > ? 2015?2?20??06:23?John Spray <john.spray@redhat.com> ???
>> >
>> >
>> > Background: a while ago, we found (#10277) that existing cache expiration mechanism wasn't working with latest kernels.  We used to invalidate the top level dentries, which caused fuse to invalidate everything, but an implementation detail in fuse caused it to start ignoring our repeated invalidate calls, so this doesn't work any more.  To persuade fuse to dirty its entire metadata cache, Zheng added in a system() call to "mount -o remount" after we expire things from our client side cache.
>>
>> Change of d_invalidate() implementation breaks our old cache expiration
>> mechanism. When invalidating a denty, d_invalidate() also walks the
>> dentry subtree and try pruning any unused descendant dentries. Our old
>> cache expiration mechanism replies on this to prune unused dentries. We
>> invalidate the top level dentries, d_invalidate() try pruning unused
>> dentries underneath these top level dentries. Prior to 3.18 kernel,
>> d_invalidate() can fail if the dentry is used by some one.
>> Implementation of d_invalidate() change in 3.18 kernel, d_invalidate()
>> always successes and unhash the dentry even if it?s still in use. This
>> behavior changes make us not be able to use d_invalidate() at will. One
>> known bad consequence is getcwd() system call return -EINVAL after
>> process? working directory gets invalidated.
>
> I took another look at this and it seems to me like we might need
> something more than a new call that does the pruning.  What we were doing
> before was also a bit of a hack, it seems.
>
> What is really going on is that the MDS is telling us to reduce the number
> of inodes we have pinned.  We should ideally turn that into pressure on
> dcache.. but it's not per-superblock, so there's not a shrinker we can
> poke that that does what we want.
>
> We *are* doing the dentry is, so the dentries are unhashed.
> But they aren't getting destroyed... Zheng, this is what the previous hack
> was doing, right?  Forcing unhashed dentries to get trimmed from the LRU?
>
Yes, that's what previous hack does. When invalidating dentry, VFS also tries
destroying the dentry.

> It seems like the most elegant solution would be to patch fs/fuse to make
> that happen in the general case when we do the invalidate upcall.  Does
> that sound right?

what do you mean "make that happen in the general case".  In my option,
there isn't much fuse kernel module can do about dentry. Maybe we can try
adding a new callback which call d_prune_aliases().

Regards
Yan, Zheng

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
