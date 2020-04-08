From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 0/2] stable CephFS backports
Date: Wed,  8 Apr 2020 11:58:38 +0100
Message-ID: <20200408105844.21840-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, stable@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Hi!

Please pick the backports for the following upstream commits:

  4fbc0c711b24 "ceph: remove the extra slashes in the server path"
  b27a939e8376 "ceph: canonicalize server path in place"

They fix an ancient bug that can be reproduced in kernels as old as 4.9 (I
couldn't reproduced it with 4.4).

Cheers,
