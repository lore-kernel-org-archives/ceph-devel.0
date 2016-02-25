From: Ken Dreyer <kdreyer@redhat.com>
Subject: "ceph-installer" in GitHub
Date: Thu, 25 Feb 2016 14:07:54 -0700
Message-ID: <CALqRxCwLvXtGDb3t0eg5-4c27eTO=PLSx1zkv+g7MR9+8oMfMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35304 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcBYVH4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 16:07:56 -0500
Received: by mail-wm0-f45.google.com with SMTP id c200so46900643wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 13:07:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi folks,

A few of us at RH are working on a project called "ceph-installer",
which is a Pecan web app that exposes endpoints for running
ceph-ansible under the hood.

The idea is that other applications will be able to consume this REST
API in order to orchestrate Ceph installations.

Another team within Red Hat is also working on a GUI component that
will interact with the ceph-installer web service, and that is
https://github.com/skyrings

These are all nascent projects that are very much works-in-progress,
and so the workflows are very rough and there are a hundred things we
could do to improve the experience and integration, etc. We welcome
feedback from the rest of the community :)

- Ken
