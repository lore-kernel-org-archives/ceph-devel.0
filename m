From: Tommi Virtanen <tv@inktank.com>
Subject: Re: iozone test crashed on ceph
Date: Wed, 6 Jun 2012 09:17:20 -0700
Message-ID: <CADvuQRH1eC1J5DSwuyau-wnLmAoZMdmxtdeN70Cpku8GgZKM0A@mail.gmail.com>
References: <loom.20120601T025228-787@post.gmane.org> <0F43C46A9543420FBEB081A55ACD1FB0@inktank.com>
 <loom.20120604T235042-446@post.gmane.org> <CADvuQRFRsc24feZFbQYo7Rkg=ot4PF7j9VCEFDO2PJq3AGkzsw@mail.gmail.com>
 <loom.20120605T012913-573@post.gmane.org> <loom.20120605T014157-339@post.gmane.org>
 <CADvuQRHMxM9PxOyxmej9_MuJajGNV2=yBxL9vN7P4KEvA7US5A@mail.gmail.com>
 <loom.20120606T041909-114@post.gmane.org> <loom.20120606T060500-193@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46713 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2FFQRl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:17:41 -0400
Received: by pbbrp8 with SMTP id rp8so9144400pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 09:17:40 -0700 (PDT)
In-Reply-To: <loom.20120606T060500-193@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 5, 2012 at 9:15 PM, udit agarwal <fzdudit@gmail.com> wrote:
> Hi,
> =C2=A0Thank you all for your support in resolving the issue. As I men=
tioned in my
> previous post that I ran my iozone test again on a 5G file excluding =
the 4k
> record size. And now, I have successfully completed this test with re=
cord sizes
> of 8k and 16k and hopefully all others will also work fine. But I am =
still
> confused with the failure of the iozone test on 5G & 5M file with rec=
ord size
> 4k, while it worked happily for files of sizes 10M & 10G.
>
> =C2=A0Can anyone help me with this problem with suitable reasons??
> =C2=A0Thanks in advance.

Smaller records means more operations which means all kinds of locking
bugs and races are more likely to manifest.

I created ticket http://tracker.newdream.net/issues/2520 for us to add
iozone 4k random read/write into our test suite.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
