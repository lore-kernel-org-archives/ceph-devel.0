From: Gregory Farnum <greg@inktank.com>
Subject: Re: new developer - where to start contributing
Date: Fri, 29 Aug 2014 17:07:48 -0700
Message-ID: <CAPYLRzh-20dL7GHpePx33XM7NxHM-jAoOAXASKaohYKxbyfOOw@mail.gmail.com>
References: <loom.20140828T160715-242@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:47203 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaH3AHt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Aug 2014 20:07:49 -0400
Received: by mail-qc0-f180.google.com with SMTP id c9so3104845qcz.25
        for <ceph-devel@vger.kernel.org>; Fri, 29 Aug 2014 17:07:49 -0700 (PDT)
In-Reply-To: <loom.20140828T160715-242@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kostiantyn Danylov <kdanilov@mirantis.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 28, 2014 at 7:12 AM, Kostiantyn Danylov
<kdanilov@mirantis.com> wrote:
> Hi all,
>
> My name is Kostiantyn Danylov, I'm C++/C/python developer with ~9 yea=
r of
> experience, also I'm interesting in distributed systems. I would like=
 to
> contribute to ceph. I already read documents at
> http://ceph.com/docs/master/dev/. Where I can start contributing? Pro=
bably I
> can start by fixing some
> simple bugs, can you point me on them?

As with many projects we aren't very good at maintaining them, but
there are two places that should be good to start:
1) go to tracker.ceph.com and search for tickets marked as new-dev
(http://tracker.ceph.com/search?utf8=3D=E2=9C=93&q=3Dnew-dev)
2) wiki.ceph.com has a chum bucket "maintained" by the community:
https://wiki.ceph.com/Development/Chum_Bucket

I would avoid the copy-on-read feature in the chum bucket for now, but
the rest will introduce you to several very different pieces of the
code base.

Aside: you might be better off figuring out if there are specific
(small!) things you want Ceph to do and working from there; it's a big
project with a bunch of different kinds of things to do.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
