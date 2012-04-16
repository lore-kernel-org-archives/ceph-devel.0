From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 08:41:57 -0700
Message-ID: <5036C30AB5AE47A280F2296A6753A90D@dreamhost.com>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41371 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab2DPPmB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 11:42:01 -0400
Received: by obbta14 with SMTP id ta14so3771207obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 08:42:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Sunday, April 15, 2012 at 9:44 PM, Sage Weil wrote:
> We just switched the completion callbacks so that they are called 
> asynchronously from another thread. This makes the locking less weird for 
> certain callers and lets you call back into librados in your callback 
> safely.
> 
> This breaks one of the functional tests, which sets a bool in the 
> callback, does wait_for_complete() on the aio handle, and then asserts 
> that the bool is set. There's now a race between the caller's thread and 
> the completion thread.
> 
> Do we just call this a broken test, or do we want some way of blocking on 
> the aio handle until the completion has been called?
> 


I think we have to block the aio handle until the completion has been called. Expecting users to (constantly re-)implement that themselves is just silly, and anybody who needs to wait_for_complete() is going to expect the completion to have been called.
I don't remember exactly how wait_for_complete() is triggered, but it can't be too difficult to move it into the completion thread.
-Greg

