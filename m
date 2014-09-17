From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: RadosGW objects to Rados object mapping
Date: Wed, 17 Sep 2014 08:52:38 -0700
Message-ID: <CABBk=J8a-Wh4x8mbR83Ympk2zeYCS1ko1z92ffru-XbtwE+FRQ@mail.gmail.com>
References: <87wq92ia4z.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46933 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbaIQPwj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 11:52:39 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so965220ieb.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Sep 2014 08:52:38 -0700 (PDT)
In-Reply-To: <87wq92ia4z.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 17, 2014 at 7:39 AM, Abhishek L
<abhishek.lekshmanan@gmail.com> wrote:
>
> Hi,
>
> I'm trying to understand the internals of RadosGW, on how
> buckets/containers, objects are mapped back to rados objects. I couldn't
> find any docs, however a previous mailing list discussion[1] explained
> how an S3/Swift objects are cut into rados objects and about manifests. I was
> able to construct back a file uploaded to RadosGW by getting the rados
> objects by using the manifest to figure out the rados object names.
> For eg:
> ```
> # random.txt is an 8 MB text file
> [r@ra:~/ceph/src]$ s3 -us put my-first-bucket/random filename=random.txt
> [r@ra:~/ceph/src]$ ./radosgw-admin object stat --bucket=my-first-bucket --object=random  | grep prefix
>       "prefix": "._op2xmptte2DD7z3_9EjQKgmmRcWRWL_",
>
> ```
>
> And then getting the objects via rados and joining back
>
> ```
> [r@ra:~/ceph/src]$ ./rados --pool .rgw.buckets ls | grep _op2xm
> default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_2
> default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_1
> [r@ra:~/ceph/src]$ ./rados get default.4124.1_random random.part0 --pool .rgw.buckets
> [r@ra:~/ceph/src]$ ./rados get default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_1 random.part1 --pool .rgw.buckets
> [r@ra:~/ceph/src]$ ./rados get default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_2 random.part2 --pool .rgw.buckets
>
> # Now join the objects back
> [r@ra:~/ceph/src]$ cat random.part0 random.part1 random.part2 > random.rados.txt
> [r@ra:~/ceph/src]$ diff random.txt random.rados.txt
> ```
>
> I'm trying to find similiar information on how radosgw ends up storing
> the buckets & metadata into rados objects, what information is
> contained within them and how they are updated when say an object is
> added etc. I was able to find the bucket name & bucket meta data being
> stored in .rgw pool, but not sure how the bucket knows the objects it
> has or buckets owned by user etc.
>

The bucket doesn't know who owns each object, this info is stored in
the object's info. The bucket index is stored as omap information in
the bucket instance object. The list of buckets per user is kept in
the user metadata object (also as omap information). There's a rados
command that lets you list the omap keys for each rados object.

Yehuda

> [1] https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg19747.html
>
> Thanks
> --
> Abhishek
