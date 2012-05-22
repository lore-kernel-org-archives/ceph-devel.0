From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RGW, future directions
Date: Tue, 22 May 2012 21:56:52 +0200
Message-ID: <CAMwB3TjT1oN27HDO=9KNTc8jFatijzX5Tg=zhYBs_+25e9eZHA@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
	<CAMwB3Tj00tJPRh7Z9C1Fd78-a-A9q0+ZCqrHRqy7wzijXh3UCg@mail.gmail.com>
	<CAC-hyiHcf+vt_EzdsYo9m2Ti5DsNbRP536CefTuMvbeZDq+C+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44879 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab2EVT4x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:56:53 -0400
Received: by weyu7 with SMTP id u7so4130330wey.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 12:56:52 -0700 (PDT)
In-Reply-To: <CAC-hyiHcf+vt_EzdsYo9m2Ti5DsNbRP536CefTuMvbeZDq+C+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 22, 2012 at 9:09 PM, Yehuda Sadeh <yehuda@inktank.com> wrot=
e:
> On Tue, May 22, 2012 at 11:25 AM, S=B3awomir Skowron <szibis@gmail.co=
m> wrote:
>> On Tue, May 22, 2012 at 8:07 PM, Yehuda Sadeh <yehuda@inktank.com> w=
rote:
>>> RGW is maturing. Beside looking at performance, which highly ties i=
nto
>>> RADOS performance, we'd like to hear whether there are certain pain
>>> points or future directions that you (you as in the ceph community)
>>> would like to see us taking.
>>>
>>> There are a few directions that we were thinking about:
>>>
>>> 1. Extend Object Storage API
>>>
>>> Swift and S3 has some features that we don't currently support. We =
can
>>> certainly extend our functionality, however, is there any demand fo=
r
>>> more features? E.g., self destructing objects, web site, user logs,
>>> etc.
>>
>> More compatibility with S3 and swift is good.

Now i have no issues about that, because we use only simples parts of
S3, but there is always, a good if compatibility is better.

>
> Any specific functional interest?
>
>>
>>>
>>> 2. Better OpenStack interoperability
>>>
>>> Keystone support? Other?
>>>
>>> 3. New features
>>>
>>> Some examples:
>>>
>>> =A0- multitenancy: api for domains and user management

multitenancy - quotas, QoS, and user management it's nice feature for
admin, especially in cloud systems, with many different type of
control, even performance, and nice integration API for external
accounting services in cloud system.

>>> =A0- snapshots
>>> =A0- computation front end: upload object, then do some data
>>> transformation/calculation.
>>> =A0- simple key-value api
>>>
>>> 4. CDMI
>>>
>>> Sage brought up the CDMI support question to ceph-devel, and I don'=
t
>>> remember him getting any response. Is there any intereset in CDMI?
>>>
>>>
>>> 5. Native apache/nginx module or embedded web server
>>>
>>> We still need to prove that the web server is a bottleneck, or pose=
s
>>> scaling issues. Writing a correct native nginx module will require
>>> turning rgw process model into event driven, which is not going to =
be
>>> easy.
>>>
>>
>> nginx module is nice thing.
>
> It would be nice to have some concrete numbers as to where apache or
> nginx with fastcgi holding us back, and how a dedicated module is
> going to improve that. As a rule of thumb it is a no brainer, but
> still we want to have a better understanding of the situation before
> we dive into such a project.

Now it's hard to say, beacause for now there is now intensive traffic
@ this cluster. I have only synthetic test. Reads from one machine in
cluster are about 500req/s (no nginx cache) via nginx <-> radosgw
fcgi, but machine can handle more (cpu, ram, drives). I need to test
that how it's realy holding this a whole service. With cache enabled
in nginx, reads operation are no issue, but writes (PUTs, DELETEs)
will always be problematic, but now radosgw have improved with this a
lot.

>
>>
>>> 6. Improve garbage collection
>>>
>>> Currently rgw generates intent logs for garabage removal that requi=
re
>>> running an external tool later, which is an administrative pain. We
>>> can implement other solutions (OSD side garbage collection,
>>> integrating cleanup process into the gateway, etc.) but we need to
>>> understand the priority.
>>
>> crontab can handle this task for now, but in big workload, better if
>> it's integrated, like scrub, and tuned via conf
>
> Yeah. One of the original ideas was to leverage scrubbing for objects
> expiration (issue #1994). The discussion never converged, as the devi=
l
> is as always in the details. We can revive that discussion.
>
>>
>>>
>>> 7. libradosgw
>>>
>>> We have had this in mind for some time now. Creating a programming =
api
>>> for rgw, not too different from librados and librbd. It'll hopefull=
y
>>> make code much cleaner. It will allow users to write different fron=
t
>>> ends for the rgw backend, and it will make it easier for users to
>>> write applications that interact with the backend, e.g., do process=
ing
>>> on objects that users uploaded, FUSE for rgw without S3 as an
>>> intermediate, etc.
>>>
>>> 8. Administration tools improvement
>>>
>>> We can always do better there.
>>>
>>> 9. Other ideas?
>>
>> - I would like to see a feature that can make replication between
>> clusters. For start 2 clusters. It's a very good feature, when you
>> have two datacenters, and repliacation goes via hight speed link, bu=
t
>> aplications at top of clusters does not need to handle this tasks, a=
nd
>> data are consistent.
>
> This is a more generic ceph issue. We do need, however, to be able to
> support multiple clusters in rgw. Opened issue #2460.

=46or rbd is nice feature too :)

>
>>
>> - gracefull upgrade
>
> Can you elaborate on that? This is always our intention, we've put
> some mechanisms in place to help with that, although it is not always
> possible.

How to upgrade cluster without any down ?? How to upgrade cluster with
new features that change logic with 100% uptime ?? Yes i understand
that sometimes, big changes need restart, a whole cluster at once, but
in many situations, info about that before upgrade, or tool that tell
administrator, that this will be needed it's important. Tests and
integration env before upgrade is helpful, but maybe there is a way to
make upgrade more smooth and secure.

>
>>
>> - reload cluster config without restart daemons - or maybe this exis=
t
>> right now ??
>>
>
> I opened issue #2459.


>
> Thanks,
> Yehuda



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
