From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: new ceph-0.60 always crash mds
Date: Sat, 13 Apr 2013 10:30:45 +0800
Message-ID: <CAJiejCQTnPTpx+BDACQtGzTwu7=3UcPZpxm=AHoKbcz2PiC+dA@mail.gmail.com>
References: <CAJiejCRunA9z=L2zTQP=b+=F2Pf17nG1CNoF1EN7rhvLwuqtKA@mail.gmail.com>
 <CAPYLRzgUTOFoiAr-siPKxPr_GgiJs69KgBWSc3Hy-qxqAaTzwg@mail.gmail.com>
 <CAJiejCS9cgvtGTtYEcmw7DMsP0EsUx_fg10RuLdeGo-rmFmGdw@mail.gmail.com> <CAPYLRzjbgmXAKxAsC+hwq-dJct8-oe6OQe2m9XYfieaek8569Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:50444 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab3DMCbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 22:31:07 -0400
Received: by mail-qa0-f45.google.com with SMTP id i20so91328qad.18
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 19:31:06 -0700 (PDT)
In-Reply-To: <CAPYLRzjbgmXAKxAsC+hwq-dJct8-oe6OQe2m9XYfieaek8569Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: maillist-linux <ceph-devel@vger.kernel.org>

2013/4/13 Gregory Farnum <greg@inktank.com>:
> On Fri, Apr 12, 2013 at 5:19 PM, Drunkard Zhang <gongfan193@gmail.com> wrote:
>> 2013/4/13 Gregory Farnum <greg@inktank.com>:
>>> Have you made any changes from the default settings? That assert
>>
>> Do you means one of these settings?
>> auth cluster required = cephx
>> auth service required = cephx
>> auth client required = cephx
>> cephx require signatures = true
>> cephx cluster require signatures = true
>> cephx service require signatures = true
>> cephx sign messages = true
>> keyring = /etc/ceph/keyring
>
> These all look fine.
>
>>
>> yes, these was my testing configs. And the command created the cluster was:
>> mkcephfs -v -a -c /etc/ceph/ceph.conf --mkfs
>>
>> I thought it was permission problem, so I grabbed just all keys from
>> 'ceph auth list' into /etc/ceph/keyring, mds still crashs.
>>
>> I wondering which point I should check for MDS's permission? Is it
>> just 'ceph auth list' ?
>
> Yeah. Mine has pretty broad permissions:
> mds.a
>         key: AQC0omhRaPzNLBAAz5J/JdZ6LrJo/DNG0ns8xg==
>         caps: [mds] allow
>         caps: [mon] allow *
>         caps: [osd] allow *
>
> but I wasn't sure if yours were more constricted on pool access or something.

Didn't change anything since created. Here's my previous config, is
there any improper ?

[global]
cluster network = 10.205.119.0/24, 150.164.100.0/24
tcp nodelay = true
;tcp rcvbuf = 32*1024*1024
;ms bind ipv6 = true
;ms tcp read timeout = 900

# Auth
auth cluster required = cephx
auth service required = cephx
auth client required = cephx
cephx require signatures = true
cephx cluster require signatures = true
cephx service require signatures = true
cephx sign messages = true
keyring = /etc/ceph/keyring

mon osd full ratio = .85
mon osd nearfull ratio = .75

max open files = 812150
log file = /var/log/ceph/$name.log
pid file = /var/run/ceph/$name.pid
;debug osd = 20
;debug filestore = 20

; MON, Always create an odd number.
[mon]
mon data = /ceph/$name
osd pool default size = 2
;osd pool default crush rule = 0
;mon clock drift allowed = 1
;mon clock drift warn backoff = 30

[mon.a]
host = c15
mon addr = 10.205.119.15:6789

[mon.b]
host = c16
mon addr = 10.205.119.16:6789

[mon.c]
host = squid79-log-ceph
mon addr = 150.164.100.79:6789

; MDS
[mds]
;debug ms = 1
;debug mds = 20

[mds.u]
host = c15

[mds.v]
host = c16

;[mds.w]
;host =

; OSD
[osd]
osd data = /ceph/$name
osd journal = /ceph/$name/journal
osd journal size = 2048 ; journal size, in megabytes
journal aio = true
journal dio = true
journal block align = true
;osd recovery max active = 5

;filestore max sync interval = 5
filestore min sync interval = 0.01
filestore fiemap = true

;btrfs options = rw,noatime
osd mkfs type = xfs
osd mkfs options xfs = -f -L $name
osd mount options xfs = rw,noatime,nodiratime

[osd.0]
host = c15
devs = /dev/sdb1
osd heartbeat address = 10.205.119.15
public addr = 10.205.119.15
cluster addr = 10.205.119.15

[snipped 32 osd]

I got 33 OSDs totally, distributed in 3 servers.
