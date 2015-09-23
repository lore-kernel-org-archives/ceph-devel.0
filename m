From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 14:28:36 -0400 (EDT)
Message-ID: <628927553.33246726.1443032916737.JavaMail.zimbra@redhat.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com> <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com> <20150922092847.GA13767@gmail.com> <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com> <20150923063313.GA8713@gmail.com> <CAOi1vP_KNFG7KNYsEmh+tX3xq0EY4op0fXxdCcNW+xSDFuxPig@mail.gmail.com> <1213966550.33031523.1443013689108.JavaMail.zimbra@redhat.com> <CAOi1vP9=3Uf1Z69AFpsENpimebf+3=RTP2JsOouhAnVPpQMzgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:52991 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbIWS2i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 14:28:38 -0400
In-Reply-To: <CAOi1vP9=3Uf1Z69AFpsENpimebf+3=RTP2JsOouhAnVPpQMzgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

> So a pool policy is just a set of feature bits?

It would have to store additional details as well.

> I think Cinder at least creates images with rbd_default_features from
> ceph.conf and adds in layering if it's not set, meaning there is no
> interface for passing through feature bits (or anything else really,
> things like striping options, etc).  What pool-level default feature
> bits infrastructure would do is replace a big (cluster-level) hammer
> with a smaller (pool-level) hammer.  You'd have to add librbd APIs for
> it and someone eventually will try to follow suit and add defaults for
> other settings.  You said you weren't attempting to create a mechanism
> to specify arbitrary default features for a given pool, but I think it
> will come up in the future if we introduce this - it's only logical.
> 
> What we might want to do instead is use this mirroring milestone to add
> support for a proper key-value interface for passing in features and
> other settings for individual rbd images to OpenStack.  I assume it's
> all python dicts with OpenStack, so it shouldn't be hard?  I know that
> getting patches into OpenStack can be frustrating at times and I might
> be underestimating the importance of the use case you have in mind, but
> patching our OpenStack drivers rather than adding what essentially is
> a workaround to librbd makes a lot more sense to me.
> 

It would be less work to skip adding the pool-level defaults which is a plus given everything else required.  However, putting aside how long it would take for the required changes to trickle down from OpenStack, Qemu, etc (since I agree that shouldn't drive design), in some ways your proposal could be seen as blurring the configuration encapsulation between clients and Ceph. 

Is the goal to configure my storage policies in one place or should I have to update all my client configuration settings (not that big of a deal if you are using something like Puppet to push down consistent configs across your servers)? Trying to think like an end-user, I think I would prefer configuring it once within the storage system itself.  I am not familiar with any other storage systems that configure mirroring via OpenStack config files, but I could be wrong since there are a lot of volume drivers now.

I do like the idea of key/value configuration pairs on image create and I had even proposed that a few weeks ago on a separate email thread since we shouldn't keep expanding rbd_create/rbd_clone/rbd_copy for every possible configuration override.  

--

Jason
