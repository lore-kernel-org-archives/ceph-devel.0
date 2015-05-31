From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Nightly "Kernel branch not found" errors
Date: Sun, 31 May 2015 13:49:09 -0700
Message-ID: <CAC6JEv8CCThYLNa73ufOo7C8U42fVPTaW8r6CNOQxXHx_04=qg@mail.gmail.com>
References: <CAC6JEv_oJzokLL-QvJ6VTNC43kSp9s4Vf=cY47Ug+Gqy0BBApw@mail.gmail.com>
	<CAOi1vP-63Qya7JQcPhr62a5ffufaYSd9WwqLY-hMFYs7MmHS8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36227 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489AbbEaUtL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 16:49:11 -0400
Received: by qkx62 with SMTP id 62so74508521qkx.3
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 13:49:10 -0700 (PDT)
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com. [209.85.192.54])
        by mx.google.com with ESMTPSA id c38sm5465236qgd.33.2015.05.31.13.49.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 13:49:09 -0700 (PDT)
Received: by qgg60 with SMTP id 60so42401886qgg.2
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 13:49:09 -0700 (PDT)
In-Reply-To: <CAOi1vP-63Qya7JQcPhr62a5ffufaYSd9WwqLY-hMFYs7MmHS8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Zack Cerza <zack@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, May 31, 2015 at 1:40 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Sun, May 31, 2015 at 10:54 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> We are getting this error in what looks like everything that specifies
>> the testing kernel. (That turns out to be almost all of the FS tests
>> and a surprising number of the non-rados runs; e.g. rgw.) I've checked
>> that the testing branch of ceph-client.git still exists and when
>> looking at the teuthology git logs the recent ping-pong of commits on
>> kernel flavors et al stand out. Any ideas? :)
>
> Which lab is this in?  Latest rgw and fs in sepia look fine.
>
> Kernel task was broken the entire last week but in a different way -
> when scheduled with teuthology-suite it wouldn't install anything even
> if you told it to install e.g. testing.  I fixed that on Friday.
>
> Looks like this is coming from create_initial_config().  Could be an
> environment issue, like down gitbuilders or a problem with requests
> module?  Kernel branch is checked before the others so it may not have
> anything to do with it at all.

It's happening across labs for tests that were supposed to be
scheduled starting on the 29 (at least, that I've noticed). I think
this issue is before they get into pulpito, which is why the latest fs
suite run there was scheduled on May 27. :(
Looking at the gitbuliders I do see that the CentOS6 testing branch is
red and rhel7 appears to be down...maybe we're checking on more of
them now and then failing when those don't appear? :/
-Greg
