From: Artur Molchanov <artur.molchanov@synesis.ru>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Mon, 13 Feb 2017 12:54:07 +0300
Message-ID: <e2a7b8c7-a1e7-e280-2ef3-e412c2df9848@synesis.ru>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
 <1486726280.4233.1.camel@redhat.com>
 <CAOi1vP_SJD7Vh97WBU2=EsYfWruXqQe06BND+uaq10=V7ZGH1g@mail.gmail.com>
 <CAOi1vP-1EPasYZUPoqwh1Ykgq59xEAf1oeGZH5Y8Kpo9ooQMow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35400 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbdBMJyK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 04:54:10 -0500
Received: by mail-lf0-f68.google.com with SMTP id v186so7893377lfa.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 01:54:09 -0800 (PST)
In-Reply-To: <CAOi1vP-1EPasYZUPoqwh1Ykgq59xEAf1oeGZH5Y8Kpo9ooQMow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilya,

On 02/13/2017 12:11 PM, Ilya Dryomov wrote:
> Hi Artur,
>
> How about the attached patch?  handle_timeout() is going to iterate
> over all but the homeless OSD anyway; all it costs us is a couple of
> tests, so I don't think a separate work is needed.
>
> abort_request() is a simple wrapper around complete_request(), making
> it safe to call at any time -- replace it with complete_request() for
> now if you want to try this out.

Using one job for sending keepalive requests and completing stuck requests 
brings us to the need to check that osd_keepalive_timeout is not larger then 
osd_request_timeout. So we should not forget to say about it in the documentation.
Is it worth creating a correlation between osd_keepalive_timeout and 
osd_request_timeout?

-- 
Artur
