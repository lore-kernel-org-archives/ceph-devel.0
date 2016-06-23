From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-disk improvements
Date: Thu, 23 Jun 2016 15:41:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606231530350.3223@piezo.us.to>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com> <CAC-Np1xvHWPSr44RMaS0wOSSxvXBYkcBjbCJSu0G9yGf-=9nWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57011 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbcFWPl2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jun 2016 11:41:28 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D4C31667
	for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2016 15:41:28 +0000 (UTC)
In-Reply-To: <CAC-Np1xvHWPSr44RMaS0wOSSxvXBYkcBjbCJSu0G9yGf-=9nWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

[Resurrecting an old thread!]

On Thu, 7 Apr 2016, Alfredo Deza wrote:

> On Fri, Apr 1, 2016 at 11:36 AM, Sage Weil <sweil@redhat.com> wrote:
> > Hi all,
> >
> > There are a couple of looming features for ceph-disk:
> >
> > 1- Support for additional devices when using BlueStore.  There can be up
> > to three: the main device, a WAL/journal device (small, ~128MB, ideally
> > NVRAM), and a fast metadata device (as big as you have available; will be
> > used for internal metadata).
> >
> > 2- Support for setting up dm-cache, bcache, and/or FlashCache underneath
> > filestore or bluestore.
> >
> > The current syntax of
> >
> >  ceph-disk prepare [--dmcrypt] [--bluestore] DATADEV [JOURNALDEV]
> >
> > isn't terribly expressive.  For example, the journal device size is set
> > via a config option, not on the command line.  For bluestore, the metadata
> > device will probably want/need explicit user input so they can ensure it's
> > 1/Nth of their SSD (if they have N HDDs to each SSD).
> >
> > And if we put dmcache in there, that partition will need to be sized too.
> 
> Sebastien's suggestion of allowing plugins for ceph-disk is ideal
> here, because it would allow to enable extra functionality
> (and possibly at a faster release pace) without interfering with the
> current syntax.
> 
> Reusing your examples, a "bluestore" plugin could be a sub-command:
> 
>     ceph-disk bluestore prepare [...]
> 
> Device size, extra flags or overriding options would be clearly
> separated because of the subcommand. This would be the same
> case for dm-cache, bcache, or whatever comes next.

I like this in principle, but I'm not sure how to make this coexist 
peacefully with the current usage.  Lots of tooling already does 
'ceph-disk prepare ...' and 'ceph-dist activate ...'.  We definitely can't 
break the activate portion (and in general that part has to be "magic" and 
leverage whatever plugins are needed in order to make the device go).  And 
for prepare, in my ideal world we'd be able to flip the switch on the 
'default' without changing the usage, so that legacy instantiations that 
targetted filestore would "just work" and start creating bluestore osds.
Is that too ambitious?

Maybe it is just the prepare path that matters, and the usage would 
go from

	ceph-disk prepare --cluster [cluster-name] --cluster-uuid [uuid] \
		--fs-type [ext4|xfs|btrfs] [data-path] [journal-path]

to

	ceph-disk prepare [plugin] ...

?  Or maybe it's simpler to do

	ceph-disk -p|--plugin <foo> prepare ...

I'm not sure it's quite to simple, though, because really dm-cache or 
dm-crypt functionality are both orthogonal to filestore vs bluestore...

> > Another consideration is that right now we don't play nice with LVM at
> > all.  Should we?  dm-cache is usually used in conjunction with LVM
> > (although it doesn't have to be).  Does LVM provide value?  Like, the
> > ability for users to add a second SSD to a box and migrate cache, wal, or
> > journal partitions around?
> 
> One of the problematic corners of ceph-disk is that it tries to be 
> helpful by trying to predict accurately sizes and partitions to make it 
> simpler for a user. I would love to see ceph-disk be less flexible here 
> and require actual full devices for an OSD and a separate device for a 
> Journal, while starting to deprecate journal collocation and 
> directory-osd.

You mean you would have it not create partitions for you?  This might be a 
bit hard since it's pretty centered around creating labeled partitions.  
We could feed it existing partitions without labels, but I think that 
would just make the usability much harder.

Perhaps standardizing the syntax around this so that partitions is either 
size X, Y%, or the full/rest of the device, and have sane defaults for 
each--but standard options.  For bluestore, for instance,

	ceph-disk prepare bluestore BASEDEV [--wal WALDEV] [--db DBDEV]

and any DEV looks like

	/dev/foo[=<full|x%|yM|zG>]

> Going back to the plugin idea, LVM support could be enabled by a 
> separate plugin and ceph-disk could stay lean.

We could do something like

	/dev/foo[,<gpt|lvm>][=<full|x%|yM|zG>]

e.g.,

	ceph-disk prepare bluestore /dev/sdb --wal /dev/sdc=128M
or
	ceph-disk prepare bluestore /dev/sdb,lvm --wal /dev/sdc,lvm=128M

?

sage
