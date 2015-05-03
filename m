From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Re: Help with CEPH deployment
Date: Sun, 3 May 2015 10:42:29 -0700
Message-ID: <CAKKTCLXG3nzSQs8V5Qq7ycpbd__-vVHMG3Dma+Mihij4o7kakg@mail.gmail.com>
References: <CAKKTCLVJJA04BuymLiONYKmJELGpbPp776g=btF1ha4TRhHR-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34056 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbECRmu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 May 2015 13:42:50 -0400
Received: by obfe9 with SMTP id e9so93349361obf.1
        for <ceph-devel@vger.kernel.org>; Sun, 03 May 2015 10:42:50 -0700 (PDT)
In-Reply-To: <CAKKTCLVJJA04BuymLiONYKmJELGpbPp776g=btF1ha4TRhHR-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Here is the output..I am still stuck at this step. :(
(multiple times tried to by purging and restarting from scratch)

vjujjuri@rgulistan-wsl10:~/ceph-cluster$ ceph-deploy mon create-initial
[ceph_deploy.conf][DEBUG ] found configuration file at:
/home/vjujjuri/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (1.5.23): /usr/bin/ceph-deploy mon
create-initial
[ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts rgulistan-wsl11
[ceph_deploy.mon][DEBUG ] detecting platform for host rgulistan-wsl11 ...
[rgulistan-wsl11][DEBUG ] connection detected need for sudo
[rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
[rgulistan-wsl11][DEBUG ] detect platform information from remote host
[rgulistan-wsl11][DEBUG ] detect machine type
[ceph_deploy.mon][INFO  ] distro info: Ubuntu 12.04 precise
[rgulistan-wsl11][DEBUG ] determining if provided host has same
hostname in remote
[rgulistan-wsl11][DEBUG ] get remote short hostname
[rgulistan-wsl11][DEBUG ] deploying mon to rgulistan-wsl11
[rgulistan-wsl11][DEBUG ] get remote short hostname
[rgulistan-wsl11][DEBUG ] remote hostname: rgulistan-wsl11
[rgulistan-wsl11][DEBUG ] write cluster configuration to
/etc/ceph/{cluster}.conf
[rgulistan-wsl11][DEBUG ] create the mon path if it does not exist
[rgulistan-wsl11][DEBUG ] checking for done path:
/var/lib/ceph/mon/ceph-rgulistan-wsl11/done
[rgulistan-wsl11][DEBUG ] create a done file to avoid re-doing the mon
deployment
[rgulistan-wsl11][DEBUG ] create the init path if it does not exist
[rgulistan-wsl11][DEBUG ] locating the `service` executable...
[rgulistan-wsl11][INFO  ] Running command: sudo initctl emit ceph-mon
cluster=ceph id=rgulistan-wsl11
[rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
--admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
[rgulistan-wsl11][DEBUG ]
********************************************************************************
[rgulistan-wsl11][DEBUG ] status for monitor: mon.rgulistan-wsl11
[rgulistan-wsl11][DEBUG ] {
[rgulistan-wsl11][DEBUG ]   "election_epoch": 1,
[rgulistan-wsl11][DEBUG ]   "extra_probe_peers": [],
[rgulistan-wsl11][DEBUG ]   "monmap": {
[rgulistan-wsl11][DEBUG ]     "created": "2015-05-02 10:52:17.318500",
[rgulistan-wsl11][DEBUG ]     "epoch": 1,
[rgulistan-wsl11][DEBUG ]     "fsid": "64e48bd5-f174-44a4-a485-7df3adbdad3d",
[rgulistan-wsl11][DEBUG ]     "modified": "2015-05-02 10:52:17.318500",
[rgulistan-wsl11][DEBUG ]     "mons": [
[rgulistan-wsl11][DEBUG ]       {
[rgulistan-wsl11][DEBUG ]         "addr": "xx.xx.xx.xx:6789/0",
[rgulistan-wsl11][DEBUG ]         "name": "rgulistan-wsl11",
[rgulistan-wsl11][DEBUG ]         "rank": 0
[rgulistan-wsl11][DEBUG ]       }
[rgulistan-wsl11][DEBUG ]     ]
[rgulistan-wsl11][DEBUG ]   },
[rgulistan-wsl11][DEBUG ]   "name": "rgulistan-wsl11",
[rgulistan-wsl11][DEBUG ]   "outside_quorum": [],
[rgulistan-wsl11][DEBUG ]   "quorum": [
[rgulistan-wsl11][DEBUG ]     0
[rgulistan-wsl11][DEBUG ]   ],
[rgulistan-wsl11][DEBUG ]   "rank": 0,
[rgulistan-wsl11][DEBUG ]   "state": "leader",
[rgulistan-wsl11][DEBUG ]   "sync_provider": []
[rgulistan-wsl11][DEBUG ] }
[rgulistan-wsl11][DEBUG ]
********************************************************************************
[rgulistan-wsl11][INFO  ] monitor: mon.rgulistan-wsl11 is running
[rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
--admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
[ceph_deploy.mon][INFO  ] processing monitor mon.rgulistan-wsl11
[rgulistan-wsl11][DEBUG ] connection detected need for sudo
[rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
[rgulistan-wsl11][INFO  ] Running command: sudo ceph --cluster=ceph
--admin-daemon /var/run/ceph/ceph-mon.rgulistan-wsl11.asok mon_status
[ceph_deploy.mon][INFO  ] mon.rgulistan-wsl11 monitor has reached quorum!
[ceph_deploy.mon][INFO  ] all initial monitors are running and have
formed quorum
[ceph_deploy.mon][INFO  ] Running gatherkeys...
[ceph_deploy.gatherkeys][DEBUG ] Checking rgulistan-wsl11 for
/etc/ceph/ceph.client.admin.keyring
[rgulistan-wsl11][DEBUG ] connection detected need for sudo
[rgulistan-wsl11][DEBUG ] connected to host: rgulistan-wsl11
[rgulistan-wsl11][DEBUG ] detect platform information from remote host
[rgulistan-wsl11][DEBUG ] detect machine type
[rgulistan-wsl11][DEBUG ] fetch remote file
[ceph_deploy.gatherkeys][WARNIN] Unable to find
/etc/ceph/ceph.client.admin.keyring on rgulistan-wsl11
[ceph_deploy][ERROR ] KeyNotFoundError: Could not find keyring file:
/etc/ceph/ceph.client.admin.keyring on host rgulistan-wsl11





On Sat, May 2, 2015 at 1:58 PM, Venkateswara Rao Jujjuri
<jujjuri@gmail.com> wrote:
> Started to install basic cluster from scratch, but running into keyring issues.
> Basically /etc/ceph/ceph.client.admin.keyring is not getting generated
> on monitor node.
> When I tried to create it on the monitor node, it fails with:
>
> $ ceph auth get-or-create client.admin mon 'allow *' mds 'allow *' osd
> 'allow *' -o /etc/ceph/ceph.client.admin.keyring
> 2015-05-02 12:32:59.198588 7f0e30395700 -1 monclient(hunting): ERROR:
> missing keyring, cannot use cephx for authentication
> 2015-05-02 12:32:59.198592 7f0e30395700  0 librados: client.admin
> initialization error (2) No such file or directory
> Error connecting to cluster: ObjectNotFound
>
>
> $ ceph --version
> ceph version 0.94.1 (e4bfad3a3c51054df7e537a724c8d0bf9be972ff)
>
>
> Following these insructions:
>
> http://docs.ceph.com/docs/master/start/quick-ceph-deploy/
>
> Failing at :
>
> $ ceph-deploy  mon create-initial
> because it could not find /etc/ceph/ceph.client.admin.keyring
>
> Help appreciated.
> --
> Jvrao
> ---
> First they ignore you, then they laugh at you, then they fight you,
> then you win. - Mahatma Gandhi



-- 
Jvrao
---
First they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
