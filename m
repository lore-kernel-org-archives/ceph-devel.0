From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Separating clients data
Date: Wed, 17 Aug 2011 09:19:56 -0700
Message-ID: <CAORUGqCz=ba9HuJCc4FEqFq87S0xW0Jxqz2szBsPd-w4wZnsjw@mail.gmail.com>
References: <CAGqxmDOGnrRPgyRFBW28f6zm7Fy-mrhSbBERceZD=KeU3P4GvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39218 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab1HQQUQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2011 12:20:16 -0400
Received: by iye16 with SMTP id 16so2170941iye.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2011 09:20:16 -0700 (PDT)
In-Reply-To: <CAGqxmDOGnrRPgyRFBW28f6zm7Fy-mrhSbBERceZD=KeU3P4GvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Maciej_Ga=C5=82kiewicz?= <maciejgalkiewicz@ragnarson.com>
Cc: ceph-devel@vger.kernel.org

2011/8/16 Maciej Ga=C5=82kiewicz <maciejgalkiewicz@ragnarson.com>:
> I have a storage cluster based on glusterfs. Each client have its own
> volume and his is not able to mount any other. Is it possible to
> implement such separation with ceph? I have read about authentication
> and mounting subdirectories. I am not sure if I can configure
> different login/pass for selected directories stored in ceph. All
> clients are running on Xen's domU (virtual machine). Maybe there is
> some other way to achieve this?

This seems to be possible with Ceph as it is now, but it is definitely
not the normal setup. As in, test carefully and understand you're
going off the beaten path.

To avoid confusion with the word "client", I'll call these
mutually-untrusting domains "customers". Each customer can have
multiple clients.

It builds up something like this:

1. Each customer naturally needs separate keys (really, every client
should have a separate key).
2. Because clients talk to OSDs directly, you need to have different
trust domains use different pools (otherwise they can just read/write
each other's raw objects); use "cauthtool --cap osd 'allow rwx
pool=3Dsomething'" on the client/customer key to specify who can write
where.
3. You probably want the root of your ceph filesystem stored in
pool=3Ddata, but give most clients just read-only access to it.
4. Use "cephfs /your/ceph/mountpoint/customerA set_location --pool
customerA" to tell the MDS what pool subtrees of your ceph filesystem
are stored in.
5. Tell clients to mount their part of the filesystem directly, use
your-ceph-mon-here:/customerA as the mount device.

Disclaimer: not tested, not security audited, customers can still DoS
each other etc nasty things, your mileage may vary, if you break it we
will probably help you fix at least one of the halves, warning this
sign has sharp edges.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
