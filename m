From: John Spray <jspray@redhat.com>
Subject: async messenger --debug-ms=1 too verbose?
Date: Thu, 22 Sep 2016 18:31:18 +0100
Message-ID: <CALe9h7cUtAL7Rw5r01=d=KXwmG_Fwc-ULjKBuY1NUsHyKSijcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36742 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934732AbcIVRbp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 13:31:45 -0400
Received: by mail-qt0-f179.google.com with SMTP id l91so41054651qte.3
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 10:31:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

Minor thing, I'm finding --debug-ms=1 harder to read with my squishy
mammal brain since we switched to async messenger (comparison here:
http://pastebin.com/LcG2Z91m).  There is just more noise in the screen
now and it's harder to read as a list of messages.

Any thoughts?  Was it kind of accidental or is there a strong need for
the extra stuff?

Cheers,
John
