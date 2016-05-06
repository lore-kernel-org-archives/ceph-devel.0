From: Jaze Lee <jazeltq@gmail.com>
Subject: about rbd journaling
Date: Fri, 6 May 2016 11:17:42 +0800
Message-ID: <CAKZcxgd-1O64885PZ+tNJJrFNnvTx=uaA7aJi91Puv+KuqSGgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34380 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970AbcEFDRo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2016 23:17:44 -0400
Received: by mail-io0-f177.google.com with SMTP id 190so103602656iow.1
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2016 20:17:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
   I found the rbd journaling first send data to journal pool (in
append_io_event, and return a future
  by journaler append) and then(when the append is safe) send to the
real data pool.
   Can someone explain a little more on this. I do not why doing this,
why not first to data pool,
   then to the journal pool?  May be put data first in journal pool
will let the rbd-mirror sync first?

Thanks a lot




--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
