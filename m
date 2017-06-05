From: Sage Weil <sage@newdream.net>
Subject: Re: Missing CMake compilation for different OSes common/*_errno.cc
Date: Mon, 5 Jun 2017 02:31:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706050231300.3646@piezo.novalocal>
References: <8ce3c764-c4aa-c1c7-75bb-85c14639c0ed@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46590 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdFECbp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jun 2017 22:31:45 -0400
In-Reply-To: <8ce3c764-c4aa-c1c7-75bb-85c14639c0ed@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, 4 Jun 2017, Willem Jan Withagen wrote:
> Hi,
> 
> I found the following in src/common/Makefile.am:
> if SOLARIS
> libcommon_internal_la_SOURCES += \
>         common/solaris_errno.cc
> endif
> 
> if AIX
> libcommon_internal_la_SOURCES += \
>         common/aix_errno.cc
> endif
> 
> But I seem to be unable to find its counterpart in the Cmake files.
> 
> Is this an "oversight", or part of thet code that is not excersized
> anyways on these platforms?

Oversight, I think!
sage
