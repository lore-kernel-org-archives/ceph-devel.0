From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: rgw: possibility to put several small S3 objects into single
 rados object
Date: Thu, 21 Dec 2017 11:43:39 -0500
Message-ID: <CAKOnark-pBVHnXTTZ4-Hb6NbsKLPCm2fT-CmFHw-jLwCHRcXsQ@mail.gmail.com>
References: <094c2abd-b861-3fcd-7b5c-176d23beed0c@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:39207 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdLUQnk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Dec 2017 11:43:40 -0500
Received: by mail-io0-f172.google.com with SMTP id g70so9120710ioj.6
        for <ceph-devel@vger.kernel.org>; Thu, 21 Dec 2017 08:43:40 -0800 (PST)
In-Reply-To: <094c2abd-b861-3fcd-7b5c-176d23beed0c@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Alex,

Certainly it cannot do so now.  This detail would I guess need to be
represented in the RGW object's manifest.  I'm not convinced it would
be helpful in a near time frame, though?

Matt

On Thu, Dec 21, 2017 at 11:35 AM, Aleksei Gutikov
<aleksey.gutikov@synesis.ru> wrote:
> Hi all.
>
> While rgw bucket index, theoretically, with reasonable latency can handle up
> to 10M objects (100 shards of 100k each),
> and rgw user's bucket index can handle, theoretically again, up to 100k
> buckets.
>
> Radosgw can split huge s3 objects into several rados objects.
> Can it on the other hand put several small files into one rados object?
>
> Is there any design restrictions that will not allow to implement it?
> For example add offset field to index omap record and manage pool of
> opened containter objects for parallel small put requests.
>
> Main advantage, as I understand, would be significant decrease of the rados
> re-balancing time in case of large amount of small s3 objects.
> And, also, smaller space overhead.
>
> Or, maybe it is possible to store small pieces of data in omap?
> As I understand space overhead would be much smaller in this case.
> And what about backfilling and remapping for omap?
>
>
> Thanks
>
> --
>
> Best regards,
> Aleksei Gutikov
> Software Engineer | synesis.ru | Minsk. BY
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
