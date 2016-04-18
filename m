From: =?UTF-8?B?0K7RgNC40Lkg0KHQvtC60L7Qu9C+0LI=?=
	<funny.falcon@gmail.com>
Subject: Re: Flexible placement
Date: Mon, 18 Apr 2016 20:35:03 +0300
Message-ID: <CAL-rCA3AfkSJ9VN_MyMjPyxwnYxECAh6_xrx1mW3BNT4yvhWew@mail.gmail.com>
References: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com>
	<20160418170836.GB20078@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36439 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbcDRRfG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 13:35:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id l6so26474310wml.3
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 10:35:05 -0700 (PDT)
In-Reply-To: <20160418170836.GB20078@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

> However, part of the benefit of the NaCl-based Flexible Placement design is that
> administrators can put in all sorts of weird things we've never thought of.
> If we are to redesign some of our abstractions to support
> it and other goals we want (which I think we must), it seems a shame
> not to make them as flexible as we reasonably can

You suggests awful things. People fears flexibility. Ceph policies are
really already flexible.
Those couple of people that wish "super flexibility" are able to fork
Ceph and implement their needs.

Until several people explicitly asked for "super-puper" flexibility,
that cannot be described with Crush,
there is no need to do this "flexibility".

It is better focus effort on pushing down memory consumption,
especially during recovery.
It is much more desired feature.
