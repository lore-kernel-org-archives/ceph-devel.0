From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-post-file : Permission denied (publickey).
Date: Wed, 2 Nov 2016 13:26:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611021325480.20331@piezo.us.to>
References: <89b95e99-73e5-474e-df5f-cbd7927924ed@epfl.ch> <20161028021506.GE6026@rskikr.localdomain> <7f4235ea-9a4b-66db-3e49-7be4b526513d@epfl.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752546AbcKBN0L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 2 Nov 2016 09:26:11 -0400
In-Reply-To: <7f4235ea-9a4b-66db-3e49-7be4b526513d@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yoann Moulin <yoann.moulin@epfl.ch>
Cc: Brad Hubbard <bhubbard@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 2 Nov 2016, Yoann Moulin wrote:
> Hello,
> 
> >> I tried to upload files with ceph-post-file but got "Permission denied (publickey)."
> >>
> >>> $ ceph-post-file 17180.tgz
> >>> args: -- 17180.tgz
> >>> /usr/bin/ceph-post-file: upload tag 60a84fdd-b9e9-42cb-817e-5a90e0f9bcf0
> >>> /usr/bin/ceph-post-file: user: yoann@kveikur
> >>> /usr/bin/ceph-post-file: will upload file 17180.tgz
> >>> Permission denied (publickey).
> >>> Couldn't read packet: Connection reset by peer
> >>
> >> do I need to set anything on my side to be able to upload file with this command ?
> > 
> > $ ./bin/ceph-post-file test_file
> > args: -- test_file
> > ./bin/ceph-post-file: upload tag eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2
> > ./bin/ceph-post-file: user: brad@localhost
> > ./bin/ceph-post-file: will upload file test_file
> > sftp> mkdir post/eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2_brad@localhost_38cc969c-04af-4d5b-b862-ec9d594d3a3c
> > sftp> cd post/eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2_brad@localhost_38cc969c-04af-4d5b-b862-ec9d594d3a3c
> > sftp> put /tmp/tmp.1biVN9avrx user
> > sftp> put test_file
> > ./bin/ceph-post-file: copy the upload id below to share with a dev:
> > 
> > ceph-post-file: eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2
> > 
> > You can test connectivity with something like the following.
> > 
> > $ sftp -o "IdentityFile=../share/id_rsa_drop.ceph.com" -C -oCheckHostIP=no -oGlobalKnownHostsFile=../share/known_hosts_drop.ceph.com -oBatchMode=no -oIdentitiesOnly=yes -- postfile@drop.ceph.com
> > Connected to drop.ceph.com.
> > sftp>
> 
> Finally I found time to look on why it wasn't working, I only had the dsa key, I grab the rsa key from git and change the path in the
> ceph-post-file from dsa to rsa and it works

Ah.  Is this hammer or jewel?  We should backport the new key.

Thanks!
sage
