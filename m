From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Crash whilst detecting mime-type in radosgw/0.55.1
Date: Wed, 19 Dec 2012 07:42:56 -0800
Message-ID: <CAC-hyiEz7Cfiw=ox+t5RcCzNXC7sTMrtZpLy5DWkgoSQgVGw4g@mail.gmail.com>
References: <50D1D8E4.8000808@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57969 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab2LSPm7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 10:42:59 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so2913518ieb.5
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 07:42:56 -0800 (PST)
In-Reply-To: <50D1D8E4.8000808@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Dec 19, 2012 at 7:10 AM, James Page <james.page@ubuntu.com> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi
>
> I'm seeing a couple of issues with Ceph 0.55.1 on Ubuntu raring
> (current development release) whilst testing the keystone integration
> with radosgw.
>
> 1) Crash in RADOS Gateway when Content-Type not specified in Upload

I opened ceph issue #3648.

>
> https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/1092137
>
> RADOS Gateway crashes when trying to match the mime type with the
> extension of the file being uploaded - full backtrace here:
>
> http://paste.ubuntu.com/1450073/
>
> If the file has no extension then all is good!
>
> I'm uploading using the python-swiftclient package using the following
> command:
>
>    swift upload test quantal-server-cloudimg-amd64-disk1.img
>
> for example.
>
>    swift upload test quantal-server-cloudimg-amd64-disk1
>
> works OK.
>
> 2) swift list returns no output

Ceph issue #3649

>
> I was expecting a list of the buckets I had just created - but instead
> I get zip; I can stat the buckets OK individually but the top level
> list returns nothing - am I missing something?
>
> Other than those two things the integration with Keystone was pretty
> easy to get up and running and will feature in the next version of the
> Ceph RADOS Gateway charm for Juju (see 1) - nice work!

Thanks!
Yehuda
