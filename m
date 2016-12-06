From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore with ZS
Date: Tue, 6 Dec 2016 09:53:49 -0600
Message-ID: <ca516a6a-0089-2b7c-95aa-3a21de181f35@redhat.com>
References: <BY2PR02MB39644AE8ABB2551CC39A46AF4820@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751613AbcLFPxw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Dec 2016 10:53:52 -0500
In-Reply-To: <BY2PR02MB39644AE8ABB2551CC39A46AF4820@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Excellent Somnath!

I will attempt to test this today, though I also am going to be looking 
at the new RBD erasure coding stuff so it might be a day or two.

Mark

On 12/06/2016 02:33 AM, Somnath Roy wrote:
> Mark,
> Please find the Bluestore + ZS integrated code synced with today's master in the following location.
>
> https://github.com/somnathr/ceph/tree/wip-bluestore-zs
>
> As discussed in the standup , this is with single kv_sync_thread.
> I am still cleaning up multi kv_sync_thread  version and will send out a pull request for Sage to review hopefully by tomorrow.
>
> Here is the steps you need to follow to use this.
>
> 1.  ./do_cmake.sh -DWITH_ZS=1
>
> 2. make and make install
>
> 3. In the ceph.conf , use the following option.
>
> enable experimental unrecoverable data corrupting features = bluestore zs rocksdb
> bluestore_sync_submit_transaction = false
> bluestore_kvbackend=zs
>
> With smaller volumes you will be seeing rocks outperforming ZS , but, for bigger volumes ZS is catching up fast.
> The code (shim layer and thus BlueStore)  is no way optimally using ZS yet and we are in process of optimizing it further (with multi kv_sync, more batching etc. etc.).
> Will keep community posted on this.
>
> Thanks & Regards
> Somnath
>
>
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
