From: Gregory Farnum <greg@inktank.com>
Subject: Re: help - i/o error when mounting with cephfs
Date: Fri, 14 Mar 2014 18:10:14 -0700
Message-ID: <CAPYLRzixtzb-k7koUm3i4vzFRf1zwnVg-HiC6oWuMx8Hxi0S5A@mail.gmail.com>
References: <CAAtBRA1j842+x+LhMHfJm68V0dvihad=uJotxOb7xY3ktSr9qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:48714 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbaCOBKP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Mar 2014 21:10:15 -0400
Received: by mail-qa0-f50.google.com with SMTP id o15so3250699qap.37
        for <ceph-devel@vger.kernel.org>; Fri, 14 Mar 2014 18:10:14 -0700 (PDT)
In-Reply-To: <CAAtBRA1j842+x+LhMHfJm68V0dvihad=uJotxOb7xY3ktSr9qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shaun Keenan <skeenan@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 14, 2014 at 6:06 PM, Shaun Keenan <skeenan@gmail.com> wrote:
> When trying to mount off my ceph cluster I get this:
> mount error 5 = Input/output error
>
> cluster looks healthy:
>
> [root@ceph-mds2 ~]# ceph -s
>   cluster 61b6dda1-5412-41f7-9769-3ae7e47241b7
>    health HEALTH_OK
>    monmap e1: 1 mons at {ceph-mds1=10.9.53.53:6789/0}, election epoch
> 1, quorum 0 ceph-mds1
>    osdmap e14: 2 osds: 2 up, 2 in
>     pgmap v94: 192 pgs: 192 active+clean; 14540 bytes data, 26388 MB
> used, 50148 MB / 80631 MB avail
>    mdsmap e7: 0/0/1 up

The MDS isn't running, and doesn't look to have actually been started.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

>
> mds dump seems fine:
>
> [root@ceph-mds2 ~]# ceph mds dump
> dumped mdsmap epoch 7
> epoch   7
> flags   0
> created 2014-03-14 20:22:04.096926
> modified        2014-03-14 20:22:04.097018
> tableserver     0
> root    0
> session_timeout 60
> session_autoclose       300
> last_failure    0
> last_failure_osd_epoch  0
> compat  compat={},rocompat={},incompat={1=base v0.20,2=client
> writeable ranges,3=default file layouts on dirs,4=dir inode in
> separate object,5=mds uses versioned encoding}
> max_mds 1
> in
> up      {}
> failed
> stopped
> data_pools      1
> metadata_pool   0
>
> any help?  this has me completely stumped...
> fuse hangs too, btw.
> Thanks,
> Shaun
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
