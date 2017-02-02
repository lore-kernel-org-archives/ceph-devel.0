From: Haomai Wang <haomai@xsky.com>
Subject: Re: mgr issue with RDMA
Date: Thu, 2 Feb 2017 16:25:35 +0800
Message-ID: <CACJqLyY3iEH6eXP34K0+f+z-iahJrqHtUx-wrZN=OgL7x6hP0g@mail.gmail.com>
References: <VI1PR0501MB27828E6A500097E382147C47D74A0@VI1PR0501MB2782.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0095.outbound.protection.outlook.com ([104.47.124.95]:45124
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750920AbdBBIZt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Feb 2017 03:25:49 -0500
Received: by mail-io0-f173.google.com with SMTP id l66so176577477ioi.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2017 00:25:44 -0800 (PST)
In-Reply-To: <VI1PR0501MB27828E6A500097E382147C47D74A0@VI1PR0501MB2782.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adir Lev <adirl@mellanox.com>
Cc: Sarit Zubakov <saritz@mellanox.com>, Oren Duer <oren@mellanox.com>, Daniel Bar-On <danielbo@mellanox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

[cc to ceph-devel]



On Tue, Jan 31, 2017 at 11:58 PM, Adir Lev <adirl@mellanox.com> wrote:
> Hi Haomai
>
>
>
> For conf of:
>
> ms_public_type = async+posix
>
> ms_cluster_type = async+posix
>
> I can run
>
> systemctl start ceph-mon@r-dcs45
>
> and all is OK !
>
> [root@r-dcs45 my-cluster]# ps aux |grep ceph
>
> root      4136  0.0  0.0 187676  2444 pts/0    S    15:22   0:00 su ceph
>
> ceph      4137  0.0  0.0 115372  1940 pts/0    S    15:22   0:00 bash
>
> ceph     21579  5.0  0.0 338668 19008 ?        Ssl  15:46   0:00
> /usr/bin/ceph-mon -f --cluster ceph --id r-dcs45 --setuser ceph --setgroup
> ceph
>
> ceph     22595 12.0  0.0 528604 26088 ?        Ssl  15:46   0:00
> /usr/bin/ceph-mgr -f --cluster ceph --id r-dcs45 --setuser ceph --setgroup
> ceph
>
> root     22619  0.0  0.0 112644   948 pts/0    S+   15:46   0:00 grep
> --color=auto ceph
>
>
>
> but when I move to RDMA and change the conf to
>
> ms_public_type = async+rdma
>
> ms_cluster_type = async+rdma
>
>
>
> if I  try to start again using:
>
> systemctl start ceph-mon@r-dcs45
>
>
>
> command is stuck. (console no return)
>
>
>
> looking at ps:
>
> [root@r-dcs45 my-cluster]# ps aux |grep ceph
>
> root      4136  0.0  0.0 187676  2444 pts/0    S    15:22   0:00 su ceph
>
> ceph      4137  0.0  0.0 115372  1940 pts/0    S    15:22   0:00 bash
>
> root     22726 19.5  0.5 940308 191156 ?       Ssl  15:48   0:00
> /usr/bin/python2.7 /usr/bin/ceph -i /var/lib/ceph/mgr/ceph-r-dcs45/keyring
> auth add mgr.r-dcs45 mon allow *
> --keyring=/var/lib/ceph/mon/ceph-r-dcs45/keyring --name=mon.

do you restart mon to use rdma firstly?

>
> root     22764  0.0  0.0 112644   952 pts/0    S+   15:48   0:00 grep
> --color=auto ceph
>
>
>
> looking at vim /usr/lib/systemd/system/ceph-mgr@.service
>
> seems like this command:
>
> ExecStartPre=-/usr/bin/ceph -i /var/lib/ceph/mgr/${CLUSTER}-%i/keyring auth
> add mgr.%i mon 'allow *' --keyring=/var/lib/ceph/mon/${CLUSTER}-%i/keyring
> --name=mon.
>
> Have problem running in RDMA mode
>
>
>
> Any idea?
>
>
>
> Thanks, Adir
