From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Probable memory leak in Hammer write path ?
Date: Mon, 29 Jun 2015 11:52:54 +0100
Message-ID: <CAC6JEv9sfdLtMKjpSJzRxgOjLOMH-kvj0MtA1i4jnCne4FtStA@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB0142@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36368 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbbF2Kw6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 06:52:58 -0400
Received: by lagc2 with SMTP id c2so4833288lag.3
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 03:52:56 -0700 (PDT)
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com. [209.85.215.42])
        by mx.google.com with ESMTPSA id xl7sm10688715lbb.42.2015.06.29.03.52.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 03:52:55 -0700 (PDT)
Received: by lagh6 with SMTP id h6so48648602lag.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 03:52:54 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDB0142@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm confused. Changing the kernel you're using is changing the
apparent memory usage of a userspace application (Ceph)?

Are you changing the compiler when you change kernel versions?
-Greg

On Mon, Jun 29, 2015 at 3:35 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Some more data point..
>
> 1. I am not seeing this in 3.13.0-24-generic
>
> 2. Seeing this in 3.16.0-23-generic , 3.19.0-21-generic
>
> Could this be related to gcc 4.9.* ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Somnath Roy
> Sent: Saturday, June 27, 2015 5:57 PM
> To: ceph-devel@vger.kernel.org
> Subject: Probable memory leak in Hammer write path ?
>
> Hi,
> I am chasing a substantial memory leak in latest Hammer code base in the write path since yesterday and wanted to know if anybody else is also observing this or not. This is as simple as running a fio-rbd random_write workload in my single OSD server with say block size 16K and num_jobs = 8. I am seeing memory is increasing very substantially and eventually OSD stopped responding.
> I tried it on two different servers (just to make sure since I was playing with lot of kernel param of late), but results are similar.
> Digging down the code and short circuiting different layers, I got the following.
>
> 1. Seeing the nature of leak, it seems the entire transaction is leaking.
>
> 2.  Code is deleting the transaction with a help of C_DeleteTransaction context and commenting out the following line and deleting the transaction (op_t) from submit_transaction(), seems resolved the leak.
>
>   /*op_t->register_on_applied(
>     new ObjectStore::C_DeleteTransaction(op_t));*/
>
>
> 3. In my case, I short circuited the queue_transaction and that's why it is working, but in reality, we can't delete the transaction from submit_transaction(). Code seems to be doing proper way , but I am not able to find out yet why it is leaking memory during deleting it async way.
>
> Appreciate if anybody try out latest hammer building from source and confirm the behavior.
>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
