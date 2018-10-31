From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 4.20-rc1
Date: Wed, 31 Oct 2018 14:44:04 -0700
Message-ID: <CAHk-=whbb5FZ7O8MgO8w6yY-1ZkhLGOXA8o7Pkcg+pxdZLh8Ww@mail.gmail.com>
References: <20181031174425.27372-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031174425.27372-1-idryomov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Oct 31, 2018 at 10:44 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> - a series that fixes some old memory allocation issues in libceph
>   (myself).  We no longer allocate memory in places where allocation
>   failures cannot be handled and BUG when the allocation fails.
>
> - support for copy_file_range() syscall (Luis Henriques).  If size and
>   alignment conditions are met, it leverages RADOS copy-from operation.
>   Otherwise, a local copy is performed.
>
> - a patch that reduces memory requirement of ceph_sync_read() from the
>   size of the entire read to the size of one object (Zheng Yan).
>
> - fallocate() syscall is now restricted to FALLOC_FL_PUNCH_HOLE (Luis
>   Henriques)

Pulled.

                   Linus
