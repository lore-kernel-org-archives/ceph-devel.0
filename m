From: Joaquim Rocha <joaquim.rocha@cern.ch>
Subject: Possible bug when getting batched xattrs
Date: Fri, 17 Oct 2014 11:28:17 +0200
Message-ID: <5440E131.2020501@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070404050503050701010502"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:32464 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaJQJdb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Oct 2014 05:33:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

--------------070404050503050701010502
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I need to get a list of xattrs from one object (so I'm batching them in 
one ObjectReadOperation) but I don't know in advance if all of those 
xattrs exist.

I was expecting to figure out the ones that don't exist from the return 
code of each getxattr call but I have however noticed that as soon one 
nonexistent xattr is processed, its return code gets correctly set to 
-ENODATA but the remaining xattrs are never checked. And what is worse, 
the remaining getxattr op's return codes get assigned to 0.

I am attaching a small test case I've quickly written that proves the 
case. (I am using Ceph 0.80.5)

Could you confirm that this is not the intended behavior (that all read 
op's calls should be processed)?


Thank you in advance,

--
Joaquim Rocha
http://www.joaquimrocha.com

--------------070404050503050701010502
Content-Type: text/x-c++src; name="test-rados-xattrs.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test-rados-xattrs.cpp"

#include <rados/librados.hpp>
#include <sstream>
#include <cstdio>
#include <sys/errno.h>

int main(int argc, char **argv)
{
  if (argc < 5)
  {
    fprintf(stdout, "Usage: %s CONFIGURATION_FILE POOL_NAME OBJ_NAME "
                    "ONE_EXISTING_XATTRIBUTE \n",
            argv[0]);

    return EINVAL;
  }

  librados::Rados rados;

  char *conf = argv[1];
  char *pool = argv[2];
  char *obj = argv[3];
  char *xattr = argv[4];

  rados.init(0);
  rados.conf_read_file(conf);
  rados.connect();

  librados::IoCtx ioctx;
  rados.ioctx_create(pool, ioctx);

  const size_t numXAttrs(5);
  librados::bufferlist buffs[numXAttrs];
  int xattrRets[numXAttrs];

  librados::ObjectReadOperation op;

  fprintf(stdout, "Ret codes before the op: \n");

  for (size_t i = 0; i < numXAttrs; i++)
  {
    xattrRets[i] = -1;
    fprintf(stdout, "  RET#%d: %d\n", i, xattrRets[i]);
  }

  fprintf(stdout, "\n--------\nData and ret codes after the op: \n");

  for (size_t i = 0; i < numXAttrs; i++)
  {
    std::stringstream stream;

    if (i == 0)
      stream << xattr;
    else
      stream << "nonexistent-xattr" << i;

    op.getxattr(stream.str().c_str(), &buffs[i], &xattrRets[i]);
  }

  ioctx.operate(obj, &op, 0);

  for (size_t i = 0; i < numXAttrs; i++)
  {
    librados::bufferlist *buff = &buffs[i];
    std::string value;

    if (buff->length() > 0)
      value = std::string(buff->c_str(), buff->length());

    fprintf(stdout, "  RET#%d: %s %d\n", i, value.c_str(), xattrRets[i]);
  }

  rados.shutdown();

  return 0;
}

--------------070404050503050701010502--
