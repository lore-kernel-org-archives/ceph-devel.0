From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Geo-replication with RBD
Date: Mon, 18 Feb 2013 15:20:13 +0100
Message-ID: <CAMwB3Tiipqh3kT1WQ7Rga0zSGGO2rFt++cTALZd_HUbtf+afjQ@mail.gmail.com>
References: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
	<CAJH6TXhNqRY3TziGw_4bR9CkxawsxV4s6BcKkfCX6ePTWvQO1w@mail.gmail.com>
	<CAMwB3TiOF_gK4bw1YTZk8A2c7akT2ozMJQrVp+p7yrRsYc294Q@mail.gmail.com>
	<CAJH6TXj9j7Qv=-+qOd-HpnyaPN2AAdxyOp4uttrChE69w0nsjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:49755 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3BROUO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 09:20:14 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so7139605ieb.6
        for <ceph-devel@vger.kernel.org>; Mon, 18 Feb 2013 06:20:13 -0800 (PST)
In-Reply-To: <CAJH6TXj9j7Qv=-+qOd-HpnyaPN2AAdxyOp4uttrChE69w0nsjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, now i can response, after i was sick.

Nginx is compiled with perl/or lua support. Inside nginx configuration
is hook, for a perl code, or lua code, as you prefer. This code have a
inline functionality. We have testing this from logs, but it's not a
good idea.Now in line option, have advantage, because, we can reject
PUT's if AMQP is not working, and we don't need to resync, all
requests. If it took long, than, wee can't disable queue, and go
direct, without AMQP, and resync offline, from logs, by a simple admin
tool.

This in line functionality, working only on DELETE, PUT, and rest are
skipped, Every DELETE, PUT, have a own queue, with own priorities, and
custom info in header, for calculating, a time, of synchronization.
This nginx functionality, only putting data into queues, and every
data, are going into our, S3 (ceph), and Amazon s3, via nginx, with
almost same configuration, distributed by puppet.

On every DataCenter, we have a bunch of workers, getting data from
queues, dedicated for a location, and then, they are getting data
syncing, from source to destination. If data can't be get from source,
than info is going into error queue, and this queue is re-checked, for
some time.

I am in middle of writing some article, about this, but my sickness,
have slow down this process slightly.


On Thu, Jan 31, 2013 at 10:50 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/31 S=C5=82awomir Skowron <szibis@gmail.com>:
>> We are using nginx, on top of rgw. In nginx we manage to create logi=
c, for
>> using a AMQP, and async operations via queues. Then workers, on ever=
y side
>> getiing data from own queue, and then coping data from source, to
>> destination in s3 API. Works for PUT/DELETE, and work automatic when
>> production goes on another location.
>
> I don't know much about messaging, are you able to share some
> configuration or more details ?



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron

On Thu, Jan 31, 2013 at 10:50 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/31 S=C5=82awomir Skowron <szibis@gmail.com>:
>> We are using nginx, on top of rgw. In nginx we manage to create logi=
c, for
>> using a AMQP, and async operations via queues. Then workers, on ever=
y side
>> getiing data from own queue, and then coping data from source, to
>> destination in s3 API. Works for PUT/DELETE, and work automatic when
>> production goes on another location.
>
> I don't know much about messaging, are you able to share some
> configuration or more details ?



--
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
