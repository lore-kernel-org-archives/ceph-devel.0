From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: OSD network failure
Date: Thu, 15 Nov 2012 00:40:25 -0800
Message-ID: <50A4AA79.80009@inktank.com>
References: <CAJH6TXi5-SogM9=vJKcb5bEknCvRd4BZ8JvgH5tkXM6pDeLfZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:56572 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711Ab2KOIk3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 03:40:29 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so574867dak.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Nov 2012 00:40:28 -0800 (PST)
In-Reply-To: <CAJH6TXi5-SogM9=vJKcb5bEknCvRd4BZ8JvgH5tkXM6pDeLfZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/13/2012 06:15 AM, Gandalf Corvotempesta wrote:
> Hi,
> what happens in case of OSD network failure? Is ceph smart enough to
> isolate OSDs not synced?
> Should I use LACP in ODS network or a single 10GBe per server should be ok?
>
> LACP will need stackable switches and much more hardware investment.

OSDs send heartbeats to each other and report failure to receive
a heartbeat in a certain interval to the monitor cluster.
When the monitor cluster receives enough of these reports,
it marks the OSD 'down' in the OSD map, and after a grace period
to allow for flapping or daemon restarts, marks the osd 'out'
as well. This makes the cluster rebalance any data that was on the
failed OSD, and places no new data there.

A lot of this is configurable, but that's the basic model.

In this model, a network failure is equivalent to extreme slowness or a
crashed OSD - everything results in an updated map of the cluster
eventually, and the OSDs maintain strong consistency of the data
through the peering and recovery processes.

So basically you'd only need a single nic per storage node. Multiple
can be useful to separate frontend and backend traffic, but ceph
is designed to maintain strong consistency when failures occur.

Josh
