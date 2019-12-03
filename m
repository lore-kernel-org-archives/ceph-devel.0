From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 3/6] fs: ceph: Delete timespec64_trunc() usage
Date: Tue, 03 Dec 2019 14:49:29 -0500
Message-ID: <24dc8c6760b3ea2797c13558d8eca124e2c629f1.camel@kernel.org>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
         <20191203051945.9440-4-deepa.kernel@gmail.com>
         <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
         <CABeXuvouZTBnugzNhDq2EUt8o9U-frV-xh8vsbxf+Jx6Mm4FEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABeXuvouZTBnugzNhDq2EUt8o9U-frV-xh8vsbxf+Jx6Mm4FEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On Tue, 2019-12-03 at 11:41 -0800, Deepa Dinamani wrote:
> > Thanks Deepa. We'll plan to take this one in via the ceph tree.
> 
> Actually, deletion of the timespec64_trunc() will depend on this
> patch. Can we merge the series through a common tree? Otherwise,
> whoever takes the [PATCH 6/7] ("fs:
> Delete timespec64_trunc()") would have to depend on your tree. If you
> are ok with the change, can you ack it?
> 
> Thanks,
> Deepa

Sure, no problem if that works better for you.

Acked-by: Jeff Layton <jlayton@kernel.org>
