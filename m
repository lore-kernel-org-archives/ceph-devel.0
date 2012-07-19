From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph doesn't update the block device size while a rbd image is mounted
Date: Thu, 19 Jul 2012 08:38:18 -0700
Message-ID: <CADvuQRH05NnF_-a34R2mWfLomhpnyrbek9-63poKZA_zvP5BUw@mail.gmail.com>
References: <CAOLwVUkWUrjQTxQw5-umpWnY6G-AjReCwLTyQCOdCyNT175KgA@mail.gmail.com>
 <CAOLwVUm-31QzWb2fnZP+tsntunXEJOcaFLRenqJtAQ9nYPmLyA@mail.gmail.com>
 <50082476.4020109@widodh.nl> <CAOLwVUm+NnB-ooMiCDx+rkHJhn7tCE7xM67wY6mmMckG87CrQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47857 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2GSPik convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 11:38:40 -0400
Received: by yhmm54 with SMTP id m54so2890948yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 08:38:40 -0700 (PDT)
In-Reply-To: <CAOLwVUm+NnB-ooMiCDx+rkHJhn7tCE7xM67wY6mmMckG87CrQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 19, 2012 at 8:26 AM, S=C3=A9bastien Han <han.sebastien@gmai=
l.com> wrote:
> Ok I got your point seems logic, but why is this possible with LVM fo=
r example?
>
> You can easily do this with LVM without un-mounting the device.

Do your LVM volumes have partition tables inside them? That might be
the difference.

Of course, you can put your filesystem straight on the RBD; that would
be a good experiment to run.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
