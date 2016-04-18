From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: jewel punch list
Date: Mon, 18 Apr 2016 12:59:21 -0700
Message-ID: <CAJ4mKGYU=53qMvQgCMRk2i3bak3ZxXDrDLk-ZvZ_VeNbV-J-Kg@mail.gmail.com>
References: <alpine.DEB.2.11.1604181448220.4803@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33520 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbcDRT7W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 15:59:22 -0400
Received: by mail-vk0-f53.google.com with SMTP id n62so117804230vkb.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 12:59:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604181448220.4803@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ack.

On Mon, Apr 18, 2016 at 12:57 PM, Sage Weil <sweil@redhat.com> wrote:
> I think we're in good shape.  Assuming the qa/workunit bit is fixed (let's
> do a rados run as soon as master builds), are we good for the 10.2.0
> release?  There is still the rgw leak, so please merge the parts that are
> safe and we'll backport any follow-on fixes.
>
> There is also one selinux issue (http://tracker.ceph.com/issues/15524)
> that we need to take care of before this goes out.  Yuri, are there other
> outstanding issues that we haven't addressed yet?
>
> Those items aside, can the leads and QA please ACK for a release?
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
