From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: can't read superblock
Date: Tue, 18 Jan 2011 06:58:55 -0800
Message-ID: <AANLkTimLwK5hBJ3CLQM7OTz8coyy3ikokfwVZN4Yt9GQ@mail.gmail.com>
References: <AANLkTim+oK0=_oK5DnsVwfR2mKndDTGpLBO-znwQfq8T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37697 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1ARPE3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jan 2011 10:04:29 -0500
Received: by ewy5 with SMTP id 5so3289226ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jan 2011 07:04:28 -0800 (PST)
In-Reply-To: <AANLkTim+oK0=_oK5DnsVwfR2mKndDTGpLBO-znwQfq8T@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?= <maciejgalkiewicz@ragnarson.com>
Cc: ceph-devel@vger.kernel.org

2011/1/18 Maciej Ga=C5=82kiewicz <maciejgalkiewicz@ragnarson.com>:
> I could not report a bug in bug tracer (I am not allowed to or I just
> couldn't find appropriate button?) so I send it here. There is a
> problem on debian squeeze with kernel 2.6.32 and ceph kernel module.
> Ceph version 0.24.1-1~bpo60+1. I can not mount filesystem on client
> machine:
You don't have an active MDS. One is still starting up, and the second
is in standby:
> 2011-01-18 12:50:54.084113 =C2=A0 mds e6: 1/1/1 up {0=3Dup:creating},=
 1 up:standby
We'll need more information to figure out why that is, though.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
