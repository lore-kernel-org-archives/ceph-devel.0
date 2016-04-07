From: Alfredo Deza <adeza@redhat.com>
Subject: Re: ceph-disk improvements
Date: Thu, 7 Apr 2016 08:10:23 -0400
Message-ID: <CAC-Np1xvHWPSr44RMaS0wOSSxvXBYkcBjbCJSu0G9yGf-=9nWw@mail.gmail.com>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33774 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945AbcDGMKZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 08:10:25 -0400
Received: by mail-wm0-f48.google.com with SMTP id f198so22585714wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2016 05:10:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 1, 2016 at 11:36 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi all,
>
> There are a couple of looming features for ceph-disk:
>
> 1- Support for additional devices when using BlueStore.  There can be up
> to three: the main device, a WAL/journal device (small, ~128MB, ideally
> NVRAM), and a fast metadata device (as big as you have available; will be
> used for internal metadata).
>
> 2- Support for setting up dm-cache, bcache, and/or FlashCache underneath
> filestore or bluestore.
>
> The current syntax of
>
>  ceph-disk prepare [--dmcrypt] [--bluestore] DATADEV [JOURNALDEV]
>
> isn't terribly expressive.  For example, the journal device size is set
> via a config option, not on the command line.  For bluestore, the metadata
> device will probably want/need explicit user input so they can ensure it's
> 1/Nth of their SSD (if they have N HDDs to each SSD).
>
> And if we put dmcache in there, that partition will need to be sized too.

Sebastien's suggestion of allowing plugins for ceph-disk is ideal
here, because it would allow to enable extra functionality
(and possibly at a faster release pace) without interfering with the
current syntax.

Reusing your examples, a "bluestore" plugin could be a sub-command:

    ceph-disk bluestore prepare [...]

Device size, extra flags or overriding options would be clearly
separated because of the subcommand. This would be the same
case for dm-cache, bcache, or whatever comes next.

>
> Another consideration is that right now we don't play nice with LVM at
> all.  Should we?  dm-cache is usually used in conjunction with LVM
> (although it doesn't have to be).  Does LVM provide value?  Like, the
> ability for users to add a second SSD to a box and migrate cache, wal, or
> journal partitions around?

One of the problematic corners of ceph-disk is that it tries to be
helpful by trying to predict accurately sizes and partitions
to make it simpler for a user. I would love to see ceph-disk be less
flexible here and require actual full devices for an OSD and a
separate
device for a Journal, while starting to deprecate journal collocation
and directory-osd.

Going back to the plugin idea, LVM support could be enabled by a
separate plugin and ceph-disk could stay lean.

>
> I'm interested in hearing feedback on requirements, approaches, and
> interfaces before we go too far down the road...
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
