From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: RGW bucket tagging
Date: Fri, 26 Jan 2018 11:08:49 -0500
Message-ID: <CAKOnar=rwS6SKDDbAk6udCi8bJUD5pnM1g4ZSkH-VD4Edjo-rg@mail.gmail.com>
References: <CAA1GxO07U6t_WQhHFur9BPjaaWhZoA1nGazffSB_1Nfjptetog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:45930 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeAZQIv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jan 2018 11:08:51 -0500
Received: by mail-io0-f176.google.com with SMTP id p188so914955ioe.12
        for <ceph-devel@vger.kernel.org>; Fri, 26 Jan 2018 08:08:50 -0800 (PST)
In-Reply-To: <CAA1GxO07U6t_WQhHFur9BPjaaWhZoA1nGazffSB_1Nfjptetog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Calminder <andreas.calminder@klarna.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>

Hi Andreas,

I think we don't support bucket tagging yet.  There is support for
object tagging, plus integration w/bucket policy and lifecycle.

Abhishek, do you have anything to add here?

Matt

On Fri, Jan 26, 2018 at 9:47 AM, Andreas Calminder
<andreas.calminder@klarna.com> wrote:
> Hello,
> I'm evaluating the possibility of using tags for buckets in RGW, using
> boto3 s3.BucketTagging.put returns  client error and the rgw log
> throws a 400 and says: provided input did not specify location
> constraint correctly
>
> I figured it's most likely that I did something silly in the code,
> however before digging deeper I figured I should probably check if
> it's even supported in RGW, I found this:
> http://docs.ceph.com/docs/master/dev/radosgw/s3_compliance/
>
> Which says Bucket Tagging "?", So I suspect Bucket Tagging isn't
> supported? Any clarification or pointers appreciated here.
>
> Thanks!
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
