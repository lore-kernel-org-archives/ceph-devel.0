From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/3] libceph: get rid of ack vs commit
Date: Thu, 23 Feb 2017 23:18:08 +0100
Message-ID: <CAOi1vP_KjVqsVtg1JJ53et46TrZDWOujzsnWSvZetDHhu10mDQ@mail.gmail.com>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
 <1487883561-32001-3-git-send-email-idryomov@gmail.com> <alpine.DEB.2.11.1702232142510.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34956 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdBWWSv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 17:18:51 -0500
Received: by mail-ua0-f172.google.com with SMTP id 40so3182822uau.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 14:18:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702232142510.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On Thu, Feb 23, 2017 at 10:43 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 23 Feb 2017, Ilya Dryomov wrote:
>> - CEPH_OSD_FLAG_ACK shouldn't be set anymore, so assert on it
>
> Conversely, FLAG_ONDISK should *always* be set.  We should probably assert
> that as well.

That's asserted in handle_reply().  Also in the next patch I assert
that neither is set and then set ONDISK in submit_request().

Thanks,

                Ilya
