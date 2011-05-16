From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: rbd create error with 0.26
Date: Mon, 16 May 2011 08:40:11 -0700
Message-ID: <BANLkTi=mUpMdaz4j7f0BQW7q0MUijBSRjw@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
	<BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
	<BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
	<BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com>
	<BANLkTikPk32SMy0-bNrto8+6tSajciZ4pw@mail.gmail.com>
	<Pine.LNX.4.64.1105130854110.12286@cobra.newdream.net>
	<BANLkTimr+Ov=s=He5eKFmb6QFspDU=YmHQ@mail.gmail.com>
	<Pine.LNX.4.64.1105152130240.21842@cobra.newdream.net>
	<BANLkTimrqOAFkicL6fm9mfDbHZOqUG7aaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42869 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131Ab1EPPkO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2011 11:40:14 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D101EC068
	for <ceph-devel@vger.kernel.org>; Mon, 16 May 2011 08:40:13 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 80377C066
	for <ceph-devel@vger.kernel.org>; Mon, 16 May 2011 08:40:13 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1285059eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 May 2011 08:40:11 -0700 (PDT)
In-Reply-To: <BANLkTimrqOAFkicL6fm9mfDbHZOqUG7aaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

On Sun, May 15, 2011 at 11:44 PM, Simon Tian <aixt2006@gmail.com> wrote=
:
> Great! =A0 Thx very much...
> It's just that reason!!!
> I just did "rados -p data bench 60 write -t 1 -b 1024", the speed is
> more or less the same.
>
> So I changed the IO_SIZE to 1MB and above in my test codes, the speed
> became perfect.
>
> There should be a buffer policy in the libceph api, so speed is not
> hurt badly by the small IO_SIZE, is it right? =A0Hmm, where can I fin=
d
> the buffer policy in the ceph code?
>
> Thx!
> Simon

The Ceph code proper does do buffering, but the lower-level rados and
RBD apis don't have any at all -- applications that want it are
expected to implement that themselves. libceph uses the Client class
in the source code, and that does buffering and caching with the
ObjectCacher module. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
