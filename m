From: Gregory Farnum <greg@inktank.com>
Subject: Re: does still not recommended place rbd device on nodes, where osd
 daemon located?
Date: Wed, 21 Nov 2012 11:15:26 -0800
Message-ID: <CAPYLRzg9DiKTY24w4DSY2t4ATk=VxNC0GHSM32_s9U7SAqi+yA@mail.gmail.com>
References: <CAHULbCmY6j3GbRFs_fyO1VP5_-BG5Cg1H_Kvfg1nN3jMMpyvHA@mail.gmail.com>
	<alpine.DEB.2.00.1211200849080.7369@cobra.newdream.net>
	<CAHULbC=Hk0ADhKB-GT-LCrHnzdGOyPTEJTxOp4=+bHVBdVQuCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46325 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab2KUTP0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 14:15:26 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so805552iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 11:15:26 -0800 (PST)
In-Reply-To: <CAHULbC=Hk0ADhKB-GT-LCrHnzdGOyPTEJTxOp4=+bHVBdVQuCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 21, 2012 at 4:33 AM, ruslan usifov <ruslan.usifov@gmail.com> wrote:
> So, not possible use ceph as scalable block device without visualization?

I'm not sure I understand, but if you're trying to take a bunch of
compute nodes and glue their disks together, no, that's not a
supported use case at this time. There are a number of deadlock issues
caused by this sort of loopback; it's the same reason you shouldn't
mount NFS on the server host.
We may in the future manage to release an rbd-fuse client that you can
use to do this with a little less pain, but it's not ready at this
point.
-Greg
