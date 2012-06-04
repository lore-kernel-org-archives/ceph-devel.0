From: Tommi Virtanen <tv@inktank.com>
Subject: Re: iozone test crashed on ceph
Date: Mon, 4 Jun 2012 15:42:53 -0700
Message-ID: <CADvuQRFRsc24feZFbQYo7Rkg=ot4PF7j9VCEFDO2PJq3AGkzsw@mail.gmail.com>
References: <loom.20120601T025228-787@post.gmane.org> <0F43C46A9543420FBEB081A55ACD1FB0@inktank.com>
 <loom.20120604T235042-446@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49435 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab2FDWnO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 18:43:14 -0400
Received: by dady13 with SMTP id y13so6456162dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 15:43:14 -0700 (PDT)
In-Reply-To: <loom.20120604T235042-446@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 4, 2012 at 2:52 PM, udit agarwal <fzdudit@gmail.com> wrote:
> I ran the 5g iozone test on my ceph system and I got the following ou=
tput on the
> terminal:
=2E..
> Message from syslogd@hp1 at Jun =C2=A04 22:19:03 ...
> =C2=A0kernel:[ 7627.132065] Oops: 0000 [#1] PREEMPT SMP
> Message from syslogd@hp1 at Jun =C2=A04 22:19:03 ...
> =C2=A0kernel:[ 7627.132190] Stack:
> Message from syslogd@hp1 at Jun =C2=A04 22:19:03 ...
> =C2=A0kernel:[ 7627.132213] Call Trace:
> Message from syslogd@hp1 at Jun =C2=A04 22:19:03 ...
> =C2=A0kernel:[ 7627.132356] Code: ab c0 fe ff ff 0f 84 85 00 00 00 31=
 f6 48 89 df e8
> 03 d7 ff ff 4c 89 ef 48 89 44 24 28 e8 f6 91 ed e0 48 8b 44 24 28 48 =
8b 50 08

Can you share the whole message? That part is not very useful by itself=
=2E
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
