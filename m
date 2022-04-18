Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE9C433EF
	for <ceph-devel@archiver.kernel.org>; Mon, 18 Apr 2022 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiDRKzf (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 18 Apr 2022 06:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDRKze (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2022 06:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1599215FFB
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2022 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650279175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEX8a2lSylP9RYvKo7SCwSa4BCBvhhUQvbuCpcWqvSY=;
        b=Rz9lZreSqNcuP9CGr6AZu1bDfV9CPWHP0hU2be5yM0Sa2pnZY50zm6wRCpAx9oUuJoi3Cr
        3K/gv/DCSgL8wRk2eT0IJ/tbkfMwM2CQxvGPrGhaIMiHhncZq2RG28RbDQ2WFRvaTfRKB9
        ySvZD8gjAnZb8kn+zYil3PESLQ1Zu00=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-O34sPLdAPA2jcipazRgW9Q-1; Mon, 18 Apr 2022 06:52:54 -0400
X-MC-Unique: O34sPLdAPA2jcipazRgW9Q-1
Received: by mail-pl1-f197.google.com with SMTP id u5-20020a17090282c500b00158e301f407so3332733plz.15
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2022 03:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uEX8a2lSylP9RYvKo7SCwSa4BCBvhhUQvbuCpcWqvSY=;
        b=qHe+B+1pqz/YOk6z9NXzGQpuHmKWgoVoF5ZyhYY8opQmQrApOewkkKZecmw7HEy7T2
         R5UhG4vSdCeCnlDSrVXdjdDNLv/3XOVx2sEeWOFuC2zk0eXPtNnz0xom/vRCqKKDW3s0
         mItUk4CbUQiaAJe/wdlJ1fEUNHrTtPS3F0dgzD5B62TaVfdz/53iiemTciyyJXMIrxoq
         Y0xZxgmlNlV+tDFiKik5QpcDckYdne5uObrAioAoHnmtWUU0SxPSfvi16gk9xW8F7eXS
         7KxYNhQR3vHYaYgwB3S+f4mGFiJmWBHKomttORF6wavdG0fN8gPddbCuNu5/FcY9UYoN
         DimA==
X-Gm-Message-State: AOAM530A/STcGG+eZW61xHw8pqt8dpGvJhE+QtsENeO3hXS2chBjPeLL
        hI7LzdxaedMSVOgFEyRNAne8t3qM6mKfNBY5dRQmdLurhMJ8d6mZfQX8DwfrQv2pqVNnc7GG1GP
        PAnBoh9LuwkE5VyWWIbkLm8QeEaPwNdoestXNFQiT1dnuEQPXAGQbyTp5kLFqgtNO1d5kOew=
X-Received: by 2002:a05:6a00:15d4:b0:50a:512e:92e9 with SMTP id o20-20020a056a0015d400b0050a512e92e9mr10569379pfu.28.1650279172694;
        Mon, 18 Apr 2022 03:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiQClXysmpI4I54w5RuLm0nHR9XNTq9ckcfYSRD6k0QgUKZeH5T+WJcjaaEnnYBc+VIfTf/Q==
X-Received: by 2002:a05:6a00:15d4:b0:50a:512e:92e9 with SMTP id o20-20020a056a0015d400b0050a512e92e9mr10569350pfu.28.1650279172386;
        Mon, 18 Apr 2022 03:52:52 -0700 (PDT)
Received: from [10.72.12.77] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a4f0900b001d2a3a58228sm2192795pjh.11.2022.04.18.03.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 03:52:51 -0700 (PDT)
Subject: Re: [PATCH v2] ceph: fix possible NULL pointer dereference for
 req->r_session
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     jlayton@kernel.org, idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org
References: <20220418014440.573533-1-xiubli@redhat.com>
 <20220418104318.4fb3jpdgnhje4b5d@ava.usersys.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <53d24ea4-554b-2df3-e4ee-6761f6ae5c8e@redhat.com>
Date:   Mon, 18 Apr 2022 18:52:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220418104318.4fb3jpdgnhje4b5d@ava.usersys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org


On 4/18/22 6:43 PM, Aaron Tomlin wrote:
> On Mon 2022-04-18 09:44 +0800, Xiubo Li wrote:
>> The request will be inserted into the ci->i_unsafe_dirops before
>> assigning the req->r_session, so it's possible that we will hit
>> NULL pointer dereference bug here.
>>
>> URL: https://tracker.ceph.com/issues/55327
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/caps.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 69af17df59be..c70fd747c914 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -2333,6 +2333,8 @@ static int unsafe_request_wait(struct inode *inode)
>>   			list_for_each_entry(req, &ci->i_unsafe_dirops,
>>   					    r_unsafe_dir_item) {
>>   				s = req->r_session;
>> +				if (!s)
>> +					continue;
>>   				if (unlikely(s->s_mds >= max_sessions)) {
>>   					spin_unlock(&ci->i_unsafe_lock);
>>   					for (i = 0; i < max_sessions; i++) {
>> @@ -2353,6 +2355,8 @@ static int unsafe_request_wait(struct inode *inode)
>>   			list_for_each_entry(req, &ci->i_unsafe_iops,
>>   					    r_unsafe_target_item) {
>>   				s = req->r_session;
>> +				if (!s)
>> +					continue;
>>   				if (unlikely(s->s_mds >= max_sessions)) {
>>   					spin_unlock(&ci->i_unsafe_lock);
>>   					for (i = 0; i < max_sessions; i++) {
>> -- 
>> 2.36.0.rc1
> Tested-by: Aaron Tomlin <atomlin@redhat.com>
>
Hi Aaron,

Thanks very much for you testing.

BTW, did you test this by using Livepatch or something else ?

-- Xiubo


