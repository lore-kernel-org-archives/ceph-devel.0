From: Tommi Virtanen <tv@inktank.com>
Subject: Re: OSD per disk.
Date: Tue, 29 May 2012 09:26:54 -0700
Message-ID: <CADvuQREMRQtBv2NhM_QH0A_-mFE5wRGPVMHk0Wu7jhUvgXjcYQ@mail.gmail.com>
References: <loom.20120528T080903-621@post.gmane.org> <1c048abb-0cbb-4d69-9922-419c16019887@mailpro>
 <loom.20120528T111434-469@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51815 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab2E2Q1P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 12:27:15 -0400
Received: by pbbrp8 with SMTP id rp8so6165339pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:27:15 -0700 (PDT)
In-Reply-To: <loom.20120528T111434-469@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chandrashekhar <chandubigc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, May 28, 2012 at 2:25 AM, chandrashekhar <chandubigc@gmail.com> =
wrote:
> Thanks Alexandre, =C2=A0I created four directories in /data =C2=A0(os=
d0,osd1,osd2,osd3)
> and mounted as below:
>
> /dev/sdb1 -> /data/osd1
> /dev/sdc1 -> /data/osd2
> /dev/sdd1 -> /data/osd3
>
>
> But when I start ceph its starting mons and md daemons but not osds. =
Please help
> me to get this working.

How did you create the cluster? mkcephfs?

Do you see log entries in /var/log/ceph/*osd*.log ? What do they say?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
