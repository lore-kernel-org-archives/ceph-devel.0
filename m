From: hemant surale <hemant.surale@gmail.com>
Subject: Re: Ceph setup on single node : prob with "
Date: Thu, 16 Aug 2012 10:14:19 +0530
Message-ID: <CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com>
References: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com>
	<CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54474 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab2HPEoT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 00:44:19 -0400
Received: by obbuo13 with SMTP id uo13so3129303obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Aug 2012 21:44:19 -0700 (PDT)
In-Reply-To: <CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello Tommi, Ceph community

I did mkdir the directory. Infact I have created a new partition by
the same name and formatted using ext3. I also executed the following
command for the partition/directory:

"mount -o remount,user_xattr /"

Still I am getting the same error:
>> 2012-08-14 14:31:29.390410 7fe3b920e780  ** ERROR: error creating
>> empty object store in /ceph_data/osd.0: (2) No such file or directory
>> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.n6zx4y4y33 --init-daemon osd.0'

Can you please help me out. I am using Ubuntu 12.04 with kernel version: 3.3.7

Do let me know if I am missing out on something. My college project is
stuck because of this issue. Please help me out.

Regards
Hemant


On Tue, Aug 14, 2012 at 9:41 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Tue, Aug 14, 2012 at 3:13 AM, hemant surale <hemant.surale@gmail.com> wrote:
>> 2012-08-14 14:31:29.390410 7fe3b920e780  ** ERROR: error creating
>> empty object store in /ceph_data/osd.0: (2) No such file or directory
>> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.n6zx4y4y33 --init-daemon osd.0'
>
> Sounds like /ceph_data/osd.0 does not exist. You need mkdir it, and
> you probably want to mount a disk there.
