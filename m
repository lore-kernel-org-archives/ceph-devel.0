Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A5BC388F7
	for <ceph-devel@archiver.kernel.org>; Tue, 10 Nov 2020 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B716D206A1
	for <ceph-devel@archiver.kernel.org>; Tue, 10 Nov 2020 15:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwY0tjhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgKJPoy (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKJPoy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2020 10:44:54 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05313C0613CF
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2020 07:44:54 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id l12so9817009ilo.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2020 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WaERiuaBFL9EGpo+sbIIePuTMBxlMl/aXMX6BNwGVew=;
        b=DwY0tjhzl1zedMgOl6HR9Ghk5QThFyPH5S/melgGoMsxjXjowyhx15kSMCfBaAQg29
         XbGJDvGd8VUE0FuR9WBaRlDhaYt9o8m2JoDNExS1Z5/lw1SjeXB9c0/OUnUWmcTUlQGc
         0PPPY3geNcQtOS6TzPZzuvrNveMgCsgclb/ngtsXMzXSWbPkwFkHVLk1IDFFoKQKTygl
         8r4aOwyS2mrvTkSsecCIpZR7fHCXbyIlT1Qnme1WPz1qssQblBbHf1zJALLgQM80xTLp
         4+lfwX+lxUb0uIfW8v51bazlJH6H5TQ2mRxpJCR7f/PO0jxFmgTSdbVvjpR1Faq/J3Rn
         UBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WaERiuaBFL9EGpo+sbIIePuTMBxlMl/aXMX6BNwGVew=;
        b=Dja86XdNHbPQcPeUWLRJ8kqX4Y8M05jGB+oSFnx+IGzNsSXEPslk7/XFZSPZlwVtUa
         IXJYWgr8q3TCxRUo3M8+um9m8sHD0f5ancEhGGCxENBO6rsaY/KK3ifVBtWfjcjHdT8d
         bj76+0Wid5TsKKWonPP4Y0vmW1B+oOgZqB/NppISE3SuwDUDx2TYeP2DEYnwsoSmTQ2h
         kCXoD//CZYb/trAW8y7H4e+23MxrFPHHACthzV1g97ec9ay0bypvZ7IQ6yKE71mt7V+j
         yLsE44wY7ZcFt2V/VbsC+y8L9CvrN2/4SbZEFrcqVNCgjFdeVMkto/3wcWYtTQkTCL7T
         F+Cw==
X-Gm-Message-State: AOAM533ERhJcyyS3Ap6CkZGOz/199cX53OESxFmpEwgKLKgYX/4K12Sa
        WsAb2/OUwiwouVbrnAoIuishZyGcGO11OMHbRFA=
X-Google-Smtp-Source: ABdhPJyhoqIyq2vKpTQ748XgwLPE64DJnU97BzsNg6wKlASCu26eP3ClBiMKVetdtxrYGXYutexGsWt28VfMQq4cMWY=
X-Received: by 2002:a05:6e02:c:: with SMTP id h12mr15458025ilr.177.1605023093372;
 Tue, 10 Nov 2020 07:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20201110141937.414301-1-xiubli@redhat.com>
In-Reply-To: <20201110141937.414301-1-xiubli@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 10 Nov 2020 16:44:52 +0100
Message-ID: <CAOi1vP-tBRNEgkmhvieUyBzOms-n=vge4XpYSpnU6cnq86SRMQ@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: add osd op counter metric support
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>,
        Patrick Donnelly <pdonnell@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:19 PM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> The logic is the same with osdc/Objecter.cc in ceph in user space.
>
> URL: https://tracker.ceph.com/issues/48053
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>
> V3:
> - typo fixing about oring the _WRITE
>
>  include/linux/ceph/osd_client.h |  9 ++++++
>  net/ceph/debugfs.c              | 13 ++++++++
>  net/ceph/osd_client.c           | 56 +++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 83fa08a06507..24301513b186 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -339,6 +339,13 @@ struct ceph_osd_backoff {
>         struct ceph_hobject_id *end;
>  };
>
> +struct ceph_osd_metric {
> +       struct percpu_counter op_ops;
> +       struct percpu_counter op_rmw;
> +       struct percpu_counter op_r;
> +       struct percpu_counter op_w;
> +};

OK, so only reads and writes are really needed.  Why not expose them
through the existing metrics framework in fs/ceph?  Wouldn't "fs top"
want to display them?  Exposing latency information without exposing
overall counts seems rather weird to me anyway.

The fundamental problem is that debugfs output format is not stable.
The tracker mentions test_readahead -- updating some teuthology test
cases from time to time is not a big deal, but if a user facing tool
such as "fs top" starts relying on these, it would be bad.

Thanks,

                Ilya
