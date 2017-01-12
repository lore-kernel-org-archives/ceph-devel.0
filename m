From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: [ceph-users] RBD v1 image format ...
Date: Thu, 12 Jan 2017 12:43:12 +0900
Message-ID: <CAHX7ARtB=TqykS0jxUBNBdW0+kS+=rbxXPn7kSAm4r7X+wuWoQ@mail.gmail.com>
References: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
 <20170112122858.04de2897@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35182 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdALDnN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2017 22:43:13 -0500
Received: by mail-qk0-f182.google.com with SMTP id u25so8119220qki.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2017 19:43:13 -0800 (PST)
In-Reply-To: <20170112122858.04de2897@batzmaru.gol.ad.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Balzer <chibi@gol.com>
Cc: Jason Dillaman <jdillama@redhat.com>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 12, 2017 at 12:28 PM, Christian Balzer <chibi@gol.com> wrote:
>
> Hello,
>
> On Wed, 11 Jan 2017 11:09:46 -0500 Jason Dillaman wrote:
>
>> I would like to propose that starting with the Luminous release of Ceph,
>> RBD will no longer support the creation of v1 image format images via the
>> rbd CLI and librbd.
>>
>> We previously made the v2 image format the default and deprecated the v1
>> format under the Jewel release. It is important to note that we would still
>> support the use of v1 images by the CLI, VMs, etc for Luminous.
>>
>> Any objections or concerns?
>>
> As with the "deprecation" of v1, a transparent and non-downtime conversion
> tool from v1 to v2 would significantly reduce the number of people who are
> likely to take issue with this

 +2
 * Reduce manual operation as much as possible.
 * A recovery tool in case that we break something which would not
appear to us initially.

>
> Christian
> --
> Christian Balzer        Network/Systems Engineer
> chibi@gol.com           Global OnLine Japan/Rakuten Communications
> http://www.gol.com/
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
