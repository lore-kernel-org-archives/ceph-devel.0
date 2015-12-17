From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw subuser create and admin api
Date: Thu, 17 Dec 2015 10:09:12 -0800
Message-ID: <CADRKj5Ru=HhbhYGXq829oKPiB6Wr+9b8qgxjtmCn207xfCdc0Q@mail.gmail.com>
References: <5672EB1F.9070209@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35608 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbbLQSJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 13:09:13 -0500
Received: by mail-oi0-f43.google.com with SMTP id l9so18381952oia.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 10:09:12 -0800 (PST)
In-Reply-To: <5672EB1F.9070209@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Derek Yarnell <derek@umiacs.umd.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 17, 2015 at 9:04 AM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> I am having an issue with the 'radosgw-admin subuser create' command
> doing something different than the '/{admin}/user?subuser&format=json'
> admin API.  I want to leverage subusers in S3 which looks to be possible
> in my testing for bit more control without resorting to ACLs.
>
> radosgw-admin subuser create --uid=-staff --subuser=test1
> --access-key=aaaaaaaaa --secret=zzzzzzzzz --access=read
>
> This command will work and create a both a subuser -staff:test1 with
> permission read and a s3 key with the the correct access and secret key set.
>
> The Admin API will not allow me to do this it would seem as the
> following is accepted and a subuser is created however a swift_key is
> created instead.
>
> DEBUG:requests.packages.urllib3.connectionpool:"PUT
> /admin/user?subuser&format=json&uid=-staff&subuser=test2&access-key=bbbbbbbbb&secret-key=cccccccccc&access=read
> HTTP/1.1" 200 130
>
> The documentation for the admin API[0] does not seem to indicate that
> access-key is accepted at all.  Also if you pass key-type=s3 it will
> return a 400 with InvalidArgument although the documentation says it
> should accept the key type s3.
>
> Bug? Design?

Somewhat a bug. The whole subusers that use s3 was unintentional, so
when creating the subuser api, we didn't think of needing the access
key. For some reason we do get the key type. Can you open a ceph
tracker issue for that?

You can try using the metadata api to modify the user once it has been
created (need to get the user info, add the s3 key to the structure,
put the user info).

>
> One other issue is that a command that uses the --purge-keys from
> radosgw-admin seems to have no effect.  The following command removes
> the subuser and leaves the swift keys it has (but also any s3 keys too).
>
> radosgw-admin subuser rm --uid=-staff --subuser=test2 --purge-keys
>

It's a known issue, and it will be fixed soon (so it seems).

Thanks,
Yehuda

>
> [0] - http://docs.ceph.com/docs/master/radosgw/adminops/#create-subuser
>
>
> --
> Derek T. Yarnell
> University of Maryland
> Institute for Advanced Computer Studies
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
