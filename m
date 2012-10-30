From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 22:38:16 +0800
Message-ID: <CAMm-wcJox33ZvdfQMT-UN75g5tmGjkbLzPvcbJNmC0-jD1rKVw@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
	<CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
	<CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com>
	<CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com>
	<CAMm-wcJTfubebF=W+GCHdHM9kvZ6b9pGWpMv-Ri0-Pn7XQ-SeQ@mail.gmail.com>
	<CAJH6TXjE=nQscexL34fQ7RA0sDVc4+QB_O1r39UUAJ5_q87+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61321 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933743Ab2J3OiR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 10:38:17 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2200620qad.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 07:38:16 -0700 (PDT)
In-Reply-To: <CAJH6TXjE=nQscexL34fQ7RA0sDVc4+QB_O1r39UUAJ5_q87+OQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

> In this case, can a single block device (for example a huge virtual
> machine image) be striped across many OSDs to archieve better
> performance in reading?
> an image striped across 3 disks, should get 3*IOPS when reading
Yes, but network (and many other isssues) must be considered.


> Another question: in a standard RGW/RBD infrastructure (no CephFS), I
> have to configure only "mon" and "osd" nodes, right?
Yes.

> How many monitor nodes is suggested?
3 is suggested.


On 30 October 2012 22:31, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2012/10/30 =D4=AC=B6=AC <yuandong1222@gmail.com>:
>> RGW and libRBD are not the same pool,  you can`t access aRBD volume =
with
>> RGW. The RADOS treats the RBD volume as just a large object.
>
> Ok, I think to have understood. RADOS store only object on an existen=
t
> filesystem (this is why I have to create a FS to use RADOS/Ceph).
> Now, if that object is accessed by RGW, that object will be a single
> file stored on the FS but if I'm accessing
> with RBD, RBD is masking a very large object, stored on FS, as it is =
a
> single block device.
> In this case, can a single block device (for example a huge virtual
> machine image) be striped across many OSDs to archieve better
> performance in reading?
> an image striped across 3 disks, should get 3*IOPS when reading
>
>
> Another question: in a standard RGW/RBD infrastructure (no CephFS), I
> have to configure only "mon" and "osd" nodes, right?
> How many monitor nodes is suggested?



--=20
=D4=AC=B6=AC
Email:yuandong1222@gmail.com
QQ:10200230
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
