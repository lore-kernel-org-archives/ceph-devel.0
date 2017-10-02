From: Loic Dachary <ldachary@redhat.com>
Subject: Re: "tobe" and "ready" in ceph-disk source
Date: Mon, 2 Oct 2017 15:42:20 +0200
Message-ID: <c08b3f45-7ab6-711d-aae5-dce053938cbd@redhat.com>
References: <CAJE9aOOY4Bj-y-fATOeXS3ps5M3mhaypmAUYv=4SaduexN9Znw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdJBNmX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 2 Oct 2017 09:42:23 -0400
In-Reply-To: <CAJE9aOOY4Bj-y-fATOeXS3ps5M3mhaypmAUYv=4SaduexN9Znw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Kefu,

On 09/22/2017 02:49 PM, kefu chai wrote:
> hi Loic,
>
> while ready the source of ceph-disk, i found the "tobe" and "ready"
> are confusing, why do we need them, instead of just using a single
> ptype? why creating some block partition is atomic, while creating
> some others is not?
>
> could you please shed some insights on it?
>
In the case of a journal, it is enough to create the partition with the appropriate type and it is ready to be used by ceph-osd. For a data partition, there is an intermediate step: creating the file system and populating it with the required files.

Does that answer your question ? If not I'd be happy to explain further.

Cheers

