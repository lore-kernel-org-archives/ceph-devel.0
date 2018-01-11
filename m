From: Huamin Chen <hchen@redhat.com>
Subject: Re: CSI (container storage interface)
Date: Thu, 11 Jan 2018 13:42:09 -0500
Message-ID: <CAD-gW=nyuuJ7GeYJPjsH5x4wPXWZbs28X1H16RidU0TOntp6gQ@mail.gmail.com>
References: <alpine.DEB.2.11.1801101842180.17779@piezo.novalocal> <B03A147C-24FA-415D-9C74-A3821725AEEE@tabbara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:39834 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeAKSmK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jan 2018 13:42:10 -0500
Received: by mail-ot0-f173.google.com with SMTP id 37so2931505otv.6
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jan 2018 10:42:10 -0800 (PST)
In-Reply-To: <B03A147C-24FA-415D-9C74-A3821725AEEE@tabbara.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <bassam@tabbara.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Steve LeonTang <Steve.LeonTang@quantum.com>

(resending, previous reply bounced back)

Hi Bassam,

Thanks for the suggestions.

Having a CSI repo is a great first step. Now Serguei is putting up a
prototype as PR #1. It mirrors the current k8s in tree rbd volume
plugin.

Since the project just starts, there is no formal meetings and process
management. Since not every contributor here use Ceph tracker, I
propose to use github issues for issue and bug tracking, feature
request, and assignment so we can track topics like krbd/nbd, cephfs
and fuse.

On Wed, Jan 10, 2018 at 5:29 PM, Bassam Tabbara <bassam@tabbara.com> wrote:
> Excellent! Excited to see this work starting.
>
> Could we please get a blueprint/design on ceph-csi written down and reviewed?
>
> There are a lot of different topics to consider here around secret management, user-mode vs. kernel, etc. that might be better sorted in a design doc vs. in PR reviews.
>
> (cc’ing steve that offered to help)
>
>> On Jan 10, 2018, at 10:45 AM, Sage Weil <sweil@redhat.com> wrote:
>>
>> Development has kicked off on a CSI driver for Ceph (RBD initially; CephFS
>> will follow).  See
>>
>>       https://github.com/ceph/ceph-csi
>>       https://github.com/ceph/ceph-csi/pulls
>>
>> CSI is a generic provisioning (and attachment) interface for container
>> orchestration platforms, including Kubernetes and Mesos.
>>
>>       https://github.com/container-storage-interface/spec
>>
>> In the kubernetes context, this will /eventually/ replace the in-tree RBD
>> and CephFS volume drivers, as well as Rook's flex volume plugin.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
