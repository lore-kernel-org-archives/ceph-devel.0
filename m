From: Alex Elder <elder@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Fri, 14 Dec 2012 10:46:26 -0600
Message-ID: <50CB57E2.10703@inktank.com>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <CAPud5_6fCfOkXviFB6rz9YvWYBkwNzf699Z1_TW3_v4nCoaUQA@mail.gmail.com> <CAPud5_7jXmz9Bz9hAcQKG769wvuCn2eWkV-wc_qEZ7kPdsZf1Q@mail.gmail.com> <CAPud5_7P_Z-+14kyGZGxLCUY4SfTWnW3kTOpMh3OYBWgWCt_1w@mail.gmail.com> <alpine.DEB.2.00.1211212041240.9963@cobra.newdream.net> <CAPud5_4S6-K33f4qLR+-cMm5NLn35H3aXo_LVSenwBM2sxgELg@mail.gmail.com> <CAPud5_7EckkvSth8+YeGvEph1GxjTqovXhG6gVWKUX-3K9cLjQ@mail.gmail.com> <50B7C788.6040404@inktank.com> <50B93FCA.2060801@inktank.com> <CAPud5_4avt1ohkdg3s_pcwoF+4AfuAYDP3qJUqL84nFnmh2GjA@mail.gmail.com> <50BC2DE6.6050307@inktank.com> <50C65AE5.2050704@inktank.com> <CAPud5_7OPrpg1Q_UTw2PskG+o=+H82xgJHacmGT+bVOZkf466A@mail.gmail.com> <50C774FD.9030107@inktank.com> <50C78D09.5050403@inktank
 .com> <CAPud5_697TJpxU_fCe+FzmgeuTxWx61My5p+FJN_2B1fpn_G3Q@mail.gmail.com> <CAPud5_6q0gQD0ajpKZdvnaaMBvapQ59fkOA7ANVhPo0dMGJ+Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34156 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab2LNQq2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 11:46:28 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6194622ieb.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 08:46:28 -0800 (PST)
In-Reply-To: <CAPud5_6q0gQD0ajpKZdvnaaMBvapQ59fkOA7ANVhPo0dMGJ+Sw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/13/2012 01:00 PM, Nick Bartos wrote:
> Here's another log with the kernel debugging enabled:
> https://gist.github.com/raw/4278697/1c9e41d275e614783fbbdee8ca5842680f46c249/rbd-hang-1355424455.log
> 
> Note that it hung on the 2nd try.

Just to make sure I'm working with the right code base, can
you confirm that you're using a kernel built with the equivalent
of what's now in the "wip-nick-newer" branch (commit id 1728893)?


Also, looking at this log I don't think I see any rbd debug output.
Does that make sense to you?

How are you activating debugging to get these messages?
If it includes something like:

    echo module libceph +p > /sys/kernel/debug/dynamic_debug/control

it might be that you need to also do:

    echo module rbd +p > /sys/kernel/debug/dynamic_debug/control

This information would be helpful in providing some more context
about what rbd is doing that's leading to the various messaging
activity I seen in this log.

Please send me a log with that info if you are able to produce
one.  Thanks a lot.

					-Alex
