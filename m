From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: libceph API
Date: Wed, 27 Apr 2011 11:49:11 -0700
Message-ID: <BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
	<Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
	<BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
	<BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43559 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab1D0StM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 14:49:12 -0400
Received: by vxi39 with SMTP id 39so1537446vxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 11:49:11 -0700 (PDT)
In-Reply-To: <BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

ceph_mount_t is forward declared as a struct in libceph.h.
When referencing that within libceph.h, gcc barfs:
client/libceph.h:32: error: expected =91)=92 before =91*=92 token

Is libceph.h intended to be used in C-programs, and if so, am I using
it incorrectly?
ceph_mount_t is defined as a class in libceph.cc, and I'm unclear on
how that would be translated into a struct for C-programs linking to
libceph.

I suppose I could use a void * and pass it around opaquely?

Here's the C-program I was trying to compile with it (a rough
conversion of testceph.cc)"

//#include "common/errno.h"
#include "libceph.h"

#include <errno.h>
#include <string.h>
#include <iostream>

//using std::cout;
//using std::cerr;

int main(int argc, const char **argv)
{
  ceph_mount_t *cmount;
  int ret =3D ceph_create(&cmount, NULL);
  if (ret) {
    printf(STDERR, "ceph_create failed with error: %i\n", ret);
    return 1;
  }

  ceph_conf_read_file(cmount, NULL);
  ceph_conf_parse_argv(cmount, argc, argv);

  char buf[128];
  ret =3D ceph_conf_get(cmount, "log file", buf, sizeof(buf));
  if (ret) {
    printf(STDERR, "ceph_conf_get(\"log file\") failed with error %i\n"=
, ret);
  }
  else {
    printf(STDOUT, "log_file =3D \"%s\"\n", ret);
  }

  ret =3D ceph_mount(cmount, NULL);
  if (ret) {
    printf(STDERR, "ceph_mount error: $i\n", ret);
    return 1;
  }
  printf(STDOUT, "Successfully mounted Ceph!\n");

  ceph_dir_result_t *foo_dir;
  ret =3D ceph_opendir(cmount, "foo", &foo_dir);
  if (ret !=3D -ENOENT) {
    printf(STDERR, "ceph_opendir error: unexpected result from trying
to open foo: %s\n", strerror(ret));
    return 1;
  }

  ret =3D ceph_mkdir(cmount, "foo",  0777);
  if (ret) {
    printf(STDERR, "ceph_mkdir error: %s\n", strerror(ret));
    return 1;
  }

  struct stat stbuf;
  ret =3D ceph_lstat(cmount, "foo", &stbuf);
  if (ret) {
    printf(STDERR, "ceph_lstat error: %s\n", strerror(ret));
    return 1;
  }

  if (!S_ISDIR(stbuf.st_mode)) {
    printf(STDERR, "ceph_lstat(foo): foo is not a directory? st_mode =3D
%x\n", stbuf.st_mode
    return 1;
  }

  ret =3D ceph_rmdir(cmount, "foo");
  if (ret) {
    printf(STDERR, "ceph_rmdir error: %s\n", strerror(ret));
    return 1;
  }

  ret =3D ceph_mkdirs(cmount, "foo/bar/baz",  0777);
  if (ret) {
    printf(STDERR, "ceph_mkdirs error: %s\n", strerror(ret));
    return 1;
  }
  ret =3D ceph_rmdir(cmount, "foo/bar/baz");
  if (ret) {
    printf(STDERR, "ceph_rmdir error: %s\n", strerror(ret));
    return 1;
  }
  ret =3D ceph_rmdir(cmount, "foo/bar");
  if (ret) {
    printf(STDERR, "ceph_rmdir error: %s\n", strerror(ret));
    return 1;
  }
  ret =3D ceph_rmdir(cmount, "foo");
  if (ret) {
    printf(STDERR, "ceph_rmdir error: %s\n", strerror(ret));
    return 1;
  }

  ceph_shutdown(cmount);

  return 0;
}


On Thu, Apr 21, 2011 at 12:32 PM, Colin McCabe <cmccabe@alumni.cmu.edu>=
 wrote:
> Hi all,
>
> I pushed the DIR* change and the connect->mount change.
> Check it out.
>
> I'm going to try to get the hadoop bindings up and running in libceph=
_api.
>
> sincerely,
> C.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
