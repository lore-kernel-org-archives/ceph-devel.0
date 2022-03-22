Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DCBC433EF
	for <ceph-devel@archiver.kernel.org>; Tue, 22 Mar 2022 02:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiCVCLM (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiCVCLK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2022 22:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B771B1C105
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2022 19:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647914978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yd7isXtBmzwrsskA4sR31jmSfKAATD918r7aG4X3KaU=;
        b=Ugd8vmmY0K4jT93dgddj/38lFrIPRDv4YBV4CL0LhqeQpqgRbDxM34YhvKceI2EDVMvA9D
        EeNWc81Gv/VN2cqN4IpnAKZDDiYvlXqwDEaTlabIeq1wfkyPKw7G1KdOsX56L+s2IApxFR
        8L46KeBc88JWjf3AqJAWFvnTbgz/lfw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-R2jvqx2qPXK6Dj8FmQk8ug-1; Mon, 21 Mar 2022 22:09:37 -0400
X-MC-Unique: R2jvqx2qPXK6Dj8FmQk8ug-1
Received: by mail-pj1-f69.google.com with SMTP id rm11-20020a17090b3ecb00b001c713925e58so718642pjb.6
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2022 19:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Yd7isXtBmzwrsskA4sR31jmSfKAATD918r7aG4X3KaU=;
        b=BbdAMFFhIdeGzc3Y5daYNaw/9qCug1TmvLN+Gk/HDfYwTGLKd3P65yrzcDj3O6j6qV
         2ISlJ7aM5UMz+PEwKGUM5RttspL2dKJJUesGA9vPDbPV04GUEHGmYGNbiycSan4za5mv
         DJ6YPzDO+zctqHMNP48x6NmNx7fV5Qjr2KYYhzgEsaFduMok2Re8rQtlthHjkoUHDcup
         0sg6nIjW01OlTU8N2KbiZJ4o+sn5EjvJpHM/EuhunxlSD/927KcmDbNUh9SZJb8J4X1i
         Lo0VnA6kHX5Fw629wr/+gjy96pffWq4zynwDlL2DQKuvqfRE+zvMDKp2fLZVItsUb9Gb
         Zzrg==
X-Gm-Message-State: AOAM530D0ZFaQh+iaWvMRkvyMgRoREQLDgwrMZsyIgkmsilh62H+we5x
        oS7EGujlxe5YquqFLrM7HlJ0HHGaCUekAFK1zNSJq2ablaLfUYV/sICwzriQuvSRphApY7VWAaw
        cAun/m1Cg4ZfA8/PtQ91RtzNRiN4u05EUtdACa3+nawfF2VhV1/FfkciQBGtBsPAUn5GRqPM=
X-Received: by 2002:a05:6a00:10cb:b0:4f7:942:6a22 with SMTP id d11-20020a056a0010cb00b004f709426a22mr27428258pfu.84.1647914975872;
        Mon, 21 Mar 2022 19:09:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl3qpMdjg8pshDnT/00RFxACc1mlA/TtFUeqWowTAYF9WRgTG2HCQKPIWq9SnwzsL44MLGFA==
X-Received: by 2002:a05:6a00:10cb:b0:4f7:942:6a22 with SMTP id d11-20020a056a0010cb00b004f709426a22mr27428236pfu.84.1647914975542;
        Mon, 21 Mar 2022 19:09:35 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm22399539pfl.140.2022.03.21.19.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 19:09:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] libceph: add sparse read support to OSD client
From:   Xiubo Li <xiubli@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org
References: <20220318135013.43934-1-jlayton@kernel.org>
 <20220318135013.43934-5-jlayton@kernel.org>
 <76d21ca6-6166-d42e-cb87-7bca7189c559@redhat.com>
Message-ID: <6a47b138-7588-4433-c07a-f9f05fd0dec6@redhat.com>
Date:   Tue, 22 Mar 2022 10:09:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <76d21ca6-6166-d42e-cb87-7bca7189c559@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org


On 3/22/22 9:58 AM, Xiubo Li wrote:
>
> On 3/18/22 9:50 PM, Jeff Layton wrote:
>>
...
>> +
>> +#ifdef __BIG_ENDIAN
>> +static inline void convert_extent_map(struct ceph_sparse_read *sr)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < sr->sr_count; i++) {
>> +        struct ceph_sparse_extent *ext = sr->sr_extent[i];
>> +
>> +        ext->off = le64_to_cpu((__force __le32)ext->off);
>> +        ext->len = le64_to_cpu((__force __le32)ext->len);
>
> Why '__le32' ? Shouldn't it be '__le64' ?
>
Please ignore this, I just received your new patch series after this and 
found you have fixed it.

I will check the new series today.

Thanks.

-- XIubo

