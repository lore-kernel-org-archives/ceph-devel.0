From: Gregory Farnum <greg@inktank.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:40:59 +0100
Message-ID: <CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
	<CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65332 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab2J3NlA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 09:41:00 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so171930iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 06:40:59 -0700 (PDT)
In-Reply-To: <CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Oct 30, 2012 at 2:36 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2012/10/30 Gregory Farnum <greg@inktank.com>:
>> Not a lot of people are publicly discussing their sizes on things like
>> that, unfortunately. I believe DreamHost is still the most open. They
>> have an (RGW-based) object storage service which is backed by ~800
>> OSDs and are currently beta-testing a compute service using RBD, which
>> you can see described here:
>> http://www.youtube.com/watch?v=l_8Y988fO44&feature=plcp
>
> I'm watching right now. Seems interesting.
> Please let me know if I understand ceph properly:
> RADOS is the block storage.
> RADOS can be accessed through RGW (a REST Gateway) or throgh librbd

Not exactly. RADOS is natively a (powerful) object store. RGW takes S3
and Swift REST requests and translates them into RADOS requests,
stored in a "custom" format. RBD is a client-side library which takes
a logical block device and stripes it over RADOS objects (by default,
the first 4MB is one object, the second 4MB are another object, etc).
Make sense?
-Greg

> In the first case, we will have an object store, in the second case,
> we will have a block device connected directly to a server (like an
> iSCSI block device)
>
> But in the first case, should I create a filesystem on RBD and then
> manage that FS with gateway?
