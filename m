From: Alex Elder <elder@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Tue, 18 Dec 2012 10:09:03 -0600
Message-ID: <50D0951F.6050106@inktank.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <alpine.DEB.2.00.1211212041240.9963@cobra.newdream.net> <CAPud5_4S6-K33f4qLR+-cMm5NLn35H3aXo_LVSenwBM2sxgELg@mail.gmail.com> <CAPud5_7EckkvSth8+YeGvEph1GxjTqovXhG6gVWKUX-3K9cLjQ@mail.gmail.com> <50B7C788.6040404@inktank.com> <50B93FCA.2060801@inktank.com> <CAPud5_4avt1ohkdg3s_pcwoF+4AfuAYDP3qJUqL84nFnmh2GjA@mail.gmail.com> <50BC2DE6.6050307@inktank.com> <50C65AE5.2050704@inktank.com> <CAPud5_7OPrpg1Q_UTw2PskG+o=+H82xgJHacmGT+bVOZkf466A@mail.gmail.com> <50C774FD.9030107@inktank.com> <50C78D09.5050403@inktank.com> <CAPud5_697TJpxU_fCe+FzmgeuTxWx61My5p+FJN_2B1fpn_G3Q@mail.gmail.com> <CAPud5_6q0gQD0ajpKZdvnaaMBvapQ59fkOA7ANVhPo0dMGJ+Sw@mail.gmail.com> <50CB57E2.10703@inktank.com> <CAPud5_7FF=AXMzd4N9kLb4DGQJgp0Csi
 d7_LV3RKYbiTdB+09g@mail.gmail.com> <50CB69E5.7080001@inktank.com> <CAPud5_5PuF0kMzaWVb84_zB6XyZ4QexUsmqoCTdp8vsFNDE=LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45971 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab2LRQJD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 11:09:03 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so1132158iea.8
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 08:09:02 -0800 (PST)
In-Reply-To: <CAPud5_5PuF0kMzaWVb84_zB6XyZ4QexUsmqoCTdp8vsFNDE=LA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/17/2012 11:12 AM, Nick Bartos wrote:
> Here's a log with the rbd debugging enabled:
> 
> https://gist.github.com/raw/4319962/d9690fd92c169198efc5eecabf275ef1808929d2/rbd-hang-test-1355763470.log
> 
> On Fri, Dec 14, 2012 at 10:03 AM, Alex Elder <elder@inktank.com> wrote:
>> On 12/14/2012 10:53 AM, Nick Bartos wrote:
>>> Yes I was only enabling debugging for libceph.  I'm adding debugging
>>> for rbd as well.  I'll do a repro later today when a test cluster
>>> opens up.
>>
>> Excellent, thank you.   -Alex

I looked through these debugging messages.  Looking only at the
rbd debugging, what I see seems to indicate that rbd is idle at
the point the "hang" seems to start.  This suggests that the hang
is not due to rbd itself, but rather whatever it is that might
be responsible for using the rbd image once it has been mapped.

Is that possible?  I don't know what process you have that is
mapping the rbd image, and what is supposed to be the next thing
it does.  (I realize this may not make a lot of sense, given
a patch in rdb seems to have caused the hang to begin occurring.)

Also note that the debugging information available (i.e., the
lines in the code that can output debugging information) may
well be incomplete.  So if you don't find anything it may be
necessary to provide you with another update which might include
more debugging.

Anyway, could you provide a little more context about what
is going on sort of *around* rbd when activity seems to stop?

Thanks a lot.

					-Alex
