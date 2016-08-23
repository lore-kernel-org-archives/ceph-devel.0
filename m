From: Mark Nelson <mnelson@redhat.com>
Subject: Re: pg_stat_t is 500+ bytes
Date: Tue, 23 Aug 2016 14:39:46 -0500
Message-ID: <733beb17-d7f2-3a7c-c985-7508389bd373@redhat.com>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbcHWTjt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 15:39:49 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1914A4E4C6
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 19:39:49 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 08/23/2016 01:13 PM, Sage Weil wrote:
> This is huge.  It takes the pg_info_t str from 306 bytes to 847 bytes, and
> this _info omap key is rewritten on *every* IO.
>
> We could shrink this down significant with varint and/or delta encoding
> since a huge portion of it is just a bunch of uint64_t counters.  This
> will probably cost some CPU time, but OTOH it'll also shrink our metadata
> down a fair bit too which will pay off later.

I'm a little nervous given how heavy we are on CPU already for small IO. 
  How often/much of this is empty space?  Could a fast packing 
implementation work here?

>
> Anybody want to tackle this?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
