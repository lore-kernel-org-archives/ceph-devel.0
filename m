From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 22:15:26 +0300
Message-ID: <CAOi1vP_p-SP6jyGm=P=tBoHgNqPGU0gXm6YkPqBYOkW0jSAbhw@mail.gmail.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com>
	<189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com>
	<20150922092847.GA13767@gmail.com>
	<151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com>
	<20150923063313.GA8713@gmail.com>
	<CAOi1vP_KNFG7KNYsEmh+tX3xq0EY4op0fXxdCcNW+xSDFuxPig@mail.gmail.com>
	<1213966550.33031523.1443013689108.JavaMail.zimbra@redhat.com>
	<CAOi1vP9=3Uf1Z69AFpsENpimebf+3=RTP2JsOouhAnVPpQMzgQ@mail.gmail.com>
	<628927553.33246726.1443032916737.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35139 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbbIWTPh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 15:15:37 -0400
Received: by wicge5 with SMTP id ge5so221851160wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 12:15:26 -0700 (PDT)
In-Reply-To: <628927553.33246726.1443032916737.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 9:28 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>> So a pool policy is just a set of feature bits?
>
> It would have to store additional details as well.
>
>> I think Cinder at least creates images with rbd_default_features from
>> ceph.conf and adds in layering if it's not set, meaning there is no
>> interface for passing through feature bits (or anything else really,
>> things like striping options, etc).  What pool-level default feature
>> bits infrastructure would do is replace a big (cluster-level) hammer
>> with a smaller (pool-level) hammer.  You'd have to add librbd APIs for
>> it and someone eventually will try to follow suit and add defaults for
>> other settings.  You said you weren't attempting to create a mechanism
>> to specify arbitrary default features for a given pool, but I think it
>> will come up in the future if we introduce this - it's only logical.
>>
>> What we might want to do instead is use this mirroring milestone to add
>> support for a proper key-value interface for passing in features and
>> other settings for individual rbd images to OpenStack.  I assume it's
>> all python dicts with OpenStack, so it shouldn't be hard?  I know that
>> getting patches into OpenStack can be frustrating at times and I might
>> be underestimating the importance of the use case you have in mind, but
>> patching our OpenStack drivers rather than adding what essentially is
>> a workaround to librbd makes a lot more sense to me.
>>
>
> It would be less work to skip adding the pool-level defaults which is a plus given everything else required.  However, putting aside how long it would take for the required changes to trickle down from OpenStack, Qemu, etc (since I agree that shouldn't drive design), in some ways your proposal could be seen as blurring the configuration encapsulation between clients and Ceph.
>
> Is the goal to configure my storage policies in one place or should I have to update all my client configuration settings (not that big of a deal if you are using something like Puppet to push down consistent configs across your servers)? Trying to think like an end-user, I think I would prefer configuring it once within the storage system itself.  I am not familiar with any other storage systems that configure mirroring via OpenStack config files, but I could be wrong since there are a lot of volume drivers now.

I'm not very familiar with OpenStack so I don't know either, I'm just
pointing out that, as far as at least cinder goes, we currently use
a cluster-wide default for something that is inherently a per-image
property, that there is no way to change it, and that there is a way to
configure only a small subset of settings.  I don't see it as blurring
the configuration encapsulation: if a user is creating an image from
OpenStack (or any other client for that matter), they should be able to
specify all the settings they want for a given image and not rely on
cluster-wide or pool-wide defaults.  (Maybe I'm too fixed on this idea
that per-image properties should be per-image and you are trying to
think bigger.  What I'm ranting about here is status quo, mirroring and
the new use cases and configuration challanges it brings along are
somewhat off to the side.)

I'm not against pool-level defaults per se, I just think if we go down
this road it's going to be hard to draw a line in the future, and I want
to make sure we are not adding it just to work around deficiencies in
our OpenStack drivers (and possibly librbd create-like APIs).

Thanks,

                Ilya
