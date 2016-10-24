From: Jeff Layton <jlayton@redhat.com>
Subject: Re: btime and change_attr features in kclient
Date: Mon, 24 Oct 2016 12:25:43 -0400
Message-ID: <1477326343.14828.11.camel@redhat.com>
References: <alpine.DEB.2.11.1610241613520.14316@piezo.us.to>
         <1477325965.14828.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36441 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938959AbcJXQZq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 12:25:46 -0400
Received: by mail-qk0-f176.google.com with SMTP id o68so243151136qkf.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 09:25:46 -0700 (PDT)
In-Reply-To: <1477325965.14828.8.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, zyan@redhat.com, ceph-devel@vger.kernel.org

On Mon, 2016-10-24 at 12:19 -0400, Jeff Layton wrote:
> On Mon, 2016-10-24 at 16:16 +0000, Sage Weil wrote:
> > 
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
> 

Sorry, I misread the subject...

No, those are not yet supported or recognized in kclient yet. In which
kernel are you planning to merge the addr2 patches?
-- 
Jeff Layton <jlayton@redhat.com>
