From: chris holcombe <chris.holcombe@canonical.com>
Subject: Re: Encryption for data at rest support
Date: Thu, 2 Jun 2016 05:31:26 -0700
Message-ID: <5750271E.10102@canonical.com>
References: <CANA9Uk6d+MTomL+7rQzRVUHHLWpE_WyEVL5BzpNRLrn-Xe8zJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33707 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbcFBMbv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 08:31:51 -0400
Received: by mail-pa0-f46.google.com with SMTP id um11so5608244pab.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jun 2016 05:31:50 -0700 (PDT)
In-Reply-To: <CANA9Uk6d+MTomL+7rQzRVUHHLWpE_WyEVL5BzpNRLrn-Xe8zJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi Swami,

Yes ceph supports encryption at rest using dmcrypt.  The docs are here:
http://docs.ceph.com/docs/jewel/rados/deployment/ceph-deploy-osd/

My team has integrated this functionality into the ceph-osd charm also
if you'd like to try that out: https://jujucharms.com/ceph-osd/xenial/2
When combined with the ceph-mon charm you're up and running fast :)

-Chris

On 06/02/2016 03:57 AM, M Ranga Swami Reddy wrote:
> Hello,
> 
> Can you please share if the ceph supports the "data at rest" functionality?
> If yes, how can I achieve this? Please share any docs available.
> 
> Thanks
> Swami
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
