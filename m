From: Leander Yu <leander.yu@gmail.com>
Subject: Re: No space left while there are still available disk space
Date: Wed, 6 Oct 2010 12:57:13 +0800
Message-ID: <AANLkTinkdf3B7CEOaSsmAS8v-5oFjR31CRTHsKfHPpFb@mail.gmail.com>
References: <AANLkTi=8ovvk8NPRx3Z=50DboYt4Qni8Ly0EFf0f79E-@mail.gmail.com>
	<AANLkTimcwHyJs+VL5TJVgZTU4MM5PjiAaDkkRkW1Frof@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64156 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab0JFE5P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Oct 2010 00:57:15 -0400
Received: by wwj40 with SMTP id 40so6631408wwj.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Oct 2010 21:57:13 -0700 (PDT)
In-Reply-To: <AANLkTimcwHyJs+VL5TJVgZTU4MM5PjiAaDkkRkW1Frof@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Thanks, we found that even after I clean some disk space and make sure
all the osd disk usage is less than 90%, I still can not write any
data to the filesystem(not a single byte).
Henry have check the kernel client debug info and found the osdmap is
out of date and the flag is keep at full.
He will post more detail information later.
I guess there are some error handling problem there so that the client
didn't keep updating the osdmap when disk is fulled.

Any suggestion for further trouble shooting ?

Regards,
Leander Yu.

On Wed, Oct 6, 2010 at 12:48 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> On Tue, Oct 5, 2010 at 9:40 PM, Leander Yu <leander.yu@gmail.com> wrote:
>> Hi,
>> I just found my ceph cluster report no space left error. I check the
>> df and every osd disk. it still has space available and after delete
>> some file, I still can't write any data to the file system.
>> Any suggestion for trouble shooting this case?
> As with all distributed filesystems, Ceph still doesn't handle things
> very well when even one disk runs out of space. Some sort of solution
> will appear, but isn't on the roadmap yet. The most likely cause is
> that you have disks of different sizes and haven't balanced their
> input (via the CRUSH map) to match. Unfortunately, the best fix is
> either to keep deleting data or to put a larger disk in whichever OSD
> is full. The logs should tell you which one reported full.
>
> Keep in mind that to prevent more nasty badness from the local
> filesystem, Ceph reports a disk "full" at some percentage below full
> (I think it's 95%, but it may actually be less).
> -Greg
>
