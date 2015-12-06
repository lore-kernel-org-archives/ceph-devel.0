From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: testing the /dev/cciss/c0d0 device names
Date: Sun, 6 Dec 2015 20:15:21 +0100
Message-ID: <CAOi1vP-jdgunEx4zt27ETZHbNGTzFxGp-rEbWJViD5OWLpS69A@mail.gmail.com>
References: <56632EAC.3040105@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38657 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbbLFTPX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Dec 2015 14:15:23 -0500
Received: by wmec201 with SMTP id c201so125430940wme.1
        for <ceph-devel@vger.kernel.org>; Sun, 06 Dec 2015 11:15:21 -0800 (PST)
In-Reply-To: <56632EAC.3040105@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Stolte, Felix" <f.stolte@fz-juelich.de>

On Sat, Dec 5, 2015 at 7:36 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ilya,
>
> ceph-disk has special handling for device names like /dev/cciss/c0d1 [1] and it was partially broken when support for device mapper was introduced. Ideally there would be a way to test that support when running the ceph-disk suite [2]. Do you know of a way to do that without having the hardware for which this driver is designed ?
>
> Maybe this convention (/dev/cciss/c0d0 being mapped to /sys/block/cciss!c0d0 is not unique to this driver and I could use another to validate the name conversion from X/Y to X!Y and vice versa is handled as it should ?

No, it's not unique.  driver core does strreplace(s, '/', '!') at
register time to work around such block devices.  The list includes
DAC960, aoeblk, cciss, cpqarray, sx8 and probably more, but I don't
think anything widespread uses this naming scheme.  IIRC dm actually
won't let you name a device with anything that contains a slash.

If you really wanted you could set up aoeblk I guess, but a simple unit
test should be be more than enough ;)

Thanks,

                Ilya
