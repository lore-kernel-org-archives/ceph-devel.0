From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: symbol lookup error v9.1.0
Date: Fri, 16 Oct 2015 21:54:31 -0700
Message-ID: <5621D487.3050101@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192524E19@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38663 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbbJQEya (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 17 Oct 2015 00:54:30 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192524E19@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/16/2015 08:37 PM, Deneau, Tom wrote:
> On an ubuntu trusty system,
>     * I installed v9.1.0 and could bring up a single node cluster with it.
>     * I did a git checkout of v9.1.0, followed by ./autogen.sh; ./configure; make
>
> Then when I try to run for example the rados I just built using
>       "./src/.libs/rados -v"
>
> I get
> ./src/.libs/rados: symbol lookup error: ./src/.libs/rados: undefined symbol: _ZN8librados20ObjectWriteOperation9copy_fromERKSsRKNS_5IoCtxEmj
>
> which decodes to
>   librados::ObjectWriteOperation::copy_from(std::string const&, librados::IoCtx const&, unsigned long, unsigned int)
>
> Is there any reason why this symbol should not be resolved by the installed libraries of v9.1.0?

Sounds like you've got a pre-9.1.0 librados getting loaded. This is one
of the ABI breakages that's fixed in the infernalis branch, but didn't
make the rc. This is the fix:

https://github.com/ceph/ceph/pull/6215

Josh
