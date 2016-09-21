From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: ceph osd metadata fails if any osd is down
Date: Wed, 21 Sep 2016 13:29:53 -0400
Message-ID: <CAGbviv+8SkMApa8sbc4-ZjvRxRUVM-SZR+dt2u1CvGshVRoinA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36475 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758057AbcIURaK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 13:30:10 -0400
Received: by mail-io0-f182.google.com with SMTP id m79so60208086ioo.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 10:29:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

In 10.2.2 when running "ceph osd metadata" (defaulting to get metdata for
"all" OSDs), if even 1 OSD is currently marked "down", the entire command
fails and returns an error:

$ ceph osd metadata
Error ENOENT:

- One OSD in the cluster was "down", I removed that OSD and re-ran the
command successfully.

It seems that the "metadata" command should be able to dump the data for
the OSDs that are up and ignore the ones that are down.  Is this a known
bug?

-Wyllys Ingersoll
 Keeper Technology, LLC
