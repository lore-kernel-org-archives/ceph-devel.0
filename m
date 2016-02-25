From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: [ceph-users] "ceph-installer" in GitHub
Date: Thu, 25 Feb 2016 17:57:21 -0500 (EST)
Message-ID: <722555143.53556042.1456441041302.JavaMail.zimbra@redhat.com>
References: <CALqRxCwLvXtGDb3t0eg5-4c27eTO=PLSx1zkv+g7MR9+8oMfMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:42776 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcBYW5W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 17:57:22 -0500
In-Reply-To: <CALqRxCwLvXtGDb3t0eg5-4c27eTO=PLSx1zkv+g7MR9+8oMfMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Where should I go to get "ceph-installer" source code?

Rgds,
Shinobu

----- Original Message -----
From: "Ken Dreyer" <kdreyer@redhat.com>
To: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users@lists.ceph.com>
Sent: Friday, February 26, 2016 6:07:54 AM
Subject: [ceph-users] "ceph-installer" in GitHub

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
_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
