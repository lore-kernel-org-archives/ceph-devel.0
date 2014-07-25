From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: Fwd: S3 API Compatibility support
Date: Fri, 25 Jul 2014 22:44:44 +0530
Message-ID: <CANA9Uk468XOE1cr935HY1y+tSnu-xp6QPaj7uCpZNQbJhg-pOA@mail.gmail.com>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com>
	<CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
	<alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:64370 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbaGYROq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 13:14:46 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so3250117lan.5
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 10:14:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Thanks for quick reply.
Yes,  versioned object - missing in ceph ATM
Iam looking for: bucket lifecylce (get/put/delete), bucket location,
put object notification and object restore (ie versioned object) S3
API support.
Please let me now any of the above work is in progress or some one
planned to work on.

Thanks
Swami


On Fri, Jul 25, 2014 at 9:19 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 25 Jul 2014, M Ranga Swami Reddy wrote:
>> Hi Team: As per the ceph document a few S3 APIs compatibility not supported.
>>
>> Link: http://ceph.com/docs/master/radosgw/s3/
>>
>> Is there plan to support the ?n supported item in the above table?
>> or
>> Any working on this?
>
> Yes.  Unfortunately this table isn't particularly detailed or accurate or
> up to date.   The main gap, I think, is versioned objects.
>
> Are there specfiic parts of the S3 API that are missing that you need?
> That sort of info is very helpful for prioritizing effort...
>
> sage
