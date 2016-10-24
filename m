From: Sage Weil <sweil@redhat.com>
Subject: Re: btime and change_attr features in kclient
Date: Mon, 24 Oct 2016 16:26:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610241625430.14316@piezo.us.to>
References: <alpine.DEB.2.11.1610241613520.14316@piezo.us.to> <1477325965.14828.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1055692954-1477326408=:14316"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965298AbcJXQ0y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Oct 2016 12:26:54 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB3BA624BC
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 16:26:48 +0000 (UTC)
In-Reply-To: <1477325965.14828.8.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: zyan@redhat.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1055692954-1477326408=:14316
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 24 Oct 2016, Jeff Layton wrote:
> On Mon, 2016-10-24 at 16:16 +0000, Sage Weil wrote:
> > Hi,
> > 
> > This PR that changes the entity_addr encoding is finally ready to merge
> > 
> >         https://github.com/ceph/ceph/pull/9825
> > 
> > but it defines an MSG_ADDR2 feature bit indicating whether we support the 
> > new addr encoding.  Right now it's defined with the same value as the 
> > FS_CHANGE_ATTR and FS_BTIME feature bit.  Are those upstream yet?  If not, 
> > we should get the addr2 support in at the same time so that we can 
> > conserve a feature bit.  If not, we'll have to consume another bit.  :(
> > 
> > sage
> > 
> 
> That support is merged into master -- is that what you mean by
> "upstream"?

I mean support on the client side in the upstream kernel...

sage
--8323329-1055692954-1477326408=:14316--
