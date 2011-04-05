From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Question about librados
Date: Tue, 5 Apr 2011 06:42:25 -0700
Message-ID: <BANLkTik1OakYf7aqeUd6AW=wVXB87T72eg@mail.gmail.com>
References: <incab7$gnn$1@dough.gmane.org>
	<BANLkTi=-9ESbE5uaMZYBH2X9Q5y-gPtW7w@mail.gmail.com>
	<inedo0$3v2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56441 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1DENm2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 09:42:28 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7B2EAC066
	for <ceph-devel@vger.kernel.org>; Tue,  5 Apr 2011 06:42:27 -0700 (PDT)
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2B743C063
	for <ceph-devel@vger.kernel.org>; Tue,  5 Apr 2011 06:42:27 -0700 (PDT)
Received: by wwk4 with SMTP id 4so2754308wwk.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2011 06:42:25 -0700 (PDT)
In-Reply-To: <inedo0$3v2$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 4, 2011 at 11:44 PM, Rutger ter Borg <rutger@terborg.net> w=
rote:
> thanks for the elaborate answer! With respect to the compile error, I=
 got
> this in an empty file with just including rados/librados.hpp
>
> $ g++ ./rados.cpp
> In file included from /usr/include/rados/buffer.h:55:0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from /usr/include/rados/librados.hpp:=
10,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from ./rados.cpp:6:
> /usr/include/rados/atomic.h:25:24: fatal error: atomic_ops.h: No such=
 file
> or directory
> compilation terminated.
Have you tried using the full make system (go to src dir,
=2E/autogen.sh; ./configure; make)? All the required headers should get
pulled in when you install the package, but they might not be in your
default include paths.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
