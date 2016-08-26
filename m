From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: new boost
Date: Fri, 26 Aug 2016 12:13:13 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1608261211090.32234@ancalagon.suse.de>
References: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53769 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbcHZTdn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 Aug 2016 15:33:43 -0400
In-Reply-To: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 26 Aug 2016, Sage Weil wrote:

> 4) #1, with cmake smarts to let you choose the submodule or installed
> boost (and possibly autoselect system boost if it's new enough).

This sounds like the best option to me. One thing to keep in mind, though, 
is that Boost libraries can and do break interfaces between versions 
sometimes, so newer does not at all mean backward compatibility with an 
older version.

> 'bcp' can be used to extra subcomponents of the library to compile
> statically.  Matt found this tended to snowball and there was some risk of
> conflicting with an installed boost.

This was what I found as well.

-Jesse
