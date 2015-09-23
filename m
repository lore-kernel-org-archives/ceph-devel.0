From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 11:48:48 +0300
Message-ID: <CAOi1vP_KNFG7KNYsEmh+tX3xq0EY4op0fXxdCcNW+xSDFuxPig@mail.gmail.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com>
	<189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com>
	<20150922092847.GA13767@gmail.com>
	<151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com>
	<20150923063313.GA8713@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32848 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbIWIst (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 04:48:49 -0400
Received: by wiclk2 with SMTP id lk2so228471394wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 01:48:48 -0700 (PDT)
In-Reply-To: <20150923063313.GA8713@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 9:33 AM, Mykola Golub <mgolub@mirantis.com> wrote:
> On Tue, Sep 22, 2015 at 01:32:49PM -0400, Jason Dillaman wrote:
>
>> > > * rbd mirror pool enable <pool-name>
>> > >         This will, by default, ensure that all images created in this
>> > >         pool have exclusive lock, journaling, and mirroring feature bits
>> > >         enabled.
>> > >
>> > > * rbd mirror pool disable <pool-name>
>> > >         This will clear the default image features for new images in this
>> > >         pool.
>> >
>> > Will 'rbd mirror pool enable|disable' change behaviour only for newly
>> > created images in the pool or will enable|disable mirroring for
>> > existent images too?
>>
>> Since the goal is to set default pool behavior, it would only apply
>> to newly created images.  You can enable/disable on specific images
>> using the 'rbd mirror image enable/disable' commands.
>
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

I haven't read the discussion in full, so feel free to ignore, but I'd
much rather have rbd create create images with the same set of features
enabled no matter which pool it's pointed to.

I'm not clear on what exactly a pool policy is.  If it's just a set of
feature bits to enable at create time, I don't think it's worth
introducing at all.  If it's a set feature bits + a set of mirroring
related options, I think it should just be a set of those options.
Then, rbd create --enable-mirroring could be a way to create an image
with mirroring enabled.

My point is a plain old "rbd create foo" shouldn't depend an any new
pool-level metadata.  It's not that hard to remember which features you
want for which pools and rbd create shortcuts like --enable-object-map
and --enable-mirroring would hide feature bit dependencies and save
typing.  --enable-mirroring would also serve as a ticket to go look at
new metadata and pull out any mirroring related defaults.

Thanks,

                Ilya
