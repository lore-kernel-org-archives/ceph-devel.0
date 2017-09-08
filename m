From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: [ceph-users] Ceph release cadence
Date: Fri, 8 Sep 2017 23:12:45 +0800
Message-ID: <CAEYCsV+4iFCTsufxvJzSU77dd5ZACJ4+jpdFM2fRY6eGEtq1=g@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal> <f939c8a1-2fca-f66f-51b3-048ae0afce18@sanger.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34251 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbdIHPMr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Sep 2017 11:12:47 -0400
Received: by mail-oi0-f66.google.com with SMTP id a197so1996965oib.1
        for <ceph-devel@vger.kernel.org>; Fri, 08 Sep 2017 08:12:46 -0700 (PDT)
In-Reply-To: <f939c8a1-2fca-f66f-51b3-048ae0afce18@sanger.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Vernon <mv3@sanger.ac.uk>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, ceph-users <ceph-users@ceph.com>

It is not because user want to skip odd release, it just we usually
land major and important feature to even release:)

We have several large ceph cluster starting from Firefly Although in
practice we only use LTS release but it is not because we bias LTS
release, just the timeline is a little bit misleading...  Lets use
kraken as an example , it is out on late jan , when I deciding whether
to upgrade all cluster to kraken,  the timeline said Luminous will be
out on April, although from the community activity it doesn't looks
like it, but in all public presentation we(the community) were
releasing the same information.

Considering the effort of  pre-production test and rolling upgrade
usually take half a month, we decide to skip kraken and wait for
another 3 month(but actually 8 months).

Rethinking about it now,  if  either

1) community re-adjust the release timeline in Jun, postpone Luminous
to August , we will do the upgrade.
2) some important features first ready in Kraken( Multi-mds,
Bluestore, EC overwrite), we will also do the upgrade.

But both are not true.




2017-09-08 17:20 GMT+08:00 Matthew Vernon <mv3@sanger.ac.uk>:
> Hi,
>
> On 06/09/17 16:23, Sage Weil wrote:
>
>> Traditionally, we have done a major named "stable" release twice a year,
>> and every other such release has been an "LTS" release, with fixes
>> backported for 1-2 years.
>
> We use the ceph version that comes with our distribution (Ubuntu LTS);
> those come out every 2 years (though we won't move to a brand-new
> distribution until we've done some testing!). So from my POV, LTS ceph
> releases that come out such that adjacent ceph LTSs fit neatly into
> adjacent Ubuntu LTSs is the ideal outcome. We're unlikely to ever try
> putting a non-LTS ceph version into production.
>
> I hope this isn't an unusual requirement :)
>
> Matthew
>
>
> --
>  The Wellcome Trust Sanger Institute is operated by Genome Research
>  Limited, a charity registered in England with number 1021457 and a
>  company registered in England with number 2742969, whose registered
>  office is 215 Euston Road, London, NW1 2BE.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
