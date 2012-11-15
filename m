From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: OSD network failure
Date: Thu, 15 Nov 2012 10:51:38 +0100
Message-ID: <CAJH6TXixnqBgxOdk3UD2Tr4RTC5_RYnfXW9wmuHjD5ZD6G2OCQ@mail.gmail.com>
References: <CAJH6TXi5-SogM9=vJKcb5bEknCvRd4BZ8JvgH5tkXM6pDeLfZQ@mail.gmail.com>
	<50A4AA79.80009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:55517 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab2KOJvj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 04:51:39 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so564465eaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 01:51:38 -0800 (PST)
In-Reply-To: <50A4AA79.80009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/11/15 Josh Durgin <josh.durgin@inktank.com>:
> So basically you'd only need a single nic per storage node. Multiple
> can be useful to separate frontend and backend traffic, but ceph
> is designed to maintain strong consistency when failures occur.

Probably i've not exaplained well.
I'll have multiple nics, one for frontend, one for backend used as ODS
sync network.
What happens in case of backend network failure? The frontend network
is still ok, OSD is
still reachable but is not able to sync datas.
