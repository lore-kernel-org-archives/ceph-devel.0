From: Noah Watkins <noahwatkins@gmail.com>
Subject: getting eperm on lseek
Date: Tue, 11 Oct 2016 17:30:51 -0700
Message-ID: <CAB2gnbXkE6xqTiDEMFnfWp-EUuTJiG_LaaBLN+-WeBXCfuomeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34182 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbcJLAaw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 20:30:52 -0400
Received: by mail-oi0-f49.google.com with SMTP id t73so44083283oie.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2016 17:30:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Michael Sevilla <msevilla@ucsc.edu>, Gregory Farnum <gfarnum@redhat.com>

Some code using libcephfs running on Jewel isn't working on master.
After creating a file I receive -EPERM when seeking on the file
immediately after opening it. I would expect the seek to succeed, or
the open to have failed.

Here is the code. The check_zero call after ceph_lseek is getting
permission denied.

#include <cassert>
#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include "include/cephfs/libcephfs.h"

#define check_zero(ret) do { \
  if (ret) { \
    fprintf(stderr, "error: ret: %d/%s", ret, strerror(-ret)); \
    assert(0); \
    exit(1); \
  } } while (0)

int main(int argc, char **argv)
{
  struct ceph_mount_info *cmount;

  int ret = ceph_create(&cmount, "admin");
  check_zero(ret);

  ceph_conf_read_file(cmount, NULL);
  ceph_conf_parse_env(cmount, NULL);

  ret = ceph_mount(cmount, "/");
  check_zero(ret);

  int fd = ceph_open(cmount, "/hello", O_CREAT|O_RDWR, 0666);
  assert(fd >= 0);

  int64_t lret = ceph_lseek(cmount, fd, 0, SEEK_END);
  check_zero(lret);

  ceph_close(cmount, fd);

  ceph_unmount(cmount);
  ceph_release(cmount);

  return 0;
}
