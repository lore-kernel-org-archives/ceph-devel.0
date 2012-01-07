From: huang jun <hjwsm1989@gmail.com>
Subject: Re: questions about radosgw
Date: Sat, 7 Jan 2012 11:10:15 +0800
Message-ID: <CABAwU-Y-h+1Yez49wsYzNnDF_=KLdMQg6osY1XHi2NHTSZDRhw@mail.gmail.com>
References: <CABAwU-ZVOzWBH1ethSuCFmNODC9bN3QPO7DMj3Y8EwP5tM3xjA@mail.gmail.com>
	<4F05AE63.8080302@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:46946 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759377Ab2AGDKR convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Jan 2012 22:10:17 -0500
Received: by obcwo16 with SMTP id wo16so2590908obc.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2012 19:10:16 -0800 (PST)
In-Reply-To: <4F05AE63.8080302@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

hi,wido
I have an idea, why not use radosgw+fs to balance the workload?
but i can not successfully deploy it.
I really want to know whether radosgw+fs works?
If so, how about the performance between radosgw+fs and radosgw+rados?

thanks!

2012/1/5 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
>
> On 01/05/2012 12:48 PM, huang jun wrote:
>>
>> hi,all
>> I'am using the s3+radosgw, there are some questions confused me very=
 much:
>> first) An object's size is 400MB, then the =A0whole object will stor=
ed
>> in OSDs as one big single object, but not striped into 4MB objects. =
so
>> how can we got workload banlance if we want to store big objects and
>> small ones?
>
>
> That is correct, RADOS nor the RADOS gateway stripes objects.
>
> You will get workload balance if you have a (almost) even spread of w=
orkload
> over your different objects.
>
> The dev's might shed some more light on this.
>
>
>> second) Can we change the number of pgs in a pool that created by S3
>> clients or just using rados commands?
>
>
> As far as I know you can't do this through the S3 clients but only wi=
th the
> rados commands. I also would find it rather weird if you could do thi=
s as a
> client.
>
> Wido
>
>>
>> thanks
>>
>



--=20
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
