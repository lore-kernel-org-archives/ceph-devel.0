From: Mykola Golub <trociny@FreeBSD.org>
Subject: Re: [sepia] how to use teuthology-suite in the new world
Date: Thu, 15 Dec 2016 17:00:27 +0200
Message-ID: <20161215150026.GB1451@gmail.com>
References: <alpine.DEB.2.11.1612142211440.10615@piezo.novalocal>
 <20161215145143.GA1451@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33958 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbcLOPAa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2016 10:00:30 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so10187040wjc.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2016 07:00:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161215145143.GA1451@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, "sepia@ceph.com" <sepia@ceph.com>

On Thu, Dec 15, 2016 at 04:51:44PM +0200, Mikolaj Golub wrote:
> Hi, Sage,
> 
> It looks like we still need to push testing branches to ceph.git for
> things like below?
> 
> qa/workunits/rbd/test_librbd_python.sh:
> 
> wget -O test_rbd.py "https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=$CEPH_REF;f=src/test/pybind/test_rbd.py" || \
>     wget -O test_rbd.py "https://git.ceph.com/?p=ceph.git;a=blob_plain;hb=ref/heads/$CEPH_REF;f=src/test/pybind/test_rbd.py"
> 
> Do we have some env variable (CEPH_REPO?) we could use simirlaly to
> CEPH_REF here?

Or rather may be now we can avoid such hacks at all?

-- 
Mykola Golub
