From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: OSD network failure
Date: Mon, 19 Nov 2012 15:22:42 +0100
Message-ID: <CAJH6TXi29hrp99TA0zSwOB_u1dg340ze1ZkEOH8c=sJABfPqrg@mail.gmail.com>
References: <CAJH6TXi5-SogM9=vJKcb5bEknCvRd4BZ8JvgH5tkXM6pDeLfZQ@mail.gmail.com>
	<50A4AA79.80009@inktank.com>
	<CAJH6TXixnqBgxOdk3UD2Tr4RTC5_RYnfXW9wmuHjD5ZD6G2OCQ@mail.gmail.com>
	<50A6EEB6.2020400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35975 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2KSOWn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 09:22:43 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so1119800eek.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 06:22:42 -0800 (PST)
In-Reply-To: <50A6EEB6.2020400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/11/17 Josh Durgin <josh.durgin@inktank.com>:
> Ah, ok. By default, the OSDs use the backend network for heartbeats,
> so if it fails, they will notice and report peers they can't reach as
> failed to the monitors, and the normal failure handling takes care
> of things.
>
> If you're worried about consistency, remember that a write won't
> complete until it's on disk on all replicas. If you're interested
> in the gory details of maintaining consistency, check out the peering
> process [1].

Ok. now it's clear.
So it will be safe to use a single NIC for backend network.
