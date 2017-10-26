From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: 12.2.2 status
Date: Thu, 26 Oct 2017 17:19:21 +0200
Message-ID: <87fua6c4xy.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38530 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbdJZPTX (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 26 Oct 2017 11:19:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>


A first round of PRs were tested on Luminous integration branch, results
updated at http://tracker.ceph.com/issues/21830,
RADOS suite was green, RBD, RGW & FS hit some known failures

ceph-disk has hit a failure with dmcrypt, details at
http://tracker.ceph.com/issues/21830#note-10 which doesn't seem to have
occured in QE runs before but there is a bug report, is anyone aware of
past issues with ceph-disk & dmcrypt?

Also for the leads, Sage, Yehuda. Jason, Josh, Patrick are there any
critical PRs that we need to have in 12.2.2 so that we can include
them in the next round of testing before handing over to QE?

Best,
Abhishek & Karol
