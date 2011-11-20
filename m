From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: radosgw performance after 0.37
Date: Sun, 20 Nov 2011 15:03:31 -0800
Message-ID: <CAC-hyiHWENFD88bjCP0Zz4KYCR_7PHO9iDbqLZ+jNOzXRWxZ-w@mail.gmail.com>
References: <CAA9wQNc9qmbbshrL5hYYhiwpAbwF-5bzhM=h3dG9B_jY9HO3Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63288 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab1KTXDd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Nov 2011 18:03:33 -0500
Received: by bke11 with SMTP id 11so5795500bke.19
        for <ceph-devel@vger.kernel.org>; Sun, 20 Nov 2011 15:03:31 -0800 (PST)
In-Reply-To: <CAA9wQNc9qmbbshrL5hYYhiwpAbwF-5bzhM=h3dG9B_jY9HO3Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Nov 20, 2011 at 9:49 AM, Leander Yu <leander.yu@gmail.com> wrote:
> Hi all,
> I found that after 0.37 the radosgw have some fundamental changes
> which put all object in to .rgw.buckets pool.
> From the release note it seem for better scalability however I wonder
> how this changes will improve the scalability? Base on our test, a
> simple list bucket command by s3cmd will take more than 10 sec when
> the file number is bigger than 10k. is this normal? or it's a
> potential bug?

The scaling issue that was solved was the ability to increase the
number of buckets, whereas you're hitting a different issue now that
relates to the number of objects per bucket. The problem is with the
inefficient implementation of the rados tmap (trivial map) that
requires that every read/write from the directory index requires
reading the entire object, which is not too scalable. We are going to
replace tmap with a not-so-trivial-map that would scale much better
(feature #1571 in the ceph tracker, currently planned for 0.39).

I verified that this is in fact the issue. The problem with listing
object using s3cmd is that it requests the data in chunks of 1000,
which means that going through 10k objects requires that the entire
directory is being read of disk (on the osd side) 10 times.

>
> I haven't fully understand the radosgw code but it seems when you list
> a bucket, it has to list all object in .rgw.buckets and filter out
> those object not belong to the bucket id? if my understanding is
> correct then it make sense to have 10 sec for listing a bucket from
> s3cmd since "rados -p .rgw.bucket ls" took about 7 sec in my case.

I think you misread it. The old implementation did have to list the
entire pool and then filtered out the result, but there was a 1:1
mapping between pools and buckets. The new implementation issues a rgw
class operation that reads the directory index.


Yehuda
