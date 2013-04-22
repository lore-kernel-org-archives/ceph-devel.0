From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Mon, 22 Apr 2013 12:35:19 -0500
Message-ID: <517574D7.3030004@inktank.com>
References: <1365774766-29899-1-git-send-email-laurent@ksperis.com> <516C37D5.1090804@inktank.com> <51756F11.6050708@inktank.com> <alpine.DEB.2.00.1304221014410.15710@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:48354 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab3DVRfW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 13:35:22 -0400
Received: by mail-ia0-f171.google.com with SMTP id f27so5613300iae.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 10:35:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304221014410.15710@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Laurent Barbe <laurent@ksperis.com>, ceph-devel@vger.kernel.org

On 04/22/2013 12:14 PM, Sage Weil wrote:
> On Mon, 22 Apr 2013, Alex Elder wrote:
>> On 04/15/2013 12:24 PM, Alex Elder wrote:
>>> On 04/12/2013 08:52 AM, Laurent Barbe wrote:
>>>> If rbd disk is open and rbd resize is done, new size is not visible by
>>>> filesystem.
>>>> Like is done in virtio-blk and dm driver, revalidate_disk() permits to
>>>> update the bd_inode size.
>>>>
>>>> Signed-off-by: Laurent Barbe <laurent@ksperis.com>
>>>
>>> This one looks good (too).  And this time I've tested
>>> it just to be sure I get no lockdep warnings.  Unless
>>> I see any strangeness in my sanity testing (which I
>>> don't expect) I'll commit this to the testing branch
>>> later today.  Thanks a lot.
>>>
>>> Reviewed-by: Alex Elder <elder@inktank.com>
>>
>> I have committed this to the "testing" branch of the
>> ceph-client git repository.
> 
> Is this the one that had the lockdep issue?

It did, but moving where it got called (into
rbd_dev_refresh(), outside the control mutex)
resolved that.

					-Alex

