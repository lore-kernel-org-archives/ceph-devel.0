From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [ceph-users] CephFS Segfault 12.2.0
Date: Mon, 18 Sep 2017 13:48:19 -0700
Message-ID: <CA+2bHPYXhKyeQAwJ+imwAvxRwe2SxhvQom0rEid-+G19RDtW=w@mail.gmail.com>
References: <5f43d77d-4684-1dfd-e597-6dd113004d6f@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:47420 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdIRUsv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 16:48:51 -0400
Received: by mail-it0-f43.google.com with SMTP id z8so58500itc.2
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 13:48:50 -0700 (PDT)
In-Reply-To: <5f43d77d-4684-1dfd-e597-6dd113004d6f@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Derek Yarnell <derek@umiacs.umd.edu>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Derek,

On Mon, Sep 18, 2017 at 1:30 PM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> We have a recent cluster upgraded from Jewel to Luminous.  Today we had
> a segmentation fault that led to file system degraded.  Systemd then
> decided to restart the daemon over and over with a different stack trace
> (can be seen after the 10k events in the log file[0]).
>
> After trying to fail over to the standby which also kept failing.  After
> shutting down both MDSs for some time we brought one back online and
> what seemed to be the clients had been out long enough to be evicted.
> We were able to then reboot clients (RHEL 7.4) and have them re-connect
> to the file system.

This looks like an instance of:

http://tracker.ceph.com/issues/21070

Upcoming v12.2.1 has the fix. Until then, you will need to apply the
patch locally.

-- 
Patrick Donnelly
