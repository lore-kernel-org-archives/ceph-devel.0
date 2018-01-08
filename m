From: Sage Weil <sage@newdream.net>
Subject: Re: C++17 and C++ ABI on master
Date: Mon, 8 Jan 2018 22:14:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801082213050.24931@piezo.novalocal>
References: <20180108214425.GA10545@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:48361 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932521AbeAHWOe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 17:14:34 -0500
In-Reply-To: <20180108214425.GA10545@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, The Exoteric Order of the Squid Cybernetic <ceph-users@ceph.com>

On Mon, 8 Jan 2018, Adam C. Emerson wrote:
> Good day,
> 
> I've just merged some changs into master that set us up to compile
> with C++17. This will require a reasonably new compiler to build
> master.

Yay!
 
> Due to a change in how 'noexcept' is handled (it is now part of the type
> signature of a function), mangled symbol names of noexcept functions are
> different, so if you have custom clients using the C++ libraries, you may
> need to recompile.
> 
> Do not worry, there should be no change to the C ABI. Any C clients
> should be unaffected.

I added cards to the backlog for libradospp, librbdpp, and libcephfspp.  
Anybody out there interested in working on that?  libcephfspp might be the 
one to start with since it doesn't depend on librados and is a much 
simpler API.

sage


