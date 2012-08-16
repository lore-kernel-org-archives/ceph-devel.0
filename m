From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph setup on single node : prob with "
Date: Thu, 16 Aug 2012 09:13:27 -0700
Message-ID: <CADvuQREJp_v=ywHPPe-WVZfgmhua-pYwUz+duedo54XXt9usAQ@mail.gmail.com>
References: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com>
 <CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com> <CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62099 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739Ab2HPQNs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 12:13:48 -0400
Received: by vcbfk26 with SMTP id fk26so2516555vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 09:13:47 -0700 (PDT)
In-Reply-To: <CAGfy=6nJR+jRmM8sVaWOOjwm+DXfjTQ762K9JhLpxyRYt0eghQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 15, 2012 at 9:44 PM, hemant surale <hemant.surale@gmail.com> wrote:
> Hello Tommi, Ceph community
>
> I did mkdir the directory. Infact I have created a new partition by
> the same name and formatted using ext3. I also executed the following
> command for the partition/directory:
>
> "mount -o remount,user_xattr /"

Remounting root with extended attributes isn't really relevant; what
you care about is /ceph_data/osd.0.

Please share output of

mount
ls /ceph_data/osd.0
