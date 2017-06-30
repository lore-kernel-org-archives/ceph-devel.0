From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Fri, 30 Jun 2017 09:41:43 -0400
Message-ID: <214435da-9714-7929-00a0-3e9235c6d833@suse.com>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
 <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
 <3822b2e0-69b2-1213-ff9e-bb5f576dc43f@suse.com>
 <alpine.DEB.2.11.1706292117250.3424@piezo.novalocal>
 <ff5f4540-a99c-a7ab-db5c-02ee3e289f0d@suse.com>
 <72854a7f-2441-b940-c10f-b71cb65600d6@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54080 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdF3Nl6 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 30 Jun 2017 09:41:58 -0400
In-Reply-To: <72854a7f-2441-b940-c10f-b71cb65600d6@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Igor,

On 06/30/2017 09:32 AM, Igor Fedotov wrote:
> AFAIR I observed the issue for tcmalloc as well. There is a
> corresponding note in the ticket..

Yes I did see the note, but I wasn't able to reproduce the issue with
Ceph so I couldn't confirm the status with regard to tcmalloc + Ceph.
I'm about to try the workload that Sage suggested. If you have some
instructions on how to reproduce the problem, it would be great!

Mohamad

