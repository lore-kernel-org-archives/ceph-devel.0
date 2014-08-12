From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: Fwd: S3 API Compatibility support
Date: Tue, 12 Aug 2014 22:28:43 +0530
Message-ID: <CANA9Uk5u5q4CGDPat+rdPVY=e-bYA6gG+aii6zMAoxUdK+CQuA@mail.gmail.com>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com>
	<CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
	<alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
	<CANA9Uk468XOE1cr935HY1y+tSnu-xp6QPaj7uCpZNQbJhg-pOA@mail.gmail.com>
	<CABBk=J8+3K28M-RNf+ULx0TnTMmGxdymJDLeFMft-EX8PhS_4A@mail.gmail.com>
	<CANA9Uk58WqPoH-mGiuNiXwfJK1YJtozxOjhgmDeKDq585xqx9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:35416 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbaHLQ6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 12:58:45 -0400
Received: by mail-la0-f52.google.com with SMTP id b17so7140839lan.11
        for <ceph-devel@vger.kernel.org>; Tue, 12 Aug 2014 09:58:43 -0700 (PDT)
In-Reply-To: <CANA9Uk58WqPoH-mGiuNiXwfJK1YJtozxOjhgmDeKDq585xqx9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Yehuda,
Can I please get any suggestion on the "get bucket_location" API
error?  Please share any info, which can help us to debug more here.

Thanks
Swami

On Mon, Aug 4, 2014 at 4:44 PM, M Ranga Swami Reddy
<swamireddy@gmail.com> wrote:
> Hi Yehuda,
> I tried to test the get bucket location API, but got an error as
> below. Is this known issue? Could you please confirm.  Thanks,Swami
> ====
> In [14]: b.get_location()
> send: 'GET /some-bucket-from-libs3/?
> location HTTP/1.1\r\nHost: 192.168.122.61\r\nAccept-Encoding:
> identity\r\nDate: Fri, 01 Aug 2014 12:02:22 GMT\r\nContent-Length:
> 0\r\nAuthorization: AWS
> cec157b52253463b91547e0a73369960:sT5aw9yXantfAafRn/6x+IgI1pk=\r\nUser-Agent:
> Boto/2.20.1 Python/2.7.6 Linux/3.13.0-29-generic\r\n\r\n'
> reply: ''
> send: 'GET /some-bucket-from-libs3/?location HTTP/1.1\r\nHost:
> 192.168.122.61\r\nAccept-Encoding: identity\r\nDate: Fri, 01 Aug 2014
> 12:02:22 GMT\r\nContent-Length: 0\r\nAuthorization: AWS
> cec157b52253463b91547e0a73369960:sT5aw9yXantfAafRn/6x+IgI1pk=\r\nUser-Agent:
> Boto/2.20.1 Python/2.7.6 Linux/3.13.0-29-generic\r\n\r\n'
> reply: 'HTTP/1.1 200 OK\r\n'
> header: Date: Fri, 01 Aug 2014 12:02:23 GMT
> header: Server: Apache/2.4.7 (Ubuntu)
> header: Vary: Accept-Encoding
> header: Transfer-Encoding: chunked
> header: Content-Type: application/xml
> ---------------------------------------------------------------------------
> AttributeError                            Traceback (most recent call last)
> <ipython-input-14-7c597523523d> in <module>()
> ----> 1 b.get_location()
>
> /usr/lib/python2.7/dist-packages/boto/s3/bucket.pyc in get_location(self)
>    1005             h = handler.XmlHandler(rs, self)
>    1006             xml.sax.parseString(body, h)
> -> 1007             return rs.LocationConstraint
>    1008         else:
>    1009             raise self.connection.provider.storage_response_error(
>
> AttributeError: 'ResultSet' object has no attribute 'LocationConstraint'
> ===
>
> On Fri, Jul 25, 2014 at 11:31 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>> On Fri, Jul 25, 2014 at 10:14 AM, M Ranga Swami Reddy
>> <swamireddy@gmail.com> wrote:
>>> Thanks for quick reply.
>>> Yes,  versioned object - missing in ceph ATM
>>> Iam looking for: bucket lifecylce (get/put/delete), bucket location,
>>> put object notification and object restore (ie versioned object) S3
>>> API support.
>>> Please let me now any of the above work is in progress or some one
>>> planned to work on.
>>
>>
>> I opened an issue for bucket lifecycle (we already had an issue open
>> for object expiration though). We do have bucket location already
>> (part of the multi-region feature). Object versioning is definitely on
>> our backlog and one that we'll hopefully implement sooner rather
>> later.
>> With regard to object notification, it'll require having a
>> notification service which is a bit out of the scope. Integrating the
>> gateway with such a service whouldn't be hard, but we'll need to have
>> that first.
>>
>> Yehuda
>>
>>>
>>> Thanks
>>> Swami
>>>
>>>
>>> On Fri, Jul 25, 2014 at 9:19 PM, Sage Weil <sweil@redhat.com> wrote:
>>>> On Fri, 25 Jul 2014, M Ranga Swami Reddy wrote:
>>>>> Hi Team: As per the ceph document a few S3 APIs compatibility not supported.
>>>>>
>>>>> Link: http://ceph.com/docs/master/radosgw/s3/
>>>>>
>>>>> Is there plan to support the ?n supported item in the above table?
>>>>> or
>>>>> Any working on this?
>>>>
>>>> Yes.  Unfortunately this table isn't particularly detailed or accurate or
>>>> up to date.   The main gap, I think, is versioned objects.
>>>>
>>>> Are there specfiic parts of the S3 API that are missing that you need?
>>>> That sort of info is very helpful for prioritizing effort...
>>>>
>>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
