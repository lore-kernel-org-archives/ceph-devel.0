From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: Why does Erasure-pool not support omap?
Date: Thu, 26 Oct 2017 13:32:41 -0400
Message-ID: <CAKOnarnmiDeQxWJLRZ7GJc-xdTzxsR-5=AiUxKTUte0h9XxLoQ@mail.gmail.com>
References: <201710251652060421729@zte.com.cn> <alpine.DEB.2.11.1710251213140.22592@piezo.us.to>
 <37aa304a-f13b-2cf8-c5c5-5d03d37feffa@redhat.com> <CAJ4mKGa+Xpt9a2P0y_cz9bohj7R_hP_Ysiar4oqRgW-yWJY+ug@mail.gmail.com>
 <alpine.DEB.2.11.1710261423200.22592@piezo.us.to> <1e168a03-ec8f-36c9-f444-550738f4c0f1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:50055 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdJZRcm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 13:32:42 -0400
Received: by mail-io0-f178.google.com with SMTP id n137so7097842iod.6
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 10:32:42 -0700 (PDT)
In-Reply-To: <1e168a03-ec8f-36c9-f444-550738f4c0f1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Xie Xingguo <xie.xingguo@zte.com.cn>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 26, 2017 at 12:21 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 10/26/2017 07:26 AM, Sage Weil wrote:
>>

>
> If this is only for rbd, we might as well store k+m copies since there's
> so little omap data.
>
> I agree cephfs and rgw continue to refuse to use EC for metadata, since
> their omap use gets far to large and is in the data path.

This highlights, but isn't an answer to the problem.  What RGW
actually has is a split data path, when data is on EC.

Matt

-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
