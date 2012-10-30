From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:57:18 +0100
Message-ID: <CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
	<CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
	<CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45261 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2J3N5T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 09:57:19 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so168988eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 06:57:18 -0700 (PDT)
In-Reply-To: <CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

2012/10/30 Gregory Farnum <greg@inktank.com>:
> Not exactly. RADOS is natively a (powerful) object store. RGW takes S3
> and Swift REST requests and translates them into RADOS requests,
> stored in a "custom" format. RBD is a client-side library which takes
> a logical block device and stripes it over RADOS objects (by default,
> the first 4MB is one object, the second 4MB are another object, etc).
> Make sense?

So, a ceph cluster is made from multiple OSDs.
these OSDs are combined by RADOS that is an object store that will
stripe over multiple OSDs

This store can be accessed by RGW (for S3 and Swift api compatibility,
in needed) or directly by a server as a block device with librbd

This should be the architecture:

OSD -> RADOS -> RGW/LibRBD -> Customer/Server

Nothing prevents me to offer a service directly based on RADOS API, if
S3 compatibility is not needed, right ?

What I don't understand is how can I access a single file from RGW. If
LibRBD and RGW are 'gateway' to a RADOS store, i'll have access to a
block device, not to a single file.
Should I create a filesystem on the block device before using that with RGW?
