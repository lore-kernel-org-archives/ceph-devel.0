From: Kiran Patil <kirantpatil@gmail.com>
Subject: Re: RGW, future directions
Date: Wed, 23 May 2012 15:47:31 +0530
Message-ID: <CANT588skKYuwE2sGvkNs_7W0i=X5Ts=mr_Z+4iQXE4BUpqQcmg@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61200 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755559Ab2EWKRd convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 May 2012 06:17:33 -0400
Received: by lahd3 with SMTP id d3so4979239lah.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 03:17:31 -0700 (PDT)
In-Reply-To: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello,

How about this CloudFS=A0management=A0system ?

The=A0CloudFS=A0management=A0system=A0consists=A0of=A0two=A0parts:=A0a=A0=
very=A0simple
web-based management=A0daemon=A0called=A0cloudfsd,=A0and=A0scripts=A0to=
=A0perform
various=A0discrete functions.

http://git.fedorahosted.org/git/?p=3DCloudFS.git;a=3Dsummary

http://git.fedorahosted.org/git/?p=3DCloudFS.git;a=3Dblob;f=3Dscripts/R=
EADME.ssl;h=3D3547f6b354d8b3455359ea019f6db9ce74862d2e;hb=3Dcloudfsd

I am not sure, whether it can be reused for ceph.

Thanks,
Kiran.

On Tue, May 22, 2012 at 11:37 PM, Yehuda Sadeh <yehuda@inktank.com> wro=
te:
>
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
> 6. Improve garbage collection
>
> Currently rgw generates intent logs for garabage removal that require
> running an external tool later, which is an administrative pain. We
> can implement other solutions (OSD side garbage collection,
> integrating cleanup process into the gateway, etc.) but we need to
> understand the priority.
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
