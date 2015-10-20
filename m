From: Alfredo Deza <adeza@redhat.com>
Subject: Package requirements for upcoming Infernalis Repository
Date: Tue, 20 Oct 2015 09:17:14 -0400
Message-ID: <CAC-Np1yPTLJTRfX1N0hF=QxAw=N+aoGZ0FPgyAB5-UivfCooDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38684 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbJTNRQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 09:17:16 -0400
Received: by wicll6 with SMTP id ll6so28029552wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2015 06:17:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I am in the process of getting the new Infernalis repository and going
over the notes I had when
the Hammer repository was created includes a few packages that didn't
come from a Ceph build and had to be added manually.

I don't know which of these packages are still needed for Infernalis,
so hopefully someone on this list can help rule out the ones that are
no longer needed:

* xfsprogs
* snappy
* snappy-devel
* leveldb
* leveldb-dev
* gperftools
* gdisk
* fcgi
* curl
* libcurl
* libleveldb
* snappy
* python-requests
* urllib3

*Hopefully* we don't need any of these anymore. Any help would be great.

Thanks,


Alfredo
