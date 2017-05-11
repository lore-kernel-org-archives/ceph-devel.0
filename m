From: Matthew Vernon <mv3@sanger.ac.uk>
Subject: Re: [Ceph-ansible] EXT: Re: EXT: Re: osd-directory scenario is used
 by us
Date: Thu, 11 May 2017 09:41:07 +0100
Message-ID: <b56c9d1d-07c3-2b50-fffc-fabbc86d75a8@sanger.ac.uk>
References: <C7677170-0BA7-4310-B25B-CC3006517D2D@walmart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.sanger.ac.uk ([193.62.202.243]:39616 "EHLO
        smtp.sanger.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932258AbdEKI5A (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 04:57:00 -0400
In-Reply-To: <C7677170-0BA7-4310-B25B-CC3006517D2D@walmart.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Warren Wang - ISD <Warren.Wang@walmart.com>, Gregory Meno <gmeno@redhat.com>, Michael Gugino <Michael.Gugino@walmart.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users-bounces@lists.ceph.com>
Cc: "ceph-ansible@lists.ceph.com" <ceph-ansible@lists.ceph.com>, Sebastien Han <shan@redhat.com>

On 08/05/17 04:57, Warren Wang - ISD wrote:

> A little extra background here. If Ceph directly supported LVM
> devices as OSDs, we probably wouldn’t have to do what we’re doing
> now.  We don’t know of a way to be able to use LVM cache device as an
> OSD without this type of config. This is primarily to support big
> data workloads that use object storage as the only backing storage.
> So the type of IO that we see is highly irregular, compared to most
> object storage workloads.

This is probably a stupid question, but does using your NVMe as ceph 
journals (which is what we do) not do the same sort of job as LVM cache 
devices?

Regards,

Matthew


-- 
 The Wellcome Trust Sanger Institute is operated by Genome Research 
 Limited, a charity registered in England with number 1021457 and a 
 company registered in England with number 2742969, whose registered 
 office is 215 Euston Road, London, NW1 2BE. 
