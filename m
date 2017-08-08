From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: radosgw: stale/leaked bucket index entries
Date: Tue, 8 Aug 2017 19:18:16 -0400
Message-ID: <CAKOnarm0Lm5Ya_XLz8bXpYTNgikSbOLFA0FYvhuO0fSpB_-SfQ@mail.gmail.com>
References: <6B335CE5-2828-47E7-A993-2D5ACC302AC1@walmartlabs.com> <07824FC2-2F4A-4DAD-B38A-39973B4D96E5@TERADATA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:37168 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHHXSR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 19:18:17 -0400
Received: by mail-pg0-f44.google.com with SMTP id y129so20577243pgy.4
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 16:18:17 -0700 (PDT)
In-Reply-To: <07824FC2-2F4A-4DAD-B38A-39973B4D96E5@TERADATA.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: Pavan Rallabhandi <PRallabhandi@walmartlabs.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Nitin,

It's pending-backport.

Matt

On Tue, Aug 8, 2017 at 6:37 PM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
> Good you have brought this issue. I also have seen the stale index entries lingering after objection deletion for rgw. It would be nice to see this issue captured and addressed in a bug.
>
> Nitin
>
>
> On 6/19/17, 10:37 AM, "ceph-devel-owner@vger.kernel.org on behalf of Pavan Rallabhandi" <ceph-devel-owner@vger.kernel.org on behalf of PRallabhandi@walmartlabs.com> wrote:
>
>     On many of our clusters running Jewel (10.2.5+), am running into a strange problem of having stale bucket index entries left over for (some of the) objects deleted. Though it is not reproducible at will, it has been pretty consistent of late and am clueless at this point for the possible reasons to happen so.
>
>     The symptoms are that the actual delete operation of an object is reported successful in the RGW logs, but a bucket list on the container would still show the deleted object. An attempt to download/stat of the object appropriately results in a failure. No failures are seen in the respective OSDs where the bucket index object is located. And rebuilding the bucket index by running ‘radosgw-admin bucket check –fix’ would fix the issue.
>
>     Though I could simulate the problem by instrumenting the code, to not to have invoked `complete_del` on the bucket index op https://github.com/ceph/ceph/blob/master/src/rgw/rgw_rados.cc#L8793, but that call is always seem to be made unless there is a cascading error from the actual delete operation of the object, which doesn’t seem to be the case here.
>
>     I wanted to know the possible reasons where the bucket index would be left in such limbo, any pointers would be much appreciated. FWIW, we are not sharding the buckets and very recently I’ve seen this happen with buckets having as low as
>     < 10 objects, and we are using swift for all the operations.
>
>     Thanks,
>     -Pavan.
>
>     ?�{.n�+�������+%��lzwm��b�맲��r��yǩ�ׯzX��?��ܨ}���Ơz�&j:+v���?����zZ+��+zf���h���~����i���z�?�w���?����&�)ߢ?f
>
