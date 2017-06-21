From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: RGW: Implement S3 storage class feature
Date: Wed, 21 Jun 2017 10:04:03 -0400 (EDT)
Message-ID: <2035535832.26037779.1498053843582.JavaMail.zimbra@redhat.com>
References: <CAF8OO3Mo3xFbxioTedym+rByF1Eu3kNhHayn9mx1V6N5h-LWbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbdFUOEF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Jun 2017 10:04:05 -0400
In-Reply-To: <CAF8OO3Mo3xFbxioTedym+rByF1Eu3kNhHayn9mx1V6N5h-LWbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jiaying Ren <mikulely@gmail.com>
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Looks very coherent.

My main question is about...

----- Original Message -----
> From: "Jiaying Ren" <mikulely@gmail.com>
> To: "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, June 21, 2017 7:39:24 AM
> Subject: RGW: Implement S3 storage class feature
> 

> 
> * Todo List
> 
> + the head of rgw-object should only contains the metadata of
>   rgw-object,the first chunk of rgw-object data should be stored in
>   the same pool as the tail of rgw-object

Is this always desirable?

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
