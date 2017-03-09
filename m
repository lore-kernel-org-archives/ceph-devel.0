From: Jiaying Ren <mikulely@gmail.com>
Subject: Re: RGW: Implement S3 bucket logging feature
Date: Thu, 9 Mar 2017 12:31:18 +0800
Message-ID: <CAF8OO3PV=K-LAH8U8-PTGGRkq8PHzbm=Fm0B5X-PFkMfmwqPEQ@mail.gmail.com>
References: <CAF8OO3P3UiP+23CLUY0doYJLJNroAm2m5fu5zap6ctr3uP9wtw@mail.gmail.com>
 <robbat2-20170308T204010-762077588Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36081 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbdCIEk1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 23:40:27 -0500
Received: by mail-qk0-f169.google.com with SMTP id 1so101939156qkl.3
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 20:40:26 -0800 (PST)
In-Reply-To: <robbat2-20170308T204010-762077588Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 9 March 2017 at 04:42, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Wed, Mar 08, 2017 at 04:21:18PM +0800, Jiaying Ren wrote:
>> Hi~ Yehuda and Ceph developers:
>>
>> We're trying to implement S3 feature bucket
>> logging (http://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html).
> ...
>> Any comments are appreciated.Thx.
>
> Strongly in favour of this from my end, and willing to find some cycles
> to help you test/review it.
>
> One thing that comes to mind, is ensuring logging of the correct client
> IP when a load-balancer (eg HAProxy) is used in front of the RGW
> instances. The internal IP of the load balancer should NOT be
> written/exposed in the logs.

Hi~ Robin:

Thx for reminding. It seems current impl define a config option
rgw_remote_addr_param(https://github.com/ceph/ceph/blob/master/src/rgw/rgw_log.cc#L343)
to replace internal IP?

>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
