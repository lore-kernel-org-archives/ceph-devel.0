From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: libcephfs create file with layout and replication
Date: Sat, 17 Nov 2012 13:35:08 -0800
Message-ID: <50A8030C.2010003@inktank.com>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:58813 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab2KQVfP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 16:35:15 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so183364dak.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 13:35:15 -0800 (PST)
In-Reply-To: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 11/17/2012 12:13 PM, Noah Watkins wrote:
> The Hadoop VFS layer assumes that block size and replication can be
> set on a per-file basis, which is important to users for file
> layout/workload optimizations.
>
> The libcephfs interface doesn't make this entirely easy. Here is one
> approach, but it isn't thread safe as the default values are global
> variables in the client.
>
>    orig_obj_size = ceph_get_default_object_size() //save
>    set_default_object_size(new size)
>    open(path, O_CREAT)
>    set_default_object_size(new size) //reset
>
> Something more convenient might be:
>
>    ceph_open_layout(path, flags, mode, layout, replication)

I think this makes the most sense, since changing the layout of a
file after it's been created can't happen, and this interface
makes that the most clear. It also avoids maintaining extra state
in libcephfs between calls.

Since replication count is a per-pool setting, I think the hadoop
bindings would have to translate from a vfs request to a pool
with the requested replication level. So something like this,
where layout is a struct containing stripe unit, stripe count,
and object size (the subset of struct ceph_file_layout related to
objects that's useful currently):

     ceph_open_layout(path, flags, mode, layout, pool_name)

BTW, for anyone interested, there's a nice description of
the layout parameters here:

http://ceph.com/docs/master/dev/file-striping/

> where layout and replication are used with O_CREAT | O_EXCL, or and
> interface for setting these values explicitly on newly created files:
>
>    ceph_open(path, O_CREAT|O_EXCL)
>    ceph_set_layout(path, layout, replication)
>
> where ceph_set_layout would succeed ostensibly on zero-length files.
>
> Any thoughts on how to handle this?
>
> Thanks,
> Noah

