From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 00/20] vfs: Add support for timestamp limits
Date: Tue, 20 Aug 2019 07:05:10 -0400
Message-ID: <27d1943a0027cb4f658334fad8dc880df133c22d.camel@kernel.org>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de, adilger.kernel@dilger.ca, adrian.hunter@intel.com, aivazian.tigran@gmail.com, al@alarsen.net, anna.schumaker@netapp.com, anton@enomsg.org, asmadeus@codewreck.org, ccross@android.com, ceph-devel@vger.kernel.org, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu, darrick.wong@oracle.com, dedekind1@gmail.com, devel@lists.orangefs.org, dsterba@suse.com, dushistov@mail.ru, dwmw2@infradead.org, ericvh@gmail.com, gregkh@linuxfoundation.org, hch@infradead.org, hch@lst.de, hirofumi@mail.parknet.co.jp, hubcap@omnibond.com, idryomov@gmail.com, jack@suse.com, jaegeuk@kernel.org, jaharkes@cs.cmu.edu, jfs-discussion@lists.sourceforge.net, jlbec@evilplan.org, keescook@chromium.org, linux-cifs@vger.kernel.org, linux-ext4@vger.ke
List-Id: ceph-devel.vger.kernel.org

On Sun, 2019-08-18 at 09:57 -0700, Deepa Dinamani wrote:
> The series is an update and a more complete version of the
> previously posted series at
> https://lore.kernel.org/linux-fsdevel/20180122020426.2988-1-deepa.kernel@gmail.com/
> 
> Thanks to Arnd Bergmann for doing a few preliminary reviews.
> They helped me fix a few issues I had overlooked.
> 
> The limits (sometimes granularity also) for the filesystems updated here are according to the
> following table:
> 
> File system   Time type                      Start year Expiration year Granularity
> cramfs        fixed                          0          0
> romfs         fixed                          0          0
> pstore        ascii seconds (27 digit ascii) S64_MIN    S64_MAX         1
> coda          INT64                          S64_MIN    S64_MAX         1
> omfs          64-bit milliseconds            0          U64_MAX/ 1000   NSEC_PER_MSEC
> befs          unsigned 48-bit seconds        0          0xffffffffffff  alloc_super
> bfs           unsigned 32-bit seconds        0          U32_MAX         alloc_super
> efs           unsigned 32-bit seconds        0          U32_MAX         alloc_super
> ext2          signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
> ext3          signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
> ext4 (old)    signed 32-bit seconds          S32_MIN    S32_MAX         alloc_super
> ext4 (extra)  34-bit seconds, 30-bit ns      S32_MIN    0x37fffffff	1
> freevxfs      u32 secs/usecs                 0          U32_MAX         alloc_super
> jffs2         unsigned 32-bit seconds        0          U32_MAX         alloc_super
> jfs           unsigned 32-bit seconds/ns     0          U32_MAX         1
> minix         unsigned 32-bit seconds        0          U32_MAX         alloc_super
> orangefs      u64 seconds                    0          U64_MAX         alloc_super
> qnx4          unsigned 32-bit seconds        0          U32_MAX         alloc_super
> qnx6          unsigned 32-bit seconds        0          U32_MAX         alloc_super
> reiserfs      unsigned 32-bit seconds        0          U32_MAX         alloc_super
> squashfs      unsigned 32-bit seconds        0          U32_MAX         alloc_super
> ufs1          signed 32-bit seconds          S32_MIN    S32_MAX         NSEC_PER_SEC
> ufs2          signed 64-bit seconds/u32 ns   S64_MIN    S64_MAX         1
> xfs           signed 32-bit seconds/ns       S32_MIN    S32_MAX         1
> ceph          unsigned 32-bit second/ns      0          U32_MAX         1000

Looks reasonable, overall.

Note that the granularity changed recently for cephfs. See commit
0f7cf80ae96c2a (ceph: initialize superblock s_time_gran to 1).

In any case, you can add my Acked-by

-- 
Jeff Layton <jlayton@kernel.org>
