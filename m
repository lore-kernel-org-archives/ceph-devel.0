From: Sage Weil <sage@newdream.net>
Subject: Re: master / mimic-dev1 deb build broken on ceph/ceph-ci
Date: Thu, 4 Jan 2018 14:30:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801041429290.8186@piezo.novalocal>
References: <CAJE9aOPsGdqDEZFFxwYJ2SRgqOPSkYmC5px5yKyMkvYw0GsP3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:55382 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbeADOaP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 09:30:15 -0500
In-Reply-To: <CAJE9aOPsGdqDEZFFxwYJ2SRgqOPSkYmC5px5yKyMkvYw0GsP3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Thu, 4 Jan 2018, kefu chai wrote:
> hi guys,
> 
> as you may notice that we recently switched our toolchain on xenial to
> gcc-7. to enable the built executables to run on old systems without
> the new libstdc++ runtime, they should be linked against libstdc++
> statically. but the master and mimic-dev1 branches fail to do so.
> that's why the built packages will refuse to install with error
> messages like:
> 
> ceph-test : Depends: libradosstriper1 but it is not going to be installed
>              Depends: libstdc++6 (>= 6) but 5.4.0-6ubuntu1~16.04.5 is
> to be installed
> 
> 
> https://github.com/ceph/ceph/pull/19763 is posted to address this
> issue. but before it is merged, please include it for testing your
> debian packages in sepia.
> 
> the centos-7 build is not impacted by this issue, as it use DTS-7, and
> DTS-7's ld script links the stdc++_nonshared.a for us by default.
> 
> sorry for the inconvenience =(

Thanks for sorting it out!

By the way, v13.0.1 is tagged and mimic-dev1 branch is merged into master 
and removed.

Thanks, everyone!
sage
