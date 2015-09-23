From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 09:04:52 -0400 (EDT)
Message-ID: <99106919.33030088.1443013492368.JavaMail.zimbra@redhat.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com> <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com> <20150922092847.GA13767@gmail.com> <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com> <20150923063313.GA8713@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:35118 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbbIWNEx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 09:04:53 -0400
In-Reply-To: <20150923063313.GA8713@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> In this case the commands look a little confusing to me, as from their
> names I would rather think they enable/disable mirror for existent
> images too. Also, I don't see a command to check what current
> behaviour is. And, I suppose it would be useful if we could configure
> other default features for a pool (exclusive-lock, object-map, ...)
> Also, I am not sure we should specify <pool-name> this way, as it is
> not consistent with other rbd commands. By default rbd operates on
> 'rbd' pool, which can be changed by --pool option. So what do you
> think if we have something similar to 'rbd feature' commands?
> 
>   rbd [--pool <pool>] default-feature enable <feature>
>   rbd [--pool <pool>] default-feature disable <feature>
>   rbd [--pool <pool>] default-feature show [<feature>]
> 
> (If <feature> is not specified in the last command, all features are
> shown).
> 
> Similarly, it might be useful to have 'rbd feature show' command:
> 
>   rbd feature show <image-spec> [<feature>]
> 
> BTW, where do you think these default feature flags will be stored?
> Storing in pg_pool_t::flags I suppose is the easiest but it looks like
> a layering violation.
> 

I used 'mirror pool enable/disable' to keep all the related commands together.  I wasn't attempting to create a mechanism to specify arbitrary default features for a given pool, only the ability to enable mirroring (by default) on a given pool since that is the use case discussed at CDS. 

Image features can already be seen (along with lots of other image stats) via "rbd info <image-spec>".  Mirror pool settings can be seen via the previously proposed "mirror pool info" command.
