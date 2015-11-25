From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: block-rbd: One function call less in rbd_dev_probe_parent() after
 error detection
Date: Wed, 25 Nov 2015 11:23:21 +0100
Message-ID: <56558C19.8090607@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <56536BAD.4000309@users.sourceforge.net>
 <56536D12.4000308@users.sourceforge.net>
 <CAOi1vP_t6-vw-sesRwpgfbqLVRyevOP4uvhbj05b3PPg=oHD6Q@mail.gmail.com>
 <5654B91D.4040808@users.sourceforge.net>
 <CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
 <5654C9F2.20409@users.sourceforge.net>
 <CAOi1vP_MoqiPqNMGJVEeAyBywtkHbZrn7cLayEgdT1cL63c7KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_MoqiPqNMGJVEeAyBywtkHbZrn7cLayEgdT1cL63c7KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: ceph-devel.vger.kernel.org

> "one err bug" as per CodingStyle is a NULL deref on line 2 if foo is NULL.
> If it was just "err: kfree(foo); return ret;", a NULL foo would be perfectly OK.

Would it make sense to rename such an issue as the "one error jump label bug"?
https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ

Regards,
Markus
