From: =?ISO-8859-1?Q?Alexis_G=DCNST_HORN?=
	<alexis.gunsthorn@outscale.com>
Subject: Maintenance mode
Date: Fri, 1 Feb 2013 08:40:52 +0100
Message-ID: <CAEqYNSaOVFQyYaN=e0JeBBvj7r3hnjc3f=gtw3_HQsSsxJBLFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:45002 "HELO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750918Ab3BAHkz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 02:40:55 -0500
Received: by mail-oa0-f72.google.com with SMTP id j6so14173049oag.11
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 23:40:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello to all,

Here is my setup :

- 2 racks
- osd1 .. osd6 in rack1
- osd7 .. osd12 in rack2
- replica = 2
- CRUSH map set to put replicas accross racks

My question :
Let's imagine that one day, I need to unplug one of the racks (let's
say, rack1). No problem because an other copy of my objects will be in
the other rack. But, if i do it, Ceph will start to rebalance data
accross OSDs.

So, is there a way to put nodes in "Maintenance mode", in order to put
Ceph in "degraded" mode, but avoiding any  remaping.

The idea is to have a command like :

$ ceph osd set maintenance=on osd.1
$ ceph osd set maintenance=on osd.2
$ ceph osd set maintenance=on osd.3
$ ceph osd set maintenance=on osd.4
$ ceph osd set maintenance=on osd.5
$ ceph osd set maintenance=on osd.6

So Ceph knows that 6 osds are down, goes into degraded mode, but
without remapping data.
Then, once maintenance finished, i'll only have to do the opposite :

$ ceph osd set maintenance=off osd.1
$ ceph osd set maintenance=off osd.2
$ ceph osd set maintenance=off osd.3
$ ceph osd set maintenance=off osd.4
$ ceph osd set maintenance=off osd.5
$ ceph osd set maintenance=off osd.6

What do you think ?
I know that there is a way in Ceph doc to do so with reweight, but
it's a little bit complex...

What do you think ?
Thanks,

Alexis
