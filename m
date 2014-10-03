From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Regarding key/value interface
Date: Fri, 3 Oct 2014 13:25:26 +0800
Message-ID: <CACJqLyZkY8UNqCkSnvXbPGfqB-mdvc9StHZPOqMeWg5Z8vDymA@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784F809@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35961 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaJCFZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Oct 2014 01:25:27 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so578608wgg.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Oct 2014 22:25:26 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784F809@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Correctly, maybe we can move these super metadata to backend!

On Fri, Oct 3, 2014 at 6:47 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi Sage/Haomai,
>
> I was going through the key/value store implementation and have one basic question regarding the way it is designed.
>
> I think key/value interface is assuming there will be a filesystem on top of the device . I saw in mount you are accessing files like superblock/fsid. So, for example, /var/lib/ceph/osd/ceph-0 should be a filesystem path, right ?
> If so, this may not be the case always as there are key/value stores which can work on the raw device. In that case, these files (superblock/fsid) also need to go in the key/value db.
>
> Let me know if I am missing anything.
>
> Thanks & Regards
> Somnath
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>



-- 
Best Regards,

Wheat
