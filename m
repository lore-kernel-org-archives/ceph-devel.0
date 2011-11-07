From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Feature request: "max mon" setting
Date: Mon, 7 Nov 2011 13:21:46 -0800
Message-ID: <CAF3hT9BQcpsxWxt5Ec9wjWjJPWTAQULt2mDQKb5HXp4+==Vy3g@mail.gmail.com>
References: <201111031302.51236.a.ott@m-privacy.de>
	<CAORUGqCg815t-C_=+RPB3Z6xRWG6JeeSa1LtpQr1G-yo2wU=7g@mail.gmail.com>
	<201111040912.14250.a.ott@m-privacy.de>
	<CAF3hT9AoUL63hZeiFXdXON1H8nE=mQTcuE7Tkam8M7gRF__TBw@mail.gmail.com>
	<CAA9wQNdQNpNzx+JxTMQBkXqk+PveZa85Hnym9t11ce=es0O8zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65526 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab1KGVVr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 16:21:47 -0500
Received: by gyc15 with SMTP id 15so4610769gyc.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 13:21:47 -0800 (PST)
In-Reply-To: <CAA9wQNdQNpNzx+JxTMQBkXqk+PveZa85Hnym9t11ce=es0O8zg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: Amon Ott <a.ott@m-privacy.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 7, 2011 at 1:03 PM, Leander Yu <leander.yu@gmail.com> wrote:
> Hi Greg,
> Will there be any performance impact if there are too many mons?

Eventually there could be a small one. Every time the monitor systems
do a map update (to, for instance, change the record of whether an OSD
is up or down, or which MDS owns what data) it needs to get agreement
from a strict majority of the monitors. The more monitors you have the
higher the variance in latency you can get for this operation, and the
more bandwidth the leader monitor needs to devote to sending out the
updates to all the other monitors.
But under normal operation these map updates are "rare" (maybe one
every 5 seconds) and they're never in the client's critical path for
data transfer, so any performance issues would be noticed based on the
side effects they produce, not by client performance.
-Greg
