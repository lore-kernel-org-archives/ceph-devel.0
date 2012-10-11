From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Wed, 10 Oct 2012 18:36:40 -0700
Message-ID: <CAPrxi58zNBQtaaMP=1TuRgy81w=bxm5G6CWQ30SdyNx7tixEhw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53641 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933446Ab2JKBgl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 21:36:41 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2134836iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 18:36:40 -0700 (PDT)
In-Reply-To: <1349916817.25403.1.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: James Page <james.page@ubuntu.com>, Sage Weil <sage@inktank.com>, Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Oct 10, 2012 at 5:53 PM, Laszlo Boszormenyi (GCS) <gcs@debian.hu> wrote:
> Hi Noah,
>
> On Wed, 2012-10-10 at 15:00 -0700, Noah Watkins wrote:
>> Laszlo, James:
>>
>> Changes based on your previous feedback are ready for review. I pushed the changes here:
>>
>>   git://github.com/noahdesu/ceph.git wip-java-cephfs
>  Checking only the diff, as it's 3 am here. It looks quite OK. But will
> check it further in the afternoon.

Ok, great. The one thing I was most curious about is if the ceph.jar
reference in debian/libceph-java.jlibs is correct. Previously I was
able to reference its installation path within debian/tmp
(usr/lib/ceph.jar), but jh_installlibs was only able to find the jar
when I referenced its build location (src/java/ceph.jar).

Thanks!

>
> Laszlo/GCS
>
