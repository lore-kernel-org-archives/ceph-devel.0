From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: radosgw performance after 0.37
Date: Mon, 21 Nov 2011 10:55:18 -0800
Message-ID: <CAF3hT9DwOV_FkeEPFkL3-ip_iKLj7OKH5hRtHRPux9drZYYtdA@mail.gmail.com>
References: <CAA9wQNc9qmbbshrL5hYYhiwpAbwF-5bzhM=h3dG9B_jY9HO3Hw@mail.gmail.com>
	<CAC-hyiHWENFD88bjCP0Zz4KYCR_7PHO9iDbqLZ+jNOzXRWxZ-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39562 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab1KUSzT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 13:55:19 -0500
Received: by iage36 with SMTP id e36so7659288iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2011 10:55:18 -0800 (PST)
In-Reply-To: <CAC-hyiHWENFD88bjCP0Zz4KYCR_7PHO9iDbqLZ+jNOzXRWxZ-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Leander Yu <leander.yu@gmail.com>, ceph-devel@vger.kernel.org

On Sun, Nov 20, 2011 at 3:03 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Sun, Nov 20, 2011 at 9:49 AM, Leander Yu <leander.yu@gmail.com> wr=
ote:
>> Hi all,
>> I found that after 0.37 the radosgw have some fundamental changes
>> which put all object in to .rgw.buckets pool.
>> From the release note it seem for better scalability however I wonde=
r
>> how this changes will improve the scalability? Base on our test, a
>> simple list bucket command by s3cmd will take more than 10 sec when
>> the file number is bigger than 10k. is this normal? or it's a
>> potential bug?
>
> The scaling issue that was solved was the ability to increase the
> number of buckets, whereas you're hitting a different issue now that
> relates to the number of objects per bucket. The problem is with the
> inefficient implementation of the rados tmap (trivial map) that
> requires that every read/write from the directory index requires
> reading the entire object, which is not too scalable. We are going to
> replace tmap with a not-so-trivial-map that would scale much better
> (feature #1571 in the ceph tracker, currently planned for 0.39).
>
> I verified that this is in fact the issue. The problem with listing
> object using s3cmd is that it requests the data in chunks of 1000,
> which means that going through 10k objects requires that the entire
> directory is being read of disk (on the osd side) 10 times.

I wouldn't expect this to be so slow, though =97 presumably the
directory object is in cache so all it's doing is some memory copies
after the first read off disk?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
