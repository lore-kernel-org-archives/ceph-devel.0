From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ls -l not listing file attributes inside ceph directory
Date: Tue, 13 Mar 2012 11:22:50 -0700
Message-ID: <CAORUGqCdDzaeAw61AJo5=BzYoAsmqd4FZp0wVxBw-w24iyNG8g@mail.gmail.com>
References: <loom.20120313T100729-291@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61560 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758733Ab2CMSXK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Mar 2012 14:23:10 -0400
Received: by ghrr11 with SMTP id r11so864975ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Mar 2012 11:23:10 -0700 (PDT)
In-Reply-To: <loom.20120313T100729-291@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Mar 13, 2012 at 02:13, madhusudhana
<madhusudhana.u.acharya@gmail.com> wrote:
> Hi all
> When I run ls -l command inside a folder coming from ceph cluster,
> sometime it will not list file properties. when I run again, it
> will list for some files and not for some. Any idea why this happens =
?
>
>
> [root@ceph-node-9 test35]# ll
> total 0
> ?--------- =C2=A0? ? =C2=A0 =C2=A0 =C2=A0? =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? arra=
ys

Is that with the kernel client or FUSE?

What's the version number of Ceph?

What's the kernel version on the client?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
