From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: 12.2.2 Luminous validation status
Date: Wed, 15 Nov 2017 18:07:37 -0800
Message-ID: <9162c114-44ea-3153-fc3f-76fbd20e06b4@redhat.com>
References: <CAMMFjmH0-XbJ1P431bErnMS1BEaU3Ln9XhVMPbEte3ixm+YSzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdKPCHi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Nov 2017 21:07:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DA614E341
        for <ceph-devel@vger.kernel.org>; Thu, 16 Nov 2017 02:07:38 +0000 (UTC)
In-Reply-To: <CAMMFjmH0-XbJ1P431bErnMS1BEaU3Ln9XhVMPbEte3ixm+YSzQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/15/2017 02:00 PM, Yuri Weinstein wrote:
> Details of this release summarized here
> http://tracker.ceph.com/issues/21830#note-26

The rados failures are due to a bug in the test fixed by:

https://github.com/ceph/ceph/pull/18808

