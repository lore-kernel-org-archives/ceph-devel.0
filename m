From: Nick Bartos <nick@pistoncloud.com>
Subject: Determining when it's safe to reboot a node?
Date: Tue, 25 Sep 2012 10:12:25 -0700
Message-ID: <CAPud5_4Y2ff8Y5gNgaM0Ap_A4_NwBv2JvLpF9dWxxXKj1CZH-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53628 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101Ab2IYRM0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 13:12:26 -0400
Received: by ieak13 with SMTP id k13so14504458iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 10:12:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I need to figure out some way of determining when it's OK to safely
reboot a single node.  I believe this involves making sure that at
least one other monitor is running and up to date, and all the PGs on
the local OSDs have up to date copies somewhere else in the cluster.
We're not concerned about MDS at this time, since we're not currently
using the POSIX filesystem.

I recall having a verbal conversation with Sage on this topic, but
apparently I didn't take good notes or I can't find them.  I do
remember the solution was somewhat complicated.  Is there any sort of
straight forward 'ceph' command that can do this now?  If there isn't
one, I think it would be really great if something like that could be
implemented.  It would seem to be a common enough use case to have a
simple command which could tell the admin if rebooting the node would
render the cluster partially unusable.
