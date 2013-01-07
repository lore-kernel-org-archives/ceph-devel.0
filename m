From: David Zafman <david.zafman@inktank.com>
Subject: Fwd: Interfaces proposed changes
Date: Mon, 7 Jan 2013 10:40:42 -0800
Message-ID: <6B8287C9-C600-45EC-B9B4-FCBE55328A3A@inktank.com>
References: <A963CD18-8455-40DC-91E6-ECA8EC4B11C0@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46375 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab3AGSr6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 13:47:58 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so3092981ggd.33
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 10:47:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


I sent this proposal out to the developers that own the FSAL CEPH portion of Nfs-Ganesha.  They have changes to Ceph that expose additional interfaces for this.  This is our initial cut at improving the interfaces.

David Zafman
Senior Developer
david.zafman@inktank.com


Begin forwarded message:

> From: David Zafman <david.zafman@inktank.com>
> Subject: Interfaces proposed changes
> Date: January 4, 2013 5:50:49 PM PST
> To: "Matthew W. Benjamin" <matt@linuxbox.com>, "Adam C. Emerson" <aemerson@linuxbox.com>
> 
> 
> Below is a patch that shows the newly proposed low-level interface.  Obviously, the ceph_ll_* functions you created in libcephfs.cc will have the corresponding changes made to them.  An Fh * type is used for as an open file descriptor and needs a corresponding ll_release()/ceph_ll_close().  An Inode * returned by various inode create functions and ll_lookup_ino() is a referenced inode and needs a corresponding _ll_put() exposed via something maybe named ceph_ll_put().
> 
> The existing FSAL CEPH doesn't ever call ceph_ll_forget() even though there are references taken on inodes ceph ll_* operation level.  This interface creates a clearer model to be used by FSAL CEPH.  As I don't understand Ganesha's inode caching model, it isn't clear to me if it can indirectly "hold" inodes that are below FSAL.  Especially for NFS v3 where there is no open state, the code shouldn't keep doing final release of an inode after every operation.
> 
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index d876454..4d4d0f1 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -6250,13 +6250,39 @@ bool Client::ll_forget(vinodeno_t vino, int num)
>   return last;
> }
> 
> +
> +inodeno_t Client::ll_get_ino(Inode *in)
> +{
> +  return in->ino;
> +}
> +
> +snapid_t Client::ll_get_snapid(Inode *in)
> +{
> +  return in->snapid;
> +}
> +
> +vinodeno_t Client::ll_get_vino(Inode *in)
> +{
> +  return vinodeno_t(in->ino, in->snapid);
> +}
> +
> +Inode *Client::ll_lookup_ino(vinodeno_t vino)
> +{
> +  Mutex::Locker lock(client_lock);
> +  hash_map<vinodeno_t,Inode*>::iterator p = inode_map.find(vino);
> +  if (p == inode_map.end())
> +    return NULL;
> +  Inode *in = p->second;
> +  _ll_get(in);
> +  return in;
> +}
> +
> Inode *Client::_ll_get_inode(vinodeno_t vino)
> {
>   assert(inode_map.count(vino));
>   return inode_map[vino];
> }
> 
> -
> int Client::ll_getattr(vinodeno_t vino, struct stat *attr, int uid, int gid)
> {
>   Mutex::Locker lock(client_lock);
> @@ -7219,7 +7245,7 @@ int Client::ll_release(Fh *fh)
>   return 0;
> }
> 
> -
> +// --------------------------
> 
> 
> 
> diff --git a/src/client/Client.h b/src/client/Client.h
> index 9512a2d..0cfe8d9 100644
> --- a/src/client/Client.h
> +++ b/src/client/Client.h
> @@ -706,6 +706,32 @@ public:
>   void ll_register_ino_invalidate_cb(client_ino_callback_t cb, void *handle);
> 
>   void ll_register_getgroups_cb(client_getgroups_callback_t cb, void *handle);
> +
> +  // low-level interface v2
> +  inodeno_t ll_get_ino(Inode *in);
> +  snapid_t ll_get_snapid(Inode *in);
> +  vinodeno_t ll_get_vino(Inode *in);
> +  Inode *ll_lookup_ino(vinodeno_t vino);
> +  int ll_lookup(Inode *parent, const char *name, struct stat *attr, Inode **out, int uid = -1, int gid = -1);
> +  bool ll_forget(Inode *in, int count);
> +  int ll_getattr(Inode *in, struct stat *st, int uid = -1, int gid = -1);
> +  int ll_setattr(Inode *in, struct stat *st, int mask, int uid = -1, int gid = -1);
> +  int ll_getxattr(Inode *in, const char *name, void *value, size_t size, int uid=-1, int gid=-1);
> +  int ll_setxattr(Inode *in, const char *name, const void *value, size_t size, int flags, int uid=-1, int gid=-1);
> +  int ll_removexattr(Inode *in, const char *name, int uid=-1, int gid=-1);
> +  int ll_listxattr(Inode *in, char *list, size_t size, int uid=-1, int gid=-1);
> +  int ll_opendir(Inode *in, void **dirpp, int uid = -1, int gid = -1);
> +  int ll_readlink(Inode *in, const char **value, int uid = -1, int gid = -1);
> +  int ll_mknod(Inode *in, const char *name, mode_t mode, dev_t rdev, struct stat *attr, Inode **out, int uid = -1, int gid = -1);
> +  int ll_mkdir(Inode *in, const char *name, mode_t mode, struct stat *attr, Inode **out, int uid = -1, int gid = -1);
> +  int ll_symlink(Inode *in, const char *name, const char *value, struct stat *attr, Inode **out, int uid = -1, int gid = -1);
> +  int ll_unlink(Inode *in, const char *name, int uid = -1, int gid = -1);
> +  int ll_rmdir(Inode *in, const char *name, int uid = -1, int gid = -1);
> +  int ll_rename(Inode *parent, const char *name, Inode *newparent, const char *newname, int uid = -1, int gid = -1);
> +  int ll_link(Inode *in, Inode *newparent, const char *newname, struct stat *attr, int uid = -1, int gid = -1);
> +  int ll_open(Inode *in, int flags, Fh **fh, int uid = -1, int gid = -1);
> +  int ll_create(Inode *parent, const char *name, mode_t mode, int flags, struct stat *attr, Inode **out, int uid = -1, int gid = -1);
> +  int ll_statfs(Inode *in, struct statvfs *stbuf);
> };
> 
> #endif
> 
> David Zafman
> Senior Developer
> david.zafman@inktank.com
> 
> 
> 

