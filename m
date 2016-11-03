From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: bluestore move_ranges
Date: Thu, 3 Nov 2016 14:40:23 +0300
Message-ID: <eb1e95f4-7199-ba0b-d6b7-81157d7405b5@mirantis.com>
References: <alpine.DEB.2.11.1611021511230.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34303 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757122AbcKCLk0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 07:40:26 -0400
Received: by mail-qt0-f173.google.com with SMTP id n6so26118604qtd.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 04:40:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1611021511230.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, roushan.ali@sandisk.com, ceph-devel@vger.kernel.org

Hi Sage,

yeah, looks like you're right, blob depth calculation isn't that 
accurate at the moment.

It's a good idea to verify blob_depth in fsck but I would disagree about 
the warning - it has almost no sense except log polluting IMHO.

I think the proper way is to make this calculation work correctly - 
perhaps we should do blob_depth calculation exactly when specific 
blob/extent is determined and ready for write.

Thanks,
Igor.

On 02.11.2016 18:18, Sage Weil wrote:
> Hey Igor, Roushan,
>
> I fixed the simple review issues, but there remains a problem with the
> blob_depth, and I'm not sure how we should proceed.  The obvious approach
> is to call the same do_write_check_depth that we do in _do_write to get a
> blob depth.  I had a question here, though, because I think this isn't
> actually quite right.  Consider existing blob a and planned write n:
>
>          |     |    |    |    |
>    aaaaaaaaaaa
>             nnnnnnnnnnnnnn
>
> We'll get blob_depth of 2, but if the min_alloc_size alignment is |, then
> the first bit of nnnn will be one blob (_do_write_small) with the correct
> depth of 2 but the rest will come from _do_write_big and get depth of 2
> when it should have depth of 1.
>
> Even if everything is min_alloc_size aligned, _do_write_big will write
> many smaller blobs depending on compression and max chunk sizes and so on,
> so I'm not sure the gc function can really make an accurate determination
> here.  Am I missing something?
>
> On that note, I think we should make fsck audit the blob_depth.  I'm
> guessing it will complain extensively about the current code.  It might
> be we decide not to make blob_depth perfectly accurate in the end.. in
> which case we can make it a warning and not an error, but either way it
> will be helpful to see.
>
> What do you think?
> sage
>

