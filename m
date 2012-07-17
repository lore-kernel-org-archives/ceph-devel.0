From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: snapshot storage use
Date: Tue, 17 Jul 2012 11:17:56 -0700
Message-ID: <5005AC54.6030708@inktank.com>
References: <CACkq2motpiYUmTNNJjFe-H0ZS95CaArz16MXMFxuqGHZ24Kt5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:44078 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab2GQSUO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 14:20:14 -0400
Received: by ghrr11 with SMTP id r11so702252ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 11:20:14 -0700 (PDT)
In-Reply-To: <CACkq2motpiYUmTNNJjFe-H0ZS95CaArz16MXMFxuqGHZ24Kt5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 07/17/2012 11:11 AM, Travis Rhoden wrote:
> Hey folks,
>
> Sorry if this info is covered elsewhere -- I searched but was unable
> to find a description of what I wanted.
>
> Roughly how much storage is used by snapshots?  Is it really just
> marking the version of certain objects, such that multiple snapshots
> of the same (unchanged) object consume essentially no new space?
> Correspondingly, once that object is finally modified, it is copied
> and the snapshots still point to the original (old) copy?  Is this
> done by using hardlinks or some other method?

Yes, snapshots are copy-on-write at the object level. On the osd, this
is either an efficient clone (btrfs) or a full copy of the object 
(non-btrfs).

>
> Just wanted the 10,000 foot view explanation.  =)
>
> Thanks,
>
>   - Travis
