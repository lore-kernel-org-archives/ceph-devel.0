From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 2/3] .gitignore: cleanup and sort entries
Date: Wed, 06 Feb 2013 19:31:25 +0100
Message-ID: <5112A17D.2080609@bisect.de>
References: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de> <1359998564-27004-3-git-send-email-danny.al-gaaf@bisect.de> <51121F03.8000005@inktank.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:37913 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753765Ab3BFSb3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 13:31:29 -0500
In-Reply-To: <51121F03.8000005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Thanks for the comments,

I will send an updated version of this patch with extra local handling
of Makefiles and where it makes sense also for some other files.

Danny

Am 06.02.2013 10:14, schrieb Josh Durgin:
> I like the cleanup in general, but non-generic entries should have
> a leading /, otherwise they match files with the same name in
> subdirectories as well.
> 
> For example, putting Makefile in .gitignore will also ignore static
> makefiles in the qa subdirectories. Some of the existing entries are
> already missing this leading /.
> 
> On 02/04/2013 09:22 AM, Danny Al-Gaaf wrote:
>> Cleanup old entries and sort the existing entries. Remove no longer
>> existing entries/files. Move src/* entries from top level .gitignore
>> to the correct subdir .gitignore file.
>>
>> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
>> ---
>>   .gitignore           |  78 ++++++++++-------------
>>   doc/.gitignore       |   3 +-
>>   src/.gitignore       | 173
>> +++++++++++++--------------------------------------
>>   src/.gitignore.orig  | 142 ++++++++++++++++++++++++++++++++++++++++++
> 
> No need for this file
> 
>>   src/gtest/.gitignore |   2 +
>>   5 files changed, 221 insertions(+), 177 deletions(-)
>>   create mode 100644 src/.gitignore.orig
>>   create mode 100644 src/gtest/.gitignore
>>

