From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Where does the data go ??
Date: Thu, 24 Sep 2015 11:30:23 -0700
Message-ID: <CAJ4mKGZ9gpDSotB=dU16-sCqYvLcxFODkyPumoxS9-D40uaTtg@mail.gmail.com>
References: <EBFBEFF470372547BAACF06D39FF53A54F58B8B8@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35105 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbIXSaY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 14:30:24 -0400
Received: by wicge5 with SMTP id ge5so264220116wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 11:30:23 -0700 (PDT)
In-Reply-To: <EBFBEFF470372547BAACF06D39FF53A54F58B8B8@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomy Cheru <Tomy.Cheru@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 22, 2015 at 6:58 PM, Tomy Cheru <Tomy.Cheru@sandisk.com> wrote:
> Noticed while benchmarking newstore with rocksdb backend that, the data is missing in "dev/osd0/fragments"
>
>>64k sized objects produces content in above mentioned dir, however missing with <=64k  sized objects
>
> Corresponding drive/s shows activity, .sst files are in "dev/osd0/db" dir
>
> Is it expected behavior ??
>
> Where does the data go ??

Newstore is designed to put large objects and updates in the
filesystem, but to store small objects and overwrites inside of
RocksDB for faster access. You seem to have discovered that from the
other end, but I'd recommend looking at some of the Newstore design
discussions (and documents? I think there are emails and documents) if
you're going to be working with it.
-Greg
