From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH 0/6] fix build and packaging issues
Date: Fri, 4 Jan 2013 10:11:02 -0800
Message-ID: <DCEE4FFA-38BD-4EA5-80C9-1C101AC1BB45@inktank.com>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de> <CAPYLRzi6MB7d_kkq5h_TOQ+-vwXR7w+fJvNytMjb3Ug9rPy+2A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:50902 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab3ADSTK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 13:19:10 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so7668811dad.41
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 10:19:09 -0800 (PST)
In-Reply-To: <CAPYLRzi6MB7d_kkq5h_TOQ+-vwXR7w+fJvNytMjb3Ug9rPy+2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Danny Al-Gaaf <dalgaaf@suse.de>

No Problem.

Cheers,
Gary

On Jan 4, 2013, at 10:00 AM, Gregory Farnum wrote:

> Thanks!
> 
> Gary, can you pull these into a branch and do some before-and-after
> package comparisons on our systems (for the different distros in
> gitbuilder) and then merge into master?
> -Greg
> 
> On Fri, Jan 4, 2013 at 9:51 AM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:
>> This set of patches contains fixes for some build and packaging issues.
>> 
>> Danny Al-Gaaf (6):
>>  src/java/Makefile.am: fix default java dir
>>  ceph.spec.in: fix handling of java files
>>  ceph.spec.in: rename libcephfs-java package to cephfs-java
>>  ceph.spec.in: fix libcephfs-jni package name
>>  configure.ac: remove AC_PROG_RANLIB
>>  configure.ac: change junit4 handling
>> 
>> ceph.spec.in         | 21 +++++++++------------
>> configure.ac         |  8 +++++---
>> src/java/Makefile.am |  6 +++---
>> 3 files changed, 17 insertions(+), 18 deletions(-)
>> 
>> --
>> 1.8.0.2
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

