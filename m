From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] mds: fix setting/removing xattrs on root
Date: Tue, 16 Apr 2013 13:06:28 -0700
Message-ID: <CAPYLRzgK5siEsvd-Uj8-4SxrUSLAz0j4S45TCb3ZCCzTkeFfFA@mail.gmail.com>
References: <1366021404-5812-1-git-send-email-big.chiu@bigtera.com>
	<1366021404-5812-2-git-send-email-big.chiu@bigtera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f51.google.com ([209.85.128.51]:36470 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935907Ab3DPUG3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 16:06:29 -0400
Received: by mail-qe0-f51.google.com with SMTP id 1so509881qec.38
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 13:06:28 -0700 (PDT)
In-Reply-To: <1366021404-5812-2-git-send-email-big.chiu@bigtera.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kuan Kai Chiu <big.chiu@bigtera.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, henry@bigtera.com

On Mon, Apr 15, 2013 at 3:23 AM, Kuan Kai Chiu <big.chiu@bigtera.com> w=
rote:
> MDS crashes while journaling dirty root inode in handle_client_setxat=
tr
> and handle_client_removexattr. We should use journal_dirty_inode to
> safely log root inode here.
> ---
>  src/mds/Server.cc |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index 11ab834..1e62dd2 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -3907,8 +3907,7 @@ void Server::handle_client_setxattr(MDRequest *=
mdr)
>    mdlog->start_entry(le);
>    le->metablob.add_client_req(req->get_reqid(), req->get_oldest_clie=
nt_tid());
>    mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PRED=
IRTY_PRIMARY, false);
> -  mdcache->journal_cow_inode(mdr, &le->metablob, cur);
> -  le->metablob.add_primary_dentry(cur->get_projected_parent_dn(), tr=
ue, cur);
> +  mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
>
>    journal_and_reply(mdr, cur, 0, le, new C_MDS_inode_update_finish(m=
ds, mdr, cur));
>  }
> @@ -3964,8 +3963,7 @@ void Server::handle_client_removexattr(MDReques=
t *mdr)
>    mdlog->start_entry(le);
>    le->metablob.add_client_req(req->get_reqid(), req->get_oldest_clie=
nt_tid());
>    mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PRED=
IRTY_PRIMARY, false);
> -  mdcache->journal_cow_inode(mdr, &le->metablob, cur);
> -  le->metablob.add_primary_dentry(cur->get_projected_parent_dn(), tr=
ue, cur);
> +  mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
>
>    journal_and_reply(mdr, cur, 0, le, new C_MDS_inode_update_finish(m=
ds, mdr, cur));
>  }

This is fine as far as it goes, but we'll need your sign-off for us to
incorporate it into the codebase. Also, have you run any tests with
it? The reason I ask is that when I apply this patch, set an xattr on
the root inode, and then restart the MDS and client, there are no
xattrs on the root any more. I think this should fix that, but there
may be other such issues:
diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index 7065460..439bd78 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -468,7 +468,7 @@ private:

     if (!pi) pi =3D in->get_projected_inode();
     if (!pdft) pdft =3D &in->dirfragtree;
-    if (!px) px =3D &in->xattrs;
+    if (!px) px =3D in->get_projected_xattrs();

     bufferlist snapbl;
     if (psnapbl)

You've fallen victim to this new setup, incidentally =97 in the past th=
e
root inode wasn't allowed to get any of these modifications because
it's not quite real in the way the rest of them are. We opened that up
when we made the virtual xattr interface, but we weren't very careful
about it so apparently we missed some side effects.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
