From: John Spray <jspray@redhat.com>
Subject: Re: CephFs performance data
Date: Wed, 3 Aug 2016 17:29:27 +0100
Message-ID: <CALe9h7fJpxymoTBz-K-MNvksT8U2ZnhDN4RUb9FeEBY_OWJV+w@mail.gmail.com>
References: <BL2PR02MB211586BC32D5102FEE450C7AF4060@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33258 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcHCQbP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Aug 2016 12:31:15 -0400
Received: by mail-qk0-f169.google.com with SMTP id p74so207525255qka.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Aug 2016 09:29:48 -0700 (PDT)
In-Reply-To: <BL2PR02MB211586BC32D5102FEE450C7AF4060@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Ben England (bengland@redhat.com)" <bengland@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 3, 2016 at 5:24 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Ben,
> Thanks for the first cut data on CephFS , it was really helpful.
> Do you mind to send out the slides ?
> Also, continuing the discussion on 4K SW throughput is ~1GB/S , if you are running test with direct IO, client Linux system can't coalesce the writes and I didn't see much coalescing at the OSD servers as well. Unless CephFS has some coalescing logic it will be good if we can find out how we are getting this bigger throughput for 4K. Let me know if I am missing something..

The impression I had was that the later kclient tests were not using
direct IO, but I might be wrong?

John

> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
