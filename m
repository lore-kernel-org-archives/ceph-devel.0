From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: No space left while there are still available disk space
Date: Tue, 5 Oct 2010 21:48:48 -0700
Message-ID: <AANLkTimcwHyJs+VL5TJVgZTU4MM5PjiAaDkkRkW1Frof@mail.gmail.com>
References: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:32902 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab0JFEst (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Oct 2010 00:48:49 -0400
Received: by pwj5 with SMTP id 5so1608043pwj.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Oct 2010 21:48:48 -0700 (PDT)
In-Reply-To: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Tue, Oct 5, 2010 at 9:40 PM, Leander Yu <leander.yu@gmail.com> wrote:
> Hi,
> I just found my ceph cluster report no space left error. I check the
> df and every osd disk. it still has space available and after delete
> some file, I still can't write any data to the file system.
> Any suggestion for trouble shooting this case?
As with all distributed filesystems, Ceph still doesn't handle things
very well when even one disk runs out of space. Some sort of solution
will appear, but isn't on the roadmap yet. The most likely cause is
that you have disks of different sizes and haven't balanced their
input (via the CRUSH map) to match. Unfortunately, the best fix is
either to keep deleting data or to put a larger disk in whichever OSD
is full. The logs should tell you which one reported full.

Keep in mind that to prevent more nasty badness from the local
filesystem, Ceph reports a disk "full" at some percentage below full
(I think it's 95%, but it may actually be less).
-Greg
