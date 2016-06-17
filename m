From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: using discard from qemu guest when snapshot exist, fill the rbd
 layer with zeroes and use more space
Date: Fri, 17 Jun 2016 09:21:53 -0400
Message-ID: <CA+aFP1A9a5ZEUzsJ_4_dRd_Ok7Ob4yk6PjaQNnrwWQbUmK6V3w@mail.gmail.com>
References: <1498621012.13671278.1466154654173.JavaMail.zimbra@oxygem.tv>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35534 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbcFQNVy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 09:21:54 -0400
Received: by mail-pa0-f54.google.com with SMTP id hl6so28595011pac.2
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 06:21:53 -0700 (PDT)
In-Reply-To: <1498621012.13671278.1466154654173.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

There is a "rbd_skip_partial_discard" configuration option which can
be set to true.  When enabled, discard will avoid zeroing holes if the
discard extent is in the middle of an object.

On Fri, Jun 17, 2016 at 5:10 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> Hi,
>
> I'm using fstrim inside my qemu guests to remove unused space from the rbd storage.
>
> This is working fine, but I just notice that if a snapshot exist,
>
> It just do the reverse, it's filling the snasphot with zeroes, and the total cluster space is growing.
>
> It's is possible to avoid that ?
>
>
> Regards,
>
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
