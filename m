From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Re: mount errors
Date: Mon, 22 Aug 2011 18:11:34 -0700
Message-ID: <CAJD3hpUZ6N-kkbOvjzBVFOuvpBJQ_zezXUrswqe5C8=ZBUJMjQ@mail.gmail.com>
References: <CAJD3hpWa7VXDNcEc7sOCZWUfm84Uo4vDxZ4OceNf+6OKt7RFGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34799 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1HWBLf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2011 21:11:35 -0400
Received: by gxk21 with SMTP id 21so3996729gxk.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2011 18:11:35 -0700 (PDT)
In-Reply-To: <CAJD3hpWa7VXDNcEc7sOCZWUfm84Uo4vDxZ4OceNf+6OKt7RFGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Also,when i try to "mkceph" i get the error:

failed: AdminSocket::bind_and_listen: failed to bind the UNIX domain
socket to '/var/run/ceph/osd.0.asok': error 2: No such file or
directory

Could this cause a fs creation issue?

-Jojy

On Mon, Aug 22, 2011 at 6:08 PM, Jojy Varghese <jojy.varghese@gmail.com=
> wrote:
> Hi
> =C2=A0I am getting "libceph: bad fsid, had
> e49ae577-0f7b-24e0-1c75-10ae17d9f86b got
> 3c9b15ef-c2d0-1318-4d12-3508025ccd97" on attempting to mount the fs.
> Any quick fixes?
>
> thanks
> -Jojy
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
