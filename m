From: Gregory Farnum <greg@inktank.com>
Subject: Re: Question about configuration
Date: Thu, 10 Jan 2013 16:43:59 -0800
Message-ID: <CAPYLRzhZr81ko3QgC1oGXs_12-C6z-EVmuf3k47Ej3j8P_T0AA@mail.gmail.com>
References: <20130110.163912.203671451.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:59078 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3AKAoA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 19:44:00 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so786480qca.17
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 16:44:00 -0800 (PST)
In-Reply-To: <20130110.163912.203671451.yasu@soe.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 10, 2013 at 4:39 PM, Yasuhiro Ohara <yasu@soe.ucsc.edu> wro=
te:
>
> Hi,
>
> What will happen when constructing a cluster of 10 host,
> but the hosts are gradually removed from the cluster
> one by one (in each step waiting Ceph status to become healthy),
> and reaches eventually to, say, 3 hosts ?
>
> In other words, is there any problem with having 10 osd configuration
> in the ceph.conf, but actually only 3 is up (the 7 are down and out) =
?

If you're not using the /etc/init.d ceph script to start up everything
with the -a option, this will work just fine.

>
> I assume that if the size of the replication is 3, we can turn off
> 2 osds at each time, and Ceph can recover itself to the healthy state=
=2E
> Is it the case ?

Yeah, that should work fine. You might consider just marking OSDs
"out" two at a time and not actually killing them until the cluster
has become quiescent again, though =97 that way they can participate as
a source for recovery.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
