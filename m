From: Samuel Just <sjust@redhat.com>
Subject: random thoughts on past_intervals
Date: Fri, 9 Dec 2016 11:59:49 -0800
Message-ID: <CAN=+7FUSq49OxTbKNRO7xkay0MQAGyfZyBKnUnn+Nux-ysNVOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36000 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbcLIT7v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2016 14:59:51 -0500
Received: by mail-qt0-f171.google.com with SMTP id w33so26020768qtc.3
        for <ceph-devel@vger.kernel.org>; Fri, 09 Dec 2016 11:59:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Weil, Sage" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There's code for dealing with some odd past_intervals configurations
including doesn't go back far enough and doesn't go forward far
enough.  I *think* we can simplify this as follows:
1) Once the PG object is constructed and in memory, past_intervals
extends from history.last_epoch_started to the PG's current map
2) On disk, either 1) is true or the set is empty (after an import)

On boot, the OSD generates past_intervals in parallel for any PGs
without them (and perhaps verifies 1) for the rest).  On receipt of a
Notify creating a PG, the OSD generates the past_intervals structure
before instantiating the PG using the same process as on boot --
starting with the included past_intervals if present (may not extend
to the current map, and so may need to be extended).

This allows us to cut out some of the other cases from PG and clarify
the in-memory state.
-Sam
