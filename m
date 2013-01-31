From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Geo-replication with RBD
Date: Thu, 31 Jan 2013 10:50:59 +0100
Message-ID: <CAJH6TXj9j7Qv=-+qOd-HpnyaPN2AAdxyOp4uttrChE69w0nsjQ@mail.gmail.com>
References: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
	<CAJH6TXhNqRY3TziGw_4bR9CkxawsxV4s6BcKkfCX6ePTWvQO1w@mail.gmail.com>
	<CAMwB3TiOF_gK4bw1YTZk8A2c7akT2ozMJQrVp+p7yrRsYc294Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:41312 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3AaJvH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 04:51:07 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so267834wgb.2
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 01:51:05 -0800 (PST)
In-Reply-To: <CAMwB3TiOF_gK4bw1YTZk8A2c7akT2ozMJQrVp+p7yrRsYc294Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: =?ISO-8859-2?Q?Skowron_S=B3awomir?= <slawomir.skowron@grupaonet.pl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/1/31 S=C5=82awomir Skowron <szibis@gmail.com>:
> We are using nginx, on top of rgw. In nginx we manage to create logic=
, for
> using a AMQP, and async operations via queues. Then workers, on every=
 side
> getiing data from own queue, and then coping data from source, to
> destination in s3 API. Works for PUT/DELETE, and work automatic when
> production goes on another location.

I don't know much about messaging, are you able to share some
configuration or more details ?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
