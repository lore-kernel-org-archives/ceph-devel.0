From: Mike <mike.almateia@gmail.com>
Subject: Re: BlueStore and maximum number of objects per PG
Date: Wed, 22 Feb 2017 17:34:22 +0300
Message-ID: <1487774062.1919.1.camel@gmail.com>
References: <1002796178.10638.1487707472256@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36409 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932596AbdBVOe0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2017 09:34:26 -0500
Received: by mail-lf0-f49.google.com with SMTP id b80so2283336lfe.3
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2017 06:34:25 -0800 (PST)
In-Reply-To: <1002796178.10638.1487707472256@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 2017-02-21 at 21:04 +0100, Wido den Hollander wrote:
> Hi,
> 
> I'm about to start a test where I'll be putting a lot of objects into BlueStore and
> see how it holds.
> 
> The reasoning behind is that I have a customer which has 165M objects in it's cluster
> which results in some PGs having 900k objects.
> 
> For FileStore with XFS this is quite heavy. A simple scrub takes ages.
> 
> The problem is that we can't simply increase the number of PGs since that will
> overload the OSDs as well.

Also the problem stands if have a huge amount _small_ objects: capacity of hardware is
enough (20% used) but PG quantity isn't.
 
> 
> On the other hand we could add hardware, but that also takes time.
> 
> So just for the sake of testing I'm looking at trying to replicate this situation
> using BlueStore from master.
> 
> Is there anything I should take into account? I'll probably be just creating a lot
> (millions) of 100 byte objects in the cluster with just a few PGs.
> 
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
