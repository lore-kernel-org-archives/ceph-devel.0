From: Greg Farnum <greg@inktank.com>
Subject: Re: how to mount a specific pool in cephs
Date: Tue, 22 May 2012 14:21:23 -0700
Message-ID: <9AF25259E69149DE97352565797966E1@inktank.com>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10>
 <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com>
 <loom.20120522T135204-38@post.gmane.org>
 <8CBFE0C21212497AA50AEBE59EEFCAFF@inktank.com>
 <3E281FAE45D705468EBA19F32321E72B32A009D964@exch11>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61436 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2EVVV0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 17:21:26 -0400
Received: by pbbrp8 with SMTP id rp8so8919468pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 14:21:26 -0700 (PDT)
In-Reply-To: <3E281FAE45D705468EBA19F32321E72B32A009D964@exch11>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Grant Ashman <Grant.Ashman@mach.com.au>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Tuesday, May 22, 2012 at 2:12 PM, Grant Ashman wrote:
> > That's the right pool ID; yes. I believe the problem is that the ce=
phfs tool currently requires you to fill in all the fields, not ?>just =
the one you wish to change. Try that (setting all the other values to m=
atch what you see when you view the layout). :) -> Greg
> =20
> =20
> =20
> Hi,
> =20
> I've tried setting all values the same as the current layout - changi=
ng only the pool number and I still get;
> =20
> root@dsan-test:/mnt/ceph-test# cephfs /mnt/ceph-backup show_layout
> layout.data_pool: 0
> layout.object_size: 4194304
> layout.stripe_unit: 4194304
> layout.stripe_count: 1
> root@dsan-test:/mnt/ceph-test# =20
> root@dsan-test:/mnt/ceph-test# cephfs /mnt/ceph-backup set_layout -p =
3 -s 4194304 -u 4194304 -c 1
> Error setting layout: Invalid argument
> =20
> If I leave all values exactly the same i.e '-p 0' the command runs wi=
thout any error output. However, changing the pool from anything but 0 =
results in 'Error setting layout: Invalid argument'
> =20
> Any ideas?
Oh, I got this conversation confused with another one. You also need to=
 specify the pool as a valid pool to store filesystem data in, if you h=
aven't done that already:
"ceph mds add_data_pool <poolname>"


And you may not actually need to specify all options =E2=80=94 I'd been=
 assuming since it broke but I don't remember if that's actually the ca=
se (I think it's changed over the versions).=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
