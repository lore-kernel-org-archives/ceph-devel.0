From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Nightly "Kernel branch not found" errors
Date: Sun, 31 May 2015 15:28:57 -0700
Message-ID: <CAC6JEv-v+jq6ba1TeyknBqQD9Lb2DiF5LNeh8pcxJt1sJFeJUg@mail.gmail.com>
References: <CAC6JEv_oJzokLL-QvJ6VTNC43kSp9s4Vf=cY47Ug+Gqy0BBApw@mail.gmail.com>
	<CAOi1vP-63Qya7JQcPhr62a5ffufaYSd9WwqLY-hMFYs7MmHS8g@mail.gmail.com>
	<CAC6JEv8CCThYLNa73ufOo7C8U42fVPTaW8r6CNOQxXHx_04=qg@mail.gmail.com>
	<alpine.DEB.2.00.1505311518340.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34646 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbEaW27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 18:28:59 -0400
Received: by qcbhb1 with SMTP id hb1so41964583qcb.1
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 15:28:58 -0700 (PDT)
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com. [209.85.192.47])
        by mx.google.com with ESMTPSA id v13sm5493752qhd.31.2015.05.31.15.28.57
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 15:28:58 -0700 (PDT)
Received: by qgfa63 with SMTP id a63so42740360qgf.0
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 15:28:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505311518340.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ilya Dryomov <idryomov@gmail.com>, Zack Cerza <zack@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, May 31, 2015 at 3:19 PM, Sage Weil <sage@newdream.net> wrote:
> On Sun, 31 May 2015, Gregory Farnum wrote:
>> On Sun, May 31, 2015 at 1:40 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> > On Sun, May 31, 2015 at 10:54 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> >> We are getting this error in what looks like everything that specifies
>> >> the testing kernel. (That turns out to be almost all of the FS tests
>> >> and a surprising number of the non-rados runs; e.g. rgw.) I've checked
>> >> that the testing branch of ceph-client.git still exists and when
>> >> looking at the teuthology git logs the recent ping-pong of commits on
>> >> kernel flavors et al stand out. Any ideas? :)
>> >
>> > Which lab is this in?  Latest rgw and fs in sepia look fine.
>> >
>> > Kernel task was broken the entire last week but in a different way -
>> > when scheduled with teuthology-suite it wouldn't install anything even
>> > if you told it to install e.g. testing.  I fixed that on Friday.
>> >
>> > Looks like this is coming from create_initial_config().  Could be an
>> > environment issue, like down gitbuilders or a problem with requests
>> > module?  Kernel branch is checked before the others so it may not have
>> > anything to do with it at all.
>>
>> It's happening across labs for tests that were supposed to be
>> scheduled starting on the 29 (at least, that I've noticed). I think
>> this issue is before they get into pulpito, which is why the latest fs
>> suite run there was scheduled on May 27. :(
>> Looking at the gitbuliders I do see that the CentOS6 testing branch is
>> red and rhel7 appears to be down...maybe we're checking on more of
>> them now and then failing when those don't appear? :/
>
> We're half-way through creating the centos7 kernel builder to replace the
> rhel ones so I expect things are broken on the rpm side.  Not sure if
> that is the root cause here, but we can probably wait for that to get
> fixed first before looking further

*None* of our FS tests are running while this problem persists (and
they're not alone). That's not the sort of thing we can wait on...
Maybe we have some gratuitous non-use of the testing kernel we can
remove (I'm not sure), but that's the sort of thing that needs to be
discussed across teams so we can deal with it proactively instead of
just finding out when the nightlies start failing.
-Greg
