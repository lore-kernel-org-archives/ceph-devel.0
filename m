From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: Rados API out of Unix environment
Date: Thu, 8 Jun 2017 21:27:51 +0800
Message-ID: <CACKY0b-EoAZydrKHY3odevkf-jrRMaV-6YFqzr_HdRsYCdkTkw@mail.gmail.com>
References: <CAAGJuFhkQXRUjUfgVZpnMtyLVHg8CFPfRscLULZ2hV7LOC40YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34436 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbdFHN2D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jun 2017 09:28:03 -0400
Received: by mail-yw0-f181.google.com with SMTP id e142so4641143ywa.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jun 2017 06:27:52 -0700 (PDT)
In-Reply-To: <CAAGJuFhkQXRUjUfgVZpnMtyLVHg8CFPfRscLULZ2hV7LOC40YA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: XoD <xoddark@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, XoD

It seems that RGW[1] is what you need. You could upload/download
object via HTTP.


1. http://ceph.com/ceph-storage/object-storage/

2017-06-08 21:10 GMT+08:00 XoD <xoddark@gmail.com>:
> Hello, in my company we are looking for a most efficient solution to
> distribute a lot of small files, for a lot of clients.
>
> We are considering using Ceph for this (Or Gluster) as our server
> infrastructure.
> On the client side we want to access data as object directly from the
> application.
> Our applications will not run in an unix environment (Windows among others).
> But unfortunately the Rados API (Or Gluster API) depends on Unix
> technologies and headers.
>
> So to summarize our needs for the API are :
> - put new files on a volume
> - read files on the volume
> - remove files on the volume
> We do not need to update any files after the first write.
>
> For the moment, here is our current investigation status:
> We have tried to build the api (librados) in a Msys/Mingw environment,
> but all dependencies are not available.
> We are considering to modify librados to replace Unix dependencies,
> but it's seems a lot of work.
> We are considering to reimplement the client library, but I haven't
> found documentation about the communication protocol of rados api.
> We are also considering to create a new (simpler) API, possibly based
> on http, but we need to know how implement the server part.
> We have seen the rados_dll port of rados for Windows, but this port is
> not up to date.
>
> Without any knowledge of the internal Ceph functionality it's not
> easy, and I haven't found any documentation about it.
>
> So here are my questions:
> Does anybody have advices/warnings about how we can achieve any of the
> afore mentioned ports ?
> Or know any open source library project to access to files/objects on
> from (at least) a Windows application.
>
> Thank you
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
