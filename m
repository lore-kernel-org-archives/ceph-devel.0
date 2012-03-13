From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Trying to build "ceph-client-standalone" under kernel 2.6.32
Date: Tue, 13 Mar 2012 15:54:18 -0700
Message-ID: <CAORUGqDDaKFapndd+Ca3pJ8u-mCcj0_DHbnXiP9ewmOTqQCxow@mail.gmail.com>
References: <loom.20120313T154901-294@post.gmane.org> <loom.20120313T193341-715@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:55287 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760506Ab2CMWyj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Mar 2012 18:54:39 -0400
Received: by dadp12 with SMTP id p12so1681547dad.11
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 15:54:38 -0700 (PDT)
In-Reply-To: <loom.20120313T193341-715@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bryan Wright <bkw1a@ayesha.phys.virginia.edu>
Cc: ceph-devel@vger.kernel.org

On Tue, Mar 13, 2012 at 11:40, Bryan Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
> Sorry, let me correct that: I'm actually doing this under CentOS 6.2 =
with a
> 2.6.32 kernel.
=2E..
> =C2=A0 =C2=A0 Regarding the possibility of using a later kernel, I co=
uld do that, but
> then I'd need to worry more about keeping on top of security updates.=
 =C2=A0If I can
> use the stock CentOS kernel, then I can just let the CentOS maintaine=
rs worry
> about that.
>
> =C2=A0 =C2=A0 Regarding the possibility of moving the 32-bit machines=
 to 64-bit, it's an
> option, but there's otherwise very little pressure to make the move, =
and some
> trepidation about what might break. =C2=A0For us, a 32-bit kernel wit=
h PAE has been a
> fine configuration.

Sorry, I don't have much else to tell you. We're not currently burning
developer hours in backporting the kernel client to old kernels. An
older version of ceph-client-standalone.git might work, or it might
not -- we don't regression test that code. If your need is big enough,
I'm sure the professional services side will take good care of you ;)

As for 64-bit, I've used it everywhere for a long time and haven't had
major breakage. I think it's a smaller risk than running an old ceph
kernel client on 2.6.32.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
