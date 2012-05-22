From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Snapshot/Clone in RBD
Date: Tue, 22 May 2012 13:20:36 +0200
Message-ID: <CAMvP8PCyrWTDqh1Fg6TZHX1_0VYYdj7JrWQc4e0HJvNrx8BHzg@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D016566CC@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58518 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758446Ab2EVLU5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 07:20:57 -0400
Received: by ghrr11 with SMTP id r11so710462ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 04:20:56 -0700 (PDT)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D016566CC@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

At this moment there's no support to clone images in RBD. Only way to
create new image is to copy the old one through client interface .
Sage mentioned that new release will included image layering
which will be copy-on-write cloning implementation.


On Tue, May 22, 2012 at 12:39 PM,  <Eric_YH_Chen@wiwynn.com> wrote:
> Hi all:
>
> =A0 =A0According to the document, snapshot in RBD is "Read-only".
>
> =A0 =A0That is to say, if I want to clone the image, I should use
> "rbd_copy". Right?
>
> =A0 =A0I am curious about if this function is optimized, ex: copy-on-=
write,
> to speed up the performance.
>
> =A0 =A0What I want to do is to integrate rbd with kvm. I hope that I =
can
> clone the image as soon as possible to speed up the vm creation.
>
> =A0 =A0(One base image, and create other vm from this.)
>
> =A0 =A0Do you have any suggestion about this point? Thanks a lot!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
