From: Dino Yancey <dino2gnt@gmail.com>
Subject: Re: 0.55 in Ceph EL6 repo?
Date: Thu, 6 Dec 2012 14:39:53 -0600
Message-ID: <CA+GnOzRYEPzb9SH202NCEBfQyPLyJRkUJOqrvkBpr3c4N6LGNQ@mail.gmail.com>
References: <CA+GnOzQ0ccjmqOEVXJet0mOZgB4dmpV7-zSYqDUab4it=On=_Q@mail.gmail.com>
	<2B458EA4-7BB6-4956-8C3B-F536876AD668@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52696 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2LFUjx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Dec 2012 15:39:53 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so6431983vcd.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Dec 2012 12:39:53 -0800 (PST)
In-Reply-To: <2B458EA4-7BB6-4956-8C3B-F536876AD668@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel@vger.kernel.org

Ah, okay.

I did not realize that there was more than one location. It might be
handy for the ceph-release RPM package (as mentioned at
http://ceph.com/docs/master/install/rpm/ ) to configure a ceph-testing
repository to provide easy access to the rpm-testing packages as well,
e.g.

[root@hmon001 ~]# cat /etc/yum.repos.d/ceph.repo
[ceph]
name=Ceph
baseurl=http://ceph.com/rpms/el6/$basearch
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CEPH

[ceph-testing]
name=Ceph-Testing
baseurl=http://ceph.com/rpm-testing/el6/$basearch
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CEPH
[root@hmon001 ~]#

Just a thought.

Dino
