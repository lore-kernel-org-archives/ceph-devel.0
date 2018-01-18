From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: RGW S3 vs S3 signature
Date: Thu, 18 Jan 2018 09:53:03 -0500
Message-ID: <CAKOnarkJS2GX-SU4yiBcdRD7TNpcAcjx1kbDEypamJY-eqzmWw@mail.gmail.com>
References: <06681238D8946F44A60AA400760A1CBF124E0505@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:40384 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbeAROxE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jan 2018 09:53:04 -0500
Received: by mail-it0-f52.google.com with SMTP id 196so13828760iti.5
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jan 2018 06:53:04 -0800 (PST)
In-Reply-To: <06681238D8946F44A60AA400760A1CBF124E0505@SHSMSX103.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Yuan,

AWS v4 signatures are supported in Jewel.  Could you create a tracker
issue with RGW debug logs to help track down the issue you hit?

thanks,

Matt

On Thu, Jan 18, 2018 at 9:39 AM, Zhou, Yuan <yuan.zhou@intel.com> wrote:
> Hello,
>
> Trying to some tests with Hadoop 2.9 + Ceph S3(Jewel, 10.2.10) and ran into a multi-part uploading issue. It looks like the new S3a driver(aws-java-sdk-bundle-1.11.199.jar, v4 signature) in Hadoop is not compatible with Ceph S3(Jewel).
>
> I find there's a doc on S3 API support status, but lack of the corresponding S3 version info there. Is there any info on the detail supported version, v2 only?
> http://docs.ceph.com/docs/jewel/radosgw/s3/
>
> I also find some commit to enable the V4 support here, I think this should be ready in Luminous?
> https://github.com/ceph/ceph/pull/15965/commits/82a7aa9e3eabfde4a82046d78aad2dadbfc0d8e1
>
>
> Any comments would be appreciated!
>
> Thanks, -yuan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-821-5101
fax.  734-769-8938
cel.  734-216-5309
