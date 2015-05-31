From: Gregory Farnum <greg@gregs42.com>
Subject: Nightly "Kernel branch not found" errors
Date: Sun, 31 May 2015 12:54:58 -0700
Message-ID: <CAC6JEv_oJzokLL-QvJ6VTNC43kSp9s4Vf=cY47Ug+Gqy0BBApw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35757 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbbEaTzA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 May 2015 15:55:00 -0400
Received: by qkhq76 with SMTP id q76so45653842qkh.2
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 12:54:59 -0700 (PDT)
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com. [209.85.192.50])
        by mx.google.com with ESMTPSA id c80sm5424835qge.49.2015.05.31.12.54.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 12:54:59 -0700 (PDT)
Received: by qgdy38 with SMTP id y38so17316279qgd.1
        for <ceph-devel@vger.kernel.org>; Sun, 31 May 2015 12:54:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, Zack Cerza <zack@redhat.com>, Andrew Schoen <aschoen@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We are getting this error in what looks like everything that specifies
the testing kernel. (That turns out to be almost all of the FS tests
and a surprising number of the non-rados runs; e.g. rgw.) I've checked
that the testing branch of ceph-client.git still exists and when
looking at the teuthology git logs the recent ping-pong of commits on
kernel flavors et al stand out. Any ideas? :)
-Greg

On Fri, May 29, 2015 at 11:10 PM,  <teuthology@ceph.com> wrote:
> Kernel branch 'testing' not found
> _______________________________________________
> Ceph-qa mailing list
> Ceph-qa@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-qa-ceph.com
