From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Geo-replication with RBD
Date: Thu, 31 Jan 2013 10:19:17 +0100
Message-ID: <CAMwB3TjKyCbCWjvNJfF_WoJofr-qpXg6QieMpOQPFKpatfLh1Q@mail.gmail.com>
References: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
	<CAJH6TXhNqRY3TziGw_4bR9CkxawsxV4s6BcKkfCX6ePTWvQO1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35791 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3AaJTT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 04:19:19 -0500
Received: by mail-lb0-f173.google.com with SMTP id gf7so3100821lbb.4
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 01:19:17 -0800 (PST)
In-Reply-To: <CAJH6TXhNqRY3TziGw_4bR9CkxawsxV4s6BcKkfCX6ePTWvQO1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We are using nginx, on top of rgw. In nginx we manage to create logic,
for using a AMQP, and async operations via queues. Then workers, on
every side getiing data from own queue, and then coping data from
source, to destination in s3 API. Works for PUT/DELETE, and work
automatic when production goes on another location.

On Thu, Jan 31, 2013 at 9:25 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/31 Skowron S=C5=82awomir <slawomir.skowron@grupaonet.pl>:
>> We have managed async geo-replication of s3 service, beetwen two cep=
h clusters in two DC's, and to amazon s3 as third. All this via s3 API.=
 I love to see native RGW geo-replication with described features in an=
other thread.
>
> how did you do this?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
