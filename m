From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 21:30:26 +0100
Message-ID: <CAJH6TXi40uB5Xup3xob+zVJaf6q=4dKjdgs4+NkD-fa5Bh2z0Q@mail.gmail.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35990 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab3ATUa2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 15:30:28 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so1868318wib.0
        for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 12:30:27 -0800 (PST)
In-Reply-To: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Nielsen <lists@jnielsen.net>
Cc: ceph-devel@vger.kernel.org

2013/1/19 John Nielsen <lists@jnielsen.net>:
> I'm planning a Ceph deployment which will include:
>         10Gbit/s public/client network
>         10Gbit/s cluster network

I'm still trying to know if a redundant cluster networks is needed or not.
Is ceph able to manage a cluster network failure from on OSD?

What I would like to know if ceph will monitor OSD from the public
side (that should be redundant, because client will use it to connect
to the cluster) or from the cluster side.
