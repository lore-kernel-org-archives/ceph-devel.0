From: Jens Rosenboom <j.rosenboom@x-ion.de>
Subject: Re: v10.0.4 released
Date: Wed, 16 Mar 2016 16:10:19 +0100
Message-ID: <CADr68WZJiXKUp_0hD7Apd9zAifU1giAjrt9a+VJt_Knn0wNmLg@mail.gmail.com>
References: <alpine.DEB.2.11.1603081634450.14358@cpach.fuggernut.com>
	<56E95C3C.7080907@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36066 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934998AbcCPPKV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 11:10:21 -0400
Received: by mail-lf0-f54.google.com with SMTP id l83so21617538lfd.3
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 08:10:20 -0700 (PDT)
In-Reply-To: <56E95C3C.7080907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

2016-03-16 14:14 GMT+01:00 Loic Dachary <loic@dachary.org>:
> Hi,
>
> Because of a tiny mistake preventing deb packages to be built, v10.0.5 was released shortly after v10.0.4 and is now the current development release. The Stable release team[0] collectively decided to help by publishing development packages[1], starting with v10.0.5.
>
> The packages for v10.0.5 are available at http://ceph-releases.dachary.org/ which can be used as a replacement for http://download.ceph.com/ for both http://download.ceph.com/rpm-testing and http://download.ceph.com/debian-testing . The only difference is the key used to sign the releases which can be imported with
>
>     wget -q -O- 'http://ceph-releases.dachary.org/release-key.asc' | sudo apt-key add -
>
> or
>
>     rpm --import http://ceph-releases.dachary.org/release-key.asc
>
> The instructions to install development packages found at http://docs.ceph.com/docs/master/install/get-packages/ can otherwise be applied with no change.

Will there be tarballs for 10.0.5? Ubuntu has built native packages
built for the upcoming Xenial LTS release, but IIUC they are still
stuck at 10.0.2 because there are no tarball releases for the newer
tags.
