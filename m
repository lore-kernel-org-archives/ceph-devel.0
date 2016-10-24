From: Sage Weil <sweil@redhat.com>
Subject: Re: btime and change_attr features in kclient
Date: Mon, 24 Oct 2016 16:28:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610241627140.14316@piezo.us.to>
References: <alpine.DEB.2.11.1610241613520.14316@piezo.us.to>         <1477325965.14828.8.camel@redhat.com> <1477326343.14828.11.camel@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1492390664-1477326500=:14316"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965167AbcJXQ2V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Oct 2016 12:28:21 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E30E8124B
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 16:28:21 +0000 (UTC)
In-Reply-To: <1477326343.14828.11.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: zyan@redhat.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1492390664-1477326500=:14316
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 24 Oct 2016, Jeff Layton wrote:
> On Mon, 2016-10-24 at 12:19 -0400, Jeff Layton wrote:
> > On Mon, 2016-10-24 at 16:16 +0000, Sage Weil wrote:
> > > 
> > > Hi,
> > > 
> > > This PR that changes the entity_addr encoding is finally ready to merge
> > > 
> > >         https://github.com/ceph/ceph/pull/9825
> > > 
> > > but it defines an MSG_ADDR2 feature bit indicating whether we support the 
> > > new addr encoding.  Right now it's defined with the same value as the 
> > > FS_CHANGE_ATTR and FS_BTIME feature bit.  Are those upstream yet?  If not, 
> > > we should get the addr2 support in at the same time so that we can 
> > > conserve a feature bit.  If not, we'll have to consume another bit.  :(
> > > 
> > > sage
> > > 
> > 
> > That support is merged into master -- is that what you mean by
> > "upstream"?
> > 
> 
> Sorry, I misread the subject...
> 
> No, those are not yet supported or recognized in kclient yet. In which
> kernel are you planning to merge the addr2 patches?

That's good news!  :)  The kclient patches for addr2 haven't been written 
yet, though.  There is no particular rush, but we should plan to merge 
all three together so that we can use the same feature bit.

Thanks!
sage
--8323329-1492390664-1477326500=:14316--
