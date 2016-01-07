From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cephfs (hammer) flips directory access bits
Date: Thu, 7 Jan 2016 11:58:14 -0800
Message-ID: <CAJ4mKGbE+ugd1q4JEJZF9u3dLy1kPgA3bRsf4N+sTWF93+zLJg@mail.gmail.com>
References: <n6l67c$hu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38555 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbcAGT6P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jan 2016 14:58:15 -0500
Received: by mail-wm0-f46.google.com with SMTP id b14so140723676wmb.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jan 2016 11:58:15 -0800 (PST)
In-Reply-To: <n6l67c$hu$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: CSa <Christian.Salzmann@fu-berlin.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 7, 2016 at 12:05 AM, CSa <Christian.Salzmann@fu-berlin.de> wrote:
> Hi,
>
> we are using cephfs on a ceph cluster (V0.94.5, 3x MON, 1x MDS, ~50x OSD).
> Recently, we observed a spontaneous (and unwanted) change in the access
> rights of newly created directories:
>
> $ umask
> 0077
> $ mkdir test
> $ ls -ld test
> drwx------ 1 me me 0 Jan  6 14:59 test
> $ touch test/foo
> $ ls -ld test
> drwxrwxrwx 1 me me 0 Jan  6 14:59 test
> $
>
> I kindly would like to ask for help tracking down this issue.

Huh. Which clients are you using? What changes have you made to your
ceph cluster or environment recently?

In any case, set mds debug to 20 and client debug to 20 on the node
you're testing on (if you're using ceph-fuse), run this test, post the
logs, and create a ticket in the tracker pointing at them, please.
(You can use ceph-post-file if you don't have storage space and it'll
upload to our lab.)
-Greg
