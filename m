From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: crash in rbd_img_request_create
Date: Sun, 11 May 2014 18:33:37 +0200
Message-ID: <CABt9es_6eU7Tu25EdT2GZVhTEz5L4_85Krm-rDdH9PNMp_J5kA@mail.gmail.com>
References: <CABt9es_QVVHR30D+VyKyn+gr=0pHahwwvZAbXAvG78ixX9t86w@mail.gmail.com>
	<536EEA5C.70503@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:53233 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbaEKQdj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 May 2014 12:33:39 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so1224225lab.31
        for <ceph-devel@vger.kernel.org>; Sun, 11 May 2014 09:33:37 -0700 (PDT)
In-Reply-To: <536EEA5C.70503@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Thorwald Lundqvist <thorwald@jumpstarter.io>

> Are you still running kernel rbd as a client of ceph
> services running on the same physical machine?
>
> I personally believe that scenario may be at risk of
> deadlock in any case--we haven't taken great care to
> avoid it in this case.

Yes. Risking a deadlock on this machine is fine though, we only use it
for development and testing.

> Anyway...
>
> I can build v3.14.1 but I don't know what kernel configuration
> you are using.  Knowing that could be helpful.  I built it using
> a config I have though, and it's *possible* you crashed on
> this line, in rbd_segment_name():
>         ret = snprintf(name, CEPH_MAX_OID_NAME_LEN + 1, name_format,
>                         rbd_dev->header.object_prefix, segment);
> And if so, the only reason I can think that this failed is if
> rbd_dev->header.object_prefix were null (or an otherwise bad
> pointer value).  But at this point it's a lot of speculation.

config: http://pastebin.com/unZCzXZZ

> Depending on what your stress tests were doing, I suppose it
> could be that you unmapped an in-use rbd image and there was
> some sort of insufficient locking.
>
> Can you also give a little insight about what your stress
> tests were doing?

The stress testing had about 3 rbd volumes constantly mapped. A
standard webstack was installed on them (LNMP) with a wordpress
installation which was hammered with requests to PHP which made
further calls to mysql. All volumes used ext4 and one of them hosted
the raw mysql innodb data files. From the stack trace it looks like
mysqld did an fsync which cased the failure in rbd. The server was
otherwise completely unused, no concurrent rbd mapping took place. rbd
was using layered mode but there should be a maximum of about 3
layers.

Thank you for your time,
Hannes
