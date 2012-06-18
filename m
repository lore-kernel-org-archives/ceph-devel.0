From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph performance on Ubuntu Oneiric vs Ubuntu Precise
Date: Mon, 18 Jun 2012 11:12:56 -0700
Message-ID: <CADvuQREzVbnw5xFSJLx5CSDPXdZOhOpHLHGr-CFYmtRWJmxZYQ@mail.gmail.com>
References: <4FDF6BB8.4080401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59433 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab2FRSNR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 14:13:17 -0400
Received: by pbbrp8 with SMTP id rp8so8539854pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 11:13:16 -0700 (PDT)
In-Reply-To: <4FDF6BB8.4080401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 18, 2012 at 10:56 AM, Mark Nelson <mark.nelson@inktank.com>=
 wrote:
> I've been tracking down some performance issues over the past month w=
ith our
> internal test nodes and believe I have narrowed it down to something =
related
> to Ubuntu Oneiric. =C2=A0Tests done on nodes running Ubuntu Precise a=
re
> significantly faster.

Did you use Ubuntu kernels or our own builds? Different/same across run=
s?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
