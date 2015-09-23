From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 09:06:11 -0400 (EDT)
Message-ID: <2098665855.33030828.1443013571211.JavaMail.zimbra@redhat.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com> <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com> <20150922092847.GA13767@gmail.com> <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com> <20150923063313.GA8713@gmail.com> <20150923073421.GB8713@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:41360 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbbIWNGM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 09:06:12 -0400
In-Reply-To: <20150923073421.GB8713@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> > > * rbd mirror pool add <remote-pool-spec>
> > >         This will register a remote cluster/pool as a peer to the
> > >         current,
> > >         local pool.  All existing mirrored images and all future mirrored
> > >         images will have this peer registered as a journal client.
> > >
> > > * rbd mirror pool remove <remote-pool-spec>
> > >         This will deregister a remote cluster/pool as a peer to the
> > >         current,
> > >         local pool.  All existing mirrored images will have the remote
> > >         deregistered from image journals.
> 
> I am not sure we need 'pool' here. I would prefer:
> 
>   rbd mirror peer add <remote-peer-spec>
>   rbd mirror peer remove <remote-peer-spec>
>   rbd mirror peer show
> 
> Where, <remote-peer-spec> should not necessary contain pool, because
> the default could be used or what is specified via '--pool' option.
> 

I used "pool" to signify that these commands operate on a per-pool basis, which is how mirroring will function.
