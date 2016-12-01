From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: disk enclosure LEDs
Date: Thu, 1 Dec 2016 07:27:02 -0800 (PST)
Message-ID: <alpine.LSU.2.20.1612010701500.16655@ancalagon.suse.de>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal> <CALe9h7ct1+VwwdWshLPkAJTgAKLa4=+gbxPAkTfa=J488Hv7KA@mail.gmail.com> <3f1f9b7f-c715-c382-603d-67fabe31a001@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45661 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbcLAP1W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 10:27:22 -0500
In-Reply-To: <3f1f9b7f-c715-c382-603d-67fabe31a001@grimmer.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lenz Grimmer <lenz@grimmer.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 1 Dec 2016, Lenz Grimmer wrote:

Hi,

> Instead, I would be in favor if it could tell me which disks it actually
> uses, which would allow me to pass this device name to any given tool I
> choose for blinking the LED on that device.

This seems like a good path to me.

The suggestion Joao made of a plugin is my second choice. That itself 
opens up new opportunities for error, but I like that it doesn't tie 
another dependency into OSD.

> There was a pull request about this, but I don't think it ever got
> merged - http://tracker.ceph.com/issues/3120

Would exposing this through the console (if this has not been done 
already) enable enough to address John's concern?

-Jesse
