From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: possible to recover a deleted RBD?
Date: Mon, 10 Sep 2012 17:14:01 -0400
Message-ID: <CACkq2moAA9X_NiE5ppDVw2R=-uwcHYYPJSQ4_igtZpKNO95gqw@mail.gmail.com>
References: <CACkq2moAQhOoSYw2+=d3G7xy-CuKdNFWMirH9KzuwRr7piefGQ@mail.gmail.com>
 <504E54CA.4010200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63585 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab2IJVOW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 17:14:22 -0400
Received: by qcro28 with SMTP id o28so1446797qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 14:14:21 -0700 (PDT)
In-Reply-To: <504E54CA.4010200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

Fair enough, thanks for the response!

On Mon, Sep 10, 2012 at 4:59 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 09/10/2012 01:55 PM, Travis Rhoden wrote:
>>
>> I sheepishly must ask -- is there any way to recover a deleted RBD?
>>
>> The RBD was created using the Linux 3.2 kernel client, running 0.48.1.
>>   Removed with "rbd rm -p rbd <name>".
>>
>> I expect the answer to be no, but wanted to check for sure!
>>
>> Thanks,
>>
>> Travis
>
>
> Short answer: no
>
> Long answer: it may be possible if your cluster was undergoing recovery
> and extra copies of objects are around, but this is unreliable since
> you don't know which objects should be there due to thin-provisioning.
>
> Josh
>
