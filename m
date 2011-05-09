From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [ceph-commit] ceph.git branch master updated. v0.27.1-331-gd9ea95f
Date: Mon, 9 May 2011 16:21:41 -0700
Message-ID: <BANLkTimhhTxKPGUhmiOS8Cw5_u8x4CHMFA@mail.gmail.com>
References: <20110509222127.2B4DA485C521@ceph-tracker.dreamhostps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42443 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab1EIXVn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 19:21:43 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6FEF6C067
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 16:21:43 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id E9AE9C065
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 16:21:42 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1683832ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2011 16:21:41 -0700 (PDT)
In-Reply-To: <20110509222127.2B4DA485C521@ceph-tracker.dreamhostps.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@ceph-tracker.dreamhostps.com>
Cc: ceph-devel@vger.kernel.org

Ermm, doesn't rados sync do a whole tree sync or something? I think we
want to maintain a simple get/set object capability and the rados tool
is a pretty logical place for that.
-Greg

On Mon, May 9, 2011 at 3:21 PM, Colin McCabe
<cmccabe@ceph-tracker.dreamhostps.com> wrote:
> The branch, master has been updated
> =A0 =A0 =A0 via =A0d9ea95f25feadec912297fce7a5031022ad493cd (commit)
> =A0 =A0 =A0from =A01cb611a057492d6aae9e0f2e7ef2bbeb2dedb064 (commit)
>
> Those revisions listed above that are new to this repository have
> not appeared on any other notification email; so we list those
> revisions in full, below.
>
> http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dcommit;h=3Dd9ea95f25fe=
adec912297fce7a5031022ad493cd
>
> - Log ---------------------------------------------------------------=
--
> commit d9ea95f25feadec912297fce7a5031022ad493cd
> Author: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
> Date: =A0 Mon May 9 08:02:25 2011 -0700
>
> =A0 =A0rados tool: remove import/export
>
> =A0 =A0rados_sync replaces rados import / rados export
>
> =A0 =A0Signed-off-by: Colin McCabe <colin.mccabe@dreamhost.com>
>
> ---
>
> =A0src/rados.cc | =A0120 --------------------------------------------=
--------------
> =A01 files changed, 0 insertions(+), 120 deletions(-)
>
> diff --git a/src/rados.cc b/src/rados.cc
> index 468b667..a4c8699 100644
> --- a/src/rados.cc
> +++ b/src/rados.cc
> @@ -67,8 +67,6 @@ void usage()
> =A0 cerr << " =A0 mksnap <snap-name> =A0 =A0 =A0 =A0 =A0 =A0 =A0 crea=
te snap <snap-name>\n";
> =A0 cerr << " =A0 rmsnap <snap-name> =A0 =A0 =A0 =A0 =A0 =A0 =A0 remo=
ve snap <snap-name>\n";
> =A0 cerr << " =A0 rollback <obj-name> <snap-name> =A0roll back object=
 to snap <snap-name>\n\n";
