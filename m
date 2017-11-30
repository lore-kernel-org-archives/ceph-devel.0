From: Sage Weil <sage@newdream.net>
Subject: Re: Upgrade from Jewel to Luminous. REQUIRE_JEWEL OSDMap
Date: Thu, 30 Nov 2017 03:10:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711300309540.2819@piezo.novalocal>
References: <CADfZm8c9GKuedHA5x0n+2euhXbSqsFYxroimm-aw3Cc5Z00iXQ@mail.gmail.com> <alpine.DEB.2.11.1711280308100.19791@piezo.novalocal> <CADfZm8c1+OhDO36BjYSqLCe-US0Nmvhw87kyUWduc_5X3hL7Pg@mail.gmail.com> <alpine.DEB.2.11.1711281308100.19791@piezo.novalocal>
 <CADfZm8dYLvGOFhtCGp1twwJopz4rUDS1EKqLCxYE_or+RndCrg@mail.gmail.com> <alpine.DEB.2.11.1711281844430.19791@piezo.novalocal> <CADfZm8dOAUnSJxHRvpNng9iOBHg1kyCauXY=VNt6z-kduSYtwg@mail.gmail.com> <alpine.DEB.2.11.1711300049560.8333@piezo.novalocal>
 <CADfZm8dd-ew+1HMDeDy_O8ewu2+-PyAHuAJn-mGLfMx2ZWn=BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:58939 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbdK3DLC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Nov 2017 22:11:02 -0500
In-Reply-To: <CADfZm8dd-ew+1HMDeDy_O8ewu2+-PyAHuAJn-mGLfMx2ZWn=BQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cary <dynamic.cary@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 30 Nov 2017, Cary wrote:
> I believe I see what I was doing wrong. I had to run "ceph-osd set
> require_jewel_osds --yes-i-really-mean-it"

'ceph osd set ...', not 'ceph-osd set ...'.

> This is the error I am getting now.
> 2017-11-30 01:11:19.691 7fc171dbd5c0 -1 unrecognized arg set
> src/tcmalloc.cc:284] Attempt to free invalid pointer 0x56262bacf4c0
> *** Caught signal (Aborted) **
> [...]

...and that is an embarassing error from bad arguments on the command 
line!

sage

