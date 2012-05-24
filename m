From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RGW, future directions
Date: Thu, 24 May 2012 10:23:02 +0200
Message-ID: <CAMwB3ThqNG7=neTc_=NJ87_yB33vtr+CNnjR9og_TG5RwUrJgA@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
	<4FBDC403.9090106@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:60187 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2EXIXE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 04:23:04 -0400
Received: by wgbds11 with SMTP id ds11so5434267wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 01:23:02 -0700 (PDT)
In-Reply-To: <4FBDC403.9090106@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org

On Thu, May 24, 2012 at 7:15 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
>
> On 22-05-12 20:07, Yehuda Sadeh wrote:
>>
>> RGW is maturing. Beside looking at performance, which highly ties in=
to
>> RADOS performance, we'd like to hear whether there are certain pain
>> points or future directions that you (you as in the ceph community)
>> would like to see us taking.
>>
>> There are a few directions that we were thinking about:
>>
>> 1. Extend Object Storage API
>>
>> Swift and S3 has some features that we don't currently support. We c=
an
>> certainly extend our functionality, however, is there any demand for
>> more features? E.g., self destructing objects, web site, user logs,
>> etc.
>>
>> 2. Better OpenStack interoperability
>>
>> Keystone support? Other?
>>
>> 3. New features
>>
>> Some examples:
>>
>> =C2=A0- multitenancy: api for domains and user management
>> =C2=A0- snapshots
>> =C2=A0- computation front end: upload object, then do some data
>> transformation/calculation.
>> =C2=A0- simple key-value api
>>
>> 4. CDMI
>>
>> Sage brought up the CDMI support question to ceph-devel, and I don't
>> remember him getting any response. Is there any intereset in CDMI?
>>
>>
>> 5. Native apache/nginx module or embedded web server
>>
>> We still need to prove that the web server is a bottleneck, or poses
>> scaling issues. Writing a correct native nginx module will require
>> turning rgw process model into event driven, which is not going to b=
e
>> easy.
>>
>
> I'd not go for a native nginx or Apache module, that would bring extr=
a C
> code into the story which would mean extra dependencies.
>
> My vote would still go to a embedded webserver written in something l=
ike
> Python. You could then use Apache/nginx/Varnish as a reverse proxy in=
 front
> and do all kinds of cool stuff.
>
> You could even doing caching in nginx or Varnish and let the RGW noti=
fy
> those proxy's when an object has changed so they can purge their cach=
e. This
> would dramatically improve the performance of the gateway.
>
> It would also simplify the code, why try to do caching on your own wh=
en some
> great HTTP caches are out there?
>

100% +1

>
>> 6. Improve garbage collection
>>
>> Currently rgw generates intent logs for garabage removal that requir=
e
>> running an external tool later, which is an administrative pain. We
>> can implement other solutions (OSD side garbage collection,
>> integrating cleanup process into the gateway, etc.) but we need to
>> understand the priority.
>>
>> 7. libradosgw
>>
>> We have had this in mind for some time now. Creating a programming a=
pi
>> for rgw, not too different from librados and librbd. It'll hopefully
>> make code much cleaner. It will allow users to write different front
>> ends for the rgw backend, and it will make it easier for users to
>> write applications that interact with the backend, e.g., do processi=
ng
>> on objects that users uploaded, FUSE for rgw without S3 as an
>> intermediate, etc.
>>
>
> Yes, I would really like this. Combine this with the Python
> stand-alone/embedded webserver I proposed and you get a really nice R=
GW I
> think.
>
>
>> 8. Administration tools improvement
>>
>> We can always do better there.
>>
>
> When we have libradosgw it wouldn't be that hard to make a nice web
> front-end where you can manage the whole thing.
>
>
>> 9. Other ideas?
>>
>>
>> Any comments are welcome!
>>
>> Thanks,
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
