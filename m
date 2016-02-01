From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: client-facing feature bits and pending kernel changes
Date: Mon, 1 Feb 2016 22:24:19 +0800
Message-ID: <CAAM7YAkmuM13q=rv7XWeAzB-=JfY7+SsfArNaAwkZ69WxLJVAQ@mail.gmail.com>
References: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com>
	<CAAM7YAnygLww6UYemZcFjPxPCnrN8D7xO4wTHZwFjTNAEof61w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33066 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbcBAOYV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Feb 2016 09:24:21 -0500
Received: by mail-lb0-f170.google.com with SMTP id x4so76803376lbm.0
        for <ceph-devel@vger.kernel.org>; Mon, 01 Feb 2016 06:24:20 -0800 (PST)
In-Reply-To: <CAAM7YAnygLww6UYemZcFjPxPCnrN8D7xO4wTHZwFjTNAEof61w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Zheng Yan <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 1, 2016 at 5:30 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Sat, Jan 30, 2016 at 12:09 AM, Sage Weil <sweil@redhat.com> wrote:
>> Hi Zheng,
>>
>> We have one feature already merged to ceph.git, CRUSH_TUNABLES5, that's a
>> pretty trivial change to crush/mapper.c that we can add to the kernel.
>>
>> But there are two more coming:
>>
>> OSDOPREPLY_ENCODING makes a small change to the OSDOpReply encoding for
>> performance reasons.  Here is the PR
>>
>>         https://github.com/ceph/ceph/pull/7386
>>
>> The other is the file layout changes, which are much more invovled:
>>
>>         https://github.com/ceph/ceph/pull/7098
>
> Can we avoid changing how file layout is encoded in MClientCaps and
> MClientReply? Instead, we encode the namespace information at the end
> of MClientCaps/MClientReply message. (like how we added inline data
> related fields to these message).

see

https://github.com/ukernel/ceph/commit/930c4982e9fda9e894dda9d5c91d17a7bed1b13a
https://github.com/ceph/ceph-client/commit/4cc460f0d57ca735bf484e63fcde917827c1775b

patch for kernel is small. should be OK for 4.5-rc


Regards
Yan, Zheng

>
> Regards
> Yan, Zheng
>
>>
>> Ideally we'd use the same feature bit for all of these, but it means they
>> all need to upstream into Linux together.  Do you see a problem with that?
>> Assuming we get it all ready to go before the next merge window..
>>
>> The tricky bit is we really need to know that we'll be able to do it
>> together before we cut jewel too and commit to the overlapping feature
>> bits.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
