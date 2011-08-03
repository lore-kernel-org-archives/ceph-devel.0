From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Wed, 3 Aug 2011 08:41:47 -0700
Message-ID: <CAC-hyiHzmn25ryJkNUdzQvk7c7chwVDfmwDeo8X2+4zTbDuFGQ@mail.gmail.com>
References: <4E33D101.1050504@ufm.su>
	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
	<4E3432FC.9030204@ufm.su>
	<20110730165001.GI7361@thunk.org>
	<Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>
	<20110730221900.GK7361@thunk.org>
	<Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net>
	<4E353D9E.5080802@ufm.su>
	<Pine.LNX.4.64.1107310951550.2348@cobra.newdream.net>
	<4E35B833.6070304@ufm.su>
	<Pine.LNX.4.64.1107311339530.23447@cobra.newdream.net>
	<80E3795B-C981-492F-9312-DC91D57E4017@mit.edu>
	<Pine.LNX.4.64.1108010918580.6290@cobra.newdream.net>
	<CAO47_-9DmxqfBsBF2K_8ScX_4d-HPz01QeQ-2FFwZS-nCDEOsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54449 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab1HCPlt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2011 11:41:49 -0400
Received: by eyx24 with SMTP id 24so807827eyx.33
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2011 08:41:47 -0700 (PDT)
In-Reply-To: <CAO47_-9DmxqfBsBF2K_8ScX_4d-HPz01QeQ-2FFwZS-nCDEOsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: Sage Weil <sage@newdream.net>, Theodore Tso <tytso@mit.edu>, Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

On Wed, Aug 3, 2011 at 7:16 AM, Christian Brunner <chb@muc.de> wrote:
...
> I tried to reproduce this without ceph, but wasn't able to...
>
> In the meantime it seams, that I can also see the side effects on the
> librbd side: I get an "librbd: data error!" when I do an "rbd copy".
>
> When I look at the librbd code this is related to a sparse_read not
> returning the right size of the object.
>
> I don't know if it helps, but I think that the problem is also related
> to sparse file usage.
>

There were a few sparse-read issues that we fixed not too long ago,
but should have been fixed for at least the previous ceph version. I'm
not sure what version you're using.
There was a ext4 fiemap issue that I was hitting on specific
environments but couldn't determine whether it was fixed in later
kernel versions (I was using 2.6.32). Now is a good time to try and
get to the bottom of it. Here's a script I was using to reproduce it:

#!/bin/sh
dd if=/dev/urandom of=bla bs=1 seek=$((0x6f000)) count=$((0x1000)); sync
dd if=/dev/urandom of=bla bs=1 seek=$((0x70000)) count=$((0x1000)); sync
dd if=/dev/urandom of=bla bs=1 seek=$((0x71000)) count=$((0x1000)); sync
dd if=/dev/urandom of=bla bs=1 seek=$((0x72000)) count=$((0x1000)); sync
dd if=/dev/urandom of=bla bs=1 seek=$((0x73000)) count=$((0x1000)); sync
dd if=/dev/urandom of=bla bs=1 seek=$((0x74000)) count=$((0x2000)); sync
dd if=/dev/urandom of=bla bs=1 seek=$((0x2ae000)) count=$((0x2000)); sync

You can compile and run the following utility to dump all the extents:
http://pastebin.com/h2Cnpk2Q

Thanks,
Yehuda

Oh, btw, You can effectively disable the use of fiemap by setting the
'filestore fiemap threshold' config option with large enough value
(e.g., anything bigger than 4 MB should be enough for rbd).
