From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [Ceph-qa] ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 11:54:56 -0700
Message-ID: <CAJ4mKGYqESJxZNwbnxgv0oBER76L-R_Dr-=deo9ttmikNiJUDQ@mail.gmail.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
	<570E4843.8000102@dachary.org>
	<CAJ4mKGZ72SOiFt_t+ErWBWuGLQSDMYGyKJDyFnRKpUGJ+oORUw@mail.gmail.com>
	<CALe9h7fmWL0TQxzjct2q26gUuX8z1D56w3QPFkbCK-AN2TTsjQ@mail.gmail.com>
	<CAN=+7FVtCyDDOx-fHhgEfX=rdne32kG0bJ2UZnnRYt8xgC2iLA@mail.gmail.com>
	<alpine.DEB.2.11.1604131436160.29593@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36130 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157AbcDMSy6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 14:54:58 -0400
Received: by mail-vk0-f48.google.com with SMTP id c4so82117600vkb.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 11:54:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604131436160.29593@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, John Spray <jspray@redhat.com>, Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

On Wed, Apr 13, 2016 at 11:38 AM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 13 Apr 2016, Samuel Just wrote:
>> It also doesn't seem like it would actually present a problem in any case.
>
> The reason we didn't do this before was because we wanted to revise tests
> independently of the thing being tested.  But as John points out,
> specifying a test branch should accomplish that, at least for testing.
>
> It might be nice to preserve the ability specify an alternate repo with
> totally out-of-tree tests.  Maybe that can be done with a simple reorg of
> the repo, like putting everything under qa/, so that tasks/ and suites/
> don't appear at the top level (of ceph.git or ceph-qa-suite.git).

I shudder to suggest it, but would we get what we're really after by
including a ceph-qa-suite submodule in ceph.git, and having the
teuthology scheduling refer to that? Then we can update ceph-qa-suite
independently while still having an atomic switch for the tests that
goes into the same Ceph branch which makes the changes requiring them.
-Greg
