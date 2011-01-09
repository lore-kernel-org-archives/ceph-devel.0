From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: thanks gregf,question about ceph
Date: Sun, 9 Jan 2011 10:05:52 -0800
Message-ID: <AANLkTik4mLKZkdG21xgeJFHwi61jgrD+ABB9B-C0FrN9@mail.gmail.com>
References: <1b70d2f.20f3.12d6a85a669.Coremail.yueluck@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33255 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab1AISFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Jan 2011 13:05:53 -0500
Received: by ewy5 with SMTP id 5so8446691ewy.19
        for <ceph-devel@vger.kernel.org>; Sun, 09 Jan 2011 10:05:52 -0800 (PST)
In-Reply-To: <1b70d2f.20f3.12d6a85a669.Coremail.yueluck@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: yueluck <yueluck@163.com>

Moving this to the list where it belongs.

2011/1/9 yueluck <yueluck@163.com>:
> 1.ceph-client-standalone.git ,ceph-client.git
> what is the different of the client.git???i know ceph-client-standalone.git
> is for ceph.ko,
> what ceph-client.git do?
ceph-client.git is the branch we do all our in-kernel development on.
ceph-client-standalone is the fs/ceph tree of ceph-client with
additional #ifdefs for backporting. If possible you should be using
ceph-client as it's more tested and up-to-date.

> 2. what is different of scsi-osd,rados?
> scsi-osd is in SCSI Architecture Model, they are object-based storage? if
> rados depend on scsi-osd(osd.ko,libosd.ko.....)?
Ceph OSDs are Object Storage Devices/Daemons. They are conceptually
similar to SCSI OSDs but are not at all the same thing.

> 3.do you have ceph call flow,document(except wiki),let me know ceph
> architecture quickly.
Unfortunately, no. However, Sage's thesis (which is available on the
Ceph website) has a pretty good description of the protocols, if not
the module architecture. You can check that out for a lot more
information than is on the wiki. :)
-Greg
