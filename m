From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: ceph-mon blocked error
Date: Thu, 3 Nov 2011 13:39:53 -0700
Message-ID: <CA+jddaO2NqLTNbS2zBnQW4MCA7=BYDC-GHx_H01hqSq9RvOgBw@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
	<CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
	<CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
	<CAORUGqB+oS5WupMZURbkenNop68u2jf2VrY3_tktBk4=b-jS8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42392 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1KCUjx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 16:39:53 -0400
Received: by vws1 with SMTP id 1so1297344vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 13:39:53 -0700 (PDT)
In-Reply-To: <CAORUGqB+oS5WupMZURbkenNop68u2jf2VrY3_tktBk4=b-jS8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

The osd data directories are on /mnt/osd$id which are btrfs.

The mon data directory is /mnt/local/mon$id which is xfs. (/mnt/local
is the mount point)

Here is the ceph.conf file (note: secure authentication is turned off
at the moment):

; global
[global]
    ; enable secure authentication
;   auth supported = cephx

; monitors
;  You need at least one.  You need at least three if you want to
;  tolerate any node failures.  Always create an odd number.
[mon]
    mon data = /mnt/local/mon$id

    ; some minimal logging (just message traffic) to aid debugging
    debug ms = 0
[mon.0]
    host = 172.16.0.130
    mon addr = 172.16.0.130:6789

[mon.1]
    host = 172.16.0.128
    mon addr = 172.16.0.128:6789

[mon.2]
    host = 172.16.0.129
    mon addr = 172.16.0.129:6789


; mds
;  You need at least one.  Define two to get a standby.
[mds]
    ; where the mds keeps its secret encryption keys
    keyring = /mnt/local/keyring.$name

[mds.node-172-16-0-130]
    host = 172.16.0.130

[mds.node-172-16-0-128]
    host = 172.16.0.128

[mds.node-172-16-0-129]
    host = 172.16.0.129
    mds standby replay = true
    mds standby for name = node-172-16-0-130


[osd]
    ; This is where the btrfs volume will be mounted.
    osd data = /mnt/osd$id

    ; Ideally, make this a separate disk or partition.  A few GB
    ; is usually enough; more if you have fast disks.  You can use
    ; a file under the osd data dir if need be
    ; (e.g. /mnt/osd$id/journal), but it will be slower than a
    ; separate disk or partition.
    osd journal = /mnt/osd$id/journal
    osd class dir = /lib/rados-classes

    ; If the OSD journal is a file, you need to specify the size. This
is specified in MB.
    osd journal size = 512

[osd.0]
    host = 172.16.0.130
[osd.1]
    host = 172.16.0.130
[osd.2]
    host = 172.16.0.130
[osd.3]
    host = 172.16.0.130
[osd.24]
    host = 172.16.0.128
[osd.25]
    host = 172.16.0.128
[osd.26]
    host = 172.16.0.128
[osd.27]
    host = 172.16.0.128
[osd.48]
    host = 172.16.0.129
[osd.49]
    host = 172.16.0.129
[osd.50]
    host = 172.16.0.129
[osd.51]
    host = 172.16.0.129



On Thu, Nov 3, 2011 at 12:23 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Nov 3, 2011 at 12:09, Mandell Degerness <mandell@pistoncloud.com> wrote:
>> We are currently running all services on each of the three nodes.
>> (mon, mds, and several osd processes).
>
> Is the osd data directory on the same filesystem as the mon data dir,
> or are they perhaps on different disks? (Hoping for the former, for
> the sake of xfs credibility ;)
>
