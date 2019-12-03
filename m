From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 3/6] fs: ceph: Delete timespec64_trunc() usage
Date: Tue, 3 Dec 2019 11:41:47 -0800
Message-ID: <CABeXuvouZTBnugzNhDq2EUt8o9U-frV-xh8vsbxf+Jx6Mm4FEQ@mail.gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com> <20191203051945.9440-4-deepa.kernel@gmail.com>
 <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

> Thanks Deepa. We'll plan to take this one in via the ceph tree.

Actually, deletion of the timespec64_trunc() will depend on this
patch. Can we merge the series through a common tree? Otherwise,
whoever takes the [PATCH 6/7] ("fs:
Delete timespec64_trunc()") would have to depend on your tree. If you
are ok with the change, can you ack it?

Thanks,
Deepa
