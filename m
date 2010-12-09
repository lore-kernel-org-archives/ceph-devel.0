From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 2/2] tests: Add tests for network disks
Date: Thu, 9 Dec 2010 11:10:22 +0000
Message-ID: <20101209111022.GG5142@redhat.com>
References: <20101202131928.GV2502@redhat.com>
 <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
 <4CFE91AD.9050206@hq.newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab0LILKg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Dec 2010 06:10:36 -0500
Content-Disposition: inline
In-Reply-To: <4CFE91AD.9050206@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <joshd@hq.newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org, sheepdog@lists.wpkg.org

On Tue, Dec 07, 2010 at 11:57:33AM -0800, Josh Durgin wrote:
> 
> Signed-off-by: Josh Durgin <joshd@hq.newdream.net>
> ---
>  tests/qemuargv2xmltest.c                           |    3 ++
>  .../qemuxml2argv-disk-drive-network-nbd.args       |    1 +
>  .../qemuxml2argv-disk-drive-network-nbd.xml        |   32 ++++++++++++++++++
>  .../qemuxml2argv-disk-drive-network-rbd.args       |    1 +
>  .../qemuxml2argv-disk-drive-network-rbd.xml        |   34 ++++++++++++++++++++
>  .../qemuxml2argv-disk-drive-network-sheepdog.args  |    1 +
>  .../qemuxml2argv-disk-drive-network-sheepdog.xml   |   32 ++++++++++++++++++
>  tests/qemuxml2argvtest.c                           |    6 +++
>  8 files changed, 110 insertions(+), 0 deletions(-)
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.args
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-nbd.xml
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.args
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-sheepdog.xml

ACK

Daniel
