From: Jeff Cody <jcody@redhat.com>
Subject: Re: [RFC v6] RBD: Add support readv,writev for rbd
Date: Thu, 23 Feb 2017 22:52:36 -0500
Message-ID: <20170224035236.GB2613@localhost.localdomain>
References: <20170221065003.26103-1-jazeltq@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdBXDwi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Feb 2017 22:52:38 -0500
Content-Disposition: inline
In-Reply-To: <20170221065003.26103-1-jazeltq@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jazeltq@gmail.com
Cc: jdurgin@redhat.com, dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, tianqing <tianqing@unitedstack.com>

On Tue, Feb 21, 2017 at 02:50:03PM +0800, jazeltq@gmail.com wrote:
> From: tianqing <tianqing@unitedstack.com>
> 
> Rbd can do readv and writev directly, so wo do not need to transform
> iov to buf or vice versa any more.
> 
> Signed-off-by: tianqing <tianqing@unitedstack.com>
> ---


This is marked as an RFC still - is this a series you would like to see in
2.9?
