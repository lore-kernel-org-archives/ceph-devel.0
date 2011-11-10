From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Crowbar barclamp for Ceph pushed to Github
Date: Thu, 10 Nov 2011 15:22:41 -0800
Message-ID: <CAORUGqCzSQgGOfo2E-aYy-3wvHEwdRaAsWi3XOeTSQ3zSADkYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51323 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab1KJXXF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Nov 2011 18:23:05 -0500
Received: by wwe5 with SMTP id 5so461038wwe.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Nov 2011 15:23:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, crowbar@lists.us.dell.com

[Cross-posted to ceph-devel and the crowbar mailing list]

Hi. I've been working on a Ceph (the unified storage system) barclamp
for Crowbar (the bare-metal deployment system). I just pushed the work
to Github, the relevant repositories are:

  https://github.com/NewDreamNetwork/barclamp-ceph
  https://github.com/NewDreamNetwork/ceph-cookbooks

ceph-cookbooks is the Ceph cookbooks for standalone Chef
installations; barclamp-ceph uses ceph-cookbooks as a submodule. To
get the submodule activated, clone the repository like this:

  git clone --recursive https://github.com/NewDreamNetwork/barclamp-ceph.git


The work was tested with the Crowbar 1.1beta3 ISO, as available from
http://crowbar.zehicle.com/crowbar111014.iso .
On top of that, the following commands need to be run (in addition to
installing the barclamp itself):

--8<--
v=0.37-1maverick
for p in ceph ceph-fuse ceph-common librados2 librbd1 libcephfs1 ceph-dbg; do
  wget -nc --progress=dot:mega --directory-prefix=pkgs
"http://ceph.newdream.net/debian/pool/main/c/ceph/${p}_${v}_amd64.deb"
done

# TODO missing because dvd does not include "universe"?
wget -nc --progress=dot:mega --directory-prefix=pkgs \
	http://archive.ubuntu.com/ubuntu/pool/universe/libc/libcrypto++/libcrypto++8_5.6.0-5_amd64.deb
\
	http://archive.ubuntu.com/ubuntu/pool/universe/g/google-perftools/libgoogle-perftools0_1.5-1_amd64.deb
\
	http://archive.ubuntu.com/ubuntu/pool/universe/g/google-perftools/libtcmalloc-minimal0_1.5-1_amd64.deb
\
	http://archive.ubuntu.com/ubuntu/pool/universe/libu/libunwind/libunwind7_0.99-0.2ubuntu1_amd64.deb

dpkg-scanpackages pkgs /dev/null 2>/dev/null | gzip -9 >Packages.gz
--8<--

I would welcome feedback from the Crowbar community on how this can be
made simpler; it seems the crowbar.yml "debs" and "gems" sections are
for the ISO building process, and are not looked at when installing
barclamps.

Also any feedback on the barclamp code itself is most welcome.

The cookbooks themselves are work in progress, and should be taken as
such. There are significant limitations in their current
functionality, such as only supporting a single monitor, and not
leveraging multiple disks for storage. Watch the repository on Github
to be notified of future improvements.


In testing the barclamp, I ran into the following recurring Crowbar
issues. Any light on them would be welcome:

1. Crowbar's "sudo ./install" call must not use an existing domain, as
it will hijack DNS for that domain completely.

2. Sometimes in the debian-installer, a progress bar would freeze
until keyboard input was seen. For example, last night I had the
"Installing the base system" portion stay at something like 39% the
whole night; in the morning, I hit arrow-down and the percentage
started increasing again.

3. Sometimes some of the recipes seem to not get called, or fail
silently; for example, I just fought with a vm that was missing the
/etc/apt/apt.conf file, and thus refused to install packages from
unsigned sources, failing the chef-client run at ipmitool install
time. I managed to see the same problem on repeat runs.


Background material, in case it is needed because of the cross-posted
nature of this message :
Crowbar itself is at https://github.com/dellcloudedge/crowbar
For more on Ceph, see http://ceph.newdream.net/
