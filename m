From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Object Write Latency
Date: Tue, 24 Sep 2013 11:13:37 +0200
Message-ID: <CABZ+qq=Pj0oQ3nUUh3T_mTnpXSUd93uLzX955bHx6MY+fek9YQ@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
 <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
 <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com> <alpine.DEB.2.00.1309231115520.7394@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:46185 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab3IXJOT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 05:14:19 -0400
Received: by mail-bk0-f53.google.com with SMTP id d7so1566654bkh.26
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 02:14:18 -0700 (PDT)
Received: by mail-lb0-f176.google.com with SMTP id y6so3558085lbh.35
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 02:14:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309231115520.7394@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 23, 2013 at 8:18 PM, Sage Weil <sage@inktank.com> wrote:
> You
> might try measuring that directly and comparing it to the 33ms
> append+fsync that you previously saw.

dd with fsync is quite slow...

[root@p05151113777233 fio]# time dd if=/dev/zero
of=/var/lib/ceph/osd/osd.1045/testtest bs=5 count=1
1+0 records in
1+0 records out
5 bytes (5 B) copied, 8.884e-05 s, 56.3 kB/s

real 0m0.001s
user 0m0.000s
sys 0m0.001s


[root@p05151113777233 fio]# time dd if=/dev/zero
of=/var/lib/ceph/osd/osd.1045/testtest bs=5 count=1 conv=fsync
1+0 records in
1+0 records out
5 bytes (5 B) copied, 0.0435103 s, 0.1 kB/s

real 0m0.045s
user 0m0.001s
sys 0m0.001s
