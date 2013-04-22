From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Mon, 22 Apr 2013 12:10:41 -0500
Message-ID: <51756F11.6050708@inktank.com>
References: <1365774766-29899-1-git-send-email-laurent@ksperis.com> <516C37D5.1090804@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:53223 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab3DVRKp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 13:10:45 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so7134628iec.8
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 10:10:45 -0700 (PDT)
In-Reply-To: <516C37D5.1090804@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Barbe <laurent@ksperis.com>
Cc: ceph-devel@vger.kernel.org

On 04/15/2013 12:24 PM, Alex Elder wrote:
> On 04/12/2013 08:52 AM, Laurent Barbe wrote:
>> If rbd disk is open and rbd resize is done, new size is not visible by
>> filesystem.
>> Like is done in virtio-blk and dm driver, revalidate_disk() permits to
>> update the bd_inode size.
>>
>> Signed-off-by: Laurent Barbe <laurent@ksperis.com>
> 
> This one looks good (too).  And this time I've tested
> it just to be sure I get no lockdep warnings.  Unless
> I see any strangeness in my sanity testing (which I
> don't expect) I'll commit this to the testing branch
> later today.  Thanks a lot.
> 
> Reviewed-by: Alex Elder <elder@inktank.com>

I have committed this to the "testing" branch of the
ceph-client git repository.

					-Alex


. . .
