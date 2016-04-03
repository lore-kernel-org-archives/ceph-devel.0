From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-disk improvements
Date: Sun, 3 Apr 2016 08:59:41 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604030859210.19675@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com> <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54442 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbcDCM7u (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 3 Apr 2016 08:59:50 -0400
In-Reply-To: <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 2 Apr 2016, Wido den Hollander wrote:
> > Op 1 april 2016 om 17:36 schreef Sage Weil <sweil@redhat.com>:
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
> 
> Keep in mind that you can't create a partition on a bcache device. So when using
> bcache, the journal has to be filebased and not a partition.

Can you create a bcache device out of a partition, though?

sage

> If we add the flag --file-based-journal or --no-partitions we can create OSDs on
> both bcache and dm-cache.
> 
> With BlueStore this becomes a problem since it requires the small (XFS)
> filesystem for it's metadata.
> 
> Wido
> 
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
> > 
> > Another consideration is that right now we don't play nice with LVM at 
> > all.  Should we?  dm-cache is usually used in conjunction with LVM 
> > (although it doesn't have to be).  Does LVM provide value?  Like, the 
> > ability for users to add a second SSD to a box and migrate cache, wal, or 
> > journal partitions around?
> > 
> > I'm interested in hearing feedback on requirements, approaches, and 
> > interfaces before we go too far down the road...
> > 
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
