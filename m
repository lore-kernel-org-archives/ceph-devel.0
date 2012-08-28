From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph benchmarks
Date: Tue, 28 Aug 2012 06:11:50 -0700
Message-ID: <CADvuQRGvz3Fy=vxAFfETMkcLRVBBROCUxXFDdF4C1Mupf5oPHQ@mail.gmail.com>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35733 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab2H1NML convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 09:12:11 -0400
Received: by vbbff1 with SMTP id ff1so5654570vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 06:12:10 -0700 (PDT)
In-Reply-To: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 27, 2012 at 1:47 PM, S=C3=A9bastien Han <han.sebastien@gmai=
l.com> wrote:
> For those of you who are interested, I performed several benchmarks o=
f
> RADOS and RBD on different types of hardware and use case.
> You can find my results here:
> http://www.sebastien-han.fr/blog/2012/08/26/ceph-benchmarks/

Nice!

Minor nit: "sudo echo 3 | tee /proc/sys/vm/drop_caches && sudo sync"
you probably want "say echo 3 | sudo tee ... && sync"
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
