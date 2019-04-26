From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Fri, 26 Apr 2019 12:25:03 -0400
Message-ID: <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
         <20190425200941.GW2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425200941.GW2217@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 2019-04-25 at 21:09 +0100, Al Viro wrote:
> On Thu, Apr 25, 2019 at 02:23:59PM -0400, Jeff Layton wrote:
> 
> > I took a quick look at the dcache code to see if we had something like
> > that before I did this, but I guess I didn't look closely enough. Those
> > routines do look nicer than my hand-rolled version.
> > 
> > I'll look at spinning up a patch to switch that over in the near future.
> 
> Jeff asked to put the name length in there; looking at the existing users,
> it does make sense.  I propose turning struct name_snapshot into
> 
> struct name_snapshot {
>         struct qstr name;
>         unsigned char inline_name[DNAME_INLINE_LEN];
> };
> 
> with
> void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
> {
>         spin_lock(&dentry->d_lock);
> 	name->name = dentry->d_name;
>         if (unlikely(dname_external(dentry))) {
>                 struct external_name *p = external_name(dentry);
>                 atomic_inc(&p->u.count);
>         } else {
>                 memcpy(name->inline_name, dentry->d_iname,
>                        dentry->d_name.len + 1);
>                 name->name.name = name->inline_name;
>         }
> 	spin_unlock(&dentry->d_lock);
> }
> 
> and callers adjusted, initially simply by turning snapshot.name into
> snapshot.name.name.  Next step: overlayfs call site becoming
>         take_dentry_name_snapshot(&name, real);
>         this = lookup_one_len(name.name.name, connected, name.name.len);
> Next: snotify stuff switched to passing struct qstr * - fsnotify_move()
> first, then fsnotify().  That one would
> 	* leave callers passing NULL alone
> 	* have the callers passing snapshot.name.name pass &snapshot.name
> 	* fsnotify_dirent() pass the entire &dentry->d_name, not just
> dentry->d_name.name (that's dependent upon parent being held exclusive;
> devpts plays fast and loose here, relying upon the lack of any kind of
> renames, explicit or implicit, in that fs)
> 	* ditto for remaining call in fsnotify_move() (both parents
> are locked in all callers, thankfully)
> 	* ditto for fsnotify_link()
> 	* kernfs callers in kernfs_notify_workfn() would grow strlen().
> Next: send_to_group() and ->handle_event() instances switched to passing
> struct qstr *.
> Next: inotify_handle_event() doesn't need to bother with strlen().
> Next: audit_update_watch() and audit_compare_dname_path() switched to
> struct qstr *.  Callers in __audit_inode_child() pass the entire
> &dentry->d_name.  strlen() inside audit_compare_dname_path() goes away.
> 
> Objections?

I have some patches that do what you lay out above. They build but I
haven't ran them through much testing yet.

It turns out though that using name_snapshot from ceph is a bit more
tricky. In some cases, we have to call ceph_mdsc_build_path to build up
a full path string. We can't easily populate a name_snapshot from there
because struct external_name is only defined in fs/dcache.c.

I could add some routines to do this, but it feels a lot like I'm
abusing internal dcache interfaces. I'll keep thinking about it though.

While we're on the subject though:

struct external_name {
        union {
                atomic_t count;
                struct rcu_head head;
        } u;
        unsigned char name[];
};

Is it really ok to union the count and rcu_head there?

I haven't trawled through all of the code yet, but what prevents someone
from trying to access the count inside an RCU critical section, after
call_rcu has been called on it?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
