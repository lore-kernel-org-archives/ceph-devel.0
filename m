From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Feature request: "max mon" setting
Date: Fri, 4 Nov 2011 10:02:37 -0700
Message-ID: <CAF3hT9AoUL63hZeiFXdXON1H8nE=mQTcuE7Tkam8M7gRF__TBw@mail.gmail.com>
References: <201111031302.51236.a.ott@m-privacy.de>
	<CAORUGqCg815t-C_=+RPB3Z6xRWG6JeeSa1LtpQr1G-yo2wU=7g@mail.gmail.com>
	<201111040912.14250.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45117 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932550Ab1KDRCh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 13:02:37 -0400
Received: by iage36 with SMTP id e36so2749517iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 10:02:37 -0700 (PDT)
In-Reply-To: <201111040912.14250.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 4, 2011 at 1:12 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> I agree that our needs are special. We want to be able to start with 2 and
> extend as customer needs grow, or start with 20 and shut some of them down if
> load gets low. I now understand that we should start with at least three
> nodes.
It's not so special a usage case, you're just thinking of it wrong.
Adding a new daemon of each type for every physical box you add is the
wrong way to expand. You want to add OSDs for every box in order to
take advantage of the storage; you CAN add an MDS for each box, but
you should really be scaling them according to how much metadata
activity you need to support; and the monitors need to be handled
carefully in order to keep a strict majority of them alive at all
times (and aside from durability the system doesn't much care about
how many there are).
-Greg