> - =A0cerr << " =A0 import <dir> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 import pool from a directory\n";
> - =A0cerr << " =A0 export <dir> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 export pool into a directory\n";
> =A0 cerr << " =A0 bench <seconds> write|seq|rand [-t concurrent_opera=
tions]\n";
> =A0 cerr << " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0default is 16 concurrent IOs and 4 MB op size\n\n";
>
> @@ -158,104 +156,6 @@ static int do_put(IoCtx& io_ctx, const char *ob=
jname, const char *infile, int op
> =A0 return 0;
> =A0}
>
> -static int import_dir(IoCtx& io_ctx, string path, const char *name, =
int prefix_len, int op_size)
> -{
> - =A0string dir_str;
> - =A0if (!path.empty())
> - =A0 =A0dir_str =3D path + "/";
> - =A0dir_str +=3D name;
> -
> - =A0DIR *dir =3D opendir(dir_str.c_str());
> - =A0if (!dir) {
> - =A0 =A0int err =3D -errno;
> - =A0 =A0generic_dout(0) << "couldn't open " << dir_str << ": " << st=
rerror(-err) << dendl;
> - =A0 =A0return -errno;
> - =A0}
> -
> - =A0struct dirent *dent;
> - =A0dent =3D readdir(dir);
> - =A0while (dent) {
> - =A0 =A0if (strcmp(dent->d_name, ".") =3D=3D 0 || strcmp(dent->d_nam=
e, "..") =3D=3D 0)
> - =A0 =A0 =A0goto next;
> - =A0 =A0char buf[dir_str.size() + 1 + strlen(dent->d_name) + 1];
> - =A0 =A0sprintf(buf, "%s/%s", dir_str.c_str(), dent->d_name);
> - =A0 =A0generic_dout(0) << buf << dendl;
> - =A0 =A0struct stat s;
> - =A0 =A0if (stat(buf, &s) < 0) {
> - =A0 =A0 =A0int err =3D -errno;
> - =A0 =A0 =A0generic_dout(0) << "WARNING: failed to stat " << buf << =
": " << strerror(-err) << dendl;
> - =A0 =A0}
> - =A0 =A0if (s.st_mode & S_IFDIR) {
> - =A0 =A0 =A0import_dir(io_ctx, dir_str, dent->d_name, prefix_len, op=
_size);
> - =A0 =A0} else {
> - =A0 =A0 =A0const char *oid =3D buf + prefix_len + 1; // cut out the=
 the dir name from the object name
> - =A0 =A0 =A0do_put(io_ctx, oid, buf, op_size, false);
> - =A0 =A0}
> -next:
> - =A0 =A0dent =3D readdir(dir);
> - =A0}
> - =A0closedir(dir);
> - =A0return 0;
> -}
> -
> -static int do_import(IoCtx& io_ctx, const char *dir_name, int op_siz=
e)
> -{
> - =A0string empty;
> - =A0return import_dir(io_ctx, empty, dir_name, strlen(dir_name), op_=
size);
> -}
> -
> -static int do_export(IoCtx& io_ctx, const char *dir_name)
> -{
> - =A0map<string, bool> dircache;
> - =A0map<string, bool>::iterator iter;
> - =A0string path =3D dir_name;
> - =A0path +=3D "/";
> -
> - =A0bool skip;
> - =A0librados::ObjectIterator i =3D io_ctx.objects_begin();
> - =A0librados::ObjectIterator i_end =3D io_ctx.objects_end();
> - =A0int r =3D mkdir(dir_name, 0700);
> - =A0if (r < 0) {
> - =A0 =A0r =3D -errno;
> - =A0 =A0if (r !=3D -EEXIST)
> - =A0 =A0 =A0return r;
> - =A0}
> - =A0for (; i !=3D i_end; ++i) {
> - =A0 =A0string name =3D *i;
> - =A0 =A0int start =3D 0;
> - =A0 =A0int pos =3D name.find('/');
> - =A0 =A0skip =3D false;
> - =A0 =A0while (pos >=3D 0) {
> - =A0 =A0 =A0string dest =3D path;
> - =A0 =A0 =A0dest +=3D name.substr(0, pos);
> - =A0 =A0 =A0if (dest.compare("..") =3D=3D 0) {
> - =A0 =A0 =A0 =A0skip =3D true;
> - =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0}
> - =A0 =A0 =A0iter =3D dircache.find(dest);
> - =A0 =A0 =A0if (iter =3D=3D dircache.end()) {
> - =A0 =A0 =A0 =A0generic_dout(0) << "mkdir: " << dest << dendl;
> - =A0 =A0 =A0 =A0mkdir(dest.c_str(), 0700);
> - =A0 =A0 =A0 =A0dircache[dest] =3D true;
> - =A0 =A0 =A0}
> - =A0 =A0 =A0start =3D pos + 1;
> - =A0 =A0 =A0if ((size_t)start < name.size())
> - =A0 =A0 =A0 =A0pos =3D name.find('/', start);
> - =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0break;
> - =A0 =A0}
> - =A0 =A0if (skip)
> - =A0 =A0 =A0continue;
> - =A0 =A0if ((size_t)start =3D=3D name.size())
> - =A0 =A0 =A0continue;
> - =A0 =A0string newfile =3D path + name;
> - =A0 =A0generic_dout(0) << "exporting " << name << " =3D> " << newfi=
le << dendl;
> - =A0 =A0do_get(io_ctx, name.c_str(), newfile.c_str(), false);
> - =A0}
> -
> - =A0return 0;
> -}
> -
> =A0/**********************************************
>
> =A0**********************************************/
> @@ -728,26 +628,6 @@ int main(int argc, const char **argv)
> =A0 =A0 cout << "rolled back pool " << pool_name
> =A0 =A0 =A0 =A0 << " to snapshot " << nargs[2] << std::endl;
> =A0 }
> - =A0else if (strcmp(nargs[0], "import") =3D=3D 0) {
> - =A0 =A0if (!pool_name || nargs.size() < 2)
> - =A0 =A0 =A0usage();
> -
> - =A0 =A0ret =3D do_import(io_ctx, nargs[1], op_size);
> - =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0cerr << "error importing " << pool_name << "/" << nargs[=
1] << ": " << strerror_r(-ret, buf, sizeof(buf)) << std::endl;
> - =A0 =A0 =A0return 1;
> - =A0 =A0}
> - =A0}
> - =A0else if (strcmp(nargs[0], "export") =3D=3D 0) {
> - =A0 =A0if (!pool_name || nargs.size() < 2)
> - =A0 =A0 =A0usage();
> -
> - =A0 =A0ret =3D do_export(io_ctx, nargs[1]);
> - =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0cerr << "error exporting " << pool_name << "/" << nargs[=
1] << ": " << strerror_r(-ret, buf, sizeof(buf)) << std::endl;
> - =A0 =A0 =A0return 1;
> - =A0 =A0}
> - =A0}
> =A0 else if (strcmp(nargs[0], "bench") =3D=3D 0) {
> =A0 =A0 if (!pool_name || nargs.size() < 3)
> =A0 =A0 =A0 usage();
> _______________________________________________
> Ceph-commit mailing list
> Ceph-commit@lists.ceph.newdream.net
> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdream=
=2Enet
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
