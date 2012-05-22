From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RGW, future directions
Date: Tue, 22 May 2012 20:25:17 +0200
Message-ID: <CAMwB3Tj00tJPRh7Z9C1Fd78-a-A9q0+ZCqrHRqy7wzijXh3UCg@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48504 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab2EVSZT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 14:25:19 -0400
Received: by weyu7 with SMTP id u7so4079780wey.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 11:25:18 -0700 (PDT)
In-Reply-To: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 22, 2012 at 8:07 PM, Yehuda Sadeh <yehuda@inktank.com> wrot=
e:
> RGW is maturing. Beside looking at performance, which highly ties int=
o
> RADOS performance, we'd like to hear whether there are certain pain
> points or future directions that you (you as in the ceph community)
> would like to see us taking.
>
> There are a few directions that we were thinking about:
>
> 1. Extend Object Storage API
>
> Swift and S3 has some features that we don't currently support. We ca=
n
> certainly extend our functionality, however, is there any demand for
> more features? E.g., self destructing objects, web site, user logs,
> etc.

More compatibility with S3 and swift is good.

>
> 2. Better OpenStack interoperability
>
> Keystone support? Other?
>
> 3. New features
>
> Some examples:
>
> =A0- multitenancy: api for domains and user management
> =A0- snapshots
> =A0- computation front end: upload object, then do some data
> transformation/calculation.
> =A0- simple key-value api
>
> 4. CDMI
>
> Sage brought up the CDMI support question to ceph-devel, and I don't
> remember him getting any response. Is there any intereset in CDMI?
>
>
> 5. Native apache/nginx module or embedded web server
>
> We still need to prove that the web server is a bottleneck, or poses
> scaling issues. Writing a correct native nginx module will require
> turning rgw process model into event driven, which is not going to be
> easy.
>

nginx module is nice thing.

> 6. Improve garbage collection
>
> Currently rgw generates intent logs for garabage removal that require
> running an external tool later, which is an administrative pain. We
> can implement other solutions (OSD side garbage collection,
> integrating cleanup process into the gateway, etc.) but we need to
> understand the priority.

crontab can handle this task for now, but in big workload, better if
it's integrated, like scrub, and tuned via conf

>
> 7. libradosgw
>
> We have had this in mind for some time now. Creating a programming ap=
i
> for rgw, not too different from librados and librbd. It'll hopefully
> make code much cleaner. It will allow users to write different front
> ends for the rgw backend, and it will make it easier for users to
> write applications that interact with the backend, e.g., do processin=
g
> on objects that users uploaded, FUSE for rgw without S3 as an
> intermediate, etc.
>
> 8. Administration tools improvement
>
> We can always do better there.
>
> 9. Other ideas?

- I would like to see a feature that can make replication between
clusters. For start 2 clusters. It's a very good feature, when you
have two datacenters, and repliacation goes via hight speed link, but
aplications at top of clusters does not need to handle this tasks, and
data are consistent.

- gracefull upgrade

- reload cluster config without restart daemons - or maybe this exist
right now ??

>
>
> Any comments are welcome!
>
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
