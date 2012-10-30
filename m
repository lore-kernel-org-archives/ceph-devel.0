From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:36:25 +0100
Message-ID: <CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:44069 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453Ab2J3Ng0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 09:36:26 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so113744eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 06:36:25 -0700 (PDT)
In-Reply-To: <CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

2012/10/30 Gregory Farnum <greg@inktank.com>:
> Not a lot of people are publicly discussing their sizes on things like
> that, unfortunately. I believe DreamHost is still the most open. They
> have an (RGW-based) object storage service which is backed by ~800
> OSDs and are currently beta-testing a compute service using RBD, which
> you can see described here:
> http://www.youtube.com/watch?v=l_8Y988fO44&feature=plcp

I'm watching right now. Seems interesting.
Please let me know if I understand ceph properly:
RADOS is the block storage.
RADOS can be accessed through RGW (a REST Gateway) or throgh librbd

In the first case, we will have an object store, in the second case,
we will have a block device connected directly to a server (like an
iSCSI block device)

But in the first case, should I create a filesystem on RBD and then
manage that FS with gateway?
