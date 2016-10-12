From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: getting eperm on lseek
Date: Tue, 11 Oct 2016 17:35:37 -0700
Message-ID: <CAJ4mKGY-EyS6KcVxjA0czbh5DiyUBgytZiPEOtTwYAmq7AVUOA@mail.gmail.com>
References: <CAB2gnbXkE6xqTiDEMFnfWp-EUuTJiG_LaaBLN+-WeBXCfuomeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37168 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbcJLAm5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 20:42:57 -0400
Received: by mail-it0-f46.google.com with SMTP id z65so40147147itc.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2016 17:42:57 -0700 (PDT)
In-Reply-To: <CAB2gnbXkE6xqTiDEMFnfWp-EUuTJiG_LaaBLN+-WeBXCfuomeg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Michael Sevilla <msevilla@ucsc.edu>

On Tue, Oct 11, 2016 at 5:30 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
> Some code using libcephfs running on Jewel isn't working on master.
> After creating a file I receive -EPERM when seeking on the file
> immediately after opening it. I would expect the seek to succeed, or
> the open to have failed.
>
> Here is the code. The check_zero call after ceph_lseek is getting
> permission denied.
>
> #include <cassert>
> #include <stdio.h>
> #include <string.h>
> #include <cstdlib>
> #include "include/cephfs/libcephfs.h"
>
> #define check_zero(ret) do { \
>   if (ret) { \
>     fprintf(stderr, "error: ret: %d/%s", ret, strerror(-ret)); \
>     assert(0); \
>     exit(1); \
>   } } while (0)
>
> int main(int argc, char **argv)
> {
>   struct ceph_mount_info *cmount;
>
>   int ret = ceph_create(&cmount, "admin");
>   check_zero(ret);
>
>   ceph_conf_read_file(cmount, NULL);
>   ceph_conf_parse_env(cmount, NULL);
>
>   ret = ceph_mount(cmount, "/");
>   check_zero(ret);
>
>   int fd = ceph_open(cmount, "/hello", O_CREAT|O_RDWR, 0666);
>   assert(fd >= 0);
>
>   int64_t lret = ceph_lseek(cmount, fd, 0, SEEK_END);
>   check_zero(lret);
>
>   ceph_close(cmount, fd);
>
>   ceph_unmount(cmount);
>   ceph_release(cmount);
>
>   return 0;
> }

Yeah, I just did this while tightening up our security model, and I
clearly did something wrong. Jeff has a revert
(https://github.com/ceph/ceph/pull/11421/commits/7238b68fdce50e70e3f5c48a1665f33591763b6d)
and says the kernel doesn't do any kind of perm checking in these
calls, but I'm still terribly confused about *why* it broke and how
not checking isn't a security hole...

Wait, I presume you mean libcephfs is master and the cluster is Jewel?
If not something else interesting is going on.
-Greg
