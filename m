From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: RGW, future directions
Date: Thu, 24 May 2012 13:49:34 +0800
Message-ID: <CANExM-M20zhkw+zRSiYyovHSi2m8tnhuDJmgKG4cCR96hSyc6w@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
	<CANExM-PHHCwnH8n_nrjA=HJ0uzL268kjZf6pAh5+Eh73=1UPMg@mail.gmail.com>
	<CAC-hyiFYYk23WMqdY4zG-tsBio+dWJSn3x-u+pnXPwGiBXvHKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39050 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2EXFtf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 01:49:35 -0400
Received: by ghrr11 with SMTP id r11so1663720ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 22:49:35 -0700 (PDT)
In-Reply-To: <CAC-hyiFYYk23WMqdY4zG-tsBio+dWJSn3x-u+pnXPwGiBXvHKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/5/24 Yehuda Sadeh <yehuda@inktank.com>:
> On Wed, May 23, 2012 at 1:59 AM, Henry C Chang <henry.cy.chang@gmail.com> wrote:
>> 2012/5/23 Yehuda Sadeh <yehuda@inktank.com>:
>>> RGW is maturing. Beside looking at performance, which highly ties into
>>> RADOS performance, we'd like to hear whether there are certain pain
>>> points or future directions that you (you as in the ceph community)
>>> would like to see us taking.
>>>
>>> There are a few directions that we were thinking about:
>>>
>>> 1. Extend Object Storage API
>>>
>>> Swift and S3 has some features that we don't currently support. We can
>>> certainly extend our functionality, however, is there any demand for
>>> more features? E.g., self destructing objects, web site, user logs,
>>> etc.
>>>
>>
>> I would like to see radosgw supporting:
>> - Object versioning
>
> Yeah, we had that in mind for while now. Ceph issue #418. We have made
> some progress towards that, but we're not there yet.
>
>> - Bucket policy
>
> Anything specific that you'd like to see there? Bucket policy is very
> tied into amazon aws, and I don't think we should clone that. We can,
> however, look at what additional useful functionality we can have.
>

To me, one of the most powerful thing of bucket policy is: it allows
you to set permissions for a large number of objects with one
statement. Below is a simple example. You can specify the "Resource"
with a wildcard (or even <bucket>/<obj_prefix>*).

{
  "Version":"2008-10-17",
  "Statement":[{
	"Sid":"AddPerm",
        "Effect":"Allow",
	  "Principal": {
            "AWS": "*"
         },
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::bucket/*"
      ]
    }
  ]
}

I agree, we don't have to clone that. Similar functionality would be great!!


>>> 7. libradosgw
>>>
>>> We have had this in mind for some time now. Creating a programming api
>>> for rgw, not too different from librados and librbd. It'll hopefully
>>> make code much cleaner. It will allow users to write different front
>>> ends for the rgw backend, and it will make it easier for users to
>>> write applications that interact with the backend, e.g., do processing
>>> on objects that users uploaded, FUSE for rgw without S3 as an
>>> intermediate, etc.
>>>
>>
>> I am also interested in libradosgw. With it, we can support other
>> protocols easily. (e.g., webdav)
>>
>
>
> Thanks,
> Yehuda
