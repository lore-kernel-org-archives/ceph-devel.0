From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Wed, 23 Sep 2015 10:34:22 +0300
Message-ID: <20150923073421.GB8713@gmail.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com>
 <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com>
 <20150922092847.GA13767@gmail.com>
 <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com>
 <20150923063313.GA8713@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37452 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbIWHeZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 03:34:25 -0400
Received: by wicfx3 with SMTP id fx3so55899246wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 00:34:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150923063313.GA8713@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 09:33:14AM +0300, Mykola Golub wrote:

> Also, I am not sure we should specify <pool-name> this way, as it is
> not consistent with other rbd commands. By default rbd operates on
> 'rbd' pool, which can be changed by --pool option.

The same reasoning for these commands:

> > * rbd mirror pool add <remote-pool-spec>
> >         This will register a remote cluster/pool as a peer to the current,
> >         local pool.  All existing mirrored images and all future mirrored
> >         images will have this peer registered as a journal client.
> >
> > * rbd mirror pool remove <remote-pool-spec>
> >         This will deregister a remote cluster/pool as a peer to the
> >         current,
> >         local pool.  All existing mirrored images will have the remote
> >         deregistered from image journals.

I am not sure we need 'pool' here. I would prefer:

  rbd mirror peer add <remote-peer-spec>
  rbd mirror peer remove <remote-peer-spec>
  rbd mirror peer show

Where, <remote-peer-spec> should not necessary contain pool, because
the default could be used or what is specified via '--pool' option.

-- 
Mykola Golub
