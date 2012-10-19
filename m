From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Fri, 19 Oct 2012 10:27:01 -0700
Message-ID: <CAPrxi58Tizv5EjGjNDn1LGg7N4xV0OtF1hM3LnN2-vVUpyedBQ@mail.gmail.com>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com>
	<alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net>
	<CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com>
	<CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com>
	<alpine.DEB.2.00.1210031238300.23173@cobra.newdream.net>
	<506DF09B.20505@ubuntu.com>
	<1349388042.11633.161.camel@julia>
	<CAPrxi58Cm98s0e1qZUBhsZBVgV2bSEb7cESxHF9Vk1_+QMg=tQ@mail.gmail.com>
	<5075EFF3.9000106@cs.ucsc.edu>
	<1349916817.25403.1.camel@julia>
	<CAPrxi58zNBQtaaMP=1TuRgy81w=bxm5G6CWQ30SdyNx7tixEhw@mail.gmail.com>
	<alpine.DEB.2.00.1210171544340.5342@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64313 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab2JSR1C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Oct 2012 13:27:02 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so745651vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Oct 2012 10:27:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210171544340.5342@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, James Page <james.page@ubuntu.com>, Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Oct 17, 2012 at 3:45 PM, Sage Weil <sage@inktank.com> wrote:
>
> Also, I have one question: this packages up libcephfs bindings in
> libceph-java.  Should that be libcephfs-java, or should be put *all* ceph
> lib bindings in here (libcephfs, librados, librbd)?

Pushed changes that build packages:

  libcephfs-java and libcephfs-jni

to git://github.com/noahdesu/ceph.git wip-java-cephfs

  rebased to master.

- Noah
