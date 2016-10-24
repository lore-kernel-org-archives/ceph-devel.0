From: Jeff Layton <jlayton@redhat.com>
Subject: Re: btime and change_attr features in kclient
Date: Mon, 24 Oct 2016 12:19:25 -0400
Message-ID: <1477325965.14828.8.camel@redhat.com>
References: <alpine.DEB.2.11.1610241613520.14316@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36510 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbcJXQTa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 12:19:30 -0400
Received: by mail-qk0-f174.google.com with SMTP id o68so243016975qkf.3
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 09:19:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610241613520.14316@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, zyan@redhat.com, ceph-devel@vger.kernel.org

On Mon, 2016-10-24 at 16:16 +0000, Sage Weil wrote:
> Hi,
> 
> This PR that changes the entity_addr encoding is finally ready to merge
> 
>         https://github.com/ceph/ceph/pull/9825
> 
> but it defines an MSG_ADDR2 feature bit indicating whether we support the 
> new addr encoding.  Right now it's defined with the same value as the 
> FS_CHANGE_ATTR and FS_BTIME feature bit.  Are those upstream yet?  If not, 
> we should get the addr2 support in at the same time so that we can 
> conserve a feature bit.  If not, we'll have to consume another bit.  :(
> 
> sage
> 

That support is merged into master -- is that what you mean by
"upstream"?

-- 
Jeff Layton <jlayton@redhat.com>
