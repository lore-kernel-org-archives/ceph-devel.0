From: Alfredo Deza <adeza@redhat.com>
Subject: Re: can we stop packaging sysvinit scripts?
Date: Wed, 10 Jan 2018 11:46:00 -0500
Message-ID: <CAC-Np1y9g5fcxQctMbRTJ4nyZUjS-k9hh=CttaB9xRdtba1sUw@mail.gmail.com>
References: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal> <b6b69060-2424-5404-cdf0-4ca019ec9ead@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:37652 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965367AbeAJQqB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 11:46:01 -0500
Received: by mail-qt0-f177.google.com with SMTP id f2so22789960qtj.4
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 08:46:01 -0800 (PST)
In-Reply-To: <b6b69060-2424-5404-cdf0-4ca019ec9ead@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

On Wed, Jan 10, 2018 at 11:18 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> Am 10.01.2018 um 15:44 schrieb Sage Weil:
>> We've had systemd unit files for several releases now and all major
>> distros are using systemd by default.  Can we stop packaging the sysvinit
>> scripts?
>>
>> I realize that Debian allows you to switch init systems... do any users
>> actually do this?  Is it required that debs include the sysvinit scripts
>> or is there some glue that lets packages avoid maintaining sysvinit
>> scripts?
>>
>> I ask because the init scripts are one of the few remainining bits that
>> use the ceph-conf utility, which I would like to deprecate (and eventually
>> remove).  It parses local config files but we are migrating this to the
>> mon.  We could make ceph-conf pull configs from the mon but I would
>> like to simplify if possible!
>
> We would really appreciate having the init scripts around for a long
> while, as we are not willing to use systemd on our servers for security
> reasons. Please do not drop them.

We no longer test those scripts (someone correct me if I am wrong
here), maybe you could support them out of the ceph tree?

>
> Amon Ott
> --
> Dr. Amon Ott
> m-privacy GmbH           Tel: +49 30 24342334
> Werner-Voß-Damm 62       Fax: +49 30 99296856
> 12101 Berlin             http://www.m-privacy.de
>
> Amtsgericht Charlottenburg, HRB 84946
>
> Geschäftsführer:
>  Dipl.-Kfm. Holger Maczkowsky,
>  Roman Maczkowsky
>
> GnuPG-Key-ID: 0x2DD3A649
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
