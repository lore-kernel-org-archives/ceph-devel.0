From: Samuel Just <sjust@redhat.com>
Subject: Re: OSD data file are OSD logs
Date: Mon, 4 Jan 2016 15:59:58 -0800
Message-ID: <CAN=+7FVZcjb1FHQGTt9WAwET3Meh8pcJW8XEbpm8rCz0D6qGJA@mail.gmail.com>
References: <CAKtk8hf=h19gTeDayhmo24ThhbJPPLmOfq2O++iuB7RuBr4gxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33916 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbcADX76 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 18:59:58 -0500
Received: by mail-io0-f177.google.com with SMTP id 1so124718808ion.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jan 2016 15:59:58 -0800 (PST)
In-Reply-To: <CAKtk8hf=h19gTeDayhmo24ThhbJPPLmOfq2O++iuB7RuBr4gxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <guangyy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

IIRC, you are running giant.  I think that's the log rotate dangling
fd bug (not fixed in giant since giant is eol).  Fixed upstream
8778ab3a1ced7fab07662248af0c773df759653d, firefly backport is
b8e3f6e190809febf80af66415862e7c7e415214.
-Sam

On Mon, Jan 4, 2016 at 3:37 PM, Guang Yang <guangyy@gmail.com> wrote:
> Hi Cephers,
> Before I open a tracker, I would like check if it is a known issue or not..
>
> One one of our clusters, there was OSD crash during repairing,  the
> crash happened after we issued a PG repair for inconsistent PGs, which
> failed because the recorded file size (within xattr) mismatched with
> the actual file size.
>
> The mismatch was caused by the fact that the content of the data file
> are OSD logs, following is from osd.354 on c003:
>
> -rw-r--r-- 1 yahoo root  75168 Jan  3 07:30
> default.12061.9\u8396947527\u52ac8b3ec6\uo.jpg__head_A2478171__3_ffffffffffffffff_7
> -bash-4.1$ head
> "default.12061.9\u8396947527\u52ac8b3ec6\uo.jpg__head_A2478171__3_ffffffffffffffff_7"
> 2016-01-03 07:30:01.600119 7f7fe2096700 15
> filestore(/home/y/var/lib/ceph/osd/ceph-354) getattrs
> 3.171s7_head/a2478171/default.12061.9_8396947527_52ac8b3ec6_o.jpg/head//3/18446744073709551615/7
> 2016-01-03 07:30:01.604967 7f7fe2096700 10
> filestore(/home/y/var/lib/ceph/osd/ceph-354)  -ERANGE, len is 494
> 2016-01-03 07:30:01.604984 7f7fe2096700 10
> filestore(/home/y/var/lib/ceph/osd/ceph-354)  -ERANGE, got 247
> 2016-01-03 07:30:01.604986 7f7fe2096700 20
> filestore(/home/y/var/lib/ceph/osd/ceph-354) fgetattrs 61 getting
> '_user.rgw.idtag'
> 2016-01-03 07:30:01.604996 7f7fe2096700 20
> filestore(/home/y/var/lib/ceph/osd/ceph-354) fgetattrs 61 getting '_'
> 2016-01-03 07:30:01.605007 7f7fe2096700 20
> filestore(/home/y/var/lib/ceph/osd/ceph-354) fgetattrs 61 getting
> 'snapset'
> 2016-01-03 07:30:01.605013 7f7fe2096700 20
> filestore(/home/y/var/lib/ceph/osd/ceph-354) fgetattrs 61 getting
> '_user.rgw.manifest'
> 2016-01-03 07:30:01.605026 7f7fe2096700 20
> filestore(/home/y/var/lib/ceph/osd/ceph-354) fgetattrs 61 getting
> 'hinfo_key'
> 2016-01-03 07:30:01.605042 7f7fe2096700 20
> filestore(/home/y/var/lib/ceph/osd/ceph-354) fgetattrs 61 getting
> '_user.rgw.x-amz-meta-origin'
> 2016-01-03 07:30:01.605049 7f7fe2096700 20
> filestore(/home/y/var/lib/ceph/osd/ceph-354) fgetattrs 61 getting
> '_user.rgw.acl'
>
>
> This only happens on the clusters we turned on the verbose log
> (debug_osd/filestore=20). And we are running ceph v0.87.
>
> Thanks,
> Guang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
