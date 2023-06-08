Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB668C7EE25
	for <ceph-devel@archiver.kernel.org>; Thu,  8 Jun 2023 10:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjFHKNQ (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFHKNP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jun 2023 06:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E4D1FE9
        for <ceph-devel@vger.kernel.org>; Thu,  8 Jun 2023 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686219146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXFdHkMjdbj3kxc2vl0mbq5q5IxmvWUVHYaQUe9zUGA=;
        b=H8cHrxhZuqv6zKrt8zkBAqQO1K8s/T10E52AUF6jx8kanNNEbUSEI96RX4D1jyDgeL07sb
        oqUwk2FTRvBmBwSPWBfFKxZp232zLtXvEymPoFewCL0O86gao0hYyTEt73OA7MG1jwfY5s
        0TdKLXL4KTSPzF5tAkNz0D3eqNubIVc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-jfwN3noSOpyAwvLW6f34cA-1; Thu, 08 Jun 2023 06:12:25 -0400
X-MC-Unique: jfwN3noSOpyAwvLW6f34cA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53f6f7d1881so310228a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jun 2023 03:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219144; x=1688811144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXFdHkMjdbj3kxc2vl0mbq5q5IxmvWUVHYaQUe9zUGA=;
        b=f/LqgcBx0dX2uBgamrNBT2TgFWb415paiXM8edBfZPbqrsSdhA6PTK51dEttvBAdyA
         yMXTkIBx6le3ARsJIpmWN8Rsb/h8bAgQvhRSNnbVhoKSEXoNdA3PHBJS0mP/eu1yE/2j
         Z7SNeik4zA1dscJ3D9Ip5tJCe9U+8rz4PvxGvR5NzGv0zMYt4sr6bCnT5tYl4ucPjUCX
         LxvS/awjhHKBKnY+DzJRmUf8kLI41gI60es+8henIaeATjMM6Dmgkk/RwT8ljz5idB1j
         otsrMwZ60fQiexKKbC+XNj3osU2Z6O/+X5JuBZBwy7Wc0xozhoyxaZvkcwrqNDvw7Hy1
         m/FQ==
X-Gm-Message-State: AC+VfDwmcG4A5Cx7UJ0ATZ7+7f+87dirISKvL3mM+/vsVu9nmO9jfp0v
        Y3HZUxA2UTAWtvvGtWPxOVQqLR2Sx5DcJPfqafss3FZj4PigQY6GzamwEufXfFjMT/vmcan5njS
        Ek7nFT4uvhAIpNt0ktqZ5aw==
X-Received: by 2002:a05:6a20:43aa:b0:10c:ff51:99bb with SMTP id i42-20020a056a2043aa00b0010cff5199bbmr6172888pzl.20.1686219144291;
        Thu, 08 Jun 2023 03:12:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4U69jgtuG1/MPYTW+NyNGq72BvGC9LQ5+PqJw4mqlQhYrMtU4w7h1yFT0lTLCaifozZP5/rg==
X-Received: by 2002:a05:6a20:43aa:b0:10c:ff51:99bb with SMTP id i42-20020a056a2043aa00b0010cff5199bbmr6172873pzl.20.1686219143979;
        Thu, 08 Jun 2023 03:12:23 -0700 (PDT)
Received: from [10.72.13.135] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l13-20020a65680d000000b0053474697607sm878436pgt.4.2023.06.08.03.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:12:23 -0700 (PDT)
Message-ID: <c4738f92-6b6c-b680-f480-949dfa413e73@redhat.com>
Date:   Thu, 8 Jun 2023 18:12:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] ceph: fix use-after-free bug for inodes when flushing
 capsnaps
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, mchangir@redhat.com, stable@vger.kernel.org
References: <20230607025434.1119867-1-xiubli@redhat.com>
 <CAOi1vP9KjpfNkonSEWSm6+HJwykm6ThHchK9E=MR1zSOjr_v+Q@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP9KjpfNkonSEWSm6+HJwykm6ThHchK9E=MR1zSOjr_v+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org


On 6/8/23 15:07, Ilya Dryomov wrote:
> On Wed, Jun 7, 2023 at 4:57 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> There is a race between capsnaps flush and removing the inode from
>> 'mdsc->snap_flush_list' list:
>>
>>     == Thread A ==                     == Thread B ==
>> ceph_queue_cap_snap()
>>   -> allocate 'capsnapA'
>>   ->ihold('&ci->vfs_inode')
>>   ->add 'capsnapA' to 'ci->i_cap_snaps'
>>   ->add 'ci' to 'mdsc->snap_flush_list'
>>      ...
>>     == Thread C ==
>> ceph_flush_snaps()
>>   ->__ceph_flush_snaps()
>>    ->__send_flush_snap()
>>                                  handle_cap_flushsnap_ack()
>>                                   ->iput('&ci->vfs_inode')
>>                                     this also will release 'ci'
>>                                      ...
>>                                        == Thread D ==
>>                                  ceph_handle_snap()
>>                                   ->flush_snaps()
>>                                    ->iterate 'mdsc->snap_flush_list'
>>                                     ->get the stale 'ci'
>>   ->remove 'ci' from                ->ihold(&ci->vfs_inode) this
>>     'mdsc->snap_flush_list'           will WARNING
>>
>> To fix this we will increase the inode's i_count ref when adding 'ci'
>> to the 'mdsc->snap_flush_list' list.
>>
>> Cc: stable@vger.kernel.org
>> URL: https://bugzilla.redhat.com/show_bug.cgi?id=2209299
>> Reviewed-by: Milind Changire <mchangir@redhat.com>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>
>> V4:
>> - s/put/need_put/
> Hi Xiubo,
>
> The other part of the suggestion was to make it a bool.  I made the
> adjustment and queued up this patch for 6.4-rc6.

Sure, thanks Ilya.

- Xiubo


> Thanks,
>
>                  Ilya
>

