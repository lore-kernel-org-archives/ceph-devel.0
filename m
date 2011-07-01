From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: MDS Replay Issues
Date: Fri, 1 Jul 2011 09:03:27 -0700
Message-ID: <BANLkTimFgvG2JhTuABwnpt8qWgwAp4vDaQ@mail.gmail.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C9A@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53182 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab1GAQD1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2011 12:03:27 -0400
Received: by yxi11 with SMTP id 11so1006982yxi.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jul 2011 09:03:27 -0700 (PDT)
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C678862E5C9A@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>, ceph-devel@vger.kernel.org

On Thu, Jun 30, 2011 at 5:54 PM, Mark Nigh <mnigh@netelligent.com> wrote:
> Yes, I did increase the max_mds prior to starting the cmds on the second node. Should I have started the daemon and then increase the mds?
Well if you increase the max_mds that tells the system to make more
active MDSes. "Active" means that the MDS is authoritative for part of
the namespace hierarchy, will be serving clients, etc.
If you just want standbys then you simply need to start up extra cmds processes.

> I decrease it to one (1) and rebooted both cmds and they are still in replay. Is there a way to get them into active?
Unfortunately we don't have a way right now to reduce the number of
active MDSes. Most of the machinery is there but it's not complete or
well-tested. You've probably confused the system by telling it to have
fewer MDSes than it's already got, so you're going to have to put
max_mds back to 2 to get this cluster back up.
