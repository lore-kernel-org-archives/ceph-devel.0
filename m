From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: advice on indexing sequential data?
Date: Thu, 1 Oct 2015 20:12:30 +0800
Message-ID: <CACJqLyaEco6T=LTeN__StswcptB32v-YVgJDFJNBJyR-AFmOTQ@mail.gmail.com>
References: <1443696277.195146.398469249.1BA6CC6B@webmail.messagingengine.com>
	<CACJqLybNJaTtcf2K3nvNasawPbJ0Ce3F4VoeK+J+MvtcpbxFuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33894 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbbJAMMb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Oct 2015 08:12:31 -0400
Received: by vkat63 with SMTP id t63so3135092vka.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Oct 2015 05:12:30 -0700 (PDT)
In-Reply-To: <CACJqLybNJaTtcf2K3nvNasawPbJ0Ce3F4VoeK+J+MvtcpbxFuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Nakamura <tnakamura@eml.cc>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

resend

On Thu, Oct 1, 2015 at 7:56 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>
>
> On Thu, Oct 1, 2015 at 6:44 PM, Tom Nakamura <tnakamura@eml.cc> wrote:
>>
>> Hello ceph-devel,
>>
>> My lab is concerned with developing data mining application for
>> detecting and 'deanonymizing' spamming botnets from high-volume spam
>> feeds.
>>
>> Currently, we just store everything in large mbox files in directories
>> separated by day (think: /data/feed1/2015/09/13.mbox) on a single NFS
>> server. We have ad-hoc scripts to extract features from these mboxes and
>> pass them to our analysis pipelines (written in a mixture of
>> R/matlab/python/etc). This system is reaching its limit point.
>>
>> We already have a small Ceph installation with which we've had good luck
>> for storing other data,and would like to see how we can use it to solve
>> our mail problem. Our basic requirements are that:
>>
>> - We need to be able to access each message by its extracted features.
>> These features include simple information found in its header (for
>> example From: and To:) as well as more complex information like
>> signatures from attachments and network information (for example,
>> presence in blacklists).
>> - We will frequently add/remove features.
>> - Faster access to recent data is more important than to older data.
>> - Maintaining strict ordering of incoming messages is not necessary. In
>> other words, if we received two spam messages on our feeds, it doesn't
>> matter too much if they are stored in that order, as long as we can have
>> coarse-grained temporal accuracy (say, 5 minutes). So we don't need
>> anything as sophisticated as Zlog.
>> - We need to be able to remove messages older than some specific age,
>> due to storage constraints.
>>
>> Any advice on how to use Ceph and librados to accomplish this?  Here are
>> my initial thoughts:
>>
>> - Each message is an object with some unique ID. Use omap to store all
>> its features in the same object.
>> - For each time period (which will have to be pre-specified to, say, an
>> hour), we have an object which contains a list of ID's, as a bytestring
>> of contatenated ID's. This should make expiring old messages trivial.
>> - For each feature, we have a timestamped index (like
>> 20150930-from-foo@bar.com or
>> 20150813-has-attachment-with-hash-123abddeadbeef) the which contains a
>> list of ID's.
>> - Hopefully use Rados classes to index/feature-extract on the OSD's.
>>
>> How does this sound? One glaring omission is that I do not know how to
>> create indices which would support querying by inequality/ranges ('find
>> all messages between 1000 and 2000 bytes').
>
>
> I guess it likes label in Gmail?
>
> Hmm, each message as a object is a luxurious way. I guess we need to have a
> primary index, which could used to combine multi messages into one rados
> object and store offset/len mapping to omap/xattr. Then Secondary index also
> can store as object, omap is used to refer to actual data.
>
>
>
>>
>>
>> Thank you,
>> Tom N.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
>
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
