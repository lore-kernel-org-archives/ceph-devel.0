From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: block-rbd: One function call less in rbd_dev_probe_parent() after
 error detection
Date: Thu, 26 Nov 2015 08:54:45 +0100
Message-ID: <5656BAC5.3060501@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP-Z2yfJVcpqZN8EOf6rYsd41ixOOQWVva_xkKmA6PLrhg@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

>> I interpreted the eventual passing of a null pointer to the rbd_dev_destroy()
>> function as an indication for further source code adjustments.
> 
> If all error paths could be adjusted so that NULL pointers are never passed in,
> destroy functions wouldn't need to have a NULL check, would they?

How do you think about to clarify corresponding implementation details a bit more?

* Why was the function "rbd_dev_probe_parent" implemented in the way
  that it relies on a sanity check in the function "rbd_dev_destroy" then?
* How are the chances to restructure the source code a bit (like changing a few
  jump labels) so that it should also work without an extra function call
  during error handling there?

Regards,
Markus
