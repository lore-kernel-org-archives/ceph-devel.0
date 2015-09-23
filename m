From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 09:08:09 -0400 (EDT)
Message-ID: <1213966550.33031523.1443013689108.JavaMail.zimbra@redhat.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com> <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com> <20150922092847.GA13767@gmail.com> <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com> <20150923063313.GA8713@gmail.com> <CAOi1vP_KNFG7KNYsEmh+tX3xq0EY4op0fXxdCcNW+xSDFuxPig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:55820 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbbIWNIL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 09:08:11 -0400
In-Reply-To: <CAOi1vP_KNFG7KNYsEmh+tX3xq0EY4op0fXxdCcNW+xSDFuxPig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

> > In this case the commands look a little confusing to me, as from their
> > names I would rather think they enable/disable mirror for existent
> > images too. Also, I don't see a command to check what current
> > behaviour is. And, I suppose it would be useful if we could configure
> > other default features for a pool (exclusive-lock, object-map, ...)
> > Also, I am not sure we should specify <pool-name> this way, as it is
> > not consistent with other rbd commands. By default rbd operates on
> > 'rbd' pool, which can be changed by --pool option. So what do you
> > think if we have something similar to 'rbd feature' commands?
> >
> >   rbd [--pool <pool>] default-feature enable <feature>
> >   rbd [--pool <pool>] default-feature disable <feature>
> >   rbd [--pool <pool>] default-feature show [<feature>]
> >
> > (If <feature> is not specified in the last command, all features are
> > shown).
> 
> I haven't read the discussion in full, so feel free to ignore, but I'd
> much rather have rbd create create images with the same set of features
> enabled no matter which pool it's pointed to.
> 
> I'm not clear on what exactly a pool policy is.  If it's just a set of
> feature bits to enable at create time, I don't think it's worth
> introducing at all.  If it's a set feature bits + a set of mirroring
> related options, I think it should just be a set of those options.
> Then, rbd create --enable-mirroring could be a way to create an image
> with mirroring enabled.
> 
> My point is a plain old "rbd create foo" shouldn't depend an any new
> pool-level metadata.  It's not that hard to remember which features you
> want for which pools and rbd create shortcuts like --enable-object-map
> and --enable-mirroring would hide feature bit dependencies and save
> typing.  --enable-mirroring would also serve as a ticket to go look at
> new metadata and pull out any mirroring related defaults.
> 

While I agree that I don't necessarily want to go down the road of specifying per-pool default features, I think there is a definite use-case need to be able to enable mirroring on a per-pool basis by default.  Without such an ability, taking OpenStack for example, it would require changes to Glance, Cinder, and Nova in order to support DR configurations -- or you could get it automatically with a little pre-configuration.
