From: Joseph Glanville <joseph.glanville@orionvm.com.au>
Subject: Re: Integration work
Date: Thu, 30 Aug 2012 01:19:04 +1000
Message-ID: <CAOzFzEj=_YZcoXm6+gGemd1X-EU_PhZrFdscFMG5xPt_3uY1sg@mail.gmail.com>
References: <503D0A00.2080905@inktank.com>
	<CAF6-1L6QKQbgPZvXYMQw+0_vaLrP0cr_P0_nZs56Lh+A2B9k8Q@mail.gmail.com>
	<503DE69B.70804@widodh.nl>
	<CAF6-1L4sVnMsx79APO5X0zEEUyDoBD2PUvjTZw6Gzb7rgfpKkg@mail.gmail.com>
	<503E1BC6.8080308@widodh.nl>
	<CADvuQREkbfxTfzdjqYof00BF7GVa+ft+SXFzHzO0NwJOkSDP3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61069 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab2H2PTF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 11:19:05 -0400
Received: by obbuo13 with SMTP id uo13so1197605obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 08:19:05 -0700 (PDT)
In-Reply-To: <CADvuQREkbfxTfzdjqYof00BF7GVa+ft+SXFzHzO0NwJOkSDP3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, Sylvain Munaut <s.munaut@whatever-company.com>, Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, xen-devel <xen-devel@lists.xen.org>

On 29 August 2012 23:43, Tommi Virtanen <tv@inktank.com> wrote:
> On Wed, Aug 29, 2012 at 9:40 AM, Wido den Hollander <wido@widodh.nl> wrote:
>>> Huh ... I've never heard this. Also the guys in ##xen haven't either.
>>> I'm not really involved in xen dev and don't follow it closely but
>>> that seems unlikely. The few slides I looked at from the Xen Summit a
>>> couple days ago show that they really like their PV model.
>> I must be wrong then!
>
> They are (at least, Red Hat is) looking at using more qemu for
> xen-hvm. Whether that has any effect on the PV side, I wouldn't know.
> It might make sense for them to use virtio even for PV, so they might
> use qemu to implement the hypervisor side of virtio too, and that
> would get you librbd support.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I don't there is much going on in terms of increasing use of QEMU,
only that Xen can now use upsteam QEMU rather than the Xen specific
fork (qemu-xen-traditional).
There was GSOC project to build a virtio front/backend for Xen but I
am not sure if this would be the way to go.
As far as I can see Xen dominates KVM in terms network and I/O
performance on every benchmark so apart from compatibility the gains
of using virtio don't seem that great... Xen's blkback/netback PV
system is just that much faster and more scalable with large numbers
of domains or 100k+ IOPs.

With regards to blktap.. blktap is currently in a state where blktap2
is included in a minimal amount of distros and is non-upstreamable.
blktap3 which is coming will but fully userspace but I have never been
a big fan of userspace block devices, YMMV.
That being said, building blktap devices is really easy (similar to tuntap).

Ideally improving the kernel RBD device would provide the best
performance across the board and the most compatibility (anything can
use a raw block device).

Joseph.

-- 
CTO | Orion Virtualisation Solutions | www.orionvm.com.au
Phone: 1300 56 99 52 | Mobile: 0428 754 846
