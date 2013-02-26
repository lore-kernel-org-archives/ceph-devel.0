From: Mark Kampe <mark.kampe@inktank.com>
Subject: Geographic DR for RGW
Date: Tue, 26 Feb 2013 13:39:53 -0800
Message-ID: <512D2BA9.4070601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43892 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab3BZVj4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 16:39:56 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so2616159pbc.35
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 13:39:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

A few weeks ago, Yehuda Sadeh sent out a proposal for adding
support for asynchronous remote site replication to the RADOS
Gateway.  We have done some preliminary planning and are
now starting the implementation work.

At the 100,000' level (from which height all water looks
drinkable and all mountains climbable) the work can be
divided into:

    1. a bunch of changes within the gateway to create
       regions, add new attributes to buckets and objects,
       log new information and implement/expose some new
       operations

    2. new RESTful APIs to exploit and manage the new
       behaviors, and associated unit test suites.

    3. free-standing data and metadata synchronization
       agents that learn of and propagate changes

    4. management agents to monitor, control, and report
       on this activity.

    5. white-box test suites to stress change detection,
       reconciliation, propagation, and replay.

We feel that we pretty much have to do (1) (lots of changes
to a great deal of complicated code).  Category (2) is
new code, and (in principle) decoupled from the internals
of the gateway, but it has many tendrils.  C++ developers
with some familiarity with the Gateway could definitely help
here ... but it is questionable whether or not it makes
sense to try to bring new people up to speed for a project
that will only last a few months.

In the near term, the most modular pieces with the lowest
activation energy are (3), and in two months there may be
enough working to enable work on (4) and (5).  The
synchronization and management agents are free-standing
processes based on RESTful APIs, and so can be implemented
in pretty much anything (Python, Java, C++, Ruby, ...).

If there are other people who are able to help make this
happen, we would love to invite your participation.  This
is an opportunity to:
    * accelerate the development of a strategic feature
    * help to shape some major new functionality
    * get very familiar with the Gateway code
    * play with eventual consistency, asynchronous pull replication
    * be one of the kool kids
    * earn Karma and improve the world through Open Source contribution

thank you,

    Mark.Kampe@inktank.com
    VP, Engineering

