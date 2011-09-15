From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: RE: mkcephfs giving problems
Date: Thu, 15 Sep 2011 13:11:24 +0200
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D671AA579AF@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
References: <loom.20110915T081127-706@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail3.alcatel.fr ([64.208.49.56]:40090 "EHLO smail3.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933261Ab1IOLUQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 07:20:16 -0400
In-Reply-To: <loom.20110915T081127-706@post.gmane.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

 Try as root.

=>   failed to open log file '/var/log/ceph/osd.0.log': error 13: Permission denied



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org 
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Atish Kathpal
> Sent: donderdag 15 september 2011 8:14
> To: ceph-devel@vger.kernel.org
> Subject: mkcephfs giving problems
> 
> Hello 
> 
> What am I trying? -  To setup single node cluster for Ceph, 
> OSD, MON and MDS on 
> same node.
> OS: Ubuntu 11.04 (natty)
> I installed Ceph following these instructions: 
> =================
> wget -q -O- 
> https://raw.github.com/NewDreamNetwork/ceph/master/keys/release.asc 
> \
> | sudo apt-key add -
> 
> sudo tee /etc/apt/sources.list.d/ceph.list <<EOF
> deb http://ceph.newdream.net/debian/ DISTRO main
> deb-src http://ceph.newdream.net/debian/ DISTRO main
> EOF
> 
> sudo apt-get update
> sudo apt-get install ceph
> =================
> 
> Next I created /etc/ceph.conf file with following contents:
> =========
> [global]
>         auth supported = cephx
>        keyring = /etc/ceph/ceph.keyring
> 
> [mon]
>         mon data = /ceph_data/mon.0
> 
> [mds]
> 
> [osd]
>         osd data = /ceph_data/osd.0
>         osd journal = /ceph_data/osd.0.journal
>         osd journal size = 1000
> 
> [mon.0]
>         host = atish-virtual-machine
>         mon addr = 10.72.147.207:6789
> 
> [osd.0]
>         host = atish-virtual-machine
> 
> [mds.0]
>         host = atish-virtual-machine
> ===========
> 
> Now on running:  mkcephfs -a -c ceph.conf -k ceph.keyring
> 
> I get following output:
> ============
> atish@atish-virtual-machine:/etc/ceph$ mkcephfs -a -c 
> ceph.conf -k ceph.keyring
> temp dir is /tmp/mkcephfs.dh5U7fAf0a
> preparing monmap in /tmp/mkcephfs.dh5U7fAf0a/monmap
> /usr/bin/monmaptool --create --clobber --add 0 
> 10.72.147.207:6789 --print 
> /tmp/mkcephfs.dh5U7fAf0a/monmap
> /usr/bin/monmaptool: monmap file /tmp/mkcephfs.dh5U7fAf0a/monmap
> /usr/bin/monmaptool: generated fsid 
> 0fad0467-bfc6-5063-935b-5abd87dbebd5
> epoch 1
> fsid 0fad0467-bfc6-5063-935b-5abd87dbebd5
> last_changed 2011-09-14 20:09:10.557121
> created 2011-09-14 20:09:10.557121
> 0: 10.72.147.207:6789/0 mon.0
> /usr/bin/monmaptool: writing epoch 1 to 
> /tmp/mkcephfs.dh5U7fAf0a/monmap (1 
> monitors)
> === osd.0 ===
> failed to open log file '/var/log/ceph/osd.0.log': error 13: 
> Permission denied
>  ** WARNING: Ceph is still under development.  Any feedback 
> can be directed  **
>  **          at ceph-devel@vger.kernel.org or 
> http://ceph.newdream.net/.     **
> 2011-09-14 20:09:10.944686 b77d86e0 
> AdminSocketConfigObs::init: failed: 
> AdminSocket::bind_and_listen: failed to bind the UNIX domain 
> socket to 
> '/var/run/ceph/osd.0.asok': error 2: No such file or directory
> 2011-09-14 20:09:10.944701 b77d86e0 AdminSocketConfigObs: 
> failed to start 
> AdminSocket
> 2011-09-14 20:09:10.946025 b77d86e0 
> filestore(/ceph_data/osd.0) FileStore::mkfs: 
> failed to open /ceph_data/osd.0/fsid: error 13: Permission denied
> 2011-09-14 20:09:10.946036 b77d86e0 OSD::mkfs: 
> FileStore::mkfs failed with error 
> -13
> 2011-09-14 20:09:10.946243 b77d86e0  ** ERROR: error creating 
> empty object store 
> in /ceph_data/osd.0: error 13: Permission denied
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.dh5U7fAf0a 
> --init-daemon osd.0'
> atish@atish-virtual-machine:/etc/ceph$
> ================
> 
> Can you please guide me with setting Ceph up correctly? Where 
> have I gone wrong?
> 
> Final aim: I intend to use just the Ceph Object Storage - 
> RASOS - with S3/REST.
> 
> Waiting for reply.
> 
> Regards
> Atish
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 