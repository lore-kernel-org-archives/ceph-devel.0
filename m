From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: Fix a memory leak in ci->i_head_snapc
Date: Tue, 19 Mar 2019 11:13:35 +0800
Message-ID: <CAAM7YAnhJUey6eX6zeWuPCVgyG9JghGQetJ-hk5R8nONivZzkg@mail.gmail.com>
References: <20190315111107.15154-1-lhenriques@suse.com> <CAAM7YAnD_dK2py+95N8Z7T+Vgr2ZbBJne+tNYivEeUGObhpiCQ@mail.gmail.com>
 <87r2b4zd2q.fsf@suse.com> <CAAM7YAkhA6ddto3KESWm8yw3D6f02ev7oYmEto=nK3mXZeUy4A@mail.gmail.com>
 <87lg1c17b2.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <87lg1c17b2.fsf@suse.com>
Sender: stable-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Mar 19, 2019 at 12:22 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> "Yan, Zheng" <ukernel@gmail.com> writes:
>
> > On Mon, Mar 18, 2019 at 6:33 PM Luis Henriques <lhenriques@suse.com> wrote:
> >>
> >> "Yan, Zheng" <ukernel@gmail.com> writes:
> >>
> >> > On Fri, Mar 15, 2019 at 7:13 PM Luis Henriques <lhenriques@suse.com> wrote:
> >> >>
> >> >> I'm occasionally seeing a kmemleak warning in xfstest generic/013:
> >> >>
> >> >> unreferenced object 0xffff8881fccca940 (size 32):
> >> >>   comm "kworker/0:1", pid 12, jiffies 4295005883 (age 130.648s)
> >> >>   hex dump (first 32 bytes):
> >> >>     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
> >> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >> >>   backtrace:
> >> >>     [<00000000d741a1ea>] build_snap_context+0x5b/0x2a0
> >> >>     [<0000000021a00533>] rebuild_snap_realms+0x27/0x90
> >> >>     [<00000000ac538600>] rebuild_snap_realms+0x42/0x90
> >> >>     [<000000000e955fac>] ceph_update_snap_trace+0x2ee/0x610
> >> >>     [<00000000a9550416>] ceph_handle_snap+0x317/0x5f3
> >> >>     [<00000000fc287b83>] dispatch+0x362/0x176c
> >> >>     [<00000000a312c741>] ceph_con_workfn+0x9ce/0x2cf0
> >> >>     [<000000004168e3a9>] process_one_work+0x1d4/0x400
> >> >>     [<000000002188e9e7>] worker_thread+0x2d/0x3c0
> >> >>     [<00000000b593e4b3>] kthread+0x112/0x130
> >> >>     [<00000000a8587dca>] ret_from_fork+0x35/0x40
> >> >>     [<00000000ba1c9c1d>] 0xffffffffffffffff
> >> >>
> >> >> It looks like it is possible that we miss a flush_ack from the MDS when,
> >> >> for example, umounting the filesystem.  In that case, we can simply drop
> >> >> the reference to the ceph_snap_context obtained in ceph_queue_cap_snap().
> >> >>
> >> >> Link: https://tracker.ceph.com/issues/38224
> >> >> Cc: stable@vger.kernel.org
> >> >> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> >> >> ---
> >> >>  fs/ceph/caps.c | 7 +++++++
> >> >>  1 file changed, 7 insertions(+)
> >> >>
> >> >> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> >> >> index 36a8dc699448..208f4dc6f574 100644
> >> >> --- a/fs/ceph/caps.c
> >> >> +++ b/fs/ceph/caps.c
> >> >> @@ -1054,6 +1054,7 @@ int ceph_is_any_caps(struct inode *inode)
> >> >>  static void drop_inode_snap_realm(struct ceph_inode_info *ci)
> >> >>  {
> >> >>         struct ceph_snap_realm *realm = ci->i_snap_realm;
> >> >> +
> >> >>         spin_lock(&realm->inodes_with_caps_lock);
> >> >>         list_del_init(&ci->i_snap_realm_item);
> >> >>         ci->i_snap_realm_counter++;
> >> >> @@ -1063,6 +1064,12 @@ static void drop_inode_snap_realm(struct ceph_inode_info *ci)
> >> >>         spin_unlock(&realm->inodes_with_caps_lock);
> >> >>         ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
> >> >>                             realm);
> >> >> +       /*
> >> >> +        * ci->i_head_snapc should be NULL, but we may still be waiting for a
> >> >> +        * flush_ack from the MDS.  In that case, we still hold a ref for the
> >> >> +        * ceph_snap_context and we need to drop it.
> >> >> +        */
> >> >> +       ceph_put_snap_context(ci->i_head_snapc);
> >> >>  }
> >> >>
> >> >>  /*
> >> >
> >> > This does not seem right.  i_head_snapc is cleared when
> >> > (ci->i_wrbuffer_ref_head == 0 && ci->i_dirty_caps == 0 &&
> >> > ci->i_flushing_caps == 0) . Nothing do with dropping ci->i_snap_realm.
> >> > Did you see 'reconnect denied' during the test? If you did, the fix
> >> > should be in iterate_session_caps()
> >> >
> >>
> >> No, I didn't saw any 'reconnect denied' in the test.  The test actually
> >> seems to execute fine, except from the memory leak.
> >>
> >> It's very difficult to reproduce this issue, but last time I managed to
> >> get this memory leak to trigger I actually had some debugging code in
> >> drop_inode_snap_realm, something like:
> >>
> >>   if (ci->i_head_snapc)
> >>         printk("i_head_snapc: 0x%px\n", ci->i_head_snapc);
> >
> > please add code that prints i_wrbuffer_ref_head, i_dirty_caps,
> > i_flushing_caps. and try reproducing it again.
> >
>
> Ok, it took me a few hours, but I managed to reproduce the bug, with
> those extra printks.  All those values are set to 0 when the bug
> triggers (and i_head_snapc != NULL).
>

Thanks, which test triggers this bug?

I searched that code, found we may fail to cleanup i_head_snap in two
places. One is in ceph_queue_cap_snap, Another is in
remove_session_caps_cb().

> Cheers,
> --
> Luis
>
>
> >
> >>
> >> This printk was only executed when the bug triggered (during a
> >> filesystem umount) and the address shown was the same as in the kmemleak
> >> warning.
> >>
> >> After spending some time looking, I assumed this to be a missing call to
> >> handle_cap_flush_ack, which would do the i_head_snapc cleanup.
> >>
> >> Cheers,
> >> --
> >> Luis
> >
