From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: Preferred location for utility execution
Date: Fri, 26 Jun 2015 20:14:01 +0000
Message-ID: <2C438B34CAC8264398F5C7AF7411910A6D9605F5@G4W3206.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:49424 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbbFZUPY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jun 2015 16:15:24 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: "gmeno@redhat.com" <gmeno@redhat.com>

Hey ceph-devel,

Gregory Meno (of Calamari fame) and I are working on what is now officially a blueprint for Jewel ( http://tracker.ceph.com/projects/ceph/wiki/Calamariapihardwarestorage ), and we'd like some feedback.

Some of this has been addressed via separate conversations about the feature that some of this work started out as (identifying drives in a cluster by toggling their LED states), but we wanted to ask a more direct question: What is the preferred location/mechanism to execute operations on storage hardware?

We see two clear options:

1. Make Calamari responsible for executing commands using various linux utilities (and /sys, when applicable).
2. Build a command set into RADOS to execute commands using various linux utilities. These commands could then be executed by Calamari using the rest api.

The big win for #1 is the ability to rapidly iterate on the capabilities of the Calamari toolset (it is almost certainly going to be faster to create a set of scripts similar to Gregory's initial commit for SMART polling than to add that functionality inside RADOS. See: https://github.com/ceph/calamari/pull/267 ). For #2, we'd pick up the ability to run those same commands via the cli, which would give users a lot more flexibility in how they troubleshoot their cluster (Calamari wouldn't be required, it would just make life easier).

The LED state conversation had people sitting on both sides of the fence on this one, there wasn't a clear winner. Gregory mentioned a hybrid option in a conversation we had this week: Implement first in Calamari, then consider migrating the feature into the Ceph source itself if users communicate that they want it there (the LED state might move for its debugging utility, whereas the SMART poll could stay in Calamari, for example).

Thoughts?

Joe
