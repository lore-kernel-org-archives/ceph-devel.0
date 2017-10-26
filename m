From: Sage Weil <sage@newdream.net>
Subject: Re: 12.2.2 status
Date: Thu, 26 Oct 2017 16:14:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710261611390.22592@piezo.us.to>
References: <87fua6c4xy.fsf@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:54836 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbdJZQPA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 12:15:00 -0400
In-Reply-To: <87fua6c4xy.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel@vger.kernel.org, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

On Thu, 26 Oct 2017, Abhishek Lekshmanan wrote:
> A first round of PRs were tested on Luminous integration branch, results
> updated at http://tracker.ceph.com/issues/21830,
> RADOS suite was green, RBD, RGW & FS hit some known failures
> 
> ceph-disk has hit a failure with dmcrypt, details at
> http://tracker.ceph.com/issues/21830#note-10 which doesn't seem to have
> occured in QE runs before but there is a bug report, is anyone aware of
> past issues with ceph-disk & dmcrypt?
> 
> Also for the leads, Sage, Yehuda. Jason, Josh, Patrick are there any
> critical PRs that we need to have in 12.2.2 so that we can include
> them in the next round of testing before handing over to QE?

I need to get

	https://github.com/ceph/ceph/pull/18524

into master and then backport it.  Except that it relies on another PR 
that introduces a new feature bit to get all of this in place.. and it's 
brand new.  So I think I'm going ot do a targetted fix for luminous and 
then sort out the backport conflicts later.  In any case, I should 
have the luminous PR to resolve it today.

sage
