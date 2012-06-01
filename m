From: Sam Just <sam.just@inktank.com>
Subject: Re: iozone test crashed on ceph
Date: Thu, 31 May 2012 19:15:56 -0700
Message-ID: <CA+4uBUYHGVEzwMsi014_Dp7oDkjWN0qob_5v=ut6rKe19e0aGA@mail.gmail.com>
References: <loom.20120601T025228-787@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49821 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab2FACP4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 22:15:56 -0400
Received: by dady13 with SMTP id y13so2104005dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 19:15:56 -0700 (PDT)
In-Reply-To: <loom.20120601T025228-787@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

Thanks for letting us know.  What version are you running?  Can you
post your ceph.conf to give us an idea of how your cluster is
configured?  Also, did any of the daemons crash?  If it's
reproducible, it would help to turn up osd and mds debugging to 20 and
post the logs.

Thanks
-Sam

On Thu, May 31, 2012 at 5:58 PM, udit agarwal <fzdudit@gmail.com> wrote=
:
> Hi,
> =A0I have set up ceph system with a client, mon and mds on one system=
 which is
> connected to 2 osds. I ran iozone test with a 10G file and it ran fin=
e. But when
> I ran iozone test with a 5G file, the process got killed and our ceph=
 system
> hanged. Can anyone please help me with this.
>
> =A0Thanks in advance.
>
> --Udit
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
