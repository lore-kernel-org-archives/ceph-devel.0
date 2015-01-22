From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Thu, 22 Jan 2015 11:54:24 +0300
Message-ID: <CALFYKtDazJJ6mXHu26qBe=ygXuX3VQGVmxs5pJ90hnu2ns+10Q@mail.gmail.com>
References: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox>
	<CALFYKtCn-gGfjZ0qnjRoiS_ksX2KC4PJMcLO0gW5znXgbVAQgg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9AA@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtAJ5RiwkEiUGD=oVFzC+Rtor9pF7R4_L9Di9Zg4THCviA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9E0@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36056 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbbAVIyZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 03:54:25 -0500
Received: by mail-qg0-f53.google.com with SMTP id a108so208894qge.12
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jan 2015 00:54:24 -0800 (PST)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9E0@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@inktank.com>
Cc: Chaitanya Huilgol <chaitanya.huilgol@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jan 21, 2015 at 11:02 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> <<inline
>
> -----Original Message-----
> From: Ilya Dryomov [mailto:ilya.dryomov@inktank.com]
> Sent: Wednesday, January 21, 2015 11:47 AM
> To: Somnath Roy
> Cc: Chaitanya Huilgol; Ceph Development
> Subject: Re: [PATCH] ceph: rbd option listing and tcp_nodelay support
>
> On Wed, Jan 21, 2015 at 10:29 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Ilya,
>> Regarding supported attribute list,  I think it could be a step towards better usability experience during rbd map command. Presently, if user gives wrong option or unsupported option it just errors out saying 'sysfs write failed' or so. User has no idea what went wrong.
>
> # rbd map -o foobar test
> rbd: unknown map option 'foobar'
> rbd: couldn't parse map options
>
> # rbd map -o fsid=foobar test
> rbd: invalid fsid value 'foobar'
> rbd: couldn't parse map options
>
> Since about a year ago, rbd cli would try to parse supplied options.
> Of course, the list of options it knows about is static, but your attribute wouldn't solve that problem (or rather it will, but only for simple boolean yes/no options, like crc or tcp_nodelay) because we also try to sanity check the value, as the above fsid example shows.
>
> [Somnath] Hmm..I missed that it seems.  Yes, for Boolean attributes kernel compatibility check should be able to flag that.
>
>> We can use this supported list from kernel module from rbd cli to show proper error message to the user.
>> Another feature that we have implemented is rbd cli to consult the /etc/ceph/ceph.conf and take the rbd kernel supported options from there automatically if user has not provided any option during rbd map. User provided option during rbd map will always get priority though.
>
> Did you mean "and take rbd kernel map options", i.e. take default map options from ceph.conf?  I think that's a good idea.
> [Somnath] Yes, whatever is common, like crc (ms_nocrc in ceph.conf) , tcp_nodelay (ms_tcp_nodelay in ceph.conf)

I was thinking more along the lines of a static "rbd default map
options" field in ceph.conf, e.g.

rbd default map options = "nocrc,tcp_nodelay"

which can then be overwritten by rbd map -o.

The thing is, kernel msgr will always be a stripped down version of
userspace msgr, and on top of that we are bound to have some kernel
client specific options.  Having both "rbd default map options" and
pulling out values for whatever options are common sounds like it can
be a bit confusing - we will have three layers of options settings to
deal with (common options, rbd_default_map_options, rbd map -o).
Sage, do you think it's worth it?

Thanks,

                Ilya
