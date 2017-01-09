From: Samuel Just <sjust@redhat.com>
Subject: Objecter command resend http://tracker.ceph.com/issues/18358
Date: Mon, 9 Jan 2017 12:50:56 -0800
Message-ID: <CAN=+7FXMsvrkUPNRhVkuv6pTHgZy6r6WBjpKoxyxPMZna63RxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36108 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755494AbdAIUu6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2017 15:50:58 -0500
Received: by mail-qk0-f169.google.com with SMTP id 11so55507145qkl.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2017 12:50:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Weil, Sage" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It seems like the Objecter doesn't resend commands if the primary
doesn't change.  As far as I can tell, mark_unfound_lost is the only
command which doesn't complete syncronously (since the cleanup
pre-jewel) since it waits for the Repop to commit.  On interval
change, it doesn't really make sense to requeue the Command message
since it didn't go through the normal op queue.  So should we:
1) Change lost_unfound to just return success immediately
2) Update the objecter to unconditionally resend Commands on interval change
3) Just return success on interval change, though it's possible that
the update will end up divergent
-Sam
