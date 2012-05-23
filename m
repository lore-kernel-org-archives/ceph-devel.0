From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: RGW, future directions
Date: Wed, 23 May 2012 16:59:00 +0800
Message-ID: <CANExM-PHHCwnH8n_nrjA=HJ0uzL268kjZf6pAh5+Eh73=1UPMg@mail.gmail.com>
References: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:46361 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2EWI7B convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 04:59:01 -0400
Received: by ghrr11 with SMTP id r11so1122379ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 01:59:00 -0700 (PDT)
In-Reply-To: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/5/23 Yehuda Sadeh <yehuda@inktank.com>:
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

I would like to see radosgw supporting:
- Object versioning
- Bucket policy

> 2. Better OpenStack interoperability
>
> Keystone support? Other?
>
> 3. New features
>
> Some examples:
>
> =C2=A0- multitenancy: api for domains and user management
> =C2=A0- snapshots
> =C2=A0- computation front end: upload object, then do some data
> transformation/calculation.
> =C2=A0- simple key-value api
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

I am also interested in libradosgw. With it, we can support other
protocols easily. (e.g., webdav)


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
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
