From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph setup on single node : prob with "
Date: Thu, 16 Aug 2012 17:12:55 +1200
Message-ID: <502C8157.5050609@catalyst.net.nz>
References: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com> <CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com> <CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42871 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab2HPFM6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 01:12:58 -0400
In-Reply-To: <CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

On 16/08/12 16:44, hemant surale wrote:
> Hello Tommi, Ceph community
>
> I did mkdir the directory. Infact I have created a new partition by
> the same name and formatted using ext3. I also executed the following
> command for the partition/directory:
>
> "mount -o remount,user_xattr /"
>
> Still I am getting the same error:
>>> 2012-08-14 14:31:29.390410 7fe3b920e780  ** ERROR: error creating
>>> empty object store in /ceph_data/osd.0: (2) No such file or directory
>>> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.n6zx4y4y33 --init-daemon osd.0'
> Can you please help me out. I am using Ubuntu 12.04 with kernel version: 3.3.7
>
> Do let me know if I am missing out on something. My college project is
> stuck because of this issue. Please help me out.
>
>

Hi Hermant,

The osd.o directory needs to be pre-created before you do mkcephfs, so 
you need to:

$ sudo mkdir /ceph_data/osd.0
$ sudo mkcephfs -a -c /etc/ceph/ceph.conf

Cheers

Mark
