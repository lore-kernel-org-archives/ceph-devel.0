From: Takuya ASADA <syuu@dokukino.com>
Subject: undefined reference to librados::Rados::read
Date: Thu, 15 Jul 2010 23:52:41 +0900
Message-ID: <AANLkTinjpOysFXSJ8vvcuNxCzJ7JTLv9R6qRcIGG2d1Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62552 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933400Ab0GOOxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jul 2010 10:53:08 -0400
Received: by pvc7 with SMTP id 7so283055pvc.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jul 2010 07:53:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm writing sample code of RADOS client to learn RADOS API, and I'm
stacking on librados::Rados::read().
It could compile, but cannot link due to this error:
get_obj.cc:(.text+0x315): undefined reference to
`librados::Rados::read(void*, std::basic_string<char,
std::char_traits<char>, std::allocator<char> > const&, long,
ceph::buffer::list&, unsigned int)'

Here's the code:
====
#include <errno.h>
#include <stdlib.h>

#include <rados/librados.hpp>
using namespace librados;

#include <string>
using namespace std;

#define ROOT_BUCKET ".rgw" //keep this synced to rgw_user.cc::root_bucket!
static string root_bucket(ROOT_BUCKET);
static pool_t root_pool;

/**
* Open the pool used as root for this gateway
* Returns: 0 on success, -ERR# otherwise.
*/
int open_root_pool(Rados &rados, pool_t *pool)
{
  int r = rados.open_pool(root_bucket.c_str(), pool);
  if (r < 0) {
    r = rados.create_pool(root_bucket.c_str());
    if (r < 0)
      return r;

    r = rados.open_pool(root_bucket.c_str(), pool);
  }

  return r;
}

int main(int argc, const char **argv)
{
  int r;
  Rados rados;
  const char *bucket = argv[1];
  string oid(argv[2]);
  string file_name(argv[3]);
  pool_t pool;
  bufferlist bl;

  r = rados.initialize(0, NULL);
  if (r < 0)
    goto err;

  r = open_root_pool(rados, &root_pool);
  if (r < 0)
    goto err;

  r = rados.open_pool(bucket, &pool);
  if (r < 0)
    goto err;


  r = rados.read(pool, oid, 0, bl, 0);
  if (r < 0)
    goto err;

  r = bl.write_file(file_name.c_str());

 err:
  rados.close_pool(pool);
  rados.close_pool(&root_pool);
  rados.shutdown();

  return r;
}
====

Then, compile & link following command:
# g++ -lcrypto -lrados -lcrush get_obj.cc
/tmp/cctA2uA8.o: In function `main':
get_obj.cc:(.text+0x315): undefined reference to
`librados::Rados::read(void*, std::basic_string<char,
std::char_traits<char>, std::allocator<char> > const&, long,
ceph::buffer::list&, unsigned int)'
collect2: ld returned 1 exit status

Do you have any idea with this?


syuu
