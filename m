From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Ceph benchmarks
Date: Tue, 28 Aug 2012 00:59:35 +0400
Message-ID: <CABYiri-+PaYyXQ2vTjcN2+n+4gFQj5vXZmbm41VSByWC9pHfqw@mail.gmail.com>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49414 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab2H0U75 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 16:59:57 -0400
Received: by wicr5 with SMTP id r5so4107168wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 13:59:55 -0700 (PDT)
In-Reply-To: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Aug 28, 2012 at 12:47 AM, S=C3=A9bastien Han <han.sebastien@gma=
il.com> wrote:
> Hi community,
>
> For those of you who are interested, I performed several benchmarks o=
f
> RADOS and RBD on different types of hardware and use case.
> You can find my results here:
> http://www.sebastien-han.fr/blog/2012/08/26/ceph-benchmarks/
>
> Hope it helps :)
>
> Feel free to comment, critic... :)
>
> Cheers!

My two cents - on ultrafast journal(tmpfs) it means which tcp
congestion control algorithm you using. For default CUBIC delays
aggregated sixteen-osd writing speed is about 450MBps, but for DCTCP
it raising up to 550MBps. For such device as SLC disk(ext4,^O journal,
commit=3D100) there is no observable difference - both times aggregated
speed measured about 330MBps. I do not tried yet H(S)TCP, it should do
the same as DCTCP. For delays lower than regular gigabit ethernet
different congestion algorithms should show bigger difference, though.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
