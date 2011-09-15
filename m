From: Wido den Hollander <wido@widodh.nl>
Subject: Re: mkcephfs giving problems
Date: Thu, 15 Sep 2011 14:01:28 +0200
Message-ID: <1316088088.3104.10.camel@wido-desktop>
References: <loom.20110915T081127-706@post.gmane.org>
	 <1316086135.3104.4.camel@wido-desktop>
	 <CAMiHsJLTR=rvoND829mE_AsZqAhY4jAAu60QtHQFepg5E8a9Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:50884 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933125Ab1IOMB3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 08:01:29 -0400
In-Reply-To: <CAMiHsJLTR=rvoND829mE_AsZqAhY4jAAu60QtHQFepg5E8a9Rg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: jan.smets@alcatel-lucent.com, hjwsm1989@gmail.com, ceph-devel@vger.kernel.org

Hi,

On Thu, 2011-09-15 at 17:24 +0530, Atish Kathpal wrote:
> Hello friends
> 
> 
> I am running the "mkcephfs -a -c ceph.conf -k ceph.keyring" script as
> root (sudo) and have also tried by giving 777 privileges to all
> directories being accessed.
> 
> 
> I also made the suggested change in the ceph.conf file, by replacing
> with $id at required places. (following convention).
> 
> 
> 
> Still I see the same output as posted before.
> 
> 
> 
> My /ceph_data directory is a normal linux directory created using
> mkdir and not a separate partition. Is that a problem?

What kind of filesystem is it? btrfs? ext4? If it's ext4, are xatrrs
enabled?

Wido

> 
> 
> atish@atish-virtual-machine:/etc/ceph$  mkcephfs -a -c ceph.conf -k
> ceph.keyring
> temp dir is /tmp/mkcephfs.NHCO3zMk87
> preparing monmap in /tmp/mkcephfs.NHCO3zMk87/monmap
> /usr/bin/monmaptool --create --clobber --add alpha 10.72.147.207:6789
> --print /tmp/mkcephfs.NHCO3zMk87/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.NHCO3zMk87/monmap
> /usr/bin/monmaptool: generated fsid
> 24b2d358-c94e-6abf-42bf-82657b64ea81
> epoch 1
> fsid 24b2d358-c94e-6abf-42bf-82657b64ea81
> last_changed 2011-09-15 17:11:10.867824
> created 2011-09-15 17:11:10.867824
> 0: 10.72.147.207:6789/0 mon.alpha
> /usr/bin/monmaptool: writing epoch 1
> to /tmp/mkcephfs.NHCO3zMk87/monmap (1 monitors)
> === osd.0 ===
>  ** WARNING: Ceph is still under development.  Any feedback can be
> directed  **
>  **          at ceph-devel@vger.kernel.org or
> http://ceph.newdream.net/.     **
> 2011-09-15 17:11:11.754143 b78c16e0 AdminSocketConfigObs::init:
> failed: AdminSocket::bind_and_listen: failed to bind the UNIX domain
> socket to '/var/run/ceph/osd.0.asok': error 2: No such file or
> directory
> 2011-09-15 17:11:11.754176 b78c16e0 AdminSocketConfigObs: failed to
> start AdminSocket
> 2011-09-15 17:11:11.759168 b78c16e0 filestore(/ceph_data/osd.0)
> FileStore::mkfs: failed to open /ceph_data/osd.0/fsid: error 13:
> Permission denied
> 2011-09-15 17:11:11.759191 b78c16e0 OSD::mkfs: FileStore::mkfs failed
> with error -13
> 2011-09-15 17:11:11.760877 b78c16e0  ** ERROR: error creating empty
> object store in /ceph_data/osd.0: error 13: Permission denied
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.NHCO3zMk87 --init-daemon
> osd.0'
> 
> 
> Looking forward to your suggestions.
> 
> 
> Regards
> Atish
> 
> 
> PS: I am unable to mail from my gmail account to the
> entire ceph-devel@vger.kernel.org mailing list. I first posted the
> mail using
> "http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/3023"
> website. Any ideas for this ?
> 
> 
> On Thu, Sep 15, 2011 at 4:58 PM, Wido den Hollander <wido@widodh.nl>
> wrote:
>         Hi,
>         
>         As Jantje said, it seems you are not running as root.
>         
>         But I do have some recommendations for your config:
>         
>         On Thu, 2011-09-15 at 06:14 +0000, Atish Kathpal wrote:
>         > [global]
>         >         auth supported = cephx
>         >        keyring = /etc/ceph/ceph.keyring
>         >
>         > [mon]
>         >         mon data = /ceph_data/mon.0
>         >
>         
>         
>         This section is globally, so if you'd add more monitors, they
>         would all
>         get /ceph_data/mon.0 as data dir.
>         
>         I'd do:
>         
>         [mon]
>            mon data = /ceph_data/mon.$id
>         
>         > [mds]
>         >
>         > [osd]
>         >         osd data = /ceph_data/osd.0
>         >         osd journal = /ceph_data/osd.0.journal
>         >         osd journal size = 1000
>         
>         
>         Same goes here for your OSD, do:
>         
>          osd data = /ceph_data/osd.$id
>          osd journal = /ceph_data/osd.$id.journal
>         
>         >
>         > [mon.0]
>         >         host = atish-virtual-machine
>         >         mon addr = 10.72.147.207:6789
>         
>         
>         Monitors should not be named "0", "1", etc, but more like:
>         * mon.alpha
>         * mon.beta
>         * mon.charlie
>         
>         >
>         > [osd.0]
>         >         host = atish-virtual-machine
>         >
>         > [mds.0]
>         >         host = atish-virtual-machine
>         
>         
>         
>         And you have only one OSD, is that correct?
>         
>         Wido
>         
> 
> 


