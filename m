From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] mds: remove waiting lock before merging with neighbours
Date: Fri, 23 Aug 2013 13:58:56 -0700
Message-ID: <CAPYLRzgeWsdxyqWNRykH1Ac+TChQwFh4PKmP7D81jc89YOZJ9w@mail.gmail.com>
References: <1375110344-26133-1-git-send-email-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:57556 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab3HWU65 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 16:58:57 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so956440wgg.28
        for <ceph-devel@vger.kernel.org>; Fri, 23 Aug 2013 13:58:57 -0700 (PDT)
In-Reply-To: <1375110344-26133-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi David,
I'm really sorry it took us so long to get back to you on this. :(
However, I've reviewed the patch and, apart from going over the code
making me want to strangle myself for structuring it that way,
everything looks good. I changed the last paragraph in the commit
message very slightly to clarify the cause of the bug:

On Mon, Jul 29, 2013 at 8:05 AM, David Disseldorp <ddiss@suse.de> wrote:
> When handling a lock request, the MDS calls adjust_locks() to merge
> the new lock with available neighbours. If the new lock is merged,
> then the waiting_locks entry is not located in the subsequent
> remove_waiting() call.
> This fix ensures that the waiting_locks entry is removed prior to
> modification during merge.

    When handling a lock request, the MDS calls adjust_locks() to merge
    the new lock with available neighbours. If the new lock is merged,
    then the waiting_locks entry is not located in the subsequent
    remove_waiting() call because adjust_locks changed the new lock to
    include the old locks.
    This fix ensures that the waiting_locks entry is removed prior to
    modification during merge.

And it's now merged into master and backported to dumpling. Thank you very much!

If you feel like cleaning up the locking code a little more (or
anything else, for that matter) I can promise you faster reviews in
the future... ;)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
