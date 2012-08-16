From: hemant surale <hemant.surale@gmail.com>
Subject: Re: Ceph setup on single node : prob with "
Date: Thu, 16 Aug 2012 14:49:07 +0530
Message-ID: <CAGfy=6=ftMyZ6vjZqj+cwbGT4S96acBi5_-h8_S3nYSaMT_=5A@mail.gmail.com>
References: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com>
	<CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com>
	<CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com>
	<502C8157.5050609@catalyst.net.nz>
	<CAGfy=6k9c1RyzTABxJvJ9A6MaS-yqSQR8oiKGs-DED0rfgxbUQ@mail.gmail.com>
	<502C8439.1060403@catalyst.net.nz>
	<CAGfy=6=VMEHTPKv1v83BfyxC=P6=ysPj5S44w_zCQNhLAOAhjg@mail.gmail.com>
	<502C94B7.9090203@catalyst.net.nz>
	<CAGfy=6=SzFvBjmdj-F2qtZnb-e8xFReQ76G8JK4+UjM=xfNdxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45182 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab2HPJTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 05:19:08 -0400
Received: by obbuo13 with SMTP id uo13so3414886obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 02:19:07 -0700 (PDT)
In-Reply-To: <CAGfy=6=SzFvBjmdj-F2qtZnb-e8xFReQ76G8JK4+UjM=xfNdxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Mark, Ceph community

I tried the suggested ceph.conf file as well and I continue to face
the same problem. Moreover, hemant-virtual-machine is a real host
(virtual machine).

Ceph version: 0.50.

Please guide me through this I continue to get the same frustrating error:

"=== osd.0 ===
2012-08-16 14:47:26.157823 7fde12e10780 -1  ** ERROR: error creating
empty objec            t store in /ceph_data/osd.0: (2) No such file
or directory
failed: '/sbin/mkcephfs -d /tmp/mkcephfs.YFCUqpT8Qh --init-daemon osd.0'
"

Looking forward to any other tricks that I could try. Please refer to
my previous emails to get a copy of my conf file and installation and
platform details.

regards
Hemant

On Thu, Aug 16, 2012 at 12:05 PM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> On 16/08/12 17:36, hemant surale wrote:
>>
>> Still same problem sir. I have attached ceph.conf here. I tried to
>> google it as well but unable to figure out what exact error is.
>>
>>
>
> Hi your ceph.conf have a few errors: any names *must* be real hosts - e.g
> myserver01 must be real. Also you can't have xxx.alpha... I am guessing that
> should be myserver01...unless they should all be hemant-virtual-machine (see
> suggestions attached).
>
> You may need to specify directory for mds too (I am not using any)...with
> some edits I can do a mkcephfs with the attached file on my system - I was
> reproducing your error with yours. Enjoy (I am off home).
>
> Cheers
>
> Mark
>
>
>
