From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: client-facing feature bits and pending kernel changes
Date: Mon, 1 Feb 2016 22:45:50 +0800
Message-ID: <CAAM7YA=QMz-aJ0qrLJecWjwLANbaC5g-wXUuf3AubSz_niMT5A@mail.gmail.com>
References: <alpine.DEB.2.11.1601291104270.28963@cpach.fuggernut.com>
	<CAAM7YAnygLww6UYemZcFjPxPCnrN8D7xO4wTHZwFjTNAEof61w@mail.gmail.com>
	<alpine.DEB.2.11.1602010807130.28963@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33037 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbcBAOpv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Feb 2016 09:45:51 -0500
Received: by mail-lb0-f176.google.com with SMTP id x4so77207655lbm.0
        for <ceph-devel@vger.kernel.org>; Mon, 01 Feb 2016 06:45:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602010807130.28963@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Zheng Yan <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 1, 2016 at 9:08 PM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 1 Feb 2016, Yan, Zheng wrote:
>> On Sat, Jan 30, 2016 at 12:09 AM, Sage Weil <sweil@redhat.com> wrote:
>> > Hi Zheng,
>> >
>> > We have one feature already merged to ceph.git, CRUSH_TUNABLES5, that's a
>> > pretty trivial change to crush/mapper.c that we can add to the kernel.
>> >
>> > But there are two more coming:
>> >
>> > OSDOPREPLY_ENCODING makes a small change to the OSDOpReply encoding for
>> > performance reasons.  Here is the PR
>> >
>> >         https://github.com/ceph/ceph/pull/7386
>> >
>> > The other is the file layout changes, which are much more invovled:
>> >
>> >         https://github.com/ceph/ceph/pull/7098
>>
>> Can we avoid changing how file layout is encoded in MClientCaps and
>> MClientReply? Instead, we encode the namespace information at the end
>> of MClientCaps/MClientReply message. (like how we added inline data
>> related fields to these message).
>
> Hmm.. yeah, we do that, at least for MClientCaps.  It just means that if
> we ever add more fields to that struct we need to maintain the message
> encoding in parallel by hand, but that shouldn't be too bad.
>
> The MClientReply one is a bit trickier because there can be N instances of
> InodeStat (or whatever) in there... on that one I'd lean toward switching
> the encoding.  What do you think?
>

We can use conection's features to decide how many memory each
InodeStat uses. It's how inline data was added to InodeStat

Regards
Yan, Zheng
