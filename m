From: Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] ceph: don't return -ESTALE if there's still an open file
Date: Tue, 19 May 2020 06:45:56 +0300
Message-ID: <CAOQ4uxi21N0O17Z_-Hf-BynKbs7xpOea0JrMF_rvZJ=bUi59_Q@mail.gmail.com>
References: <20200518174726.GA84496@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200518174726.GA84496@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, May 18, 2020 at 8:47 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Similarly to commit 03f219041fdb ("ceph: check i_nlink while converting
> a file handle to dentry"), this fixes another corner case with
> name_to_handle_at/open_by_handle_at.  The issue has been detected by
> xfstest generic/467, when doing:
>
>  - name_to_handle_at("/cephfs/myfile")
>  - open("/cephfs/myfile")
>  - unlink("/cephfs/myfile")
>  - sync; sync;
>  - drop caches
>  - open_by_handle_at()
>
> The call to open_by_handle_at should not fail because the file hasn't been
> deleted yet (only unlinked) and we do have a valid handle to it.  -ESTALE
> shall be returned only if i_nlink is 0 *and* i_count is 1.
>
> This patch also makes sure we have LINK caps before checking i_nlink.
>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> Hi!
>
> (and sorry for the delay in my reply!)
>
> So, from the discussion thread and some IRC chat with Jeff, I'm sending
> v2.  What changed?  Everything! :-)
>
> - Use i_count instead of __ceph_is_file_opened to check for open files
> - Add call to ceph_do_getattr to make sure we have LINK caps before
>   accessing i_nlink
>
> Cheers,
> --
> Luis

Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
