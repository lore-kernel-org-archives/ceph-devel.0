From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: problem with ceph init scripts
Date: Wed, 16 Feb 2011 13:41:44 -0800
Message-ID: <AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50448 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1BPVlp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 16:41:45 -0500
Received: by fxm20 with SMTP id 20so1888229fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Feb 2011 13:41:44 -0800 (PST)
In-Reply-To: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m@hexagrid.com=
> wrote:
> But if we want to start a particular osd or mon or mds ,its not
> working and there is no error
> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and don't get a=
ny error

That is expected, unless you are running init-ceph on the same node as
osd1 is on.

It might be nice to have some kind of interface like "run command X on
osd1", but init-ceph is not that.

> /etc/init.d/ceph -a stop also does not stop ceph on all nodes.It stop=
s
> on current node only
> where as
> /etc/init.d/ceph -a killall works fine.

That sounds like a bug. I'll see if I can fix it.

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
