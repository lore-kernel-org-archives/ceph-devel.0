From: Gregory Farnum <greg@inktank.com>
Subject: Re: Out-of-tree build of ceph
Date: Thu, 14 Nov 2013 08:00:02 -0800
Message-ID: <CAPYLRzjrWs6Dz0uqmiOzWfwit69EQwG+8Yb4ZXtUnHP+3TfhXg@mail.gmail.com>
References: <5284B689.7090801@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:59479 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab3KNQAE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 11:00:04 -0500
Received: by mail-wg0-f51.google.com with SMTP id m15so2143944wgh.18
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 08:00:03 -0800 (PST)
In-Reply-To: <5284B689.7090801@bob-the-boat.me.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hrm, I don't think many of the developers do builds like that too
often, so it's not surprising it got a little busted. :( Can you make
a ticket in the tracker with whatever you've figured out about the
cause and timing so we don't lose it? :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Nov 14, 2013 at 3:39 AM, Dave (Bob) <dave@bob-the-boat.me.uk> wrote:
> This is a very minor point, but this list is very responsive and
> helpful, and I am trying to be helpful myself.
>
> I find that an out-of-tree build of ceph fails because 'ceph_ver.c'
> can't be found in the build tree.
>
> I simply 'cp ceph-0.72/src/ceph_ver.c build/src' to work around the
> problem for my purposes.
>
> This issue has not always been present, but has been for quite a few
> versions now.
>
> Regards,
> David
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
