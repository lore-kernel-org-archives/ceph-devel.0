From: Cary <dynamic.cary@gmail.com>
Subject: Re: Upgrade from Jewel to Luminous. REQUIRE_JEWEL OSDMap
Date: Mon, 4 Dec 2017 05:36:13 +0000
Message-ID: <CADfZm8fjgE42ikdBBZ+44FL81EzaFyOd_Rp1D7B0Rj=-+escxQ@mail.gmail.com>
References: <CADfZm8c9GKuedHA5x0n+2euhXbSqsFYxroimm-aw3Cc5Z00iXQ@mail.gmail.com>
 <alpine.DEB.2.11.1711280308100.19791@piezo.novalocal> <CADfZm8c1+OhDO36BjYSqLCe-US0Nmvhw87kyUWduc_5X3hL7Pg@mail.gmail.com>
 <alpine.DEB.2.11.1711281308100.19791@piezo.novalocal> <CADfZm8dYLvGOFhtCGp1twwJopz4rUDS1EKqLCxYE_or+RndCrg@mail.gmail.com>
 <alpine.DEB.2.11.1711281844430.19791@piezo.novalocal> <CADfZm8dOAUnSJxHRvpNng9iOBHg1kyCauXY=VNt6z-kduSYtwg@mail.gmail.com>
 <alpine.DEB.2.11.1711300049560.8333@piezo.novalocal> <CADfZm8dd-ew+1HMDeDy_O8ewu2+-PyAHuAJn-mGLfMx2ZWn=BQ@mail.gmail.com>
 <alpine.DEB.2.11.1711300309540.2819@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:42838 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753102AbdLDFgO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Dec 2017 00:36:14 -0500
Received: by mail-oi0-f47.google.com with SMTP id o64so10916551oia.9
        for <ceph-devel@vger.kernel.org>; Sun, 03 Dec 2017 21:36:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711300309540.2819@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Sage,

 I accidentally upgraded one of my monitors to Mimic when installing
the 9999 ebuild. That ebuild pulled the latest code from
https://github.com/ceph/ceph.git which was Mimic. I uninstalled Mimic
and installed Luminous 12.2.2. Then I was able to run "ceph osd set
require_jewel_osds --yes-i-really-mean-it", and get my cluster to a
healthy state running Luminous 12.2.1. I will update the rest of the
cluster to Luminous 12.2.2 later.

 Thank you for you time and helping me with that!

Cary
-Dynamic


On Thu, Nov 30, 2017 at 3:10 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 30 Nov 2017, Cary wrote:
>> I believe I see what I was doing wrong. I had to run "ceph-osd set
>> require_jewel_osds --yes-i-really-mean-it"
>
> 'ceph osd set ...', not 'ceph-osd set ...'.
>
>> This is the error I am getting now.
>> 2017-11-30 01:11:19.691 7fc171dbd5c0 -1 unrecognized arg set
>> src/tcmalloc.cc:284] Attempt to free invalid pointer 0x56262bacf4c0
>> *** Caught signal (Aborted) **
>> [...]
>
> ...and that is an embarassing error from bad arguments on the command
> line!
>
> sage
>
