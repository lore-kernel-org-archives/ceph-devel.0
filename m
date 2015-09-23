From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Wed, 23 Sep 2015 07:05:09 -0700
Message-ID: <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
References: <56018A05.6090100@mirantis.com>
	<alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
	<56029F66.3070503@mirantis.com>
	<alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36987 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbbIWOFL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 10:05:11 -0400
Received: by wicfx3 with SMTP id fx3so70883012wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 07:05:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 6:15 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 23 Sep 2015, Igor Fedotov wrote:
>> Hi Sage,
>> thanks a lot for your feedback.
>>
>> Regarding issues with offset mapping and stripe size exposure.
>> What's about the idea to apply compression in two-tier (cache+backin=
g storage)
>> model only ?
>
> I'm not sure we win anything by making it a two-tier only thing... si=
mply
> making it a feature of the EC pool means we can also address EC pool =
users
> like radosgw.
>
>> I doubt single-tier one is widely used for EC pools since there is n=
o random
>> write support in such mode. Thus this might be an acceptable limitat=
ion.
>> At the same time it seems that appends caused by cached object flush=
 have
>> fixed block size (8Mb by default). And object is totally rewritten o=
n the next
>> flush if any. This makes offset mapping less tricky.
>> Decompression should be applied in any model though as cache tier sh=
utdown and
>> subsequent compressed data access is possibly  a valid use case.
>
> Yeah, we need to handle random reads either way, so I think the offse=
t
> mapping is going to be needed anyway.

The idea of making the primary responsible for object compression
really concerns me. It means for instance that a single random access
will likely require access to multiple objects, and breaks many of the
optimizations we have right now or in the pipeline (for instance:
direct client access). And apparently only the EC pool will support
compression, which is frustrating for all the replicated pool users
out there...

Is there some reason we don't just want to apply encryption across an
OSD store? Perhaps doing it on the filesystem level is the wrong way
(for reasons named above) but there are other mechanisms like inline
block device compression that I think are supposed to work pretty
well. The only thing that doesn't get us that I can see mentioned here
is the over-the-wire compression =E2=80=94 and Haomai already has patch=
es for
that, which should be a lot easier to validate and will work at all
levels of the stack!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
