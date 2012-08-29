From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Integration work
Date: Wed, 29 Aug 2012 09:43:16 -0400
Message-ID: <CADvuQREkbfxTfzdjqYof00BF7GVa+ft+SXFzHzO0NwJOkSDP3g@mail.gmail.com>
References: <503D0A00.2080905@inktank.com> <CAF6-1L6QKQbgPZvXYMQw+0_vaLrP0cr_P0_nZs56Lh+A2B9k8Q@mail.gmail.com>
 <503DE69B.70804@widodh.nl> <CAF6-1L4sVnMsx79APO5X0zEEUyDoBD2PUvjTZw6Gzb7rgfpKkg@mail.gmail.com>
 <503E1BC6.8080308@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54595 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab2H2Nnh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 09:43:37 -0400
Received: by vcbfk26 with SMTP id fk26so596857vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 06:43:36 -0700 (PDT)
In-Reply-To: <503E1BC6.8080308@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 29, 2012 at 9:40 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> Huh ... I've never heard this. Also the guys in ##xen haven't either.
>> I'm not really involved in xen dev and don't follow it closely but
>> that seems unlikely. The few slides I looked at from the Xen Summit a
>> couple days ago show that they really like their PV model.
> I must be wrong then!

They are (at least, Red Hat is) looking at using more qemu for
xen-hvm. Whether that has any effect on the PV side, I wouldn't know.
It might make sense for them to use virtio even for PV, so they might
use qemu to implement the hypervisor side of virtio too, and that
would get you librbd support.
