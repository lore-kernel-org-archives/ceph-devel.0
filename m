From: Andrew Schoen <aschoen@redhat.com>
Subject: upgrade testing with shaman
Date: Tue, 18 Oct 2016 12:04:25 -0500
Message-ID: <CAEPMp+696EQxGjBi6v6kN5KycaoNMuEemaromTCSh4P2gwh2rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34476 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755582AbcJRRE1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Oct 2016 13:04:27 -0400
Received: by mail-vk0-f43.google.com with SMTP id b186so227020029vkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Oct 2016 10:04:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Development, Ceph" <ceph-devel@vger.kernel.org>, sepia@ceph.com

All,

We are working on a solution that will allow us to run the
teuthology upgrade tests with shaman, until we can start using the
repos from download.ceph.com (which is the ideal scenario).

We are going to register all the upstream repos that are currently
built on chacra.ceph.com with shaman. These are the unsigned repos
that eventually get pushed to download.ceph.com. This would require a
bit of work with ceph-build so that we can get the 'extras' info, like
``version``, in the json output from shaman. We'd also have to rebuild
all these repos (for that 'extras' info) and to make sure we have all
the repos there we need.

This will mean that:

1) Any new upstream releases will automatically be added to shaman and
available for testing

2) It keeps all the repos we need to test in a single system, shaman.

3) Repos on chacra.ceph.com are not auto deleted, so we won't have to
worry about these repos disappearing.

For this to work correctly teuthology will need to do a tag to sha1
conversion using git or replace tags in ceph-qa-suite with sha1s
because our system cannot provide tag references.

Thanks,
Andrew
