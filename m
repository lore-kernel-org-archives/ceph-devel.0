From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 22:17:02 +0800
Message-ID: <CAMm-wcJTfubebF=W+GCHdHM9kvZ6b9pGWpMv-Ri0-Pn7XQ-SeQ@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
	<CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
	<CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com>
	<CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39973 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab2J3ORD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 10:17:03 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so178923qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 07:17:02 -0700 (PDT)
In-Reply-To: <CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

> Nothing prevents me to offer a service directly based on RADOS API, i=
f
> S3 compatibility is not needed, right ?

Correct, That is librados.


> What I don't understand is how can I access a single file from RGW. I=
f
> LibRBD and RGW are 'gateway' to a RADOS store, i'll have access to a
> block device, not to a single file.
> Should I create a filesystem on the block device before using that wi=
th
> RGW?

RGW and libRBD are not the same pool,  you can`t access aRBD volume wit=
h
RGW. The RADOS treats the RBD volume as just a large object.

On 30 October 2012 21:57, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
>
> 2012/10/30 Gregory Farnum <greg@inktank.com>:
> > Not exactly. RADOS is natively a (powerful) object store. RGW takes=
 S3
> > and Swift REST requests and translates them into RADOS requests,
> > stored in a "custom" format. RBD is a client-side library which tak=
es
> > a logical block device and stripes it over RADOS objects (by defaul=
t,
> > the first 4MB is one object, the second 4MB are another object, etc=
).
> > Make sense?
>
> So, a ceph cluster is made from multiple OSDs.
> these OSDs are combined by RADOS that is an object store that will
> stripe over multiple OSDs
>
> This store can be accessed by RGW (for S3 and Swift api compatibility=
,
> in needed) or directly by a server as a block device with librbd
>
> This should be the architecture:
>
> OSD -> RADOS -> RGW/LibRBD -> Customer/Server
>
> Nothing prevents me to offer a service directly based on RADOS API, i=
f
> S3 compatibility is not needed, right ?
>
> What I don't understand is how can I access a single file from RGW. I=
f
> LibRBD and RGW are 'gateway' to a RADOS store, i'll have access to a
> block device, not to a single file.
> Should I create a filesystem on the block device before using that wi=
th
> RGW?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--
=E8=A2=81=E5=86=AC
Email:yuandong1222@gmail.com
QQ:10200230
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
