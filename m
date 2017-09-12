From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: On monitor development, bugs, and reviews
Date: Tue, 12 Sep 2017 15:01:01 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1709121452470.7420@linux-psd4>
References: <dadfa535-5759-f918-cb69-c9e936229bf0@suse.de> <alpine.DEB.2.11.1709121951490.24068@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751831AbdILWBU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 12 Sep 2017 18:01:20 -0400
In-Reply-To: <alpine.DEB.2.11.1709121951490.24068@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Joao Eduardo Luis <joao@suse.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>

On Tue, 12 Sep 2017, Sage Weil wrote:

> I think one good place to start would be building a framework around the
> CLI commands.  If you look at FSCommand it provides a structured way to
> implement commands that doesn't add to the nasty if/else pile in the
> OSDMonitor and elsewhere.

I started some work on exactly this a while back. It turns out to reach 
pretty far into things, all the way to the Python interface, but I had 
made pretty good headway. Unfortunately, I believe this is lost on account 
of an SSD explosion, but if the powers that be are also ok with it, it 
wouldn't take much to get me to have another look.

-Jesse
