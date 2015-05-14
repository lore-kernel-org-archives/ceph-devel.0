From: Gregory Farnum <greg@gregs42.com>
Subject: Re: which osds get used for ec pool reads?
Date: Thu, 14 May 2015 11:33:34 -0700
Message-ID: <CAC6JEv_xsOVPh2RxRgGD=K2Q0bj_u13TmgkAhP1Jn5CEWMJLgw@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166448682@SATLEXDAG01.amd.com>
	<1146045701.21089476.1431622348438.JavaMail.zimbra@redhat.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8C782@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34841 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbbENSdg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 14:33:36 -0400
Received: by iebpz10 with SMTP id pz10so68417008ieb.2
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 11:33:35 -0700 (PDT)
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com. [209.85.213.169])
        by mx.google.com with ESMTPSA id a139sm17028621ioa.14.2015.05.14.11.33.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 11:33:34 -0700 (PDT)
Received: by igbpi8 with SMTP id pi8so16932328igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 11:33:34 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8C782@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Samuel Just <sjust@redhat.com>, Tom Deneau <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 14, 2015 at 11:23 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Sam,
> It seems the current code is optimized for performance. So, what's the advantage the new changes are bringing ?
> Every time we will be doing decoding then ?

If you read every block, you increase the amount of data accessed but
can avoid the long tail latencies. There are a bunch of research
papers about these tradeoffs and the surprising latency improvements
you can get on the aggregate read, and Yahoo! talked about this in
their blog post on their use of Ceph. :)
-Greg

>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Samuel Just
> Sent: Thursday, May 14, 2015 9:52 AM
> To: Tom Deneau
> Cc: ceph-devel
> Subject: Re: which osds get used for ec pool reads?
>
> There is a branch which may merge soonish which will optionally read from all shards and use the first N.  It's not merged yet.  If the pgs are healthy, the current behavior is to read from the data shards (since you don't need to perform a decode in that case).
> -Sam
>
> ----- Original Message -----
> From: "Tom Deneau" <tom.deneau@amd.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, May 14, 2015 9:27:14 AM
> Subject: which osds get used for ec pool reads?
>
> I am looking at disk activity on reads from an erasure coded pool (k=2, m=1).
> I have a contrived setup where I am reading a bunch of names that are all in the same PG.  I see disk activity only from the 2 K osds, not the M osd.
>
> As I understand http://ceph.com/docs/master/architecture/,  in this situation all 3 osds would be read and the first two to return would be used but that is not what I see.
>
> In this particular contrived setup, all of the OSDs are on a single node, would that be causing the 2-OSD read behavior that I am seeing?
>
> -- Tom Deneau
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
