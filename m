From: biyan chen <riby.chen@gmail.com>
Subject: Re: ceph authenticate problem
Date: Tue, 24 May 2011 09:50:18 +0800
Message-ID: <BANLkTimzNEbURVnjHFN_NmoBu_tJDi4aFA@mail.gmail.com>
References: <BANLkTinpu+Gq4CeXzpbZ-V8t8UzOH2trhQ@mail.gmail.com>
	<20110523155631.GA7495@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51149 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab1EXBuU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 21:50:20 -0400
Received: by ywe9 with SMTP id 9so2209663ywe.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 18:50:19 -0700 (PDT)
In-Reply-To: <20110523155631.GA7495@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

My steps =A3=BA
mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
/usr/local/etc/ceph/keyring.bin
/etc/init.d/ceph -a start

Can give me a little more information?


2011/5/23 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Mon, May 23, 2011 at 03:48:41PM +0800, biyan chen wrote:
>>         keyring =3D /use/local/etc/ceph/keyring.bin
>
> This might be your problem..
>
> --
> :(){ :|:&};:
>



--=20
name:Riby
mobile:+86 15280267642
company: =B0=D9=B4=F3=C1=FA=D2=BB
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
