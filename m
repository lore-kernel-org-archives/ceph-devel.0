From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Tue, 30 Jun 2015 16:21:19 -0700
Message-ID: <5593246F.2030201@redhat.com>
References: <CACJqLyZcAzb5wocrN8b8WoK6j3ynWF-_3=T+1aQkDko4Mv_SmQ@mail.gmail.com>	<99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com> <CAMeBU_3ty6ae5VXP=_D8py1_Pk4rLKxCa4Larz0oKnyTYDtz8w@mail.gmail.com> <99767EA2E27DD44DB4E9F9B9ACA458C03B319DF2@SSIEXCH-MB3.ssi.samsung.com> <55931A5E.5000408@redhat.com> <55931EEE.9070604@kernel.dk> <559323CC.1000003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbbF3XVT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 19:21:19 -0400
In-Reply-To: <559323CC.1000003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Mark Nelson <mnelson@redhat.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Casey Bodley <cbodley@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, daniel.gollub@gmail.com

On 06/30/2015 04:18 PM, Josh Durgin wrote:
> Note that ceph's ObjectStore api is internal, and not stable. Maybe not
> the best thing to include in packages, though keeping it as an option
> at build time might make sense. The api itself isn't that prone to
> change, but internal symbols (hooray c++...) certainly are, so any
> update of ceph would likely need a recompile of the backend.

And now I see the ObjectStore is included statically, so it is doable.
It just won't be updated for new ceph without recompiling the backend,
which seems fine to me.

>
> Josh
>
> On 06/30/2015 03:57 PM, Jens Axboe wrote:
>> I'd be more than happy to include it. Daniel has contributed to fio
>> before.
>>
>> Daniel (CC'ed), was it your intent to get this upstream? How do we make
>> this happen?

