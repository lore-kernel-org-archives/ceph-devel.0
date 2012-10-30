From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 15:31:11 +0100
Message-ID: <CAJH6TXjE=nQscexL34fQ7RA0sDVc4+QB_O1r39UUAJ5_q87+OQ@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
	<CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
	<CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com>
	<CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com>
	<CAMm-wcJTfubebF=W+GCHdHM9kvZ6b9pGWpMv-Ri0-Pn7XQ-SeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43853 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab2J3ObM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 10:31:12 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so189691eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 07:31:11 -0700 (PDT)
In-Reply-To: <CAMm-wcJTfubebF=W+GCHdHM9kvZ6b9pGWpMv-Ri0-Pn7XQ-SeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

2012/10/30 =E8=A2=81=E5=86=AC <yuandong1222@gmail.com>:
> RGW and libRBD are not the same pool,  you can`t access aRBD volume w=
ith
> RGW. The RADOS treats the RBD volume as just a large object.

Ok, I think to have understood. RADOS store only object on an existent
filesystem (this is why I have to create a FS to use RADOS/Ceph).
Now, if that object is accessed by RGW, that object will be a single
file stored on the FS but if I'm accessing
with RBD, RBD is masking a very large object, stored on FS, as it is a
single block device.
In this case, can a single block device (for example a huge virtual
machine image) be striped across many OSDs to archieve better
performance in reading?
an image striped across 3 disks, should get 3*IOPS when reading


Another question: in a standard RGW/RBD infrastructure (no CephFS), I
have to configure only "mon" and "osd" nodes, right?
How many monitor nodes is suggested?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
