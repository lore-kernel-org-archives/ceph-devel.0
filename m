From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 20:58:13 +0300
Message-ID: <CAOi1vP9=3Uf1Z69AFpsENpimebf+3=RTP2JsOouhAnVPpQMzgQ@mail.gmail.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com>
	<189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com>
	<20150922092847.GA13767@gmail.com>
	<151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com>
	<20150923063313.GA8713@gmail.com>
	<CAOi1vP_KNFG7KNYsEmh+tX3xq0EY4op0fXxdCcNW+xSDFuxPig@mail.gmail.com>
	<1213966550.33031523.1443013689108.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35414 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbbIWR6P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 13:58:15 -0400
Received: by wicge5 with SMTP id ge5so218939149wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 10:58:13 -0700 (PDT)
In-Reply-To: <1213966550.33031523.1443013689108.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 4:08 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>> > In this case the commands look a little confusing to me, as from their
>> > names I would rather think they enable/disable mirror for existent
>> > images too. Also, I don't see a command to check what current
>> > behaviour is. And, I suppose it would be useful if we could configure
>> > other default features for a pool (exclusive-lock, object-map, ...)
>> > Also, I am not sure we should specify <pool-name> this way, as it is
>> > not consistent with other rbd commands. By default rbd operates on
>> > 'rbd' pool, which can be changed by --pool option. So what do you
>> > think if we have something similar to 'rbd feature' commands?
>> >
>> >   rbd [--pool <pool>] default-feature enable <feature>
>> >   rbd [--pool <pool>] default-feature disable <feature>
>> >   rbd [--pool <pool>] default-feature show [<feature>]
>> >
>> > (If <feature> is not specified in the last command, all features are
>> > shown).
>>
>> I haven't read the discussion in full, so feel free to ignore, but I'd
>> much rather have rbd create create images with the same set of features
>> enabled no matter which pool it's pointed to.
>>
>> I'm not clear on what exactly a pool policy is.  If it's just a set of
>> feature bits to enable at create time, I don't think it's worth
>> introducing at all.  If it's a set feature bits + a set of mirroring
>> related options, I think it should just be a set of those options.
>> Then, rbd create --enable-mirroring could be a way to create an image
>> with mirroring enabled.
>>
>> My point is a plain old "rbd create foo" shouldn't depend an any new
>> pool-level metadata.  It's not that hard to remember which features you
>> want for which pools and rbd create shortcuts like --enable-object-map
>> and --enable-mirroring would hide feature bit dependencies and save
>> typing.  --enable-mirroring would also serve as a ticket to go look at
>> new metadata and pull out any mirroring related defaults.
>>
>
> While I agree that I don't necessarily want to go down the road of specifying per-pool default features, I think there is a definite use-case need to be able to enable mirroring on a per-pool basis by default.  Without such an ability, taking OpenStack for example, it would require changes to Glance, Cinder, and Nova in order to support DR configurations -- or you could get it automatically with a little pre-configuration.

So a pool policy is just a set of feature bits?

I think Cinder at least creates images with rbd_default_features from
ceph.conf and adds in layering if it's not set, meaning there is no
interface for passing through feature bits (or anything else really,
things like striping options, etc).  What pool-level default feature
bits infrastructure would do is replace a big (cluster-level) hammer
with a smaller (pool-level) hammer.  You'd have to add librbd APIs for
it and someone eventually will try to follow suit and add defaults for
other settings.  You said you weren't attempting to create a mechanism
to specify arbitrary default features for a given pool, but I think it
will come up in the future if we introduce this - it's only logical.

What we might want to do instead is use this mirroring milestone to add
support for a proper key-value interface for passing in features and
other settings for individual rbd images to OpenStack.  I assume it's
all python dicts with OpenStack, so it shouldn't be hard?  I know that
getting patches into OpenStack can be frustrating at times and I might
be underestimating the importance of the use case you have in mind, but
patching our OpenStack drivers rather than adding what essentially is
a workaround to librbd makes a lot more sense to me.

Thanks,

                Ilya
