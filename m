From: Christian Brunner <chb@muc.de>
Subject: Re: is RBD supported in qemu 0.13?
Date: Wed, 20 Oct 2010 18:10:53 +0200
Message-ID: <20101020161053.GB31437@dell.home>
References: <AANLkTi=qDtHgyD83uwqWOv+Qkk2qbqPXc8bmXKKua+aJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54449 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0JTOIL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 10:08:11 -0400
Received: by gyg13 with SMTP id 13so38690gyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Oct 2010 07:08:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=qDtHgyD83uwqWOv+Qkk2qbqPXc8bmXKKua+aJ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

The patch has not yet been accepted by the qemu-kvm maintainers, so
the driver is not included in qemu 0.13.

We have submited an updated patch to the qemu list, but there was
no feedback.

Regards,
Christian

On Wed, Oct 20, 2010 at 04:22:58PM +0800, Xiaoguang Liu wrote:
> just saw qemu 0.13 released, but without a change log. wondering if
> RBD patch included in this release. since Ceph website said "The
> qemu/kvm patches will likely be included in the next major qemu
> release."
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
