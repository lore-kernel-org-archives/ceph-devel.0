From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Mon, 15 Apr 2013 22:06:47 +0200
Message-ID: <CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com>
References: <loom.20130412T055215-88@post.gmane.org>
	<51683184.9010301@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:47895 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab3DOUGs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 16:06:48 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so2013380wiw.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 13:06:47 -0700 (PDT)
In-Reply-To: <51683184.9010301@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/4/12 Mark Nelson <mark.nelson@inktank.com>

> Currently reads always come from the primary OSD in the placement group
> rather than a secondary even if the secondary is closer to the client.
>

In this way, only one OSD will be involved in reading an object, this will
result in a bottleneck if multiple clients needs to access to the same file.

For example, a 3KB CSS file served by a webserver to 400 users, will be
read just from one OSD. 400 users directed to 1 OSD  while (in case of
replica 3) other 2 OSDs are available?
