From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2 04/17] ceph: fix compat_ioctl for ceph_dir_operations
Date: Wed, 12 Sep 2018 16:12:17 +0000
Message-ID: <9e5f6ad82a2344c095234b39224605d4@AcuMS.aculab.com>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912150142.157913-4-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912150142.157913-4-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Chengguang Xu <cgxu519@gmx.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

From: Arnd Bergmann
> Sent: 12 September 2018 16:01
> 
> The ceph_ioctl function is used both for files and directories, but only
> the files support doing that in 32-bit compat mode.
> 
> For consistency, add the same compat handler to the dir operations
> as well.

Have you verified that all the relevant ioctl buffer structures are
exactly the same for 32bit and 64bit applications?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
