From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: about rbd journaling
Date: Fri, 6 May 2016 08:28:31 -0400
Message-ID: <CA+aFP1BBZD2-1VojzMFw9_HXe2h0i31GaoiXdwJR=M2cWpwadQ@mail.gmail.com>
References: <CAKZcxgd-1O64885PZ+tNJJrFNnvTx=uaA7aJi91Puv+KuqSGgw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34285 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757910AbcEFM2c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 08:28:32 -0400
Received: by mail-pf0-f174.google.com with SMTP id y69so49150263pfb.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 May 2016 05:28:32 -0700 (PDT)
In-Reply-To: <CAKZcxgd-1O64885PZ+tNJJrFNnvTx=uaA7aJi91Puv+KuqSGgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The rationale for requiring the data to be safely committed to the
journal before permitting writes to the image itself is to ensure
consistent state upon a crash/failure.  If, for example, the write
modified the image and there was a failure before ensuring the journal
entry was safely committed to disk, the replicated image would no
longer be consistent with the source (since there would be no log of
the change for the replicated image to replay).

With the librbd cache enabled, we still immediately ACK the write to
the client since read-after-write requests can be correctly satisfied
by the cache.  The cache writeback for the affected extents will be
blocked until the journal entry is safely stored -- so a flush would
block until the journal event it safe on disk.

On Thu, May 5, 2016 at 11:17 PM, Jaze Lee <jazeltq@gmail.com> wrote:
> Hi all,
>    I found the rbd journaling first send data to journal pool (in
> append_io_event, and return a future
>   by journaler append) and then(when the append is safe) send to the
> real data pool.
>    Can someone explain a little more on this. I do not why doing this=
,
> why not first to data pool,
>    then to the journal pool?  May be put data first in journal pool
> will let the rbd-mirror sync first?
>
> Thanks a lot
>
>
>
>
> --
> =E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Jason
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
