From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 09:33:14 +0300
Message-ID: <20150923063313.GA8713@gmail.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com>
 <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com>
 <20150922092847.GA13767@gmail.com>
 <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33110 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbIWGdR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 02:33:17 -0400
Received: by wiclk2 with SMTP id lk2so223887884wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 23:33:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 22, 2015 at 01:32:49PM -0400, Jason Dillaman wrote:

> > > * rbd mirror pool enable <pool-name>
> > >         This will, by default, ensure that all images created in this
> > >         pool have exclusive lock, journaling, and mirroring feature bits
> > >         enabled.
> > > 
> > > * rbd mirror pool disable <pool-name>
> > >         This will clear the default image features for new images in this
> > >         pool.
> > 
> > Will 'rbd mirror pool enable|disable' change behaviour only for newly
> > created images in the pool or will enable|disable mirroring for
> > existent images too?
>
> Since the goal is to set default pool behavior, it would only apply
> to newly created images.  You can enable/disable on specific images
> using the 'rbd mirror image enable/disable' commands.

In this case the commands look a little confusing to me, as from their
names I would rather think they enable/disable mirror for existent
images too. Also, I don't see a command to check what current
behaviour is. And, I suppose it would be useful if we could configure
other default features for a pool (exclusive-lock, object-map, ...)
Also, I am not sure we should specify <pool-name> this way, as it is
not consistent with other rbd commands. By default rbd operates on
'rbd' pool, which can be changed by --pool option. So what do you
think if we have something similar to 'rbd feature' commands?

  rbd [--pool <pool>] default-feature enable <feature>
  rbd [--pool <pool>] default-feature disable <feature>
  rbd [--pool <pool>] default-feature show [<feature>]

(If <feature> is not specified in the last command, all features are
shown).

Similarly, it might be useful to have 'rbd feature show' command:

  rbd feature show <image-spec> [<feature>]

BTW, where do you think these default feature flags will be stored?
Storing in pg_pool_t::flags I suppose is the easiest but it looks like
a layering violation.

-- 
Mykola Golub
