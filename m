From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW, future directions
Date: Tue, 22 May 2012 12:09:54 -0700
Message-ID: <CAC-hyiHcf+vt_EzdsYo9m2Ti5DsNbRP536CefTuMvbeZDq+C+A@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
	<CAMwB3Tj00tJPRh7Z9C1Fd78-a-A9q0+ZCqrHRqy7wzijXh3UCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43704 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab2EVTJz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:09:55 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so5295676bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 12:09:54 -0700 (PDT)
In-Reply-To: <CAMwB3Tj00tJPRh7Z9C1Fd78-a-A9q0+ZCqrHRqy7wzijXh3UCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 22, 2012 at 11:25 AM, S=C5=82awomir Skowron <szibis@gmail.c=
om> wrote:
> On Tue, May 22, 2012 at 8:07 PM, Yehuda Sadeh <yehuda@inktank.com> wr=
ote:
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
>
> More compatibility with S3 and swift is good.

Any specific functional interest?

>
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
> nginx module is nice thing.

It would be nice to have some concrete numbers as to where apache or
nginx with fastcgi holding us back, and how a dedicated module is
going to improve that. As a rule of thumb it is a no brainer, but
still we want to have a better understanding of the situation before
we dive into such a project.

>
>> 6. Improve garbage collection
>>
>> Currently rgw generates intent logs for garabage removal that requir=
e
>> running an external tool later, which is an administrative pain. We
>> can implement other solutions (OSD side garbage collection,
>> integrating cleanup process into the gateway, etc.) but we need to
>> understand the priority.
>
> crontab can handle this task for now, but in big workload, better if
> it's integrated, like scrub, and tuned via conf

Yeah. One of the original ideas was to leverage scrubbing for objects
expiration (issue #1994). The discussion never converged, as the devil
is as always in the details. We can revive that discussion.

>
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
>> 8. Administration tools improvement
>>
>> We can always do better there.
>>
>> 9. Other ideas?
>
> - I would like to see a feature that can make replication between
> clusters. For start 2 clusters. It's a very good feature, when you
> have two datacenters, and repliacation goes via hight speed link, but
> aplications at top of clusters does not need to handle this tasks, an=
d
> data are consistent.

This is a more generic ceph issue. We do need, however, to be able to
support multiple clusters in rgw. Opened issue #2460.

>
> - gracefull upgrade

Can you elaborate on that? This is always our intention, we've put
some mechanisms in place to help with that, although it is not always
possible.

>
> - reload cluster config without restart daemons - or maybe this exist
> right now ??
>

I opened issue #2459.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
