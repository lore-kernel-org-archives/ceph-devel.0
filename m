From: Haomai Wang <haomai@xsky.com>
Subject: Re: How to propose plugin, which uses external lib
Date: Sat, 18 Jun 2016 00:04:09 +0800
Message-ID: <CACJqLybFf2G3jQjY5LBnsFtxsbeJ-L3V=+TbeR8h0Y9t_LsmOA@mail.gmail.com>
References: <CAONhiy5cg+fX-A49shN9FLREpigiTO18vk7t9anM_ZK9Czc5cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0110.outbound.protection.outlook.com ([104.47.124.110]:60256
	"EHLO APC01-HK2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753517AbcFQQEe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Jun 2016 12:04:34 -0400
Received: by mail-yw0-f175.google.com with SMTP id b75so16847336ywe.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 09:04:17 -0700 (PDT)
In-Reply-To: <CAONhiy5cg+fX-A49shN9FLREpigiTO18vk7t9anM_ZK9Czc5cQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiselyova <akiselyova@mirantis.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Cool, I guess it should be behavior better than others in intel platform.

On Fri, Jun 17, 2016 at 11:51 PM, Alyona Kiselyova
<akiselyova@mirantis.com> wrote:
> Hi,
> I would like to propose a new compression plugin, which is based on
> Isa-l open source library
> (https://github.com/01org/isa-l/tree/master/igzip). I already have a
> code - https://github.com/Ved-vampir/ceph/tree/wip_isal_plugin/src/compressor/isal.
> I see, that there are erasure-code plugin, based on isa-l too. As I
> see, library code is not loaded as submodule repo, like some others.
> But if I'm right, I think, it's not the best way to use external code.

Sorry, why it's not a best way?

> The question is, what is the right way to use external library in my case?

I think maybe we could make the whole
repo(https://github.com/01org/isa-l) as submodule and make each dir
used by different compoent?

> Thanks!
> -------------------------------
> Best regards,
> Alyona Kiseleva
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
