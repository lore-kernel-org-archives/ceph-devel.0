From: Karsten Heymann <karsten.heymann@gmail.com>
Subject: Re: [ceph-users] v10.2.1 Jewel released
Date: Tue, 17 May 2016 07:14:40 +0200
Message-ID: <CAL017hCBz01LFsg4PbVtPwdbQs=WL=qEw_GGmO5sHE4SUC+9hg@mail.gmail.com>
References: <alpine.DEB.2.11.1605160910080.2730@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35441 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcEQFPL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2016 01:15:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so1656650wme.2
        for <ceph-devel@vger.kernel.org>; Mon, 16 May 2016 22:15:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605160910080.2730@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

Hi Sage,

the updated debian packages are *still* missing ceph-{mon,osd}.target.
Was it intentional to release the point release without the fix?

root@ceph-cap1-01:~# apt-show-versions | grep ^ceph | sort
ceph:amd64/jessie 10.2.1-1~bpo80+1 uptodate
ceph-base:amd64/jessie 10.2.1-1~bpo80+1 uptodate
ceph-common:amd64/jessie 10.2.1-1~bpo80+1 uptodate
ceph-dash:all 0.1 installed: No available version in archive
ceph-deploy:all/jessie 1.5.33 uptodate
ceph-fs-common:amd64/jessie 10.2.1-1~bpo80+1 uptodate
ceph-fuse:amd64/jessie 10.2.1-1~bpo80+1 uptodate
ceph-mds:amd64/jessie 10.2.1-1~bpo80+1 uptodate
ceph-mon:amd64/jessie 10.2.1-1~bpo80+1 uptodate
ceph-osd:amd64/jessie 10.2.1-1~bpo80+1 uptodate
root@ceph-cap1-01:~# dpkg -S /lib/systemd/system/ceph*target
dpkg-query: no path found matching pattern /lib/systemd/system/ceph-mon.target
dpkg-query: no path found matching pattern /lib/systemd/system/ceph-osd.target
ceph-common: /lib/systemd/system/ceph.target
root@ceph-cap1-01:~# grep ceph-mon.target /lib/systemd/system/ceph*
/lib/systemd/system/ceph-mon@.service:PartOf=ceph-mon.target
/lib/systemd/system/ceph-mon@.service:WantedBy=ceph-mon.target
root@ceph-cap1-01:~# grep ceph-osd.target /lib/systemd/system/ceph*
/lib/systemd/system/ceph-osd@.service:PartOf=ceph-osd.target
/lib/systemd/system/ceph-osd@.service:WantedBy=ceph-osd.target

Relevant PR: https://github.com/ceph/ceph/pull/8815

Best regards
Karsten

2016-05-16 15:11 GMT+02:00 Sage Weil <sage@redhat.com>:
> This is the first bugfix release for Jewel. It contains several annoying
> packaging and init system fixes and a range of important bugfixes across
> RBD, RGW, and CephFS.
>
> We recommend that all v10.2.x users upgrade.
>
> For more detailed information, see the release notes at
>
>         http://docs.ceph.com/docs/master/release-notes/#v10-2-1-jewel
>
> or the complete changelog at
>
>         http://docs.ceph.com/docs/master/_downloads/v10.2.1.txt
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-10.2.1.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
