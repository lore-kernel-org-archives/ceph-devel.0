From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: rejoin mds daemon, 17 osd are suddenly down and out
Date: Mon, 18 Jul 2011 08:36:58 -0700
Message-ID: <CAF3hT9DB2CBbKEsJVShTjsMQxZ2J0vL4Yqv4h55wuQmV=6QfJg@mail.gmail.com>
References: <CADF7qQWkza=j_dapnRqJdPX-2i9HnEqpJ6aQ10CGFCDmU5KZCg@mail.gmail.com>
	<4E1F235C.3000207@hq.newdream.net>
	<CAF3hT9ACaCNGa9pH4LrHz2rTGHEoCcdaroLkNLWU-H=GGi6=ZQ@mail.gmail.com>
	<CADF7qQV4yaHzSaYr+KrHWq0GbCg9hNDYLS+NhOM5L3YE5cv45Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53064 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1GRPhA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2011 11:37:00 -0400
Received: by ywe9 with SMTP id 9so1347446ywe.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2011 08:36:59 -0700 (PDT)
In-Reply-To: <CADF7qQV4yaHzSaYr+KrHWq0GbCg9hNDYLS+NhOM5L3YE5cv45Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: AnnyRen <annyren6@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 14, 2011 at 7:32 PM, AnnyRen <annyren6@gmail.com> wrote:
> 2011/7/15 Gregory Farnum <gregory.farnum@dreamhost.com>:
>> I do notice that (unless mds.a is configured to be a standby in the
> Thank you for your reply.
>
> How can I configure mds.a to be a standby in ceph.conf?
See http://ceph.newdream.net/wiki/Standby-replay_modes#Specifying_standby-replays_in_the_configuration_file
