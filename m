From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/7, v2] libceph: abstract message data information
Date: Sat, 09 Mar 2013 10:14:59 -0600
Message-ID: <513B6003.8090400@inktank.com>
References: <513B5CAF.4010702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52172 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758373Ab3CIQPC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:15:02 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so3301019ieb.9
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:15:02 -0800 (PST)
In-Reply-To: <513B5CAF.4010702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 03/09/2013 10:00 AM, Alex Elder wrote:
> Over half of these have been reviewed already, but I'm re-posting
> them because I've rebased them to be on top of the series I just
> posted (that is, these are based on branch "review/wip-cleanup"
> or 60b789f libceph: record byte count not page count), and because
> I've added two more patches since the last time I sent them out.
> 
> I won't bother summarizing them again this time, their individual
> descriptions should be good enough.

These patches are available in the branch "review/wip-abstract-2"
of the ceph-client git repository.

					-Alex

  					-Alex
> 
> The patches below marked with "***" are still in need of review.
> 
> [PATCH 1/7] libceph: isolate message page field manipulation
> [PATCH 2/7] libceph: set page info with byte length         ***
> [PATCH 3/7] libceph: isolate other message data fields
> [PATCH 4/7] ceph: only set message data pointers if non-empty
> [PATCH 5/7] libceph: record message data byte length        ***
> [PATCH 6/7] libceph: set response data fields earlier       ***
> [PATCH 7/7] libceph: activate message data assignment checks
> 

