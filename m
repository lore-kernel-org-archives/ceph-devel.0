From: Gregory Farnum <greg@inktank.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:45:41 +0100
Message-ID: <CAPYLRzh3AV41CnY5VMPAtuggZxr6NidDrYF0ODYL6H64vEBVeQ@mail.gmail.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com>
	<508EE540.5060303@inktank.com>
	<CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com>
	<CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com>
	<CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com>
	<508FD83F.9020308@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42792 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2J3Npm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 09:45:42 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so365042iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 06:45:42 -0700 (PDT)
In-Reply-To: <508FD83F.9020308@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Oct 30, 2012 at 2:38 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 30.10.2012 14:36, schrieb Gandalf Corvotempesta:
>
>> 2012/10/30 Gregory Farnum <greg@inktank.com>:
>>>
>>> Not a lot of people are publicly discussing their sizes on things l=
ike
>>> that, unfortunately. I believe DreamHost is still the most open. Th=
ey
>>> have an (RGW-based) object storage service which is backed by ~800
>>> OSDs and are currently beta-testing a compute service using RBD, wh=
ich
>>> you can see described here:
>>> http://www.youtube.com/watch?v=3Dl_8Y988fO44&feature=3Dplcp
>
>
> But there's still the problem of slow random write IOP/s. At least i =
haven't
> seen any good benchmarks.

It's not magic =97 I haven't done extensive testing but I believe peopl=
e
see aggregate IOPs of about what you can calculate:
(number of storage disks * IOPS per disks) / (replication level)
The journaling bumps that up a little bit for bursts, of course;
similarly if you're doing it on a brand new RBD image it can be a bit
slower since you need to create all the objects as well as write data
to them. You need to architect your storage system to match your
requirements. If you want to run write-heavy databases on RBD, there
are people doing that. They're using SSDs and are very pleased with
its performance. *shrug*
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
