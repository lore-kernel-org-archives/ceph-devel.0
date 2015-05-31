From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Nightly "Kernel branch not found" errors
Date: Sun, 31 May 2015 23:40:11 +0300
Message-ID: <CAOi1vP-63Qya7JQcPhr62a5ffufaYSd9WwqLY-hMFYs7MmHS8g@mail.gmail.com>
References: <CAC6JEv_oJzokLL-QvJ6VTNC43kSp9s4Vf=cY47Ug+Gqy0BBApw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35584 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbEaUkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 16:40:12 -0400
Received: by wgme6 with SMTP id e6so99429847wgm.2
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 13:40:11 -0700 (PDT)
In-Reply-To: <CAC6JEv_oJzokLL-QvJ6VTNC43kSp9s4Vf=cY47Ug+Gqy0BBApw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Zack Cerza <zack@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, May 31, 2015 at 10:54 PM, Gregory Farnum <greg@gregs42.com> wrote:
> We are getting this error in what looks like everything that specifies
> the testing kernel. (That turns out to be almost all of the FS tests
> and a surprising number of the non-rados runs; e.g. rgw.) I've checked
> that the testing branch of ceph-client.git still exists and when
> looking at the teuthology git logs the recent ping-pong of commits on
> kernel flavors et al stand out. Any ideas? :)

Which lab is this in?  Latest rgw and fs in sepia look fine.

Kernel task was broken the entire last week but in a different way -
when scheduled with teuthology-suite it wouldn't install anything even
if you told it to install e.g. testing.  I fixed that on Friday.

Looks like this is coming from create_initial_config().  Could be an
environment issue, like down gitbuilders or a problem with requests
module?  Kernel branch is checked before the others so it may not have
anything to do with it at all.

In any case, I'm half asleep so somebody else should look into this ;)

Thanks,

                Ilya
