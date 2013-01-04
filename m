From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 0/6] fix build and packaging issues
Date: Fri, 4 Jan 2013 10:00:26 -0800
Message-ID: <CAPYLRzi6MB7d_kkq5h_TOQ+-vwXR7w+fJvNytMjb3Ug9rPy+2A@mail.gmail.com>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:46982 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab3ADSA1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 13:00:27 -0500
Received: by mail-qa0-f50.google.com with SMTP id cr7so91103qab.9
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 10:00:27 -0800 (PST)
In-Reply-To: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Gary Lowell <gary.lowell@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Danny Al-Gaaf <dalgaaf@suse.de>

Thanks!

Gary, can you pull these into a branch and do some before-and-after
package comparisons on our systems (for the different distros in
gitbuilder) and then merge into master?
-Greg

On Fri, Jan 4, 2013 at 9:51 AM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:
> This set of patches contains fixes for some build and packaging issues.
>
> Danny Al-Gaaf (6):
>   src/java/Makefile.am: fix default java dir
>   ceph.spec.in: fix handling of java files
>   ceph.spec.in: rename libcephfs-java package to cephfs-java
>   ceph.spec.in: fix libcephfs-jni package name
>   configure.ac: remove AC_PROG_RANLIB
>   configure.ac: change junit4 handling
>
>  ceph.spec.in         | 21 +++++++++------------
>  configure.ac         |  8 +++++---
>  src/java/Makefile.am |  6 +++---
>  3 files changed, 17 insertions(+), 18 deletions(-)
>
> --
> 1.8.0.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
