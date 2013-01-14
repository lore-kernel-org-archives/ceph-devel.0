From: =?ISO-8859-1?Q?Alexis_G=DCNST_HORN?=
	<alexis.gunsthorn@outscale.com>
Subject: Re: CephFS issue
Date: Mon, 14 Jan 2013 10:21:07 +0100
Message-ID: <CAEqYNSbr+x+DifVvnZQYpeEBDF2w6ZUJ6LxMkuhjgjEARqu0YA@mail.gmail.com>
References: <CAEqYNSYaMvprh580HNosaQe7ahMmT-iB9irMsgA87tE2fwtCTQ@mail.gmail.com>
	<50F3CAC9.5040701@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:39285 "HELO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756232Ab3ANJVK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jan 2013 04:21:10 -0500
Received: by mail-ob0-f200.google.com with SMTP id wd20so17874492obb.3
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 01:21:07 -0800 (PST)
In-Reply-To: <50F3CAC9.5040701@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hello,
Thanks for your answer.

Both OSDs and client are CentOS 6.3 with 3.7.1 kernel.
And yes, the script creates empty loop devices of different sizes.

MDS & MON are on one of the 2 OSD hosts.
I already try to put them on a separate server.

I know that CephFS is not considered as stable yet, but... i was hoping...

Thanks,
Alexis
