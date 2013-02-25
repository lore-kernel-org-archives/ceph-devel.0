From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Updated sparse warning message patches
Date: Mon, 25 Feb 2013 11:15:18 -0800
Message-ID: <512BB846.7060107@inktank.com>
References: <5127A85D.1070000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61077 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab3BYTPk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 14:15:40 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so1942393pad.16
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 11:15:39 -0800 (PST)
In-Reply-To: <5127A85D.1070000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

On 02/22/2013 09:18 AM, Alex Elder wrote:
> I'm re-posting these patches because I've updated them to be
> based on the patches I just posted ("Four miscellaneous patches").
>
> These patches are available in the branch "test/wip-4184" in
> the ceph-client git repository.  That branch is based on
> branch "test/wip-4234,5,7,8".
>
> (Here's the original description)
>
> What follows is a few series of patches that get rid of code
> issues that lead to warnings from the sparse utility.
>
> The first three patches address the warnings in the rbd, ceph
> file system, and libceph code respectively.  After that, one
> warning remains in libceph, and that is addressed by a series
> of five patches which both address the underlying problem and
> reorganized and clean up the surrounding code.  The last two
> are meant to be combined into one before commit; they've been
> posted as two separate patches to make them easier to review.
>
> 					-Alex
>
> [PATCH, v2] rbd: eliminate sparse warnings
> [PATCH, v2] ceph: eliminate sparse warnings in fs code
> [PATCH, v2] libceph: eliminate sparse warnings
> [PATCH 1/5, v2] libceph: encapsulate connection backoff
> [PATCH 2/5, v2] libceph: separate non-locked fault handling
> [PATCH 3/5, v2] libceph: use a flag to indicate a fault has occurred
> [PATCH 4/5, v2] libceph: use a do..while loop in con_work()
> [PATCH 5/5, v2] libceph: indent properly

These all look good too.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

