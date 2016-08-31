From: John Spray <jspray@redhat.com>
Subject: Python 3 plans
Date: Wed, 31 Aug 2016 15:09:31 +0100
Message-ID: <CALe9h7fHZpXF18HoiQ4qeihrbg5C9p14m=T834T6tm+pdsquuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33537 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933969AbcHaOKL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Aug 2016 10:10:11 -0400
Received: by mail-qt0-f170.google.com with SMTP id 11so13217084qtc.0
        for <ceph-devel@vger.kernel.org>; Wed, 31 Aug 2016 07:09:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

Various people have been helpfully fixing up the python modules for
python 3 -- but I realised I wasn't sure what our plan really was or
who was depending on this.

Some educated guesses:
 * All the existing modules working with both python 2 and 3 for Kraken?
 * Starting to test on python 3 when we have Xenial nodes in the lab?
 * Keeping python 2 support indefinitely for EL7?

Related things:
 * I guess some openstack CIs might start depending on Python 3 at
some stage?  Maybe this motivated some of the work so far.
 * ceph-mgr will only be python 2 when it lands, it embeds an
interpreter so will need a bunch of #ifdeffing to support both 2 and 3
(a necessary evil)

Cheers,
John
