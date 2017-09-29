From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: luminous/dmcrypt/bluestore
Date: Fri, 29 Sep 2017 10:25:33 -0700
Message-ID: <CAKPXa=ZtQo++JD2ambh4TLdW-0xvCn-RpUfQvXyWGdWRAEBhaw@mail.gmail.com>
References: <CAKRxpusAymjU9Mcm=69tiSk52ok-YfzgtMQaUzxcODpKe8b=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:43786 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbdI2RZe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Sep 2017 13:25:34 -0400
Received: by mail-oi0-f42.google.com with SMTP id r20so536066oie.0
        for <ceph-devel@vger.kernel.org>; Fri, 29 Sep 2017 10:25:34 -0700 (PDT)
In-Reply-To: <CAKRxpusAymjU9Mcm=69tiSk52ok-YfzgtMQaUzxcODpKe8b=qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 29, 2017 at 10:00 AM, Two Spirit <twospirit6905@gmail.com> wrote:
>
> It looks like bluestore is now default in luminous, so
> if I run 'ceph-deploy prepare', is it already bluestore without
> running  'prepare --bluestore' option?
>
> looking at the /var/lib/ceph/osd, also looks like what the docs
> describe as bluestore. I'm unfamiliar with the layout prior to
> luminous.
>
> so running 'ceph-deploy osd prepare --dmcrypt'  prepares the disk for
> encrypted bluestore?

yes  https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/main.py#L2130-L2132
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
